// lib/auth/auth_provider.dart

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:freezed_annotation/freezed_annotation.dart';
import '../models/app_user.dart';
import '../models/dynamic_role.dart';
import '../repositories/user_repository.dart';

part 'auth_provider.g.dart';
part 'auth_provider.freezed.dart';

// Auth Error Enum
enum AuthError {
  networkError,
  permissionDenied,
  userNotFound,
  invalidRole,
  unknown,
}

// Auth State with Freezed
@freezed
class AuthState with _$AuthState {
  const factory AuthState.loading() = _Loading;
  const factory AuthState.authenticated(AppUser user) = _Authenticated;
  const factory AuthState.unauthenticated() = _Unauthenticated;
  const factory AuthState.error(AuthError error, String message) = _Error;
}

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
        // Check user approval status (from previous conversation about approval workflow)
        if (userProfile.status == 'pending') {
          state = const AuthState.error(AuthError.permissionDenied,
              "Your account is pending approval. Please wait for authorization from your organization administrator.");
          return;
        }

        if (userProfile.status == 'rejected') {
          state = const AuthState.error(AuthError.permissionDenied,
              "Your account registration was rejected. Please contact your organization administrator for assistance.");
          return;
        }

        if (!userProfile.isActive) {
          state = const AuthState.error(
              AuthError.permissionDenied, "Your account has been disabled.");
          return;
        }

        _cacheUser(userProfile);
        state = AuthState.authenticated(userProfile);
      } else {
        // Create pending user instead of active user (from approval workflow conversation)
        await _createPendingUser(firebaseUser);

        state = const AuthState.error(AuthError.permissionDenied,
            "Registration successful! Your account has been submitted for approval. You will receive notification once approved.");
      }
    } catch (e) {
      state = AuthState.error(
          AuthError.unknown, "An error occurred: ${e.toString()}");
    }
  }

  /// Creates a new user with pending status requiring approval
  Future<void> _createPendingUser(firebase.User firebaseUser) async {
    // Create a default role for pending users
    final defaultRole = DynamicRole(
      id: 'pending_user',
      name: 'pending_user',
      displayName: 'Pending User',
      hierarchyLevel: 999, // Lowest level
      organizationId: 'default', // Will be updated during approval
      permissions: const [], // No permissions until approved
      config: const {'status': 'pending', 'dashboardType': 'none'},
    );

    // Use the factory constructor from previous conversation
    final pendingUser = AppUser.createPendingUser(
      uid: firebaseUser.uid,
      email: firebaseUser.email ?? '',
      name: firebaseUser.displayName ?? 'New User',
      photoUrl: firebaseUser.photoURL,
      role: defaultRole,
      organizationId:
          'default', // Will be updated based on organization selection
      hierarchyId: null,
    );

    await ref.read(userRepositoryProvider).createUserProfile(pendingUser);

    // Note: Don't cache pending users as they can't actually use the app
    print('Pending user created: ${pendingUser.email}');
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

  // Helper method to approve current user (for testing purposes)
  Future<void> approveCurrentUser() async {
    final currentFirebaseUser = firebase.FirebaseAuth.instance.currentUser;
    if (currentFirebaseUser != null) {
      try {
        await ref.read(userRepositoryProvider).updateUserStatus(
              currentFirebaseUser.uid,
              'approved',
              approvedBy: 'system', // Or actual approver UID
            );

        // Refresh the user profile
        await refreshUserProfile();
      } catch (e) {
        state = AuthState.error(
            AuthError.unknown, "Failed to approve user: ${e.toString()}");
      }
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

  // Since we're using DynamicRole now, get screens from role config
  final roleConfig = user.role.config;
  return (roleConfig['accessibleScreens'] as List<dynamic>?)?.cast<String>() ??
      [];
}

// Helper provider to check if user can access specific hierarchy
@riverpod
bool canAccessHierarchy(CanAccessHierarchyRef ref, String hierarchyId) {
  final user = ref.watch(currentUserProvider);
  return user?.canAccessHierarchy(hierarchyId) ?? false;
}

// Helper provider to get user's dynamic role
@riverpod
DynamicRole? userRole(UserRoleRef ref) {
  final user = ref.watch(currentUserProvider);
  return user?.role;
}

// Helper provider to check if user has specific role ID
@riverpod
bool hasRoleId(HasRoleIdRef ref, String roleId) {
  final userRole = ref.watch(userRoleProvider);
  return userRole?.id == roleId;
}

// Helper provider to check if user is admin (top level)
@riverpod
bool isAdmin(IsAdminRef ref) {
  final userRole = ref.watch(userRoleProvider);
  return userRole?.hierarchyLevel == 1;
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

// Additional providers for approval workflow from previous conversation

// Helper provider to check if current user can approve others
@riverpod
bool canApproveUsers(CanApproveUsersRef ref) {
  final user = ref.watch(currentUserProvider);
  if (user == null) return false;

  return user.hasPermission('approve_users') ||
      user.hasPermission('manage_users') ||
      user.role.hierarchyLevel <= 30; // Top hierarchy roles can approve
}

// Helper provider to get user status
@riverpod
String userStatus(UserStatusRef ref) {
  final user = ref.watch(currentUserProvider);
  return user?.status ?? 'unknown';
}

// Helper provider to check if user account is pending
@riverpod
bool isUserPending(IsUserPendingRef ref) {
  final user = ref.watch(currentUserProvider);
  return user?.isPending ?? false;
}

// Helper provider to check if user can login
@riverpod
bool canUserLogin(CanUserLoginRef ref) {
  final user = ref.watch(currentUserProvider);
  return user?.canLogin ?? false;
}
