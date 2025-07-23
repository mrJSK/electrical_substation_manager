// lib/auth/auth_provider.dart

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import '../models/app_user.dart';
import '../repositories/user_repository.dart';

part 'auth_provider.g.dart';

// User Repository Provider
@riverpod
UserRepository userRepository(UserRepositoryRef ref) {
  return FirestoreUserRepository();
}

// Connection Status Provider
@riverpod
class ConnectionStatus extends _$ConnectionStatus {
  @override
  bool build() => true;

  void updateStatus(bool isConnected) {
    state = isConnected;
  }
}

// Auth State Provider (simplified for better debugging)
@riverpod
class AuthStateNotifier extends _$AuthStateNotifier {
  final Map<String, AppUser> _userCache = <String, AppUser>{};

  @override
  AuthState build() {
    ref.keepAlive(); // Keep this provider alive

    // Listen to Firebase Auth changes
    ref.listen(firebaseAuthStreamProvider, (previous, next) {
      next.when(
        data: (firebaseUser) => _handleAuthChange(firebaseUser),
        loading: () => null,
        error: (error, stack) => state = AuthState.error(
            AuthError.unknown, "Firebase Auth Error: ${error.toString()}"),
      );
    });

    // Return initial state
    final currentUser = firebase.FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      return const AuthState.unauthenticated();
    }

    return const AuthState.loading();
  }

  Future<void> _handleAuthChange(firebase.User? firebaseUser) async {
    if (firebaseUser == null) {
      _userCache.clear();
      state = const AuthState.unauthenticated();
      return;
    }

    // Set loading state
    state = const AuthState.loading();

    try {
      // Check cache first
      if (_userCache.containsKey(firebaseUser.uid)) {
        state = AuthState.authenticated(_userCache[firebaseUser.uid]!);
        return;
      }

      // Check connection status
      if (!ref.read(connectionStatusProvider)) {
        final cachedUser = _getCachedUser(firebaseUser.uid);
        if (cachedUser != null) {
          state = AuthState.authenticated(cachedUser);
          return;
        }
        state = const AuthState.error(AuthError.networkError,
            "No internet connection and no cached data available");
        return;
      }

      // Get user profile from repository
      final userProfile = await ref
          .read(userRepositoryProvider)
          .getUserProfile(firebaseUser.uid);

      if (userProfile != null) {
        if (!userProfile.isActive) {
          state = const AuthState.error(
              AuthError.permissionDenied, "Your account has been disabled.");
          return;
        }

        _cacheUser(userProfile);
        state = AuthState.authenticated(userProfile);
      } else {
        // Create default user profile for new users
        final newUser = AppUser(
          uid: firebaseUser.uid,
          email: firebaseUser.email ?? '',
          name: firebaseUser.displayName ?? 'New User',
          photoUrl: firebaseUser.photoURL,
          role: UserRole.substationUser,
          permissions:
              RoleConfig.getPermissionsForRole(UserRole.substationUser),
          roleData: const {},
          lastLogin: DateTime.now(),
          isActive: true,
        );

        await ref.read(userRepositoryProvider).createUserProfile(newUser);
        _cacheUser(newUser);
        state = AuthState.authenticated(newUser);
      }
    } catch (e) {
      state = AuthState.error(
          AuthError.unknown, "An error occurred: ${e.toString()}");
    }
  }

  AppUser? _getCachedUser(String? uid) {
    return uid != null ? _userCache[uid] : null;
  }

  void _cacheUser(AppUser user) {
    _userCache[user.uid] = user;
  }

  Future<void> signOut() async {
    try {
      _userCache.clear();
      await firebase.FirebaseAuth.instance.signOut();
      state = const AuthState.unauthenticated();
    } catch (e) {
      state = AuthState.error(
          AuthError.unknown, "Sign out failed: ${e.toString()}");
    }
  }

  Future<void> updateUserProfile(AppUser updatedUser) async {
    try {
      await ref.read(userRepositoryProvider).updateUserProfile(updatedUser);
      _cacheUser(updatedUser);
      state = AuthState.authenticated(updatedUser);
    } catch (e) {
      throw Exception('Failed to update user profile: $e');
    }
  }

  Future<void> refreshUserProfile() async {
    final currentUser = firebase.FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      _userCache.remove(currentUser.uid);
      await _handleAuthChange(currentUser);
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      state = const AuthState.loading();

      // This will trigger the auth state change automatically
      // No need to manually handle the result here
    } catch (e) {
      state = AuthState.error(
          AuthError.unknown, "Google sign in failed: ${e.toString()}");
    }
  }
}

// Firebase Auth Stream Provider
@riverpod
Stream<firebase.User?> firebaseAuthStream(FirebaseAuthStreamRef ref) {
  return firebase.FirebaseAuth.instance.authStateChanges();
}

// Current Firebase User Provider
@riverpod
firebase.User? currentFirebaseUser(CurrentFirebaseUserRef ref) {
  final authStream = ref.watch(firebaseAuthStreamProvider);
  return authStream.whenOrNull(data: (user) => user);
}

// Helper provider to get current app user
@riverpod
AppUser? currentUser(CurrentUserRef ref) {
  final authState = ref.watch(authStateNotifierProvider);

  return authState.whenOrNull(
    authenticated: (user) => user,
  );
}

// Helper provider to check authentication status
@riverpod
bool isAuthenticated(IsAuthenticatedRef ref) {
  final authState = ref.watch(authStateNotifierProvider);

  return authState.whenOrNull(
        authenticated: (_) => true,
      ) ??
      false;
}

// Helper provider to check if user has specific permission
@riverpod
bool hasPermission(HasPermissionRef ref, String permission) {
  final user = ref.watch(currentUserProvider);
  return user?.hasPermission(permission) ?? false;
}

// Helper provider to get user's accessible screens
@riverpod
List<String> accessibleScreens(AccessibleScreensRef ref) {
  final user = ref.watch(currentUserProvider);
  if (user == null) return [];
  return RoleConfig.getScreensForRole(user.role);
}

// Helper provider to check if user can access specific hierarchy
@riverpod
bool canAccessHierarchy(CanAccessHierarchyRef ref, String hierarchyId) {
  final user = ref.watch(currentUserProvider);
  return user?.canAccessHierarchy(hierarchyId) ?? false;
}

// Helper provider to get user's role
@riverpod
UserRole? userRole(UserRoleRef ref) {
  final user = ref.watch(currentUserProvider);
  return user?.role;
}

// Helper provider to check if user has specific role
@riverpod
bool hasRole(HasRoleRef ref, UserRole role) {
  final userRole = ref.watch(userRoleProvider);
  return userRole == role;
}

// Helper provider to check if user is admin
@riverpod
bool isAdmin(IsAdminRef ref) {
  return ref.watch(hasRoleProvider(UserRole.admin));
}

// Helper provider to get loading state
@riverpod
bool isAuthLoading(IsAuthLoadingRef ref) {
  final authState = ref.watch(authStateNotifierProvider);
  return authState.whenOrNull(loading: () => true) ?? false;
}

// Helper provider to get auth error
@riverpod
String? authError(AuthErrorRef ref) {
  final authState = ref.watch(authStateNotifierProvider);
  return authState.whenOrNull(error: (error, message) => message);
}

// Provider for auth state (for widgets that need to handle all states)
@riverpod
AuthState authState(AuthStateRef ref) {
  return ref.watch(authStateNotifierProvider);
}
