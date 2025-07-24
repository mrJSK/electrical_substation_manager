// screens/hierarchy_management_screen.dart
import 'package:flutter/material.dart';

class HierarchyManagementScreen extends StatefulWidget {
  const HierarchyManagementScreen({Key? key}) : super(key: key);

  @override
  State<HierarchyManagementScreen> createState() =>
      _HierarchyManagementScreenState();
}

class _HierarchyManagementScreenState extends State<HierarchyManagementScreen> {
  final List<RoleHierarchy> _hierarchy = [
    RoleHierarchy(
      role: 'Super Admin',
      level: 1,
      description: 'Highest level access with all permissions',
      parentRole: null,
      childRoles: ['Admin'],
      userCount: 2,
    ),
    RoleHierarchy(
      role: 'Admin',
      level: 2,
      description: 'Administrative access to most features',
      parentRole: 'Super Admin',
      childRoles: ['Operator', 'Maintenance Manager'],
      userCount: 15,
    ),
    RoleHierarchy(
      role: 'Operator',
      level: 3,
      description: 'Can monitor and operate substations',
      parentRole: 'Admin',
      childRoles: ['Viewer'],
      userCount: 45,
    ),
    RoleHierarchy(
      role: 'Maintenance Manager',
      level: 3,
      description: 'Manages maintenance schedules and activities',
      parentRole: 'Admin',
      childRoles: ['Maintenance Technician'],
      userCount: 12,
    ),
    RoleHierarchy(
      role: 'Viewer',
      level: 4,
      description: 'Read-only access to reports and monitoring',
      parentRole: 'Operator',
      childRoles: [],
      userCount: 78,
    ),
    RoleHierarchy(
      role: 'Maintenance Technician',
      level: 4,
      description: 'Executes maintenance tasks',
      parentRole: 'Maintenance Manager',
      childRoles: [],
      userCount: 25,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Role Hierarchy Management'),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _showAddRoleDialog,
            tooltip: 'Add Role',
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => setState(() {}),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildHierarchyInfo(),
          Expanded(child: _buildHierarchyTree()),
        ],
      ),
    );
  }

  Widget _buildHierarchyInfo() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.grey.shade50,
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.info_outline, color: Colors.blue.shade700),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Role hierarchy defines the permission inheritance structure. Lower-level roles inherit permissions from their parent roles.',
                  style: TextStyle(color: Colors.grey.shade700),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildInfoCard(
                  'Total Roles',
                  '${_hierarchy.length}',
                  Icons.admin_panel_settings,
                  Colors.blue,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildInfoCard(
                  'Hierarchy Levels',
                  '4',
                  Icons.layers,
                  Colors.green,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildInfoCard(
                  'Total Users',
                  '${_hierarchy.fold(0, (sum, role) => sum + role.userCount)}',
                  Icons.people,
                  Colors.orange,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildInfoCard(
                  'Root Roles',
                  '${_hierarchy.where((role) => role.parentRole == null).length}',
                  Icons.account_tree,
                  Colors.purple,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(
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

  Widget _buildHierarchyTree() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: _hierarchy
            .where((role) => role.parentRole == null)
            .map((rootRole) => _buildRoleNode(rootRole, 0))
            .toList(),
      ),
    );
  }

  Widget _buildRoleNode(RoleHierarchy role, int indentLevel) {
    final children =
        _hierarchy.where((r) => r.parentRole == role.role).toList();

    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: indentLevel * 24.0, bottom: 8),
          child: Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: _getLevelColor(role.level),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Icon(
                        Icons.admin_panel_settings,
                        color: _getLevelColor(role.level),
                        size: 24,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              role.role,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              role.description,
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                          ],
                        ),
                      ),
                      Chip(
                        label: Text('Level ${role.level}'),
                        backgroundColor:
                            _getLevelColor(role.level).withOpacity(0.1),
                        labelStyle:
                            TextStyle(color: _getLevelColor(role.level)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(Icons.people, size: 16, color: Colors.grey.shade600),
                      const SizedBox(width: 4),
                      Text(
                        '${role.userCount} users',
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                      const SizedBox(width: 16),
                      if (role.parentRole != null) ...[
                        Icon(Icons.arrow_upward,
                            size: 16, color: Colors.grey.shade600),
                        const SizedBox(width: 4),
                        Text(
                          'Reports to: ${role.parentRole}',
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                      ],
                      const Spacer(),
                      PopupMenuButton<String>(
                        onSelected: (value) {
                          switch (value) {
                            case 'edit':
                              _showEditRoleDialog(role);
                              break;
                            case 'permissions':
                              _showRolePermissions(role);
                              break;
                            case 'users':
                              _showRoleUsers(role);
                              break;
                            case 'move':
                              _showMoveRoleDialog(role);
                              break;
                            case 'delete':
                              _showDeleteRoleDialog(role);
                              break;
                          }
                        },
                        itemBuilder: (context) => [
                          const PopupMenuItem(
                              value: 'edit', child: Text('Edit')),
                          const PopupMenuItem(
                              value: 'permissions', child: Text('Permissions')),
                          const PopupMenuItem(
                              value: 'users', child: Text('View Users')),
                          const PopupMenuItem(
                              value: 'move', child: Text('Move in Hierarchy')),
                          PopupMenuItem(
                            value: 'delete',
                            enabled:
                                role.childRoles.isEmpty && role.userCount == 0,
                            child: const Text('Delete'),
                          ),
                        ],
                      ),
                    ],
                  ),
                  if (role.childRoles.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.arrow_downward,
                              size: 16, color: Colors.grey.shade600),
                          const SizedBox(width: 4),
                          Text(
                            'Child roles: ${role.childRoles.join(', ')}',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
        ...children.map((child) => _buildRoleNode(child, indentLevel + 1)),
      ],
    );
  }

  Color _getLevelColor(int level) {
    switch (level) {
      case 1:
        return Colors.red;
      case 2:
        return Colors.orange;
      case 3:
        return Colors.blue;
      case 4:
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  void _showAddRoleDialog() {
    final nameController = TextEditingController();
    final descriptionController = TextEditingController();
    String? selectedParent;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Role to Hierarchy'),
        content: SizedBox(
          width: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Role Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: selectedParent,
                decoration: const InputDecoration(
                  labelText: 'Parent Role (Optional)',
                  border: OutlineInputBorder(),
                ),
                items: [
                  const DropdownMenuItem<String>(
                    value: null,
                    child: Text('None (Root Role)'),
                  ),
                  ..._hierarchy.map((role) => DropdownMenuItem(
                        value: role.role,
                        child: Text(role.role),
                      )),
                ],
                onChanged: (value) => selectedParent = value,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (nameController.text.isNotEmpty &&
                  descriptionController.text.isNotEmpty) {
                final newLevel = selectedParent != null
                    ? _hierarchy
                            .firstWhere((r) => r.role == selectedParent)
                            .level +
                        1
                    : 1;

                final newRole = RoleHierarchy(
                  role: nameController.text,
                  level: newLevel,
                  description: descriptionController.text,
                  parentRole: selectedParent,
                  childRoles: [],
                  userCount: 0,
                );

                setState(() {
                  _hierarchy.add(newRole);
                  if (selectedParent != null) {
                    final parent =
                        _hierarchy.firstWhere((r) => r.role == selectedParent);
                    parent.childRoles.add(nameController.text);
                  }
                });

                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Role added to hierarchy successfully')),
                );
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _showEditRoleDialog(RoleHierarchy role) {
    final descriptionController = TextEditingController(text: role.description);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit ${role.role}'),
        content: TextField(
          controller: descriptionController,
          decoration: const InputDecoration(
            labelText: 'Description',
            border: OutlineInputBorder(),
          ),
          maxLines: 2,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                final index = _hierarchy.indexOf(role);
                _hierarchy[index] = RoleHierarchy(
                  role: role.role,
                  level: role.level,
                  description: descriptionController.text,
                  parentRole: role.parentRole,
                  childRoles: role.childRoles,
                  userCount: role.userCount,
                );
              });
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Role updated successfully')),
              );
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }

  void _showRolePermissions(RoleHierarchy role) {
    // Mock permissions data
    final permissions = [
      'user_management',
      'substations',
      'monitoring',
      'reports',
    ];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('${role.role} Permissions'),
        content: SizedBox(
          width: 300,
          height: 200,
          child: ListView.builder(
            itemCount: permissions.length,
            itemBuilder: (context, index) => ListTile(
              leading: const Icon(Icons.security),
              title:
                  Text(permissions[index].replaceAll('_', ' ').toUpperCase()),
              trailing: const Icon(Icons.check, color: Colors.green),
            ),
          ),
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

  void _showRoleUsers(RoleHierarchy role) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Users with ${role.role} Role'),
        content: SizedBox(
          width: 400,
          height: 300,
          child: role.userCount > 0
              ? ListView.builder(
                  itemCount: role.userCount,
                  itemBuilder: (context, index) => ListTile(
                    leading: CircleAvatar(
                      child: Text('U${index + 1}'),
                    ),
                    title: Text('User ${index + 1}'),
                    subtitle: Text('user${index + 1}@company.com'),
                  ),
                )
              : const Center(child: Text('No users with this role')),
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

  void _showMoveRoleDialog(RoleHierarchy role) {
    String? newParent = role.parentRole;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Move ${role.role} in Hierarchy'),
        content: DropdownButtonFormField<String>(
          value: newParent,
          decoration: const InputDecoration(
            labelText: 'New Parent Role',
            border: OutlineInputBorder(),
          ),
          items: [
            const DropdownMenuItem<String>(
              value: null,
              child: Text('None (Root Role)'),
            ),
            ..._hierarchy
                .where((r) =>
                    r.role != role.role && !role.childRoles.contains(r.role))
                .map((r) => DropdownMenuItem(
                      value: r.role,
                      child: Text(r.role),
                    )),
          ],
          onChanged: (value) => newParent = value,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                // Remove from old parent
                if (role.parentRole != null) {
                  final oldParent =
                      _hierarchy.firstWhere((r) => r.role == role.parentRole);
                  oldParent.childRoles.remove(role.role);
                }

                // Add to new parent
                if (newParent != null) {
                  final parent =
                      _hierarchy.firstWhere((r) => r.role == newParent);
                  parent.childRoles.add(role.role);
                }

                // Update role
                final index = _hierarchy.indexOf(role);
                final newLevel = newParent != null
                    ? _hierarchy.firstWhere((r) => r.role == newParent).level +
                        1
                    : 1;

                _hierarchy[index] = RoleHierarchy(
                  role: role.role,
                  level: newLevel,
                  description: role.description,
                  parentRole: newParent,
                  childRoles: role.childRoles,
                  userCount: role.userCount,
                );
              });

              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Role moved successfully')),
              );
            },
            child: const Text('Move'),
          ),
        ],
      ),
    );
  }

  void _showDeleteRoleDialog(RoleHierarchy role) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Role'),
        content: Text(
          'Are you sure you want to delete "${role.role}"? This role has no child roles or users.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _hierarchy.remove(role);
                // Remove from parent's child roles
                if (role.parentRole != null) {
                  final parent =
                      _hierarchy.firstWhere((r) => r.role == role.parentRole);
                  parent.childRoles.remove(role.role);
                }
              });
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${role.role} deleted successfully')),
              );
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}

class RoleHierarchy {
  final String role;
  final int level;
  final String description;
  final String? parentRole;
  final List<String> childRoles;
  final int userCount;

  RoleHierarchy({
    required this.role,
    required this.level,
    required this.description,
    required this.parentRole,
    required this.childRoles,
    required this.userCount,
  });
}
