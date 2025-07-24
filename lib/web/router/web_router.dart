import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import '../screens/admin_dashboard.dart';
import '../screens/organizations_screen.dart';
// import '../screens/users_screen.dart';
// import '../screens/approvals_screen.dart';
// import '../screens/substations_screen.dart';
// import '../screens/analytics_screen.dart';
// import '../screens/roles_screen.dart';
// import '../screens/settings_screen.dart';
// import '../screens/login_screen.dart';
// import '../screens/organization_details_screen.dart';
// import '../screens/user_details_screen.dart';
import '../../auth/auth_provider.dart';

final webRouter = GoRouter(
  initialLocation: '/admin',
  redirect: (context, state) {
    // Add authentication check here if needed
    // For now, allow all routes
    return null;
  },
  routes: [
    // Login Route
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => const AdminLoginScreen(),
    ),

    // Main Admin Routes
    GoRoute(
      path: '/admin',
      name: 'dashboard',
      builder: (context, state) => const AdminDashboard(),
    ),

    // Organizations Management
    GoRoute(
      path: '/admin/organizations',
      name: 'organizations',
      builder: (context, state) => const OrganizationsScreen(),
      routes: [
        GoRoute(
          path: '/create',
          name: 'create-organization',
          builder: (context, state) => const OrganizationDetailsScreen(
            isCreating: true,
          ),
        ),
        GoRoute(
          path: '/:id',
          name: 'organization-details',
          builder: (context, state) {
            final id = state.pathParameters['id']!;
            return OrganizationDetailsScreen(
              organizationId: id,
              isCreating: false,
            );
          },
          routes: [
            GoRoute(
              path: '/edit',
              name: 'edit-organization',
              builder: (context, state) {
                final id = state.pathParameters['id']!;
                return OrganizationDetailsScreen(
                  organizationId: id,
                  isCreating: false,
                  isEditing: true,
                );
              },
            ),
          ],
        ),
      ],
    ),

    // User Management
    GoRoute(
      path: '/admin/users',
      name: 'users',
      builder: (context, state) => const UsersScreen(),
      routes: [
        GoRoute(
          path: '/create',
          name: 'create-user',
          builder: (context, state) => const UserDetailsScreen(
            isCreating: true,
          ),
        ),
        GoRoute(
          path: '/:id',
          name: 'user-details',
          builder: (context, state) {
            final id = state.pathParameters['id']!;
            return UserDetailsScreen(
              userId: id,
              isCreating: false,
            );
          },
          routes: [
            GoRoute(
              path: '/edit',
              name: 'edit-user',
              builder: (context, state) {
                final id = state.pathParameters['id']!;
                return UserDetailsScreen(
                  userId: id,
                  isCreating: false,
                  isEditing: true,
                );
              },
            ),
          ],
        ),
      ],
    ),

    // User Approvals
    GoRoute(
      path: '/admin/approvals',
      name: 'approvals',
      builder: (context, state) => const ApprovalsScreen(),
      routes: [
        GoRoute(
          path: '/pending',
          name: 'pending-approvals',
          builder: (context, state) => const ApprovalsScreen(
            initialTab: 'pending',
          ),
        ),
        GoRoute(
          path: '/approved',
          name: 'approved-users',
          builder: (context, state) => const ApprovalsScreen(
            initialTab: 'approved',
          ),
        ),
        GoRoute(
          path: '/rejected',
          name: 'rejected-users',
          builder: (context, state) => const ApprovalsScreen(
            initialTab: 'rejected',
          ),
        ),
      ],
    ),

    // Substations Management
    GoRoute(
      path: '/admin/substations',
      name: 'substations',
      builder: (context, state) => const SubstationsScreen(),
      routes: [
        GoRoute(
          path: '/create',
          name: 'create-substation',
          builder: (context, state) => const SubstationDetailsScreen(
            isCreating: true,
          ),
        ),
        GoRoute(
          path: '/:id',
          name: 'substation-details',
          builder: (context, state) {
            final id = state.pathParameters['id']!;
            return SubstationDetailsScreen(
              substationId: id,
              isCreating: false,
            );
          },
        ),
        GoRoute(
          path: '/monitoring',
          name: 'substation-monitoring',
          builder: (context, state) => const SubstationMonitoringScreen(),
        ),
      ],
    ),

    // Analytics & Reports
    GoRoute(
      path: '/admin/analytics',
      name: 'analytics',
      builder: (context, state) => const AnalyticsScreen(),
      routes: [
        GoRoute(
          path: '/users',
          name: 'user-analytics',
          builder: (context, state) => const AnalyticsScreen(
            initialTab: 'users',
          ),
        ),
        GoRoute(
          path: '/organizations',
          name: 'organization-analytics',
          builder: (context, state) => const AnalyticsScreen(
            initialTab: 'organizations',
          ),
        ),
        GoRoute(
          path: '/substations',
          name: 'substation-analytics',
          builder: (context, state) => const AnalyticsScreen(
            initialTab: 'substations',
          ),
        ),
        GoRoute(
          path: '/performance',
          name: 'performance-analytics',
          builder: (context, state) => const AnalyticsScreen(
            initialTab: 'performance',
          ),
        ),
      ],
    ),

    // Roles & Permissions
    GoRoute(
      path: '/admin/roles',
      name: 'roles',
      builder: (context, state) => const RolesScreen(),
      routes: [
        GoRoute(
          path: '/create',
          name: 'create-role',
          builder: (context, state) => const RoleDetailsScreen(
            isCreating: true,
          ),
        ),
        GoRoute(
          path: '/:id',
          name: 'role-details',
          builder: (context, state) {
            final id = state.pathParameters['id']!;
            return RoleDetailsScreen(
              roleId: id,
              isCreating: false,
            );
          },
        ),
        GoRoute(
          path: '/permissions',
          name: 'permissions-management',
          builder: (context, state) => const PermissionsScreen(),
        ),
        GoRoute(
          path: '/hierarchy',
          name: 'hierarchy-management',
          builder: (context, state) => const HierarchyManagementScreen(),
        ),
      ],
    ),

    // System Settings
    GoRoute(
      path: '/admin/settings',
      name: 'settings',
      builder: (context, state) => const SettingsScreen(),
      routes: [
        GoRoute(
          path: '/general',
          name: 'general-settings',
          builder: (context, state) => const SettingsScreen(
            initialTab: 'general',
          ),
        ),
        GoRoute(
          path: '/security',
          name: 'security-settings',
          builder: (context, state) => const SettingsScreen(
            initialTab: 'security',
          ),
        ),
        GoRoute(
          path: '/integrations',
          name: 'integration-settings',
          builder: (context, state) => const SettingsScreen(
            initialTab: 'integrations',
          ),
        ),
        GoRoute(
          path: '/backup',
          name: 'backup-settings',
          builder: (context, state) => const SettingsScreen(
            initialTab: 'backup',
          ),
        ),
      ],
    ),

    // Reports Section
    GoRoute(
      path: '/admin/reports',
      name: 'reports',
      builder: (context, state) => const ReportsScreen(),
      routes: [
        GoRoute(
          path: '/user-activity',
          name: 'user-activity-report',
          builder: (context, state) => const UserActivityReportScreen(),
        ),
        GoRoute(
          path: '/system-logs',
          name: 'system-logs',
          builder: (context, state) => const SystemLogsScreen(),
        ),
        GoRoute(
          path: '/audit-trail',
          name: 'audit-trail',
          builder: (context, state) => const AuditTrailScreen(),
        ),
      ],
    ),

    // API Management
    GoRoute(
      path: '/admin/api',
      name: 'api-management',
      builder: (context, state) => const ApiManagementScreen(),
      routes: [
        GoRoute(
          path: '/keys',
          name: 'api-keys',
          builder: (context, state) => const ApiKeysScreen(),
        ),
        GoRoute(
          path: '/documentation',
          name: 'api-documentation',
          builder: (context, state) => const ApiDocumentationScreen(),
        ),
        GoRoute(
          path: '/logs',
          name: 'api-logs',
          builder: (context, state) => const ApiLogsScreen(),
        ),
      ],
    ),

    // System Monitoring
    GoRoute(
      path: '/admin/monitoring',
      name: 'system-monitoring',
      builder: (context, state) => const SystemMonitoringScreen(),
      routes: [
        GoRoute(
          path: '/performance',
          name: 'performance-monitoring',
          builder: (context, state) => const PerformanceMonitoringScreen(),
        ),
        GoRoute(
          path: '/alerts',
          name: 'system-alerts',
          builder: (context, state) => const SystemAlertsScreen(),
        ),
        GoRoute(
          path: '/health',
          name: 'system-health',
          builder: (context, state) => const SystemHealthScreen(),
        ),
      ],
    ),

    // Error Routes
    GoRoute(
      path: '/404',
      name: 'not-found',
      builder: (context, state) => const NotFoundScreen(),
    ),

    GoRoute(
      path: '/500',
      name: 'server-error',
      builder: (context, state) => const ServerErrorScreen(),
    ),
  ],

  // Error handling
  errorBuilder: (context, state) => NotFoundScreen(
    error: state.error?.toString(),
  ),

  // URL path strategy for web
  urlPathStrategy: UrlPathStrategy.path,
);

// Navigation Helper Extension
extension WebRouterExtension on GoRouter {
  void goToOrganizationDetails(String organizationId) {
    go('/admin/organizations/$organizationId');
  }

  void goToUserDetails(String userId) {
    go('/admin/users/$userId');
  }

  void goToCreateOrganization() {
    go('/admin/organizations/create');
  }

  void goToCreateUser() {
    go('/admin/users/create');
  }

  void goToPendingApprovals() {
    go('/admin/approvals/pending');
  }

  void goToAnalytics({String? tab}) {
    if (tab != null) {
      go('/admin/analytics/$tab');
    } else {
      go('/admin/analytics');
    }
  }
}

// Route Names Constants
class RouteNames {
  static const String dashboard = 'dashboard';
  static const String organizations = 'organizations';
  static const String users = 'users';
  static const String approvals = 'approvals';
  static const String substations = 'substations';
  static const String analytics = 'analytics';
  static const String roles = 'roles';
  static const String settings = 'settings';
  static const String reports = 'reports';
  static const String apiManagement = 'api-management';
  static const String monitoring = 'system-monitoring';
  static const String login = 'login';
}

// Quick Navigation Helper
class QuickNav {
  static void goToDashboard(BuildContext context) {
    context.goNamed(RouteNames.dashboard);
  }

  static void goToOrganizations(BuildContext context) {
    context.goNamed(RouteNames.organizations);
  }

  static void goToUsers(BuildContext context) {
    context.goNamed(RouteNames.users);
  }

  static void goToApprovals(BuildContext context) {
    context.goNamed(RouteNames.approvals);
  }

  static void goToAnalytics(BuildContext context) {
    context.goNamed(RouteNames.analytics);
  }
}
