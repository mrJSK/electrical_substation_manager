import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/app_user.dart';
import '../models/dynamic_role.dart';

abstract class UserRepository {
  Future<AppUser?> getUserProfile(String uid); // ← Fix return type
  Future<void> updateUserProfile(AppUser user); // ← Fix return type
  Future<void> createUserProfile(AppUser user); // ← Fix return type
  Stream<AppUser?> watchUserProfile(String uid); // ← Fix return type
  Future<List<AppUser>> getUsersByRole(DynamicRole role); // ← Use DynamicRole
  Future<void> deleteUserProfile(String uid); // ← Fix return type
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
        return AppUser.fromJson(data);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to get user profile: $e');
    }
  }

  @override
  Future<void> updateUserProfile(AppUser user) async {
    try {
      final data = user.toJson();
      data.remove('uid'); // Don't store uid in document data

      await _firestore.collection(_collection).doc(user.uid).update(data);
    } catch (e) {
      throw Exception('Failed to update user profile: $e');
    }
  }

  @override
  Future<void> createUserProfile(AppUser user) async {
    try {
      final data = user.toJson();
      data.remove('uid'); // Don't store uid in document data
      data['createdAt'] = FieldValue.serverTimestamp();
      data['updatedAt'] = FieldValue.serverTimestamp();

      await _firestore.collection(_collection).doc(user.uid).set(data);
    } catch (e) {
      throw Exception('Failed to create user profile: $e');
    }
  }

  @override
  Stream<AppUser?> watchUserProfile(String uid) {
    return _firestore.collection(_collection).doc(uid).snapshots().map((doc) {
      if (doc.exists && doc.data() != null) {
        final data = doc.data()!;
        data['uid'] = uid;
        return AppUser.fromJson(data);
      }
      return null;
    });
  }

  @override
  Future<List<AppUser>> getUsersByRole(DynamicRole role) async {
    try {
      final query = await _firestore
          .collection(_collection)
          .where('role.id', isEqualTo: role.id) // ← Updated for DynamicRole
          .get();

      return query.docs.map((doc) {
        final data = doc.data();
        data['uid'] = doc.id;
        return AppUser.fromJson(data);
      }).toList();
    } catch (e) {
      throw Exception('Failed to get users by role: $e');
    }
  }

  @override
  Future<void> deleteUserProfile(String uid) async {
    try {
      await _firestore.collection(_collection).doc(uid).delete();
    } catch (e) {
      throw Exception('Failed to delete user profile: $e');
    }
  }
}
