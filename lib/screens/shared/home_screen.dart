import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../auth/auth_provider.dart';
import '../../models/app_user.dart';
import '../../models/dynamic_role.dart';
import '../../widgets/app_drawer.dart';
import '../../widgets/dynamic_dashboard.dart';
import '../../providers/organization_provider.dart';

class HomeScreen extends ConsumerWidget {
  final AppUser user;

  const HomeScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch for real-time updates to user profile
    final currentUser = ref.watch(currentUserProvider) ?? user;
    final orgConfig = ref.watch(organizationConfigProvider);

    return Scaffold(
      appBar: _buildAppBar(context, ref, currentUser),
      drawer: AppDrawer(user: currentUser),
      body: _buildBody(context, ref, currentUser, orgConfig),
      floatingActionButton: _buildFloatingActionButton(context, currentUser),
    );
  }

  PreferredSizeWidget _buildAppBar(
      BuildContext context, WidgetRef ref, AppUser currentUser) {
    return AppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${currentUser.role.displayName} Dashboard',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          Text(
            'Level ${currentUser.role.hierarchyLevel}',
            style: TextStyle(
              fontSize: 12,
              color: Colors.white.withOpacity(0.8),
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
      backgroundColor: _getAppBarColor(currentUser.role.hierarchyLevel),
      foregroundColor: Colors.white,
      elevation: 0,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              _getAppBarColor(currentUser.role.hierarchyLevel),
              _getAppBarColor(currentUser.role.hierarchyLevel).withOpacity(0.8),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
      actions: _buildAppBarActions(context, ref, currentUser),
    );
  }

  List<Widget> _buildAppBarActions(
      BuildContext context, WidgetRef ref, AppUser currentUser) {
    return [
      // Connection Status Indicator
      Consumer(
        builder: (context, ref, _) {
          final isConnected = ref.watch(connectionStatusProvider);
          return Container(
            margin: const EdgeInsets.only(right: 8),
            child: Icon(
              isConnected ? Icons.cloud_done : Icons.cloud_off,
              color: isConnected ? Colors.green : Colors.red,
              size: 20,
            ),
          );
        },
      ),

      // Refresh Button
      IconButton(
        icon: const Icon(Icons.refresh),
        tooltip: 'Refresh Profile',
        onPressed: () => _handleRefresh(context, ref),
      ),

      // Notifications Button
      Stack(
        children: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            tooltip: 'Notifications',
            onPressed: () => _handleNotifications(context, currentUser),
          ),
          // Notification badge
          Positioned(
            right: 8,
            top: 8,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(6),
              ),
              constraints: const BoxConstraints(
                minWidth: 12,
                minHeight: 12,
              ),
              child: const Text(
                '3',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 8,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),

      // More Options Menu
      PopupMenuButton<String>(
        icon: const Icon(Icons.more_vert),
        tooltip: 'More Options',
        onSelected: (value) =>
            _handleMenuSelection(context, ref, value, currentUser),
        itemBuilder: (context) => [
          PopupMenuItem(
            value: 'profile',
            child: _buildMenuItem(Icons.person, 'My Profile'),
          ),
          PopupMenuItem(
            value: 'organization',
            child: _buildMenuItem(Icons.business, 'Organization Info'),
          ),
          if (_canAccessSettings(currentUser))
            PopupMenuItem(
              value: 'settings',
              child: _buildMenuItem(Icons.settings, 'Settings'),
            ),
          PopupMenuItem(
            value: 'help',
            child: _buildMenuItem(Icons.help_outline, 'Help & Support'),
          ),
          const PopupMenuDivider(),
          PopupMenuItem(
            value: 'logout',
            child: _buildMenuItem(Icons.logout, 'Sign Out', Colors.red),
          ),
        ],
      ),
    ];
  }

  Widget _buildMenuItem(IconData icon, String title, [Color? color]) {
    return Row(
      children: [
        Icon(icon, size: 20, color: color),
        const SizedBox(width: 12),
        Text(title, style: TextStyle(color: color)),
      ],
    );
  }

  Widget _buildBody(BuildContext context, WidgetRef ref, AppUser currentUser,
      dynamic orgConfig) {
    // Check if user has required hierarchy ID
    if (_requiresHierarchyId(currentUser) && currentUser.hierarchyId == null) {
      return _buildHierarchyIdMissingWidget(context, currentUser);
    }

    // Check if user is active
    if (!currentUser.isActive) {
      return _buildInactiveUserWidget(context);
    }

    // Build dynamic dashboard based on role configuration
    return RefreshIndicator(
      onRefresh: () => _handleRefresh(context, ref),
      child: DynamicDashboard(
        user: currentUser,
        orgConfig: orgConfig,
      ),
    );
  }

  Widget _buildHierarchyIdMissingWidget(BuildContext context, AppUser user) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.warning_amber_rounded,
              size: 64,
              color: Colors.orange.shade600,
            ),
            const SizedBox(height: 24),
            Text(
              'Setup Required',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              '${user.role.displayName} role requires assignment to a specific ${_getHierarchyType(user.role)}.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                        'Please contact your system administrator for assignment.'),
                  ),
                );
              },
              icon: const Icon(Icons.contact_support),
              label: const Text('Contact Administrator'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInactiveUserWidget(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.block,
              size: 64,
              color: Colors.red.shade600,
            ),
            const SizedBox(height: 24),
            const Text(
              'Account Disabled',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Your account has been temporarily disabled. Please contact your administrator for assistance.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                _showSupportDialog(context);
              },
              icon: const Icon(Icons.support_agent),
              label: const Text('Contact Support'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget? _buildFloatingActionButton(BuildContext context, AppUser user) {
    // Show FAB based on role permissions and configuration
    final quickActions = user.role.config['quickActions'] as List<dynamic>?;
    if (quickActions == null || quickActions.isEmpty) return null;

    final primaryAction = quickActions.first as Map<String, dynamic>;

    return FloatingActionButton.extended(
      onPressed: () => _handleQuickAction(context, primaryAction),
      icon: Icon(
        _getIconFromString(primaryAction['icon'] as String?),
      ),
      label: Text(primaryAction['label'] as String? ?? 'Quick Action'),
      backgroundColor: _getAppBarColor(user.role.hierarchyLevel),
    );
  }

  // Helper Methods
  Color _getAppBarColor(int hierarchyLevel) {
    final colors = [
      Colors.purple, // Level 1 - Top executives
      Colors.blue, // Level 2 - Senior management
      Colors.green, // Level 3 - Middle management
      Colors.orange, // Level 4 - Supervisory
      Colors.teal, // Level 5+ - Operational
    ];

    final index = (hierarchyLevel - 1).clamp(0, colors.length - 1);
    return colors[index];
  }

  bool _requiresHierarchyId(AppUser user) {
    // Roles that require specific assignment
    return user.role.hierarchyLevel > 1 &&
        user.role.config['requiresHierarchyAssignment'] == true;
  }

  String _getHierarchyType(DynamicRole role) {
    // Extract hierarchy type from role name or config
    return role.config['hierarchyType'] as String? ?? 'department';
  }

  bool _canAccessSettings(AppUser user) {
    return user.hasPermission('admin_access') ||
        user.hasPermission('system_settings');
  }

  IconData _getIconFromString(String? iconName) {
    const iconMap = {
      'add': Icons.add,
      'edit': Icons.edit,
      'view': Icons.visibility,
      'report': Icons.assessment,
      'settings': Icons.settings,
    };
    return iconMap[iconName] ?? Icons.touch_app;
  }

  // Event Handlers
  Future<void> _handleRefresh(BuildContext context, WidgetRef ref) async {
    try {
      await ref.read(authStateNotifierProvider.notifier).refreshUserProfile();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Row(
              children: [
                Icon(Icons.check_circle, color: Colors.white),
                SizedBox(width: 8),
                Text('Profile updated successfully'),
              ],
            ),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.error, color: Colors.white),
                const SizedBox(width: 8),
                Expanded(child: Text('Failed to refresh: $e')),
              ],
            ),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 4),
          ),
        );
      }
    }
  }

  void _handleNotifications(BuildContext context, AppUser user) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Notifications'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.info, color: Colors.blue),
              title: Text('System Update'),
              subtitle: Text('New features available'),
              dense: true,
            ),
            ListTile(
              leading: Icon(Icons.warning, color: Colors.orange),
              title: Text('Maintenance Reminder'),
              subtitle: Text('Scheduled for tomorrow'),
              dense: true,
            ),
            ListTile(
              leading: Icon(Icons.check_circle, color: Colors.green),
              title: Text('Task Completed'),
              subtitle: Text('Report submitted successfully'),
              dense: true,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Navigate to full notifications screen
            },
            child: const Text('View All'),
          ),
        ],
      ),
    );
  }

  void _handleMenuSelection(
      BuildContext context, WidgetRef ref, String value, AppUser user) {
    switch (value) {
      case 'profile':
        _showProfileDialog(context, user);
        break;
      case 'organization':
        _showOrganizationInfo(context, user);
        break;
      case 'settings':
        // TODO: Navigate to settings screen
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Settings screen coming soon!')),
        );
        break;
      case 'help':
        _showHelpDialog(context);
        break;
      case 'logout':
        _handleLogout(context, ref);
        break;
    }
  }

  void _showProfileDialog(BuildContext context, AppUser user) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('User Profile'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileRow('Name', user.name),
            _buildProfileRow('Email', user.email),
            _buildProfileRow('Role', user.role.displayName),
            _buildProfileRow('Level', 'Level ${user.role.hierarchyLevel}'),
            _buildProfileRow('Organization', user.organizationId),
            if (user.hierarchyId != null)
              _buildProfileRow('Assignment', user.hierarchyId!),
            _buildProfileRow(
                'Permissions', '${user.role.permissions.length} permissions'),
            _buildProfileRow('Status', user.isActive ? 'Active' : 'Inactive'),
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

  Widget _buildProfileRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: Text(value),
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
            const SizedBox(height: 8),
            Text('Your Role: ${user.role.displayName}'),
            const SizedBox(height: 8),
            Text('Hierarchy Level: ${user.role.hierarchyLevel}'),
            const SizedBox(height: 8),
            if (user.hierarchyId != null)
              Text('Assignment: ${user.hierarchyId}'),
            const SizedBox(height: 8),
            Text('Permissions: ${user.role.permissions.join(', ')}'),
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
            SizedBox(height: 16),
            Row(
              children: [
                Icon(Icons.email, size: 16),
                SizedBox(width: 8),
                Text('support@yourapp.com'),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.phone, size: 16),
                SizedBox(width: 8),
                Text('+91-XXXX-XXXXXX'),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.web, size: 16),
                SizedBox(width: 8),
                Text('www.yourapp.com/help'),
              ],
            ),
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

  void _showSupportDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Contact Support'),
        content: const Text(
          'Your account has been disabled. Please contact your system administrator or support team for assistance.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _handleLogout(BuildContext context, WidgetRef ref) {
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

  void _handleQuickAction(BuildContext context, Map<String, dynamic> action) {
    final actionType = action['type'] as String?;

    switch (actionType) {
      case 'navigate':
        // TODO: Navigate to specified screen
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Navigating to ${action['route']}')),
        );
        break;
      case 'dialog':
        // TODO: Show dialog
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(action['title'] as String? ?? 'Action'),
            content: Text(action['content'] as String? ?? 'Action triggered'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
        break;
      default:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${action['label']} action triggered')),
        );
    }
  }
}
