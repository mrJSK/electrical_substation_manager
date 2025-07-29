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

  /// Returns a Map<String, bool> indicating the permissions the user has
  Future<Map<String, bool>> getUserPermissions(String userId) async {
    // Validate input
    if (userId.isEmpty) {
      debugPrint('Error: userId is empty');
      return _getDefaultPermissions();
    }

    // Return cached permissions if valid
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
        debugPrint('User document does not exist for userId: $userId');
        return _getDefaultPermissions();
      }

      final userData = userDoc.data();
      if (userData == null) {
        debugPrint('User data is null for userId: $userId');
        return _getDefaultPermissions();
      }

      final user = UserModel.fromJson(userData);
      final permissions = <String>{};

      // Get role-based permissions - handle null organizationId
      if (user.roles.isNotEmpty &&
          user.organizationId != null &&
          user.organizationId!.isNotEmpty) {
        try {
          final rolePermissions =
              await _getRolePermissionsBatch(user.roles, user.organizationId!);
          permissions.addAll(rolePermissions);
        } catch (e) {
          debugPrint('Error fetching role permissions: $e');
        }
      }

      // Get direct user permissions - handle null permissions map
      if (user.permissions.isNotEmpty) {
        user.permissions.forEach((key, value) {
          // Handle null keys and values
          if (key != null && key.isNotEmpty && value == true) {
            permissions.add(key);
          }
        });
      }

      // If user has no specific permissions, give basic permissions
      if (permissions.isEmpty) {
        debugPrint(
            'No permissions found for user $userId, assigning default permissions');
        permissions.addAll(_getDefaultPermissionsList());
      }

      // Convert Set<String> to Map<String, bool> for fast lookup
      final Map<String, bool> permissionMap = {};
      for (final permission in permissions) {
        if (permission.isNotEmpty) {
          permissionMap[permission] = true;
        }
      }

      // Cache and return
      _permissionCache[userId] = CachedPermissions(
        permissions: permissionMap,
        cachedAt: DateTime.now(),
      );

      debugPrint('Cached ${permissionMap.length} permissions for user $userId');
      return permissionMap;
    } catch (e) {
      debugPrint('Error fetching permissions for user $userId: $e');
      debugPrint('Stack trace: ${StackTrace.current}');

      // Try to return cached data on error
      if (_permissionCache.containsKey(userId)) {
        debugPrint(
            'Returning stale cached permissions for user $userId due to error');
        return _permissionCache[userId]!.permissions;
      }

      // Return basic permissions on error to prevent app crash
      return _getDefaultPermissions();
    }
  }

  /// Get default permissions for users when no specific permissions are found
  Map<String, bool> _getDefaultPermissions() {
    return {
      'view_dashboard': true,
      'viewer': true,
      'basic_access': true,
    };
  }

  /// Get default permissions as a list
  List<String> _getDefaultPermissionsList() {
    return ['view_dashboard', 'viewer', 'basic_access'];
  }

  /// Batch fetch role permissions for a list of role IDs
  Future<List<String>> _getRolePermissionsBatch(
      List<String> roleIds, String organizationId) async {
    if (roleIds.isEmpty || organizationId.isEmpty) {
      debugPrint('Empty roleIds or organizationId provided');
      return [];
    }

    try {
      // Filter out null/empty role IDs
      final validRoleIds = roleIds.where((id) => id.isNotEmpty).toList();
      if (validRoleIds.isEmpty) {
        debugPrint('No valid role IDs after filtering');
        return [];
      }

      final rolesQuery = await _firestore
          .collection(AppConstants.rolesCollection)
          .where(FieldPath.documentId, whereIn: validRoleIds)
          .where('organizationId', isEqualTo: organizationId)
          .where('isActive', isEqualTo: true)
          .get();

      final permissions = <String>{};
      for (final roleDoc in rolesQuery.docs) {
        try {
          final roleData = roleDoc.data();
          if (roleData != null) {
            final role = RoleModel.fromJson(roleData);
            // Handle null permissions in role
            if (role.permissions.isNotEmpty) {
              final validPermissions = role.permissions
                  .where((p) => p != null && p.isNotEmpty)
                  .cast<String>();
              permissions.addAll(validPermissions);
            }
          }
        } catch (e) {
          debugPrint('Error parsing role document ${roleDoc.id}: $e');
        }
      }

      debugPrint(
          'Found ${permissions.length} role-based permissions for organization $organizationId');
      return permissions.toList();
    } catch (e) {
      debugPrint('Error fetching role permissions: $e');
      return [];
    }
  }

  /// Checks if user has a specific permission, with optional context for constraints
  Future<bool> hasPermission(String userId, String permission,
      {Map<String, dynamic>? context}) async {
    if (userId.isEmpty || permission.isEmpty) {
      return false;
    }

    try {
      final userPermissions = await getUserPermissions(userId);

      if (userPermissions[permission] != true) {
        return false;
      }

      if (context != null) {
        return await _evaluateContextualConstraints(
            userId, permission, context);
      }

      return true;
    } catch (e) {
      debugPrint('Error checking permission $permission for user $userId: $e');
      return false; // Fail safely (deny access) on error
    }
  }

  /// Batch check multiple permissions at once
  Future<Map<String, bool>> checkMultiplePermissions(
      String userId, List<String> permissions) async {
    if (userId.isEmpty || permissions.isEmpty) {
      return {};
    }

    try {
      final userPermissions = await getUserPermissions(userId);

      return Map.fromEntries(
        permissions
            .where((perm) => perm.isNotEmpty)
            .map((perm) => MapEntry(perm, userPermissions[perm] == true)),
      );
    } catch (e) {
      debugPrint('Error checking multiple permissions for user $userId: $e');
      return Map.fromEntries(
        permissions.map((perm) => MapEntry(perm, false)),
      );
    }
  }

  /// Evaluate contextual constraints (extend as per your rules)
  Future<bool> _evaluateContextualConstraints(
      String userId, String permission, Map<String, dynamic> context) async {
    try {
      if (context.containsKey('organizationalUnit')) {
        final unitId = context['organizationalUnit'];
        if (unitId != null && unitId.toString().isNotEmpty) {
          return await _canAccessOrganizationalUnit(userId, unitId.toString());
        }
      }

      if (context.containsKey('dataScope')) {
        final scope = context['dataScope'];
        if (scope != null && scope.toString().isNotEmpty) {
          return await _canAccessDataScope(userId, scope.toString());
        }
      }

      // No specific constraints, allow
      return true;
    } catch (e) {
      debugPrint('Error evaluating contextual constraints: $e');
      return false; // Fail safely
    }
  }

  /// Check if user belongs to organizational unit or is admin
  Future<bool> _canAccessOrganizationalUnit(
      String userId, String unitId) async {
    if (userId.isEmpty || unitId.isEmpty) {
      return false;
    }

    try {
      final userDoc = await _firestore
          .collection(AppConstants.usersCollection)
          .doc(userId)
          .get();

      if (!userDoc.exists) {
        debugPrint(
            'User document not found for organizational unit check: $userId');
        return false;
      }

      final userData = userDoc.data();
      if (userData == null) {
        debugPrint('User data is null for organizational unit check: $userId');
        return false;
      }

      final user = UserModel.fromJson(userData);

      return (user.departmentId != null && user.departmentId == unitId) ||
          user.roles.contains('admin');
    } catch (e) {
      debugPrint('Error checking organizational unit access: $e');
      return false;
    }
  }

  /// Check data scope access level for user
  Future<bool> _canAccessDataScope(String userId, String scope) async {
    if (userId.isEmpty || scope.isEmpty) {
      return false;
    }

    try {
      final userDoc = await _firestore
          .collection(AppConstants.usersCollection)
          .doc(userId)
          .get();

      if (!userDoc.exists) {
        debugPrint('User document not found for data scope check: $userId');
        return false;
      }

      final userData = userDoc.data();
      if (userData == null) {
        debugPrint('User data is null for data scope check: $userId');
        return false;
      }

      final user = UserModel.fromJson(userData);

      switch (scope.toLowerCase()) {
        case 'organization':
          return user.roles.contains('admin');
        case 'department':
          return user.roles.contains('manager') || user.roles.contains('admin');
        case 'team':
          return true; // Everyone can access team level
        default:
          return false;
      }
    } catch (e) {
      debugPrint('Error checking data scope access: $e');
      return false;
    }
  }

  /// Check if cached permissions are valid (not expired)
  bool _isCacheValid(String userId) {
    if (userId.isEmpty || !_permissionCache.containsKey(userId)) {
      return false;
    }

    final cached = _permissionCache[userId]!;
    return DateTime.now().difference(cached.cachedAt) < _cacheTimeout;
  }

  /// Clear cached permissions for given user
  void clearUserCache(String userId) {
    if (userId.isNotEmpty) {
      _permissionCache.remove(userId);
      debugPrint('Cleared permission cache for user: $userId');
    }
  }

  /// Clear entire permissions cache
  void clearAllCache() {
    final cacheSize = _permissionCache.length;
    _permissionCache.clear();
    debugPrint('Cleared all permission cache ($cacheSize entries)');
  }

  /// Get simple cache statistics
  Map<String, dynamic> getCacheStats() {
    return {
      'cached_users': _permissionCache.length,
      'cache_timeout_hours': _cacheTimeout.inHours,
      'last_accessed': DateTime.now().toIso8601String(),
      'cache_entries': _permissionCache.keys.toList(),
    };
  }

  /// Convenience: Get user permissions as List of granted keys
  Future<List<String>> getUserPermissionsList(String userId) async {
    try {
      final permissionsMap = await getUserPermissions(userId);
      return permissionsMap.entries
          .where((e) => e.value == true)
          .map((e) => e.key)
          .toList();
    } catch (e) {
      debugPrint('Error getting user permissions list: $e');
      return _getDefaultPermissionsList();
    }
  }

  /// Check if user has admin privileges
  Future<bool> isAdmin(String userId) async {
    try {
      final permissions = await getUserPermissions(userId);
      return permissions['admin'] == true || permissions['super_admin'] == true;
    } catch (e) {
      debugPrint('Error checking admin status: $e');
      return false;
    }
  }

  /// Get user role priority (higher number = more privileges)
  Future<int> getUserRolePriority(String userId) async {
    try {
      final permissions = await getUserPermissions(userId);

      if (permissions['super_admin'] == true) return 100;
      if (permissions['admin'] == true) return 90;
      if (permissions['manager'] == true) return 80;
      if (permissions['supervisor'] == true) return 70;
      if (permissions['technician'] == true) return 60;
      if (permissions['operator'] == true) return 50;
      if (permissions['viewer'] == true) return 40;

      return 10; // Default/guest level
    } catch (e) {
      debugPrint('Error getting user role priority: $e');
      return 10;
    }
  }

  /// Refresh permissions for a user (bypass cache)
  Future<Map<String, bool>> refreshUserPermissions(String userId) async {
    // Clear cache first
    clearUserCache(userId);
    // Fetch fresh permissions
    return await getUserPermissions(userId);
  }

  /// Get debug permissions for testing (returns all permissions)
  Future<Map<String, bool>> getDebugPermissions(String userId) async {
    debugPrint('Getting debug permissions for user: $userId');

    // Return comprehensive permissions for testing
    return {
      'view_dashboard': true,
      'view_equipment': true,
      'view_maintenance': true,
      'view_reports': true,
      'view_analytics': true,
      'edit_equipment': true,
      'edit_maintenance': true,
      'create_reports': true,
      'delete_records': true,
      'manage_users': true,
      'admin': true,
      'super_admin': true,
      'viewer': true,
      'operator': true,
      'technician': true,
      'supervisor': true,
      'manager': true,
    };
  }

  /// Validate permissions structure
  bool _validatePermissionsStructure(Map<String, dynamic> permissions) {
    if (permissions.isEmpty) return false;

    // Check if all values are boolean
    return permissions.values.every((value) => value is bool);
  }

  /// Clean up expired cache entries
  void cleanupExpiredCache() {
    final now = DateTime.now();
    final expiredKeys = <String>[];

    _permissionCache.forEach((userId, cached) {
      if (now.difference(cached.cachedAt) >= _cacheTimeout) {
        expiredKeys.add(userId);
      }
    });

    for (final key in expiredKeys) {
      _permissionCache.remove(key);
    }

    if (expiredKeys.isNotEmpty) {
      debugPrint(
          'Cleaned up ${expiredKeys.length} expired permission cache entries');
    }
  }
}

/// Cached permissions structure
class CachedPermissions {
  final Map<String, bool> permissions;
  final DateTime cachedAt;

  CachedPermissions({
    required this.permissions,
    required this.cachedAt,
  });

  /// Check if this cache entry is expired
  bool isExpired(Duration timeout) {
    return DateTime.now().difference(cachedAt) >= timeout;
  }

  /// Get a copy of permissions
  Map<String, bool> copyPermissions() {
    return Map<String, bool>.from(permissions);
  }

  @override
  String toString() {
    return 'CachedPermissions(permissions: ${permissions.length} entries, cachedAt: $cachedAt)';
  }
}
