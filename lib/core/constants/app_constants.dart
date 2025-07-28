class AppConstants {
  // App Info
  static const String appName = 'Electrical Substation Manager';
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
  static const String dashboardConfigsCollection = 'dashboard_configs';

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
    'admin_access',
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
  static const String logoPath = 'assets/images/logo.png';
  static const String googleLogoPath = 'assets/images/google_logo.png';

  // Default Values
  static const String defaultOrganization = 'default_org';
  static const List<String> defaultRoles = ['operator'];

  // Cache Settings
  static const Duration defaultCacheDuration = Duration(hours: 1);
  static const Duration permissionCacheDuration = Duration(hours: 2);
  static const Duration userCacheDuration = Duration(minutes: 30);

  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;

  // UI Constants
  static const double defaultPadding = 16.0;
  static const double defaultBorderRadius = 8.0;
  static const int maxWidgetsPerDashboard = 20;
}
