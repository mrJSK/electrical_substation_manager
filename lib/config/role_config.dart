import 'package:substation_manager_pro/models/app_user.dart';
import 'package:substation_manager_pro/models/dynamic_role.dart';

class RoleConfig {
  // Helper methods for working with dynamic roles - no hardcoded mappings

  /// Creates a role from configuration data (from database/organization config)
  static DynamicRole createRoleFromConfig({
    required String roleId,
    required String displayName,
    required String organizationId,
    required List<String> permissions,
    required int hierarchyLevel,
    List<String> accessibleScreens = const [],
    List<String> canManage = const [],
    Map<String, dynamic> additionalConfig = const {},
  }) {
    return DynamicRole(
      id: roleId,
      name: roleId,
      displayName: displayName,
      hierarchyLevel: hierarchyLevel,
      organizationId: organizationId,
      permissions: permissions,
      config: {
        'accessibleScreens': accessibleScreens,
        'canManage': canManage,
        'isCustomRole': true,
        'createdAt': DateTime.now().toIso8601String(),
        ...additionalConfig,
      },
    );
  }

  /// Find a role by ID from a list of dynamic roles
  static DynamicRole? findRoleById(List<DynamicRole> roles, String roleId) {
    try {
      return roles.firstWhere((role) => role.id == roleId);
    } catch (e) {
      return null;
    }
  }

  /// Check if a role has a specific permission
  static bool hasPermission(DynamicRole role, String permission) {
    return role.permissions.contains(permission) ||
        role.permissions.contains('*');
  }

  /// Check if a role can manage another role based on hierarchy
  static bool canManageRole(DynamicRole managerRole, DynamicRole targetRole) {
    // Check explicit management permissions
    final canManage = managerRole.config['canManage'] as List<dynamic>? ?? [];
    if (canManage.contains('*') || canManage.contains(targetRole.name)) {
      return true;
    }

    // Check hierarchy levels (lower number = higher hierarchy)
    return managerRole.hierarchyLevel < targetRole.hierarchyLevel;
  }

  /// Get accessible screens for a role
  static List<String> getAccessibleScreens(DynamicRole role) {
    return List<String>.from(role.config['accessibleScreens'] as List? ?? []);
  }

  /// Check if a role can access a specific screen
  static bool canAccessScreen(DynamicRole role, String screenName) {
    final accessibleScreens = getAccessibleScreens(role);
    return accessibleScreens.contains(screenName) ||
        accessibleScreens.contains('*');
  }

  /// Sort roles by hierarchy level (ascending - higher roles first)
  static List<DynamicRole> sortRolesByHierarchy(List<DynamicRole> roles) {
    final sortedRoles = List<DynamicRole>.from(roles);
    sortedRoles.sort((a, b) => a.hierarchyLevel.compareTo(b.hierarchyLevel));
    return sortedRoles;
  }

  /// Get roles that can be managed by a specific role
  static List<DynamicRole> getManagedRoles(
    DynamicRole managerRole,
    List<DynamicRole> allRoles,
  ) {
    return allRoles.where((role) => canManageRole(managerRole, role)).toList();
  }

  /// Filter roles by permission
  static List<DynamicRole> getRolesWithPermission(
    List<DynamicRole> roles,
    String permission,
  ) {
    return roles.where((role) => hasPermission(role, permission)).toList();
  }

  /// Clone a role with modifications
  static DynamicRole cloneRole(
    DynamicRole originalRole, {
    String? newId,
    String? newDisplayName,
    List<String>? additionalPermissions,
    List<String>? removedPermissions,
    Map<String, dynamic>? configUpdates,
  }) {
    final newPermissions = List<String>.from(originalRole.permissions);

    if (additionalPermissions != null) {
      newPermissions.addAll(additionalPermissions);
    }

    if (removedPermissions != null) {
      newPermissions.removeWhere((p) => removedPermissions.contains(p));
    }

    return DynamicRole(
      id: newId ?? '${originalRole.id}_copy',
      name: newId ?? '${originalRole.name}_copy',
      displayName: newDisplayName ?? '${originalRole.displayName} (Copy)',
      hierarchyLevel: originalRole.hierarchyLevel,
      organizationId: originalRole.organizationId,
      permissions: newPermissions.toSet().toList(), // Remove duplicates
      config: {
        ...originalRole.config,
        'isCloned': true,
        'originalRoleId': originalRole.id,
        'clonedAt': DateTime.now().toIso8601String(),
        ...?configUpdates,
      },
    );
  }

  /// Validate if a role configuration is valid
  static bool isValidRoleConfig(Map<String, dynamic> roleConfig) {
    final requiredFields = [
      'id',
      'displayName',
      'hierarchyLevel',
      'permissions'
    ];
    return requiredFields.every((field) => roleConfig.containsKey(field));
  }

  /// Convert role to JSON for storage
  static Map<String, dynamic> roleToJson(DynamicRole role) {
    return {
      'id': role.id,
      'name': role.name,
      'displayName': role.displayName,
      'hierarchyLevel': role.hierarchyLevel,
      'organizationId': role.organizationId,
      'permissions': role.permissions,
      'config': role.config,
    };
  }

  /// Create role from JSON data
  static DynamicRole roleFromJson(Map<String, dynamic> json) {
    return DynamicRole(
      id: json['id'] as String,
      name: json['name'] as String,
      displayName: json['displayName'] as String,
      hierarchyLevel: json['hierarchyLevel'] as int,
      organizationId: json['organizationId'] as String,
      permissions: List<String>.from(json['permissions'] as List),
      config: Map<String, dynamic>.from(json['config'] as Map? ?? {}),
    );
  }

  /// Get the highest hierarchy role from a list
  static DynamicRole? getHighestHierarchyRole(List<DynamicRole> roles) {
    if (roles.isEmpty) return null;
    return roles.reduce((current, next) =>
        current.hierarchyLevel < next.hierarchyLevel ? current : next);
  }

  /// Get the lowest hierarchy role from a list (useful for default user role)
  static DynamicRole? getLowestHierarchyRole(List<DynamicRole> roles) {
    if (roles.isEmpty) return null;
    return roles.reduce((current, next) =>
        current.hierarchyLevel > next.hierarchyLevel ? current : next);
  }

  /// Check if user has any of the specified permissions
  static bool hasAnyPermission(DynamicRole role, List<String> permissions) {
    return permissions.any((permission) => hasPermission(role, permission));
  }

  /// Check if user has all of the specified permissions
  static bool hasAllPermissions(DynamicRole role, List<String> permissions) {
    return permissions.every((permission) => hasPermission(role, permission));
  }
}
