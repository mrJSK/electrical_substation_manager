// screens/roles_screen.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RolesScreen extends StatefulWidget {
  const RolesScreen({Key? key}) : super(key: key);

  @override
  State<RolesScreen> createState() => _RolesScreenState();
}

class _RolesScreenState extends State<RolesScreen> {
  final List<Role> _roles = [
    Role(
      id: '1',
      name: 'Super Admin',
      description: 'Full system access with all permissions',
      userCount: 3,
      permissions: [
        'user_management',
        'system_settings',
        'analytics',
        'substations',
        'organizations'
      ],
      isSystem: true,
    ),
    Role(
      id: '2',
      name: 'Admin',
      description: 'Administrative access to most features',
      userCount: 15,
      permissions: [
        'user_management',
        'analytics',
        'substations',
        'organizations'
      ],
      isSystem: true,
    ),
    Role(
      id: '3',
      name: 'Operator',
      description: 'Can monitor and operate substations',
      userCount: 45,
      permissions: ['substations', 'monitoring', 'reports'],
      isSystem: true,
    ),
    Role(
      id: '4',
      name: 'Viewer',
      description: 'Read-only access to reports and monitoring',
      userCount: 78,
      permissions: ['monitoring', 'reports'],
      isSystem: true,
    ),
    Role(
      id: '5',
      name: 'Maintenance Manager',
      description: 'Manages maintenance schedules and activities',
      userCount: 12,
      permissions: ['substations', 'maintenance', 'reports'],
      isSystem: false,
    ),
  ];

  String _searchQuery = '';

  List<Role> get _filteredRoles {
    return _roles.where((role) {
      return role.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          role.description.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Roles & Permissions'),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.security),
            onPressed: () => context.goNamed('permissions-management'),
            tooltip: 'Manage Permissions',
          ),
          IconButton(
            icon: const Icon(Icons.account_tree),
            onPressed: () => context.goNamed('hierarchy-management'),
            tooltip: 'Role Hierarchy',
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => setState(() {}),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSearchAndStats(),
          Expanded(child: _buildRolesList()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.goNamed('create-role'),
        backgroundColor: Colors.blue.shade700,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildSearchAndStats() {
    final totalUsers = _roles.fold(0, (sum, role) => sum + role.userCount);
    final customRoles = _roles.where((role) => !role.isSystem).length;

    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.grey.shade50,
      child: Column(
        children: [
          TextField(
            decoration: const InputDecoration(
              hintText: 'Search roles...',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
            onChanged: (value) => setState(() => _searchQuery = value),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  'Total Roles',
                  '${_roles.length}',
                  Icons.admin_panel_settings,
                  Colors.blue,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildStatCard(
                  'Total Users',
                  '$totalUsers',
                  Icons.people,
                  Colors.green,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildStatCard(
                  'Custom Roles',
                  '$customRoles',
                  Icons.tune,
                  Colors.orange,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildStatCard(
                  'System Roles',
                  '${_roles.length - customRoles}',
                  Icons.shield,
                  Colors.purple,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
      String title, String value, IconData icon, Color color) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, size: 24, color: color),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRolesList() {
    final filteredRoles = _filteredRoles;

    if (filteredRoles.isEmpty) {
      return const Center(child: Text('No roles found'));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: filteredRoles.length,
      itemBuilder: (context, index) {
        final role = filteredRoles[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      role.isSystem ? Icons.shield : Icons.admin_panel_settings,
                      size: 32,
                      color: role.isSystem
                          ? Colors.blue.shade700
                          : Colors.green.shade700,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                role.name,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 8),
                              if (role.isSystem)
                                Chip(
                                  label: const Text('System'),
                                  backgroundColor: Colors.blue.shade100,
                                  labelStyle:
                                      TextStyle(color: Colors.blue.shade700),
                                ),
                            ],
                          ),
                          Text(role.description),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(Icons.people,
                                  size: 16, color: Colors.grey.shade600),
                              const SizedBox(width: 4),
                              Text(
                                '${role.userCount} users',
                                style: TextStyle(color: Colors.grey.shade600),
                              ),
                              const SizedBox(width: 16),
                              Icon(Icons.security,
                                  size: 16, color: Colors.grey.shade600),
                              const SizedBox(width: 4),
                              Text(
                                '${role.permissions.length} permissions',
                                style: TextStyle(color: Colors.grey.shade600),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    PopupMenuButton<String>(
                      onSelected: (value) {
                        switch (value) {
                          case 'view':
                            context.goNamed('role-details',
                                pathParameters: {'id': role.id});
                            break;
                          case 'edit':
                            if (!role.isSystem) {
                              context.goNamed('role-details',
                                  pathParameters: {'id': role.id});
                            } else {
                              _showSystemRoleWarning();
                            }
                            break;
                          case 'duplicate':
                            _duplicateRole(role);
                            break;
                          case 'delete':
                            if (!role.isSystem) {
                              _showDeleteDialog(role);
                            } else {
                              _showSystemRoleWarning();
                            }
                            break;
                        }
                      },
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                            value: 'view', child: Text('View Details')),
                        PopupMenuItem(
                          value: 'edit',
                          enabled: !role.isSystem,
                          child: const Text('Edit'),
                        ),
                        const PopupMenuItem(
                            value: 'duplicate', child: Text('Duplicate')),
                        PopupMenuItem(
                          value: 'delete',
                          enabled: !role.isSystem && role.userCount == 0,
                          child: const Text('Delete'),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: role.permissions
                      .map((permission) => Chip(
                            label: Text(_formatPermissionName(permission)),
                            backgroundColor: Colors.grey.shade100,
                            labelStyle: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade700,
                            ),
                          ))
                      .toList(),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton.icon(
                      onPressed: () => _showUsersList(role),
                      icon: const Icon(Icons.people),
                      label: const Text('View Users'),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton.icon(
                      onPressed: () => context.goNamed('role-details',
                          pathParameters: {'id': role.id}),
                      icon: const Icon(Icons.visibility),
                      label: const Text('View Details'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade700,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _formatPermissionName(String permission) {
    return permission
        .replaceAll('_', ' ')
        .split(' ')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }

  void _showSystemRoleWarning() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('System Role'),
        content: const Text(
            'System roles cannot be modified or deleted as they are essential for system functionality.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _duplicateRole(Role role) {
    showDialog(
      context: context,
      builder: (context) {
        final nameController =
            TextEditingController(text: '${role.name} (Copy)');
        return AlertDialog(
          title: const Text('Duplicate Role'),
          content: TextField(
            controller: nameController,
            decoration: const InputDecoration(
              labelText: 'New Role Name',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final newRole = Role(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  name: nameController.text,
                  description: '${role.description} (Copy)',
                  userCount: 0,
                  permissions: List.from(role.permissions),
                  isSystem: false,
                );
                setState(() => _roles.add(newRole));
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Role duplicated successfully')),
                );
              },
              child: const Text('Create'),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteDialog(Role role) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Role'),
        content:
            Text('Are you sure you want to delete the role "${role.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() => _roles.removeWhere((r) => r.id == role.id));
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${role.name} deleted successfully')),
              );
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _showUsersList(Role role) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Users with ${role.name} Role'),
        content: SizedBox(
          width: double.maxFinite,
          height: 300,
          child: role.userCount > 0
              ? ListView.builder(
                  itemCount: role.userCount,
                  itemBuilder: (context, index) => ListTile(
                    leading: CircleAvatar(
                      child: Text('U${index + 1}'),
                    ),
                    title: Text('User ${index + 1}'),
                    subtitle: Text('user${index + 1}@example.com'),
                  ),
                )
              : const Center(child: Text('No users assigned to this role')),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}

class Role {
  final String id;
  final String name;
  final String description;
  final int userCount;
  final List<String> permissions;
  final bool isSystem;

  Role({
    required this.id,
    required this.name,
    required this.description,
    required this.userCount,
    required this.permissions,
    required this.isSystem,
  });
}
