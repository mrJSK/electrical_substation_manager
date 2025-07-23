import 'package:substation_manager_pro/models/app_user.dart';

class RoleConfig {
  static const Map<UserRole, List<String>> rolePermissions = {
    UserRole.admin: ['read_all', 'write_all', 'delete_all', 'manage_users'],
    UserRole.stateManager: ['read_state', 'write_state', 'manage_company'],
    UserRole.companyManager: ['read_company', 'write_company', 'manage_zone'],
    UserRole.zoneManager: ['read_zone', 'write_zone', 'manage_circle'],
    UserRole.circleManager: ['read_circle', 'write_circle', 'manage_division'],
    UserRole.divisionManager: [
      'read_division',
      'write_division',
      'manage_subdivision'
    ],
    UserRole.subdivisionManager: [
      'read_subdivision',
      'write_subdivision',
      'manage_substation'
    ],
    UserRole.substationUser: ['read_substation_data', 'write_substation_data'],
    UserRole.unknown: [],
  };

  static const Map<UserRole, List<String>> accessibleScreens = {
    UserRole.admin: ['dashboard', 'users', 'reports', 'settings', 'hierarchy'],
    UserRole.zoneManager: ['dashboard', 'reports', 'settings'],
    // ... define screen access for all other roles
  };
}
