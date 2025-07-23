import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../auth/auth_provider.dart';
import '../../models/app_user.dart';
import '../../widgets/app_drawer.dart';
import '../dashboards/admin_dashboard.dart';
import '../dashboards/state_manager_dashboard.dart';
import '../dashboards/company_manager_dashboard.dart';
import '../dashboards/zone_dashboard.dart';
import '../dashboards/circle_dashboard.dart';
import '../dashboards/division_dashboard.dart';
import '../dashboards/subdivision_dashboard.dart';
import '../dashboards/substation/substation_dashboard.dart';

class HomeScreen extends ConsumerWidget {
  final AppUser user;

  const HomeScreen({super.key, required this.user});

  // Use a constant map for role display names (more efficient and maintainable)
  static const Map<UserRole, String> _roleDisplayNames = {
    UserRole.admin: 'Admin',
    UserRole.stateManager: 'State Manager',
    UserRole.companyManager: 'Company Manager',
    UserRole.zoneManager: 'Zone Manager',
    UserRole.circleManager: 'Circle Manager',
    UserRole.divisionManager: 'Division Manager',
    UserRole.subdivisionManager: 'Subdivision Manager',
    UserRole.substationUser: 'Substation User',
    UserRole.unknown: 'User',
  };

  Widget _getDashboardByRole(UserRole role, String? hierarchyId) {
    // Use a map of builders instead of switch-case for cleaner code
    final dashboardBuilders = <UserRole, Widget Function()>{
      UserRole.admin: () => const AdminDashboard(),
      UserRole.stateManager: () => const StateManagerDashboard(),
      UserRole.companyManager: () =>
          CompanyManagerDashboard(companyId: hierarchyId),
      UserRole.zoneManager: () {
        if (hierarchyId == null) {
          return const Center(
            child: Text(
              'Zone ID is not assigned to your account.\nPlease contact your administrator.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          );
        }
        return ZoneDashboard(zoneId: hierarchyId);
      },
      UserRole.circleManager: () {
        if (hierarchyId == null) {
          return const Center(
            child: Text(
              'Circle ID is not assigned to your account.\nPlease contact your administrator.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          );
        }
        return CircleDashboard(circleId: hierarchyId);
      },
      UserRole.divisionManager: () {
        if (hierarchyId == null) {
          return const Center(
            child: Text(
              'Division ID is not assigned to your account.\nPlease contact your administrator.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          );
        }
        return DivisionDashboard(divisionId: hierarchyId);
      },
      UserRole.subdivisionManager: () {
        if (hierarchyId == null) {
          return const Center(
            child: Text(
              'Subdivision ID is not assigned to your account.\nPlease contact your administrator.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          );
        }
        return SubdivisionDashboard(subdivisionId: hierarchyId);
      },
      UserRole.substationUser: () =>
          SubstationDashboard(substationId: hierarchyId),
      UserRole.unknown: () => const Center(
            child: Text(
              'Unknown user role.\nPlease contact your administrator.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          ),
    };

    return dashboardBuilders[role]?.call() ?? const SubstationDashboard();
  }

  String _getRoleDisplayName(UserRole role) {
    return _roleDisplayNames[role] ?? 'User';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${_getRoleDisplayName(user.role)} Dashboard'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 2,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh User Profile',
            onPressed: () async {
              try {
                await ref
                    .read(authStateNotifierProvider.notifier)
                    .refreshUserProfile();
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Profile refreshed successfully'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Failed to refresh profile: $e'),
                      backgroundColor: Colors.red,
                      duration: const Duration(seconds: 3),
                    ),
                  );
                }
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.notifications),
            tooltip: 'Notifications',
            onPressed: () {
              // TODO: Implement notifications screen
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Notifications feature coming soon!'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            tooltip: 'More Options',
            onSelected: (value) {
              switch (value) {
                case 'profile':
                  // Navigate to profile screen
                  break;
                case 'settings':
                  // Navigate to settings screen
                  break;
                case 'help':
                  // Navigate to help screen
                  break;
              }
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem(
                value: 'profile',
                child: ListTile(
                  leading: Icon(Icons.person),
                  title: Text('Profile'),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              const PopupMenuItem(
                value: 'settings',
                child: ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Settings'),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              const PopupMenuItem(
                value: 'help',
                child: ListTile(
                  leading: Icon(Icons.help),
                  title: Text('Help'),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ],
          ),
        ],
      ),
      drawer: AppDrawer(user: user),
      body: _getDashboardByRole(user.role, user.hierarchyId),
    );
  }
}
