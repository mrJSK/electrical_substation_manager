import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_user.freezed.dart';
part 'app_user.g.dart';

enum UserRole {
  admin,
  stateManager,
  companyManager,
  zoneManager,
  circleManager,
  divisionManager,
  subdivisionManager,
  substationUser,
  unknown,
}

enum AuthError {
  networkError,
  permissionDenied,
  userNotFound,
  invalidRole,
  unknown,
}

@freezed
class AuthState with _$AuthState {
  const factory AuthState.loading() = _Loading;
  const factory AuthState.authenticated(AppUser user) = _Authenticated;
  const factory AuthState.unauthenticated() = _Unauthenticated;
  const factory AuthState.error(AuthError error, String message) = _Error;
}

@freezed
class AppUser with _$AppUser {
  const factory AppUser({
    required String uid,
    required String email,
    required String name,
    String? photoUrl,
    required UserRole role,
    String? hierarchyId,
    @Default([]) List<String> permissions,
    @Default({}) Map<String, dynamic> roleData,
    DateTime? lastLogin,
    @Default(true) bool isActive,
    DateTime? lastSynced,
  }) = _AppUser;

  factory AppUser.fromJson(Map<String, dynamic> json) =>
      _$AppUserFromJson(json);

  // Add helper methods
  const AppUser._();

  bool hasPermission(String permission) => permissions.contains(permission);

  bool canAccessHierarchy(String hierarchyId) {
    switch (role) {
      case UserRole.admin:
        return true;
      case UserRole.zoneManager:
        return roleData['accessibleZones']?.contains(hierarchyId) ?? false;
      case UserRole.circleManager:
        return roleData['accessibleCircles']?.contains(hierarchyId) ?? false;
      case UserRole.divisionManager:
        return roleData['accessibleDivisions']?.contains(hierarchyId) ?? false;
      case UserRole.subdivisionManager:
        return this.hierarchyId == hierarchyId;
      default:
        return this.hierarchyId == hierarchyId;
    }
  }
}

class RoleConfig {
  static const Map<UserRole, List<String>> rolePermissions = {
    UserRole.admin: ['read_all', 'write_all', 'delete_all', 'manage_users'],
    UserRole.stateManager: ['read_state', 'write_state', 'manage_companies'],
    UserRole.companyManager: ['read_company', 'write_company', 'manage_zones'],
    UserRole.zoneManager: ['read_zone', 'write_zone', 'manage_circles'],
    UserRole.circleManager: ['read_circle', 'write_circle', 'manage_divisions'],
    UserRole.divisionManager: [
      'read_division',
      'write_division',
      'manage_subdivisions'
    ],
    UserRole.subdivisionManager: [
      'read_subdivision',
      'write_subdivision',
      'manage_substations'
    ],
    UserRole.substationUser: ['read_substation', 'write_substation'],
  };

  static const Map<UserRole, List<String>> accessibleScreens = {
    UserRole.admin: ['dashboard', 'users', 'reports', 'settings', 'analytics'],
    UserRole.stateManager: ['dashboard', 'companies', 'reports', 'analytics'],
    UserRole.companyManager: ['dashboard', 'zones', 'reports'],
    UserRole.zoneManager: ['dashboard', 'circles', 'reports'],
    UserRole.circleManager: ['dashboard', 'divisions', 'reports'],
    UserRole.divisionManager: ['dashboard', 'subdivisions', 'reports'],
    UserRole.subdivisionManager: ['dashboard', 'substations', 'reports'],
    UserRole.substationUser: ['dashboard', 'substation_details'],
  };

  static List<String> getPermissionsForRole(UserRole role) {
    return rolePermissions[role] ?? [];
  }

  static List<String> getScreensForRole(UserRole role) {
    return accessibleScreens[role] ?? [];
  }
}
