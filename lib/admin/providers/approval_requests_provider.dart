import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../auth/auth_provider.dart';

part 'approval_requests_provider.g.dart';

// Provider for filtered approval requests
@riverpod
Stream<List<Map<String, dynamic>>> filteredApprovalRequests(
  FilteredApprovalRequestsRef ref,
  String status,
) {
  final currentUser = ref.watch(currentUserProvider);
  if (currentUser == null) return Stream.value([]);

  return FirebaseFirestore.instance
      .collection('approval_requests')
      .where('approvers', arrayContains: currentUser.uid)
      .where('status', isEqualTo: status)
      .orderBy('requestedAt', descending: true)
      .limit(50) // Limit for performance
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => {'id': doc.id, ...doc.data()}).toList());
}

// Provider for all approval requests (for admin overview)
@riverpod
Stream<List<Map<String, dynamic>>> allApprovalRequests(
  AllApprovalRequestsRef ref,
  String status,
) {
  return FirebaseFirestore.instance
      .collection('approval_requests')
      .where('status', isEqualTo: status)
      .orderBy('requestedAt', descending: true)
      .limit(100)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => {'id': doc.id, ...doc.data()}).toList());
}

// Provider for organization-specific approval requests
@riverpod
Stream<List<Map<String, dynamic>>> organizationApprovalRequests(
  OrganizationApprovalRequestsRef ref,
  String organizationId,
  String status,
) {
  return FirebaseFirestore.instance
      .collection('approval_requests')
      .where('organizationId', isEqualTo: organizationId)
      .where('status', isEqualTo: status)
      .orderBy('requestedAt', descending: true)
      .limit(50)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => {'id': doc.id, ...doc.data()}).toList());
}
