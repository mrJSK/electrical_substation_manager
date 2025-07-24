import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/app_user.dart';
import '../models/dynamic_role.dart';

abstract class UserRepository {
  Future<AppUser?> getUserProfile(String uid);
  Future<void> updateUserProfile(AppUser user);
  Future<void> createUserProfile(AppUser user);
  Stream<AppUser?> watchUserProfile(String uid);
  Future<List<AppUser>> getUsersByRole(DynamicRole role);
  Future<void> deleteUserProfile(String uid);

  // Additional methods for approval workflow
  Future<void> updateUserStatus(
    String uid,
    String status, {
    String? approvedBy,
    String? rejectedBy,
    String? suspendedBy,
    String? reason,
  });
  Future<List<AppUser>> getUsersByOrganization(String organizationId);
  Future<List<AppUser>> getPendingUsers();
  Future<List<AppUser>> getUsersByStatus(String status);

  // Additional methods for enhanced user management
  Future<List<AppUser>> getActiveUsersByOrganization(String organizationId);
  Future<bool> userExistsByEmail(String email);
  Future<void> bulkUpdateUsers(
      List<String> userIds, Map<String, dynamic> updates);
  Future<Map<String, int>> getUserCountsByStatus(String organizationId);
}

class FirestoreUserRepository implements UserRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collection = 'users';

  @override
  Future<AppUser?> getUserProfile(String uid) async {
    try {
      final doc = await _firestore.collection(_collection).doc(uid).get();

      if (doc.exists && doc.data() != null) {
        final data = doc.data()!;
        data['uid'] = uid; // Ensure uid is included

        // Additional validation to ensure required fields exist
        if (!_isValidUserData(data)) {
          throw Exception('Invalid user data structure in Firestore');
        }

        return AppUser.fromJson(data);
      }
      return null;
    } catch (e) {
      print('Error getting user profile for uid: $uid - $e');
      throw Exception('Failed to get user profile: $e');
    }
  }

  @override
  Future<void> updateUserProfile(AppUser user) async {
    try {
      final data = _prepareUserDataForFirestore(user);
      data['updatedAt'] = FieldValue.serverTimestamp();

      await _firestore.collection(_collection).doc(user.uid).update(data);
      print('User profile updated successfully: ${user.email}');
    } catch (e) {
      print('Error updating user profile for ${user.email}: $e');
      throw Exception('Failed to update user profile: $e');
    }
  }

  @override
  Future<void> createUserProfile(AppUser user) async {
    try {
      final data = _prepareUserDataForFirestore(user);
      data['createdAt'] = FieldValue.serverTimestamp();
      data['updatedAt'] = FieldValue.serverTimestamp();

      await _firestore.collection(_collection).doc(user.uid).set(data);
      print('User profile created successfully: ${user.email}');
    } catch (e) {
      print('Error creating user profile for ${user.email}: $e');
      throw Exception('Failed to create user profile: $e');
    }
  }

  @override
  Stream<AppUser?> watchUserProfile(String uid) {
    return _firestore.collection(_collection).doc(uid).snapshots().map((doc) {
      try {
        if (doc.exists && doc.data() != null) {
          final data = doc.data()!;
          data['uid'] = uid;

          if (!_isValidUserData(data)) {
            print('Warning: Invalid user data structure for uid: $uid');
            return null;
          }

          return AppUser.fromJson(data);
        }
        return null;
      } catch (e) {
        print('Error in watchUserProfile stream for uid: $uid - $e');
        return null;
      }
    });
  }

  @override
  Future<List<AppUser>> getUsersByRole(DynamicRole role) async {
    try {
      final query = await _firestore
          .collection(_collection)
          .where('role.id', isEqualTo: role.id)
          .get();

      return query.docs.map((doc) {
        final data = doc.data();
        data['uid'] = doc.id;
        return AppUser.fromJson(data);
      }).toList();
    } catch (e) {
      print('Error getting users by role ${role.displayName}: $e');
      throw Exception('Failed to get users by role: $e');
    }
  }

  @override
  Future<void> deleteUserProfile(String uid) async {
    try {
      await _firestore.collection(_collection).doc(uid).delete();
      print('User profile deleted successfully: $uid');
    } catch (e) {
      print('Error deleting user profile for uid: $uid - $e');
      throw Exception('Failed to delete user profile: $e');
    }
  }

  @override
  Future<void> updateUserStatus(
    String uid,
    String status, {
    String? approvedBy,
    String? rejectedBy,
    String? suspendedBy,
    String? reason,
  }) async {
    try {
      final updateData = <String, dynamic>{
        'status': status,
        'isActive': status == 'approved',
        'updatedAt': FieldValue.serverTimestamp(),
      };

      // Handle different status updates
      switch (status) {
        case 'approved':
          updateData['approvedAt'] = FieldValue.serverTimestamp();
          if (approvedBy != null) updateData['approvedBy'] = approvedBy;
          break;
        case 'rejected':
          updateData['rejectedAt'] = FieldValue.serverTimestamp();
          if (rejectedBy != null) updateData['rejectedBy'] = rejectedBy;
          if (reason != null) updateData['rejectionReason'] = reason;
          break;
        case 'suspended':
          updateData['suspendedAt'] = FieldValue.serverTimestamp();
          if (suspendedBy != null) updateData['suspendedBy'] = suspendedBy;
          if (reason != null) updateData['suspensionReason'] = reason;
          break;
      }

      await _firestore.collection(_collection).doc(uid).update(updateData);
      print('User status updated: $uid -> $status');
    } catch (e) {
      print('Error updating user status for uid: $uid - $e');
      throw Exception('Failed to update user status: $e');
    }
  }

  @override
  Future<List<AppUser>> getUsersByOrganization(String organizationId) async {
    try {
      final querySnapshot = await _firestore
          .collection(_collection)
          .where('organizationId', isEqualTo: organizationId)
          .orderBy('createdAt', descending: true)
          .get();

      return querySnapshot.docs.map((doc) {
        final data = doc.data();
        data['uid'] = doc.id;
        return AppUser.fromJson(data);
      }).toList();
    } catch (e) {
      print('Error getting users by organization $organizationId: $e');
      return [];
    }
  }

  @override
  Future<List<AppUser>> getPendingUsers() async {
    try {
      final querySnapshot = await _firestore
          .collection(_collection)
          .where('status', isEqualTo: 'pending')
          .orderBy('requestedAt', descending: true)
          .limit(100)
          .get();

      return querySnapshot.docs.map((doc) {
        final data = doc.data();
        data['uid'] = doc.id;
        return AppUser.fromJson(data);
      }).toList();
    } catch (e) {
      print('Error getting pending users: $e');
      return [];
    }
  }

  @override
  Future<List<AppUser>> getUsersByStatus(String status) async {
    try {
      final querySnapshot = await _firestore
          .collection(_collection)
          .where('status', isEqualTo: status)
          .orderBy('updatedAt', descending: true)
          .limit(50)
          .get();

      return querySnapshot.docs.map((doc) {
        final data = doc.data();
        data['uid'] = doc.id;
        return AppUser.fromJson(data);
      }).toList();
    } catch (e) {
      print('Error getting users by status $status: $e');
      return [];
    }
  }

  @override
  Future<List<AppUser>> getActiveUsersByOrganization(
      String organizationId) async {
    try {
      final querySnapshot = await _firestore
          .collection(_collection)
          .where('organizationId', isEqualTo: organizationId)
          .where('isActive', isEqualTo: true)
          .where('status', isEqualTo: 'approved')
          .orderBy('lastLogin', descending: true)
          .get();

      return querySnapshot.docs.map((doc) {
        final data = doc.data();
        data['uid'] = doc.id;
        return AppUser.fromJson(data);
      }).toList();
    } catch (e) {
      print('Error getting active users by organization $organizationId: $e');
      return [];
    }
  }

  @override
  Future<bool> userExistsByEmail(String email) async {
    try {
      final querySnapshot = await _firestore
          .collection(_collection)
          .where('email', isEqualTo: email)
          .limit(1)
          .get();

      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      print('Error checking if user exists by email $email: $e');
      return false;
    }
  }

  @override
  Future<void> bulkUpdateUsers(
      List<String> userIds, Map<String, dynamic> updates) async {
    try {
      final batch = _firestore.batch();
      updates['updatedAt'] = FieldValue.serverTimestamp();

      for (final uid in userIds) {
        final docRef = _firestore.collection(_collection).doc(uid);
        batch.update(docRef, updates);
      }

      await batch.commit();
      print('Bulk updated ${userIds.length} users successfully');
    } catch (e) {
      print('Error in bulk update: $e');
      throw Exception('Failed to bulk update users: $e');
    }
  }

  @override
  Future<Map<String, int>> getUserCountsByStatus(String organizationId) async {
    try {
      final counts = <String, int>{};
      final statuses = ['pending', 'approved', 'rejected', 'suspended'];

      for (final status in statuses) {
        final querySnapshot = await _firestore
            .collection(_collection)
            .where('organizationId', isEqualTo: organizationId)
            .where('status', isEqualTo: status)
            .get();

        counts[status] = querySnapshot.docs.length;
      }

      return counts;
    } catch (e) {
      print(
          'Error getting user counts by status for organization $organizationId: $e');
      return {};
    }
  }

  // Enhanced helper method to prepare user data for Firestore storage
  Map<String, dynamic> _prepareUserDataForFirestore(AppUser user) {
    try {
      final data = user.toJson();
      data.remove('uid'); // Don't store uid in document data

      // Ensure DynamicRole is properly serialized
      if (data['role'] is! Map<String, dynamic>) {
        final role = user.role;
        data['role'] = {
          'id': role.id,
          'name': role.name,
          'displayName': role.displayName,
          'hierarchyLevel': role.hierarchyLevel,
          'organizationId': role.organizationId,
          'permissions': role.permissions,
          'config': role.config,
        };
      }

      // The TimestampConverter handles DateTime serialization automatically
      // Remove any null timestamp fields to prevent Firestore issues
      final timestampFields = [
        'createdAt',
        'updatedAt',
        'lastLogin',
        'lastSynced',
        'requestedAt',
        'approvedAt',
        'rejectedAt',
        'suspendedAt',
        'passwordLastChanged',
        'termsAcceptedAt'
      ];

      for (final field in timestampFields) {
        if (data[field] == null) {
          data.remove(field);
        }
      }

      return data;
    } catch (e) {
      print('Error preparing user data for Firestore: $e');
      throw Exception('Failed to serialize user data: $e');
    }
  }

  // Enhanced helper method to validate user data structure
  bool _isValidUserData(Map<String, dynamic> data) {
    final requiredFields = ['email', 'name', 'organizationId', 'role'];

    for (final field in requiredFields) {
      if (!data.containsKey(field) || data[field] == null) {
        print('Missing required field: $field');
        return false;
      }
    }

    // Validate role structure
    if (data['role'] is! Map<String, dynamic>) {
      print('Invalid role structure');
      return false;
    }

    final roleData = data['role'] as Map<String, dynamic>;
    final requiredRoleFields = ['id', 'name', 'displayName', 'hierarchyLevel'];

    for (final field in requiredRoleFields) {
      if (!roleData.containsKey(field)) {
        print('Missing required role field: $field');
        return false;
      }
    }

    // Additional validation for dynamic role permissions
    if (roleData['permissions'] != null && roleData['permissions'] is! List) {
      print('Invalid permissions structure in role');
      return false;
    }

    return true;
  }
}
