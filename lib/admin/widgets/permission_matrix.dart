import 'package:flutter/material.dart';
import '../models/hierarchy_level.dart';

class PermissionMatrix extends StatefulWidget {
  final List<HierarchyLevel> hierarchy;
  final Function(Map<String, List<String>>) onChanged;
  final Map<String, List<String>>? initialPermissions;

  const PermissionMatrix({
    super.key,
    required this.hierarchy,
    required this.onChanged,
    this.initialPermissions,
  });

  @override
  State<PermissionMatrix> createState() => _PermissionMatrixState();
}

class _PermissionMatrixState extends State<PermissionMatrix> {
  late Map<String, List<String>> _rolePermissions;

  // All available permissions in your system
  final List<PermissionCategory> _permissionCategories = [
    PermissionCategory(
      name: 'Data Access',
      permissions: [
        Permission('view_all_data', 'View All Data',
            'Access to view all organizational data'),
        Permission('view_own_level', 'View Own Level',
            'View data at own hierarchy level'),
        Permission('view_subordinate', 'View Subordinate Data',
            'View data of subordinate levels'),
        Permission(
            'view_reports', 'View Reports', 'Access to view generated reports'),
        Permission('view_analytics', 'View Analytics',
            'Access to analytics dashboard'),
      ],
    ),
    PermissionCategory(
      name: 'User Management',
      permissions: [
        Permission('manage_all_users', 'Manage All Users',
            'Create, edit, delete any user'),
        Permission('manage_subordinate_users', 'Manage Subordinate Users',
            'Manage users in lower hierarchy'),
        Permission('create_users', 'Create Users', 'Create new user accounts'),
        Permission('edit_users', 'Edit Users', 'Edit existing user accounts'),
        Permission('delete_users', 'Delete Users', 'Delete user accounts'),
        Permission('assign_roles', 'Assign Roles', 'Assign roles to users'),
      ],
    ),
    PermissionCategory(
      name: 'Substation Operations',
      permissions: [
        Permission('view_substations', 'View Substations',
            'View substation information'),
        Permission(
            'edit_substations', 'Edit Substations', 'Edit substation details'),
        Permission('add_readings', 'Add Readings', 'Input equipment readings'),
        Permission(
            'edit_readings', 'Edit Readings', 'Modify existing readings'),
        Permission('delete_readings', 'Delete Readings', 'Remove readings'),
        Permission('maintenance_logs', 'Maintenance Logs',
            'Create and manage maintenance logs'),
      ],
    ),
    PermissionCategory(
      name: 'System Administration',
      permissions: [
        Permission('system_settings', 'System Settings',
            'Access system configuration'),
        Permission('backup_restore', 'Backup & Restore',
            'Backup and restore system data'),
        Permission('audit_logs', 'Audit Logs', 'View system audit logs'),
        Permission('integration_config', 'Integration Config',
            'Configure external integrations'),
        Permission('notification_settings', 'Notification Settings',
            'Manage system notifications'),
      ],
    ),
    PermissionCategory(
      name: 'Reporting & Analytics',
      permissions: [
        Permission(
            'generate_reports', 'Generate Reports', 'Create custom reports'),
        Permission(
            'export_data', 'Export Data', 'Export data to external formats'),
        Permission('schedule_reports', 'Schedule Reports',
            'Set up automated report generation'),
        Permission('custom_analytics', 'Custom Analytics',
            'Create custom analytics dashboards'),
      ],
    ),
  ];

  @override
  void initState() {
    super.initState();
    _rolePermissions = widget.initialPermissions ?? {};

    // Initialize permissions for each hierarchy level if not provided
    for (final level in widget.hierarchy) {
      if (!_rolePermissions.containsKey(level.id)) {
        _rolePermissions[level.id] = _getDefaultPermissionsForLevel(level);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.hierarchy.isEmpty) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            children: [
              Icon(Icons.security, size: 48, color: Colors.grey.shade400),
              const SizedBox(height: 16),
              Text(
                'No Hierarchy Levels Available',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Please add hierarchy levels first to configure permissions',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade500,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Permission Matrix',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    TextButton.icon(
                      onPressed: _applyRecommendedPermissions,
                      icon: const Icon(Icons.auto_fix_high),
                      label: const Text('Auto Configure'),
                    ),
                    const SizedBox(width: 8),
                    TextButton.icon(
                      onPressed: _resetAllPermissions,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Reset'),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Permission Matrix Table
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columnSpacing: 20,
                headingRowHeight: 60,
                dataRowHeight: 48,
                columns: [
                  const DataColumn(
                    label: SizedBox(
                      width: 200,
                      child: Text(
                        'Permissions',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  ...widget.hierarchy.map((level) => DataColumn(
                        label: Container(
                          width: 120,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                level.displayName.isEmpty
                                    ? 'Level ${level.level}'
                                    : level.displayName,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                'Level ${level.level}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
                ],
                rows: _buildPermissionRows(),
              ),
            ),

            const SizedBox(height: 20),

            // Permission Summary
            _buildPermissionSummary(),
          ],
        ),
      ),
    );
  }

  List<DataRow> _buildPermissionRows() {
    List<DataRow> rows = [];

    for (final category in _permissionCategories) {
      // Category header row
      rows.add(DataRow(
        color: MaterialStateProperty.all(Colors.grey.shade100),
        cells: [
          DataCell(
            Text(
              category.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
          ...widget.hierarchy.map((level) => const DataCell(Text(''))),
        ],
      ));

      // Permission rows for this category
      for (final permission in category.permissions) {
        rows.add(DataRow(
          cells: [
            DataCell(
              Container(
                padding: const EdgeInsets.only(left: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      permission.name,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Text(
                      permission.description,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ...widget.hierarchy.map((level) => DataCell(
                  Checkbox(
                    value:
                        _rolePermissions[level.id]?.contains(permission.id) ??
                            false,
                    onChanged: (bool? value) {
                      setState(() {
                        if (value == true) {
                          _addPermissionToRole(level.id, permission.id);
                        } else {
                          _removePermissionFromRole(level.id, permission.id);
                        }
                      });
                      widget.onChanged(_rolePermissions);
                    },
                    activeColor: _getColorForLevel(level.level),
                  ),
                )),
          ],
        ));
      }
    }

    return rows;
  }

  Widget _buildPermissionSummary() {
    return ExpansionTile(
      leading: const Icon(Icons.summarize),
      title: const Text('Permission Summary'),
      children: widget.hierarchy.map((level) {
        final permissions = _rolePermissions[level.id] ?? [];
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: _getColorForLevel(level.level),
            radius: 16,
            child: Text(
              '${level.level}',
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
          title: Text(level.displayName.isEmpty
              ? 'Level ${level.level}'
              : level.displayName),
          subtitle: Text('${permissions.length} permissions assigned'),
          trailing: TextButton(
            onPressed: () => _showPermissionDetails(level),
            child: const Text('View Details'),
          ),
        );
      }).toList(),
    );
  }

  void _addPermissionToRole(String roleId, String permissionId) {
    if (!_rolePermissions.containsKey(roleId)) {
      _rolePermissions[roleId] = [];
    }
    if (!_rolePermissions[roleId]!.contains(permissionId)) {
      _rolePermissions[roleId]!.add(permissionId);
    }
  }

  void _removePermissionFromRole(String roleId, String permissionId) {
    _rolePermissions[roleId]?.remove(permissionId);
  }

  List<String> _getDefaultPermissionsForLevel(HierarchyLevel level) {
    // Assign default permissions based on hierarchy level
    switch (level.level) {
      case 1: // Top level (CEO/Director)
        return [
          'view_all_data',
          'view_reports',
          'view_analytics',
          'manage_all_users',
          'system_settings',
          'generate_reports',
          'custom_analytics',
        ];
      case 2: // Regional/Zone level
        return [
          'view_own_level',
          'view_subordinate',
          'view_reports',
          'manage_subordinate_users',
          'create_users',
          'edit_users',
          'generate_reports',
        ];
      case 3: // Circle/Division level
        return [
          'view_own_level',
          'view_subordinate',
          'manage_subordinate_users',
          'view_substations',
          'edit_substations',
          'maintenance_logs',
        ];
      case 4: // Subdivision level
        return [
          'view_own_level',
          'view_substations',
          'edit_substations',
          'add_readings',
          'edit_readings',
          'maintenance_logs',
        ];
      default: // Field level (Substation operators)
        return [
          'view_substations',
          'add_readings',
          'maintenance_logs',
        ];
    }
  }

  void _applyRecommendedPermissions() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Apply Recommended Permissions'),
        content: const Text(
          'This will automatically configure permissions based on best practices for each hierarchy level. Current permissions will be overwritten.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                for (final level in widget.hierarchy) {
                  _rolePermissions[level.id] =
                      _getDefaultPermissionsForLevel(level);
                }
              });
              widget.onChanged(_rolePermissions);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Recommended permissions applied successfully'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('Apply'),
          ),
        ],
      ),
    );
  }

  void _resetAllPermissions() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reset All Permissions'),
        content: const Text(
            'This will remove all permissions from all roles. Are you sure?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _rolePermissions.clear();
                for (final level in widget.hierarchy) {
                  _rolePermissions[level.id] = [];
                }
              });
              widget.onChanged(_rolePermissions);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Reset', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showPermissionDetails(HierarchyLevel level) {
    final permissions = _rolePermissions[level.id] ?? [];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('${level.displayName} Permissions'),
        content: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('${permissions.length} permissions assigned'),
              const SizedBox(height: 16),
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: permissions.length,
                  itemBuilder: (context, index) {
                    final permissionId = permissions[index];
                    final permission = _findPermissionById(permissionId);

                    return ListTile(
                      leading:
                          const Icon(Icons.check_circle, color: Colors.green),
                      title: Text(permission?.name ?? permissionId),
                      subtitle: Text(permission?.description ?? ''),
                    );
                  },
                ),
              ),
            ],
          ),
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

  Permission? _findPermissionById(String id) {
    for (final category in _permissionCategories) {
      for (final permission in category.permissions) {
        if (permission.id == id) {
          return permission;
        }
      }
    }
    return null;
  }

  Color _getColorForLevel(int level) {
    final colors = [
      Colors.purple,
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.red,
    ];
    return colors[(level - 1) % colors.length];
  }
}

// Supporting classes
class PermissionCategory {
  final String name;
  final List<Permission> permissions;

  PermissionCategory({
    required this.name,
    required this.permissions,
  });
}

class Permission {
  final String id;
  final String name;
  final String description;

  Permission(this.id, this.name, this.description);
}
