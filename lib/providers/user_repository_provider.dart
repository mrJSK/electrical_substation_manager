import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../auth/auth_provider.dart';
import '../models/app_user.dart';
import '../models/dynamic_role.dart';
import '../repositories/user_repository.dart';

// This is required for code generation
part 'user_repository_provider.g.dart';

/// Provider for UserRepository
@riverpod
UserRepository userRepository(UserRepositoryRef ref) {
  return FirestoreUserRepository();
}

/// Provider for watching the current user's profile
@riverpod
Stream<AppUser?> currentUserProfile(CurrentUserProfileRef ref) {
  final authState = ref.watch(authStateProvider);

  return authState.when(
    authenticated: (user) {
      final userRepo = ref.watch(userRepositoryProvider);
      return userRepo.watchUserProfile(user.uid);
    },
    loading: () => Stream.value(null),
    unauthenticated: () => Stream.value(null),
    error: (_, __) => Stream.value(null),
  );
}

/// Provider for getting users by organization
@riverpod
Future<List<AppUser>> usersByOrganization(
  UsersByOrganizationRef ref,
  String organizationId,
) async {
  final userRepo = ref.watch(userRepositoryProvider);
  return userRepo.getUsersByOrganization(organizationId);
}

/// Provider for getting users by status
@riverpod
Future<List<AppUser>> usersByStatus(
  UsersByStatusRef ref,
  String status,
) async {
  final userRepo = ref.watch(userRepositoryProvider);
  return userRepo.getUsersByStatus(status);
}

/// Provider for getting pending users
@riverpod
Future<List<AppUser>> pendingUsers(PendingUsersRef ref) async {
  final userRepo = ref.watch(userRepositoryProvider);
  return userRepo.getPendingUsers();
}

/// Provider for getting users by role
@riverpod
Future<List<AppUser>> usersByRole(
  UsersByRoleRef ref,
  DynamicRole role,
) async {
  final userRepo = ref.watch(userRepositoryProvider);
  return userRepo.getUsersByRole(role);
}

/// Provider for user approval operations
@riverpod
class UserApprovalNotifier extends _$UserApprovalNotifier {
  @override
  AsyncValue<void> build() {
    return const AsyncValue.data(null);
  }

  /// Approves a user with their current role
  Future<void> approveUser(String userId, String requestId) async {
    state = const AsyncValue.loading();

    try {
      final userRepo = ref.read(userRepositoryProvider);
      final currentUser = ref.read(currentUserProvider);

      if (currentUser == null) {
        throw Exception('No authenticated user to perform approval');
      }

      await userRepo.updateUserStatus(
        userId,
        'approved',
        approvedBy: currentUser.uid,
      );

      // Refresh related providers
      ref.invalidate(pendingUsersProvider);
      ref.invalidate(usersByStatusProvider('pending'));
      ref.invalidate(usersByStatusProvider('approved'));

      state = const AsyncValue.data(null);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  /// Rejects a user registration with optional reason
  Future<void> rejectUser(String userId, String requestId,
      {String? reason}) async {
    state = const AsyncValue.loading();

    try {
      final userRepo = ref.read(userRepositoryProvider);
      final currentUser = ref.read(currentUserProvider);

      if (currentUser == null) {
        throw Exception('No authenticated user to perform rejection');
      }

      await userRepo.updateUserStatus(
        userId,
        'rejected',
        rejectedBy: currentUser.uid,
        reason: reason,
      );

      // Refresh related providers
      ref.invalidate(pendingUsersProvider);
      ref.invalidate(usersByStatusProvider('pending'));
      ref.invalidate(usersByStatusProvider('rejected'));

      state = const AsyncValue.data(null);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  /// Updates a user's profile information
  Future<void> updateUserProfile(AppUser user) async {
    state = const AsyncValue.loading();

    try {
      final userRepo = ref.read(userRepositoryProvider);
      await userRepo.updateUserProfile(user);

      // Refresh the current user profile if it's the same user
      final currentUser = ref.read(currentUserProvider);
      if (currentUser?.uid == user.uid) {
        ref.invalidate(currentUserProfileProvider);
      }

      state = const AsyncValue.data(null);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}
