class AppConstants {
  // App Info
  static const String appName = 'Substation Manager Pro';
  static const String appVersion = '1.0.0';

  // Firebase Collections
  static const String usersCollection = 'users';
  static const String organizationsCollection = 'organizations';
  static const String dynamicModelsCollection = 'dynamic_models';
  static const String permissionPoliciesCollection = 'permission_policies';
  static const String rolesCollection = 'roles';
  static const String orgUnitsCollection = 'organizational_units';
  static const String formsConfigCollection = 'forms_config';
  static const String screensConfigCollection = 'screens_config';

  // Default Permissions
  static const List<String> adminPermissions = [
    'view_dashboard',
    'manage_users',
    'manage_roles',
    'manage_organization',
    'create_models',
    'edit_models',
    'delete_models',
    'view_reports',
    'export_data',
  ];

  static const List<String> managerPermissions = [
    'view_dashboard',
    'manage_users',
    'view_reports',
    'create_records',
    'edit_records',
  ];

  static const List<String> operatorPermissions = [
    'view_dashboard',
    'create_records',
    'edit_records',
  ];

  // Asset Paths
  static const String logoPath = 'assets/logo.png';
  static const String googleLogoPath = 'assets/google_logo.webp';
}
