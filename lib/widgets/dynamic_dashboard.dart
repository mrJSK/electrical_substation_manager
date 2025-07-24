import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/app_user.dart';
import '../models/dynamic_role.dart';

class DynamicDashboard extends ConsumerWidget {
  final AppUser user;
  final dynamic orgConfig;

  const DynamicDashboard({
    super.key,
    required this.user,
    required this.orgConfig,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          _buildWelcomeCard(context),
          const SizedBox(height: 16),
          _buildRoleInfoCard(context),
          const SizedBox(height: 16),
          _buildQuickActionsGrid(context),
          const SizedBox(height: 16),
          _buildStatsCards(context),
        ],
      ),
    );
  }

  Widget _buildWelcomeCard(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: _getHierarchyColor(user.role.hierarchyLevel),
                  backgroundImage: user.photoUrl != null
                      ? NetworkImage(user.photoUrl!)
                      : null,
                  child: user.photoUrl == null
                      ? Text(
                          user.name.isNotEmpty
                              ? user.name[0].toUpperCase()
                              : 'U',
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )
                      : null,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome back, ${user.name}!',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        user.role.displayName,
                        style: TextStyle(
                            fontSize: 14, color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoleInfoCard(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Role Information',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildInfoRow('Role', user.role.displayName),
            _buildInfoRow('Level', 'Level ${user.role.hierarchyLevel}'),
            _buildInfoRow('Organization', user.organizationId),
            if (user.hierarchyId != null)
              _buildInfoRow('Assignment', user.hierarchyId!),
            _buildInfoRow(
                'Permissions', '${user.role.permissions.length} permissions'),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade700,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionsGrid(BuildContext context) {
    // Get actions from role configuration or use defaults
    final configActions = user.role.config['quickActions'] as List<dynamic>?;

    final actions = configActions
            ?.map((action) => {
                  'title': action['title'] ?? 'Action',
                  'icon': _getIconFromString(action['icon']),
                  'color': _getColorFromString(action['color']),
                })
            .toList() ??
        [
          {
            'title': 'View Data',
            'icon': Icons.visibility,
            'color': Colors.blue
          },
          {'title': 'Add Entry', 'icon': Icons.add, 'color': Colors.green},
          {
            'title': 'Reports',
            'icon': Icons.assessment,
            'color': Colors.orange
          },
          {'title': 'Settings', 'icon': Icons.settings, 'color': Colors.grey},
        ];

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Quick Actions',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 2.5,
              children: actions.map<Widget>((action) {
                return ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${action['title']} tapped')),
                    );
                  },
                  icon: Icon(action['icon'] as IconData, size: 18),
                  label: Text(
                    action['title'] as String,
                    style: const TextStyle(fontSize: 12),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: action['color'] as Color,
                    foregroundColor: Colors.white,
                    elevation: 2,
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsCards(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
              'Active Tasks', '5', Icons.assignment, Colors.blue),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildStatCard(
              'Completed', '12', Icons.check_circle, Colors.green),
        ),
      ],
    );
  }

  Widget _buildStatCard(
      String title, String value, IconData icon, Color color) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(icon, size: 32, color: color),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              title,
              style: const TextStyle(fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

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
      'add': Icons.add,
      'view': Icons.visibility,
      'edit': Icons.edit,
      'report': Icons.assessment,
      'settings': Icons.settings,
      'people': Icons.people,
      'dashboard': Icons.dashboard,
    };
    return iconMap[iconName] ?? Icons.touch_app;
  }

  Color _getColorFromString(String? colorName) {
    const colorMap = {
      'blue': Colors.blue,
      'green': Colors.green,
      'orange': Colors.orange,
      'red': Colors.red,
      'purple': Colors.purple,
      'grey': Colors.grey,
    };
    return colorMap[colorName] ?? Colors.blue;
  }
}
