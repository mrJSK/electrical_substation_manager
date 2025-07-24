import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/app_user.dart';
import '../models/dynamic_role.dart';
import '../auth/auth_provider.dart';
import '../providers/connectivity_provider.dart';

class AppDrawer extends ConsumerWidget {
  final AppUser user;

  const AppDrawer({super.key, required this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch for real-time updates
    final currentUser = ref.watch(currentUserProvider) ?? user;
    final isConnected = ref.watch(connectivityNotifierProvider);

    return Drawer(
      child: Column(
        children: [
          _buildEnhancedHeader(context, currentUser, isConnected),
          _buildNavigationSection(context, ref, currentUser),
          _buildBottomSection(context, ref, currentUser),
        ],
      ),
    );
  }

  Widget _buildEnhancedHeader(
      BuildContext context, AppUser user, bool isConnected) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            _getHierarchyColor(user.role.hierarchyLevel),
            _getHierarchyColor(user.role.hierarchyLevel).withOpacity(0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User Profile Section
              Row(
                children: [
                  _buildUserAvatar(user),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          user.email,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 14,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Role and Organization Info
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.account_box,
                          color: Colors.white.withOpacity(0.9),
                          size: 16,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            user.role.displayName,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            'L${user.role.hierarchyLevel}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (user.hierarchyId != null) ...[
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Colors.white.withOpacity(0.7),
                            size: 14,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'ID: ${user.hierarchyId}',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.7),
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // Connection Status
              Row(
                children: [
                  Icon(
                    isConnected ? Icons.cloud_done : Icons.cloud_off,
                    color: isConnected ? Colors.green : Colors.red,
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    isConnected ? 'Online' : 'Offline',
                    style: TextStyle(
                      color: isConnected ? Colors.green : Colors.red,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserAvatar(AppUser user) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
          width: 2,
        ),
      ),
      child: CircleAvatar(
        radius: 30,
        backgroundImage:
            user.photoUrl != null ? NetworkImage(user.photoUrl!) : null,
        backgroundColor: Colors.white.withOpacity(0.2),
        child: user.photoUrl == null
            ? Text(
                user.name.isNotEmpty ? user.name[0].toUpperCase() : 'U',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              )
            : null,
      ),
    );
  }

  Widget _buildNavigationSection(
      BuildContext context, WidgetRef ref, AppUser user) {
    final drawerItems = _getDynamicDrawerItems(user);

    return Expanded(
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        children: [
          // Dynamic menu items from role configuration
          ...drawerItems.map((item) => _buildDrawerItem(
                context,
                item,
                _isCurrentRoute(context, item.route),
              )),

          // Conditional sections based on permissions
          if (user.hasPermission('view_reports'))
            _buildSectionHeader('Reports & Analytics'),

          if (user.hasPermission('view_reports')) ...[
            _buildDrawerItem(
              context,
              DrawerItem(
                icon: Icons.assessment,
                title: 'Reports',
                route: '/reports',
                badge: '3', // Dynamic report count
              ),
              false,
            ),
            _buildDrawerItem(
              context,
              DrawerItem(
                icon: Icons.analytics,
                title: 'Analytics',
                route: '/analytics',
              ),
              false,
            ),
          ],

          if (user.hasPermission('admin_access') ||
              user.role.hierarchyLevel <= 2)
            _buildSectionHeader('Administration'),

          if (user.hasPermission('manage_users')) ...[
            _buildDrawerItem(
              context,
              DrawerItem(
                icon: Icons.people,
                title: 'User Management',
                route: '/users',
              ),
              false,
            ),
          ],

          if (user.hasPermission('system_settings')) ...[
            _buildDrawerItem(
              context,
              DrawerItem(
                icon: Icons.settings,
                title: 'Settings',
                route: '/settings',
              ),
              false,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildBottomSection(
      BuildContext context, WidgetRef ref, AppUser user) {
    return Column(
      children: [
        const Divider(height: 1),

        // Help & Support
        ListTile(
          leading: const Icon(Icons.help_outline, color: Colors.grey),
          title: const Text(
            'Help & Support',
            style: TextStyle(color: Colors.grey),
          ),
          onTap: () {
            Navigator.pop(context);
            _showHelpDialog(context);
          },
        ),

        // Organization Info
        ListTile(
          leading: const Icon(Icons.business, color: Colors.grey),
          title: Text(
            user.organizationId,
            style: const TextStyle(color: Colors.grey, fontSize: 12),
          ),
          subtitle: const Text(
            'Organization',
            style: TextStyle(color: Colors.grey, fontSize: 10),
          ),
          onTap: () {
            Navigator.pop(context);
            _showOrganizationInfo(context, user);
          },
        ),

        const Divider(height: 1),

        // Sign Out with confirmation
        ListTile(
          leading: const Icon(Icons.logout, color: Colors.red),
          title: const Text(
            'Sign Out',
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
          ),
          onTap: () => _handleSignOut(context, ref),
        ),

        // App Version
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'v1.0.0',
            style: TextStyle(
              color: Colors.grey.shade500,
              fontSize: 10,
            ),
          ),
        ),
      ],
    );
  }

  List<DrawerItem> _getDynamicDrawerItems(AppUser user) {
    // Base items available to all users
    final items = <DrawerItem>[
      DrawerItem(
        icon: Icons.dashboard,
        title: 'Dashboard',
        route: '/dashboard',
      ),
    ];

    // Get navigation items from role configuration
    final roleNavigation = user.role.config['navigation'] as List<dynamic>?;
    if (roleNavigation != null) {
      for (final nav in roleNavigation) {
        if (nav is Map<String, dynamic>) {
          items.add(DrawerItem(
            icon: _getIconFromString(nav['icon'] as String?),
            title: nav['title'] as String? ?? 'Unknown',
            route: nav['route'] as String? ?? '/',
            badge: nav['badge'] as String?,
          ));
        }
      }
    } else {
      // Fallback: Generate based on role level and permissions
      items.addAll(_generateFallbackItems(user));
    }

    return items;
  }

  List<DrawerItem> _generateFallbackItems(AppUser user) {
    final items = <DrawerItem>[];

    // Generate navigation based on hierarchy level
    switch (user.role.hierarchyLevel) {
      case 1:
      case 2:
        items.addAll([
          DrawerItem(
              icon: Icons.business,
              title: 'Organizations',
              route: '/organizations'),
          DrawerItem(icon: Icons.people, title: 'Users', route: '/users'),
          DrawerItem(
              icon: Icons.analytics, title: 'Analytics', route: '/analytics'),
        ]);
        break;
      case 3:
      case 4:
        items.addAll([
          DrawerItem(
              icon: Icons.location_city, title: 'Areas', route: '/areas'),
          DrawerItem(icon: Icons.group, title: 'Teams', route: '/teams'),
        ]);
        break;
      default:
        items.addAll([
          DrawerItem(
              icon: Icons.electrical_services,
              title: 'Operations',
              route: '/operations'),
          DrawerItem(icon: Icons.assignment, title: 'Tasks', route: '/tasks'),
        ]);
    }

    return items;
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.grey.shade600,
          fontSize: 12,
          fontWeight: FontWeight.bold,
          letterSpacing: 1,
        ),
      ),
    );
  }

  Widget _buildDrawerItem(
      BuildContext context, DrawerItem item, bool isSelected) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color:
            isSelected ? Theme.of(context).primaryColor.withOpacity(0.1) : null,
      ),
      child: ListTile(
        leading: Icon(
          item.icon,
          color: isSelected
              ? Theme.of(context).primaryColor
              : Colors.grey.shade600,
        ),
        title: Text(
          item.title,
          style: TextStyle(
            color: isSelected
                ? Theme.of(context).primaryColor
                : Colors.grey.shade800,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
        trailing: item.badge != null
            ? Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  item.badge!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : null,
        onTap: () {
          Navigator.pop(context);
          Navigator.pushNamed(context, item.route);
        },
      ),
    );
  }

  // Helper Methods
  Color _getHierarchyColor(int level) {
    final colors = [
      Colors.purple,
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.teal,
    ];
    return colors[(level - 1).clamp(0, colors.length - 1)];
  }

  IconData _getIconFromString(String? iconName) {
    const iconMap = {
      'dashboard': Icons.dashboard,
      'people': Icons.people,
      'business': Icons.business,
      'analytics': Icons.analytics,
      'settings': Icons.settings,
      'reports': Icons.assessment,
      'electrical': Icons.electrical_services,
      'location': Icons.location_city,
      'group': Icons.group,
      'tasks': Icons.assignment,
    };
    return iconMap[iconName] ?? Icons.circle;
  }

  bool _isCurrentRoute(BuildContext context, String route) {
    return ModalRoute.of(context)?.settings.name == route;
  }

  // Event Handlers
  void _handleSignOut(BuildContext context, WidgetRef ref) {
    Navigator.pop(context);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sign Out'),
        content: const Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              await ref.read(authStateNotifierProvider.notifier).signOut();
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child:
                const Text('Sign Out', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Help & Support'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Need help? Contact us:'),
            SizedBox(height: 8),
            Text('📧 support@yourapp.com'),
            Text('📞 +91-XXXX-XXXXXX'),
            Text('🌐 www.yourapp.com/help'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showOrganizationInfo(BuildContext context, AppUser user) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Organization Information'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Organization: ${user.organizationId}'),
            Text('Your Role: ${user.role.displayName}'),
            Text('Hierarchy Level: ${user.role.hierarchyLevel}'),
            if (user.hierarchyId != null)
              Text('Assignment: ${user.hierarchyId}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}

// Enhanced DrawerItem class
class DrawerItem {
  final IconData icon;
  final String title;
  final String route;
  final String? badge;

  const DrawerItem({
    required this.icon,
    required this.title,
    required this.route,
    this.badge,
  });
}
