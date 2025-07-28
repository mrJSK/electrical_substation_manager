import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../models/user_model.dart';
import '../models/role_model.dart';
import '../constants/app_constants.dart';

class PermissionService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Cache for permissions with expiration
  final Map<String, CachedPermissions> _permissionCache = {};
  static const Duration _cacheTimeout = Duration(hours: 2);

  // Get all permissions for a user with caching
  Future<List<String>> getUserPermissions(String userId) async {
    // Check cache first
    if (_isCacheValid(userId)) {
      debugPrint('Permission cache HIT for user: $userId');
      return _permissionCache[userId]!.permissions;
    }

    try {
      debugPrint(
          'Permission cache MISS for user: $userId - Fetching from Firestore');

      final userDoc = await _firestore
          .collection(AppConstants.usersCollection)
          .doc(userId)
          .get();

      if (!userDoc.exists) {
        return [];
      }

      final user = UserModel.fromFirestore(userDoc);
      final permissions = <String>{};

      // Get role-based permissions
      if (user.roles.isNotEmpty) {
        final rolePermissions =
            await _getRolePermissionsBatch(user.roles, user.organizationId);
        permissions.addAll(rolePermissions);
      }

      // Get direct user permissions
      if (user.permissions.isNotEmpty) {
        final directPermissions =
            List<String>.from(user.permissions['direct'] ?? []);
        permissions.addAll(directPermissions);
      }

      final result = permissions.toList();

      // Update cache
      _permissionCache[userId] = CachedPermissions(
        permissions: result,
        cachedAt: DateTime.now(),
      );

      return result;
    } catch (e) {
      debugPrint('Error fetching permissions for user $userId: $e');
      return [];
    }
  }

  // Batch fetch role permissions for better performance
  Future<List<String>> _getRolePermissionsBatch(
      List<String> roleIds, String organizationId) async {
    if (roleIds.isEmpty) return [];

    try {
      // Batch query for all roles at once
      final rolesQuery = await _firestore
          .collection(AppConstants.rolesCollection)
          .where(FieldPath.documentId, whereIn: roleIds)
          .where('organizationId', isEqualTo: organizationId)
          .where('isActive', isEqualTo: true)
          .get();

      final permissions = <String>{};
      for (final roleDoc in rolesQuery.docs) {
        final role = RoleModel.fromFirestore(roleDoc);
        permissions.addAll(role.permissions);
      }

      return permissions.toList();
    } catch (e) {
      debugPrint('Error fetching role permissions: $e');
      return [];
    }
  }

  // Check if user has specific permission
  Future<bool> hasPermission(String userId, String permission,
      {Map<String, dynamic>? context}) async {
    try {
      final userPermissions = await getUserPermissions(userId);

      if (!userPermissions.contains(permission)) {
        return false;
      }

      // Apply contextual constraints if provided
      if (context != null) {
        return await _evaluateContextualConstraints(
            userId, permission, context);
      }

      return true;
    } catch (e) {
      debugPrint('Error checking permission $permission for user $userId: $e');
      return false; // Fail securely
    }
  }

  // Batch permission checking
  Future<Map<String, bool>> checkMultiplePermissions(
      String userId, List<String> permissions) async {
    final userPermissions = await getUserPermissions(userId);

    return Map.fromEntries(
        permissions.map((p) => MapEntry(p, userPermissions.contains(p))));
  }

  // Evaluate contextual constraints
  Future<bool> _evaluateContextualConstraints(
      String userId, String permission, Map<String, dynamic> context) async {
    if (context.containsKey('organizationalUnit')) {
      return await _canAccessOrganizationalUnit(
          userId, context['organizationalUnit']);
    }

    if (context.containsKey('dataScope')) {
      return await _canAccessDataScope(userId, context['dataScope']);
    }

    return true;
  }

  Future<bool> _canAccessOrganizationalUnit(
      String userId, String unitId) async {
    // Simplified implementation - extend based on your org structure
    final userDoc = await _firestore
        .collection(AppConstants.usersCollection)
        .doc(userId)
        .get();

    if (!userDoc.exists) return false;

    final user = UserModel.fromFirestore(userDoc);

    // Check if user belongs to this unit or has admin role
    return user.departmentId == unitId || user.roles.contains('admin');
  }

  Future<bool> _canAccessDataScope(String userId, String scope) async {
    final userDoc = await _firestore
        .collection(AppConstants.usersCollection)
        .doc(userId)
        .get();

    if (!userDoc.exists) return false;

    final user = UserModel.fromFirestore(userDoc);

    switch (scope) {
      case 'organization':
        return user.roles.contains('admin');
      case 'department':
        return user.roles.contains('manager') || user.roles.contains('admin');
      case 'team':
        return true; // All users can access team level
      default:
        return false;
    }
  }

  // Cache management
  bool _isCacheValid(String userId) {
    if (!_permissionCache.containsKey(userId)) {
      return false;
    }

    final cached = _permissionCache[userId]!;
    return DateTime.now().difference(cached.cachedAt) < _cacheTimeout;
  }

  void clearUserCache(String userId) {
    _permissionCache.remove(userId);
  }

  void clearAllCache() {
    _permissionCache.clear();
  }

  Map<String, dynamic> getCacheStats() {
    return {
      'cached_users': _permissionCache.length,
      'cache_timeout_hours': _cacheTimeout.inHours,
      'last_accessed': DateTime.now().toIso8601String(),
    };
  }
}

// Cache data structure
class CachedPermissions {
  final List<String> permissions;
  final DateTime cachedAt;

  CachedPermissions({
    required this.permissions,
    required this.cachedAt,
  });
}
