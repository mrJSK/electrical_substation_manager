import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/foundation.dart';
import '../models/user_model.dart';
import '../models/role_model.dart';
import '../constants/app_constants.dart';
import 'enhanced_isar_service.dart'; // Use the enhanced Isar service

class ScalablePermissionService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Use in-memory cache for frequently accessed permissions
  final Map<String, CachedPermissions> _memoryCache = {};
  static const Duration _cacheTimeout = Duration(hours: 2);

  // Batch permission checks with multi-level caching
  Future<Map<String, bool>> checkMultiplePermissions(
      String userId, List<String> permissions) async {
    // Try memory cache first
    if (_isMemoryCacheValid(userId)) {
      debugPrint('Permission memory cache HIT for user: $userId');
      final cachedPermissions = _memoryCache[userId]!.permissions;
      return Map.fromEntries(
          permissions.map((p) => MapEntry(p, cachedPermissions.contains(p))));
    }

    // Try Isar cache second
    final cachedFromIsar =
        await EnhancedIsarService.getCachedUserPermissions(userId);
    if (cachedFromIsar != null) {
      debugPrint('Permission Isar cache HIT for user: $userId');

      // Promote to memory cache
      _memoryCache[userId] = CachedPermissions(
        permissions: cachedFromIsar,
        cachedAt: DateTime.now(),
      );

      return Map.fromEntries(
          permissions.map((p) => MapEntry(p, cachedFromIsar.contains(p))));
    }

    // Fetch from network and cache at all levels
    debugPrint(
        'Permission cache MISS for user: $userId - Fetching from network');
    final userPermissions = await _fetchUserPermissionsOptimized(userId);

    // Cache in memory
    _memoryCache[userId] = CachedPermissions(
      permissions: userPermissions,
      cachedAt: DateTime.now(),
    );

    // Cache in Isar
    await EnhancedIsarService.cacheUserPermissions(
      userId,
      userPermissions,
      _cacheTimeout,
    );

    return Map.fromEntries(
        permissions.map((p) => MapEntry(p, userPermissions.contains(p))));
  }

  // Single optimized query instead of multiple
  Future<List<String>> _fetchUserPermissionsOptimized(String userId) async {
    try {
      // Try Cloud Function first for complex permission resolution
      final callable =
          FirebaseFunctions.instance.httpsCallable('getUserPermissions');
      final result = await callable.call({'userId': userId});
      return List<String>.from(result.data['permissions']);
    } catch (e) {
      debugPrint('Cloud Function failed, using Firestore fallback: $e');
      // Fallback to direct Firestore query
      return await _fetchUserPermissionsFallback(userId);
    }
  }

  // Fallback method using direct Firestore queries
  Future<List<String>> _fetchUserPermissionsFallback(String userId) async {
    try {
      final userDoc = await _firestore
          .collection(AppConstants.usersCollection)
          .doc(userId)
          .get();

      if (!userDoc.exists) return [];

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

      return permissions.toList();
    } catch (e) {
      debugPrint('Error fetching user permissions fallback: $e');
      return [];
    }
  }

  // Batch fetch role permissions
  Future<List<String>> _getRolePermissionsBatch(
      List<String> roleIds, String organizationId) async {
    if (roleIds.isEmpty) return [];

    try {
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

  // Single permission check
  Future<bool> hasPermission(String userId, String permission) async {
    final permissions = await checkMultiplePermissions(userId, [permission]);
    return permissions[permission] ?? false;
  }

  // Memory cache validation
  bool _isMemoryCacheValid(String userId) {
    if (!_memoryCache.containsKey(userId)) return false;

    final cached = _memoryCache[userId]!;
    return DateTime.now().difference(cached.cachedAt) < _cacheTimeout;
  }

  // Cache management
  Future<void> clearUserCache(String userId) async {
    _memoryCache.remove(userId);
    await EnhancedIsarService.clearUserPermissions(userId);
  }

  void clearAllMemoryCache() {
    _memoryCache.clear();
  }

  Map<String, dynamic> getCacheStats() {
    return {
      'memory_cached_users': _memoryCache.length,
      'cache_timeout_hours': _cacheTimeout.inHours,
      'last_accessed': DateTime.now().toIso8601String(),
    };
  }
}

// Cache data structure for memory cache
class CachedPermissions {
  final List<String> permissions;
  final DateTime cachedAt;

  CachedPermissions({
    required this.permissions,
    required this.cachedAt,
  });
}
