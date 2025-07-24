import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../admin/models/organization_config.dart';
import '../models/app_user.dart';
import '../models/dynamic_role.dart';
import '../providers/organization_provider.dart';
import '../repositories/user_repository.dart';
import 'auth_provider.dart';

part 'multi_tenant_auth.g.dart';

@riverpod
class MultiTenantAuth extends _$MultiTenantAuth {
  @override
  Stream<AuthState> build() {
    final orgConfigMap = ref.watch(organizationConfigProvider);

    // Handle empty or loading state
    if (orgConfigMap.isEmpty) {
      return Stream.value(const AuthState.loading());
    }

    // Safely extract authentication config with fallbacks
    final authConfig = orgConfigMap['authentication'] as Map<String, dynamic>?;
    if (authConfig == null) {
      return Stream.value(const AuthState.error(
          AuthError.unknown, "Authentication configuration not found"));
    }

    final authType = authConfig['type'] as String? ?? 'firebase';
    final authSettings = authConfig['config'] as Map<String, dynamic>? ?? {};

    switch (authType) {
      case 'firebase':
        return _handleFirebaseAuth(authSettings);
      case 'azure':
        return _handleAzureAuth(authSettings);
      case 'ldap':
        return _handleLDAPAuth(authSettings);
      case 'custom':
        return _handleCustomAuth(authSettings);
      default:
        return _handleGoogleAuth();
    }
  }

  Stream<AuthState> _handleFirebaseAuth(Map<String, dynamic> config) {
    return FirebaseAuth.instance
        .authStateChanges()
        .asyncMap((user) => _processUser(user, config));
  }

  Stream<AuthState> _handleAzureAuth(Map<String, dynamic> config) {
    return Stream.value(const AuthState.unauthenticated());
  }

  Stream<AuthState> _handleLDAPAuth(Map<String, dynamic> config) {
    return Stream.value(const AuthState.unauthenticated());
  }

  Stream<AuthState> _handleCustomAuth(Map<String, dynamic> config) {
    return Stream.value(const AuthState.unauthenticated());
  }

  Stream<AuthState> _handleGoogleAuth() {
    return FirebaseAuth.instance
        .authStateChanges()
        .asyncMap((user) => _processUser(user, {}));
  }

  Future<AuthState> _processUser(
      User? user, Map<String, dynamic> config) async {
    if (user == null) {
      return const AuthState.unauthenticated();
    }

    try {
      final orgConfigMap = ref.read(organizationConfigProvider);

      if (orgConfigMap.isEmpty) {
        return const AuthState.error(
            AuthError.unknown, "Organization configuration not loaded");
      }

      // Process user with organization context
      final userRepository = ref.read(userRepositoryProvider);
      final userProfile = await userRepository.getUserProfile(user.uid);

      if (userProfile != null) {
        // Check user approval status
        if (userProfile.status == 'pending') {
          return const AuthState.error(AuthError.permissionDenied,
              "Your account is pending approval. Please wait for authorization from your organization administrator.");
        }

        if (userProfile.status == 'rejected') {
          return const AuthState.error(AuthError.permissionDenied,
              "Your account registration was rejected. Please contact your organization administrator for assistance.");
        }

        if (!userProfile.isActive) {
          return const AuthState.error(
              AuthError.permissionDenied, "Your account has been disabled.");
        }

        return AuthState.authenticated(userProfile);
      } else {
        // Create pending user instead of active user - requires approval
        await _createPendingUser(user, orgConfigMap);

        return const AuthState.error(AuthError.permissionDenied,
            "Registration successful! Your account has been submitted for approval. You will receive notification once approved.");
      }
    } catch (e) {
      return AuthState.error(AuthError.unknown, e.toString());
    }
  }

  /// Creates a new user with pending status requiring approval
  Future<void> _createPendingUser(
      User user, Map<String, dynamic> orgConfigMap) async {
    final userRepository = ref.read(userRepositoryProvider);

    // Get the lowest hierarchy role as temporary assignment
    final tempRole = _getLowestHierarchyRole(orgConfigMap);

    // Create user with pending status
    final pendingUser = AppUser(
      uid: user.uid,
      email: user.email ?? '',
      name: user.displayName ?? 'New User',
      photoUrl: user.photoURL,
      role: tempRole,
      organizationId: orgConfigMap['id'] as String? ?? 'default',
      permissions: [], // No permissions until approved
      roleData: {},
      lastLogin: DateTime.now(),
      isActive: false,
      status: 'pending', // Requires approval
      requestedAt: DateTime.now(),
    );

    await userRepository.createUserProfile(pendingUser);

    // Send approval request to authorized personnel
    await _sendApprovalRequest(pendingUser, orgConfigMap);
  }

  /// Sends approval request to authorized personnel in the organization
  Future<void> _sendApprovalRequest(
      AppUser pendingUser, Map<String, dynamic> orgConfigMap) async {
    try {
      // Find users who can approve new registrations
      final approvers = await _getAuthorizedApprovers(orgConfigMap);

      if (approvers.isEmpty) {
        // If no approvers found, log error but don't fail user creation
        print(
            'Warning: No authorized approvers found for organization ${orgConfigMap['id']}');
        return;
      }

      // Create approval request document
      final approvalRequest = {
        'id': '${pendingUser.uid}_${DateTime.now().millisecondsSinceEpoch}',
        'userId': pendingUser.uid,
        'userEmail': pendingUser.email,
        'userName': pendingUser.name,
        'organizationId': pendingUser.organizationId,
        'requestedAt': pendingUser.requestedAt?.toIso8601String(),
        'status': 'pending',
        'approvers': approvers.map((a) => a['uid']).toList(),
        'userDetails': {
          'email': pendingUser.email,
          'name': pendingUser.name,
          'photoUrl': pendingUser.photoUrl,
          'requestedRole': pendingUser.role.toJson(),
        },
        'organizationDetails': {
          'id': orgConfigMap['id'],
          'name': orgConfigMap['name'] ?? 'Unknown Organization',
        },
        'createdAt': FieldValue.serverTimestamp(),
      };

      // Store approval request in Firestore
      await FirebaseFirestore.instance
          .collection('approval_requests')
          .doc(approvalRequest['id'] as String)
          .set(approvalRequest);

      // Create notifications for all approvers
      for (final approver in approvers) {
        await _createApprovalNotification(approver, approvalRequest);
      }

      print('Approval request sent for user: ${pendingUser.email}');
    } catch (e) {
      print('Error sending approval request: $e');
      // Don't fail user creation if notification fails
    }
  }

  /// Finds users authorized to approve new user registrations
  Future<List<Map<String, dynamic>>> _getAuthorizedApprovers(
      Map<String, dynamic> orgConfigMap) async {
    try {
      // Get roles that can approve new users from organization config
      final roles = orgConfigMap['roles'] as List<dynamic>? ?? [];
      final approverRoleIds = <String>[];

      // Find roles with approval permissions
      for (final roleMap in roles) {
        final role = roleMap as Map<String, dynamic>;
        final permissions = List<String>.from(role['permissions'] ?? []);
        final hierarchyLevel = role['hierarchyLevel'] as int? ?? 999;

        // Check for explicit approval permissions or high hierarchy roles
        if (permissions.contains('approve_users') ||
            permissions.contains('manage_users') ||
            permissions.contains('admin_all') ||
            hierarchyLevel <= 30) {
          // Top hierarchy roles can approve
          approverRoleIds.add(role['id'] as String);
        }
      }

      if (approverRoleIds.isEmpty) {
        return [];
      }

      // Get active users with approver roles in this organization
      final usersQuery = await FirebaseFirestore.instance
          .collection('users')
          .where('organizationId', isEqualTo: orgConfigMap['id'])
          .where('isActive', isEqualTo: true)
          .where('status', isEqualTo: 'approved')
          .get();

      final approvers = <Map<String, dynamic>>[];

      for (final userDoc in usersQuery.docs) {
        final userData = userDoc.data();
        final userRole = userData['role'] as Map<String, dynamic>?;

        if (userRole != null && approverRoleIds.contains(userRole['id'])) {
          approvers.add({
            'uid': userData['uid'],
            'email': userData['email'],
            'name': userData['name'],
            'role': userRole,
          });
        }
      }

      return approvers;
    } catch (e) {
      print('Error getting authorized approvers: $e');
      return [];
    }
  }

  /// Creates notification for approver about pending user request
  Future<void> _createApprovalNotification(Map<String, dynamic> approver,
      Map<String, dynamic> approvalRequest) async {
    try {
      final notification = {
        'id': '${approvalRequest['id']}_${approver['uid']}',
        'type': 'user_approval_request',
        'title': 'New User Approval Required',
        'message':
            'User ${approvalRequest['userName']} (${approvalRequest['userEmail']}) has requested access to the system.',
        'recipientId': approver['uid'],
        'requestId': approvalRequest['id'],
        'userDetails': approvalRequest['userDetails'],
        'organizationDetails': approvalRequest['organizationDetails'],
        'isRead': false,
        'createdAt': FieldValue.serverTimestamp(),
        'expiresAt':
            DateTime.now().add(const Duration(days: 7)).toIso8601String(),
      };

      await FirebaseFirestore.instance
          .collection('notifications')
          .doc(notification['id'] as String)
          .set(notification);
    } catch (e) {
      print('Error creating approval notification: $e');
    }
  }

  /// Gets the lowest hierarchy role for temporary assignment
  DynamicRole _getLowestHierarchyRole(Map<String, dynamic> orgConfigMap) {
    final rolesList = orgConfigMap['roles'] as List<dynamic>? ?? [];

    if (rolesList.isEmpty) {
      // Fallback default role
      return DynamicRole(
        id: 'pending_user',
        name: 'pending_user',
        displayName: 'Pending User',
        hierarchyLevel: 999,
        organizationId: orgConfigMap['id'] as String? ?? 'default',
        permissions: const [], // No permissions for pending users
        config: const {'status': 'pending', 'dashboardType': 'none'},
      );
    }

    // Convert role maps to DynamicRole objects and find highest hierarchy number (lowest rank)
    final roles = rolesList
        .cast<Map<String, dynamic>>()
        .map((roleMap) => DynamicRole(
              id: roleMap['id'] as String? ?? 'unknown',
              name: roleMap['name'] as String? ?? 'unknown',
              displayName: roleMap['displayName'] as String? ?? 'Unknown',
              hierarchyLevel: roleMap['hierarchyLevel'] as int? ?? 999,
              organizationId: orgConfigMap['id'] as String? ?? 'default',
              permissions: [], // No permissions until approved
              config:
                  Map<String, dynamic>.from(roleMap['config'] as Map? ?? {}),
            ))
        .toList();

    // Sort by hierarchy level (highest number = lowest hierarchy/rank)
    roles.sort((a, b) => b.hierarchyLevel.compareTo(a.hierarchyLevel));

    return roles.first;
  }

  DynamicRole _getDefaultRoleFromMap(Map<String, dynamic> orgConfigMap) {
    // Safely extract roles from map
    final rolesList = orgConfigMap['roles'] as List<dynamic>? ?? [];

    if (rolesList.isEmpty) {
      // Fallback default role
      return DynamicRole(
        id: 'default_user',
        name: 'basic_user',
        displayName: 'Basic User',
        hierarchyLevel: 999,
        organizationId: orgConfigMap['id'] as String? ?? 'default',
        permissions: const ['view_own', 'basic_operations'],
        config: const {'hierarchyAccess': 'own', 'dashboardType': 'basic'},
      );
    }

    // Convert role maps to DynamicRole objects and find lowest hierarchy
    final roles = rolesList
        .cast<Map<String, dynamic>>()
        .map((roleMap) => DynamicRole(
              id: roleMap['id'] as String? ?? 'unknown',
              name: roleMap['name'] as String? ?? 'unknown',
              displayName: roleMap['displayName'] as String? ?? 'Unknown',
              hierarchyLevel: roleMap['hierarchyLevel'] as int? ?? 999,
              organizationId: orgConfigMap['id'] as String? ?? 'default',
              permissions:
                  List<String>.from(roleMap['permissions'] as List? ?? []),
              config:
                  Map<String, dynamic>.from(roleMap['config'] as Map? ?? {}),
            ))
        .toList();

    // Sort by hierarchy level (highest number = lowest hierarchy)
    roles.sort((a, b) => b.hierarchyLevel.compareTo(a.hierarchyLevel));

    return roles.first;
  }
}

// Provider for getting current user approval requests
@riverpod
Stream<List<Map<String, dynamic>>> pendingApprovalRequests(
    PendingApprovalRequestsRef ref) {
  final currentUser = ref.watch(currentUserProvider);
  if (currentUser == null) return Stream.value([]);

  // Only show requests that this user can approve
  return FirebaseFirestore.instance
      .collection('approval_requests')
      .where('approvers', arrayContains: currentUser.uid)
      .where('status', isEqualTo: 'pending')
      .orderBy('requestedAt', descending: true)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => {'id': doc.id, ...doc.data()}).toList());
}

// Provider for user approval service
@riverpod
UserApprovalService userApprovalService(UserApprovalServiceRef ref) {
  return UserApprovalService();
}

/// Service for handling user approval operations
class UserApprovalService {
  /// Approves a user with default role
  Future<void> approveUser(String userId, String requestId) async {
    final batch = FirebaseFirestore.instance.batch();

    try {
      // Update user status to approved and active
      final userRef =
          FirebaseFirestore.instance.collection('users').doc(userId);
      batch.update(userRef, {
        'isActive': true,
        'status': 'approved',
        'approvedAt': FieldValue.serverTimestamp(),
      });

      // Update approval request status
      final requestRef = FirebaseFirestore.instance
          .collection('approval_requests')
          .doc(requestId);
      batch.update(requestRef, {
        'status': 'approved',
        'processedAt': FieldValue.serverTimestamp(),
      });

      await batch.commit();

      // Send welcome notification to user
      await _sendWelcomeNotification(userId);

      print('User $userId approved successfully');
    } catch (e) {
      print('Error approving user: $e');
      rethrow;
    }
  }

  /// Approves a user and assigns a specific role
  Future<void> approveUserWithRole(String userId, String requestId,
      Map<String, dynamic> selectedRole) async {
    final batch = FirebaseFirestore.instance.batch();

    try {
      // Update user with assigned role and active status
      final userRef =
          FirebaseFirestore.instance.collection('users').doc(userId);
      batch.update(userRef, {
        'isActive': true,
        'status': 'approved',
        'role': selectedRole,
        'permissions': selectedRole['permissions'],
        'roleData': selectedRole['config'],
        'approvedAt': FieldValue.serverTimestamp(),
      });

      // Update approval request
      final requestRef = FirebaseFirestore.instance
          .collection('approval_requests')
          .doc(requestId);
      batch.update(requestRef, {
        'status': 'approved',
        'assignedRole': selectedRole,
        'processedAt': FieldValue.serverTimestamp(),
      });

      await batch.commit();

      await _sendWelcomeNotification(userId);

      print('User $userId approved with role ${selectedRole['displayName']}');
    } catch (e) {
      print('Error approving user with role: $e');
      rethrow;
    }
  }

  /// Rejects a user registration
  Future<void> rejectUser(String userId, String requestId,
      {String? reason}) async {
    final batch = FirebaseFirestore.instance.batch();

    try {
      // Update user status to rejected
      final userRef =
          FirebaseFirestore.instance.collection('users').doc(userId);
      batch.update(userRef, {
        'status': 'rejected',
        'rejectedAt': FieldValue.serverTimestamp(),
        'rejectionReason': reason,
      });

      // Update approval request
      final requestRef = FirebaseFirestore.instance
          .collection('approval_requests')
          .doc(requestId);
      batch.update(requestRef, {
        'status': 'rejected',
        'rejectionReason': reason,
        'processedAt': FieldValue.serverTimestamp(),
      });

      await batch.commit();

      // Send rejection notification to user
      await _sendRejectionNotification(userId, reason);

      print('User $userId rejected');
    } catch (e) {
      print('Error rejecting user: $e');
      rethrow;
    }
  }

  /// Sends welcome notification to approved user
  Future<void> _sendWelcomeNotification(String userId) async {
    try {
      final notification = {
        'id': '${userId}_welcome_${DateTime.now().millisecondsSinceEpoch}',
        'type': 'account_approved',
        'title': 'Account Approved!',
        'message':
            'Your account has been approved. You can now access the system.',
        'recipientId': userId,
        'isRead': false,
        'createdAt': FieldValue.serverTimestamp(),
      };

      await FirebaseFirestore.instance
          .collection('notifications')
          .doc(notification['id'] as String)
          .set(notification);
    } catch (e) {
      print('Error sending welcome notification: $e');
    }
  }

  /// Sends rejection notification to user
  Future<void> _sendRejectionNotification(String userId, String? reason) async {
    try {
      final notification = {
        'id': '${userId}_rejection_${DateTime.now().millisecondsSinceEpoch}',
        'type': 'account_rejected',
        'title': 'Account Registration Rejected',
        'message': reason ??
            'Your account registration was rejected. Please contact your administrator.',
        'recipientId': userId,
        'isRead': false,
        'createdAt': FieldValue.serverTimestamp(),
      };

      await FirebaseFirestore.instance
          .collection('notifications')
          .doc(notification['id'] as String)
          .set(notification);
    } catch (e) {
      print('Error sending rejection notification: $e');
    }
  }
}
