// Create lib/features/admin/data/services/user_approval_service.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../auth/multi_tenant_auth.dart';

@riverpod
UserApprovalService userApprovalService(UserApprovalServiceRef ref) {
  return UserApprovalService();
}

class UserApprovalService {
  Future<void> approveUser(String userId, String requestId) async {
    final batch = FirebaseFirestore.instance.batch();

    // Update user status to active
    final userRef = FirebaseFirestore.instance.collection('users').doc(userId);
    batch.update(userRef, {
      'isActive': true,
      'status': 'approved',
      'approvedAt': DateTime.now().toIso8601String(),
    });

    // Update approval request
    final requestRef = FirebaseFirestore.instance
        .collection('approval_requests')
        .doc(requestId);
    batch.update(requestRef, {
      'status': 'approved',
      'processedAt': DateTime.now().toIso8601String(),
    });

    await batch.commit();

    // Send welcome notification to user
    await _sendWelcomeNotification(userId);
  }

  Future<void> approveUserWithRole(String userId, String requestId,
      Map<String, dynamic> selectedRole) async {
    final batch = FirebaseFirestore.instance.batch();

    // Update user with assigned role
    final userRef = FirebaseFirestore.instance.collection('users').doc(userId);
    batch.update(userRef, {
      'isActive': true,
      'status': 'approved',
      'role': selectedRole,
      'permissions': selectedRole['permissions'],
      'roleData': selectedRole['config'],
      'approvedAt': DateTime.now().toIso8601String(),
    });

    // Update approval request
    final requestRef = FirebaseFirestore.instance
        .collection('approval_requests')
        .doc(requestId);
    batch.update(requestRef, {
      'status': 'approved',
      'assignedRole': selectedRole,
      'processedAt': DateTime.now().toIso8601String(),
    });

    await batch.commit();

    await _sendWelcomeNotification(userId);
  }

  Future<void> rejectUser(String userId, String requestId) async {
    final batch = FirebaseFirestore.instance.batch();

    // Update user status to rejected
    final userRef = FirebaseFirestore.instance.collection('users').doc(userId);
    batch.update(userRef, {
      'status': 'rejected',
      'rejectedAt': DateTime.now().toIso8601String(),
    });

    // Update approval request
    final requestRef = FirebaseFirestore.instance
        .collection('approval_requests')
        .doc(requestId);
    batch.update(requestRef, {
      'status': 'rejected',
      'processedAt': DateTime.now().toIso8601String(),
    });

    await batch.commit();
  }

  Future<void> _sendWelcomeNotification(String userId) async {
    // Implement notification logic (email, push notification, etc.)
  }
}
