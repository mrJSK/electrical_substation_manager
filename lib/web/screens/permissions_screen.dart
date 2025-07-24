// screens/permissions_screen.dart
import 'package:flutter/material.dart';

class PermissionsScreen extends StatefulWidget {
  const PermissionsScreen({Key? key}) : super(key: key);

  @override
  State<PermissionsScreen> createState() => _PermissionsScreenState();
}

class _PermissionsScreenState extends State<PermissionsScreen> {
  final List<PermissionCategory> _categories = [
    PermissionCategory(
      name: 'User Management',
      icon: Icons.people,
      permissions: [
        Permission('create_user', 'Create User', 'Create new user accounts'),
        Permission('edit_user', 'Edit User', 'Modify existing user accounts'),
        Permission('delete_user', 'Delete User', 'Remove user accounts'),
        Permission('view_user', 'View User', 'View user account details'),
      ],
    ),
    PermissionCategory(
      name: 'Organization Management',
      icon: Icons.business,
      permissions: [
        Permission('create_organization', 'Create Organization',
            'Create new organizations'),
        Permission('edit_organization', 'Edit Organization',
            'Modify organization details'),
        Permission('delete_organization', 'Delete Organization',
            'Remove organizations'),
        Permission('view_organization', 'View Organization',
            'View organization details'),
      ],
    ),
    PermissionCategory(
      name: 'Substation Operations',
      icon: Icons.electrical_services,
      permissions: [
        Permission(
            'create_substation', 'Create Substation', 'Add new substations'),
        Permission('edit_substation', 'Edit Substation',
            'Modify substation configurations'),
        Permission(
            'delete_substation', 'Delete Substation', 'Remove substations'),
        Permission('monitor_substation', 'Monitor Substation',
            'View real-time monitoring data'),
        Permission('control_substation', 'Control Substation',
            'Send control commands'),
      ],
    ),
    PermissionCategory(
      name: 'System Administration',
      icon: Icons.settings,
      permissions: [
        Permission(
            'system_settings', 'System Settings', 'Configure system settings'),
        Permission(
            'backup_restore', 'Backup & Restore', 'Manage system backups'),
        Permission('api_access', 'API Access', 'Access system APIs'),
        Permission('audit_logs', 'Audit Logs', 'View system audit logs'),
      ],
    ),
    PermissionCategory(
      name: 'Reports & Analytics',
      icon: Icons.analytics,
      permissions: [
        Permission('view_reports', 'View Reports', 'Access system reports'),
        Permission(
            'create_reports', 'Create Reports', 'Generate custom reports'),
        Permission('export_data', 'Export Data', 'Export system data'),
        Permission('analytics_dashboard', 'Analytics Dashboard',
            'Access analytics dashboard'),
      ],
    ),
  ];

  String _searchQuery = '';

  List<PermissionCategory> get _filteredCategories {
    if (_searchQuery.isEmpty) return _categories;

    return _categories.where((category) {
      return category.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          category.permissions.any((permission) =>
              permission.name
                  .toLowerCase()
                  .contains(_searchQuery.toLowerCase()) ||
              permission.description
                  .toLowerCase()
                  .contains(_searchQuery.toLowerCase()));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Permissions Management'),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _showCreatePermissionDialog,
            tooltip: 'Create Permission',
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSearchSection(),
          Expanded(child: _buildPermissionsList()),
        ],
      ),
    );
  }

  Widget _buildSearchSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.grey.shade50,
      child: Column(
        children: [
          TextField(
            decoration: const InputDecoration(
              hintText: 'Search permissions...',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
            onChanged: (value) => setState(() => _searchQuery = value),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Icon(Icons.info_outline, color: Colors.blue.shade700),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Manage system permissions and assign them to roles. Changes will affect all users with those roles.',
                  style: TextStyle(color: Colors.grey.shade700),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPermissionsList() {
    final filteredCategories = _filteredCategories;

    if (filteredCategories.isEmpty) {
      return const Center(child: Text('No permissions found'));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: filteredCategories.length,
      itemBuilder: (context, index) {
        final category = filteredCategories[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          child: Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              leading: Icon(category.icon, color: Colors.blue.shade700),
              title: Text(
                category.name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text('${category.permissions.length} permissions'),
              children: category.permissions
                  .map((permission) =>
                      _buildPermissionTile(permission, category))
                  .toList(),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPermissionTile(
      Permission permission, PermissionCategory category) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(Icons.security, color: Colors.blue.shade700, size: 20),
      ),
      title: Text(
        permission.displayName,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(permission.description),
          const SizedBox(height: 4),
          Text(
            'ID: ${permission.name}',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
      trailing: PopupMenuButton<String>(
        onSelected: (value) {
          switch (value) {
            case 'edit':
              _showEditPermissionDialog(permission, category);
              break;
            case 'roles':
              _showRolesWithPermission(permission);
              break;
            case 'delete':
              _showDeletePermissionDialog(permission, category);
              break;
          }
        },
        itemBuilder: (context) => const [
          PopupMenuItem(value: 'edit', child: Text('Edit')),
          PopupMenuItem(value: 'roles', child: Text('View Roles')),
          PopupMenuItem(value: 'delete', child: Text('Delete')),
        ],
      ),
    );
  }

  void _showCreatePermissionDialog() {
    final nameController = TextEditingController();
    final displayNameController = TextEditingController();
    final descriptionController = TextEditingController();
    String selectedCategory = _categories.first.name;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create Permission'),
        content: SizedBox(
          width: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                value: selectedCategory,
                decoration: const InputDecoration(
                  labelText: 'Category',
                  border: OutlineInputBorder(),
                ),
                items: _categories
                    .map((cat) => DropdownMenuItem(
                        value: cat.name, child: Text(cat.name)))
                    .toList(),
                onChanged: (value) => selectedCategory = value!,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Permission ID',
                  hintText: 'lowercase_with_underscores',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: displayNameController,
                decoration: const InputDecoration(
                  labelText: 'Display Name',
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
                  displayNameController.text.isNotEmpty &&
                  descriptionController.text.isNotEmpty) {
                final category = _categories
                    .firstWhere((cat) => cat.name == selectedCategory);
                final newPermission = Permission(
                  nameController.text,
                  displayNameController.text,
                  descriptionController.text,
                );

                setState(() {
                  category.permissions.add(newPermission);
                });

                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Permission created successfully')),
                );
              }
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }

  void _showEditPermissionDialog(
      Permission permission, PermissionCategory category) {
    final displayNameController =
        TextEditingController(text: permission.displayName);
    final descriptionController =
        TextEditingController(text: permission.description);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Permission'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: TextEditingController(text: permission.name),
              decoration: const InputDecoration(
                labelText: 'Permission ID',
                border: OutlineInputBorder(),
              ),
              readOnly: true,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: displayNameController,
              decoration: const InputDecoration(
                labelText: 'Display Name',
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
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                final index = category.permissions.indexOf(permission);
                category.permissions[index] = Permission(
                  permission.name,
                  displayNameController.text,
                  descriptionController.text,
                );
              });
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('Permission updated successfully')),
              );
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }

  void _showRolesWithPermission(Permission permission) {
    // Mock data for roles that have this permission
    final roles = ['Super Admin', 'Admin', 'Operator'];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Roles with "${permission.displayName}"'),
        content: SizedBox(
          width: 300,
          height: 200,
          child: roles.isNotEmpty
              ? ListView.builder(
                  itemCount: roles.length,
                  itemBuilder: (context, index) => ListTile(
                    leading: const Icon(Icons.admin_panel_settings),
                    title: Text(roles[index]),
                    trailing: const Icon(Icons.check, color: Colors.green),
                  ),
                )
              : const Center(child: Text('No roles have this permission')),
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

  void _showDeletePermissionDialog(
      Permission permission, PermissionCategory category) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Permission'),
        content: Text(
            'Are you sure you want to delete "${permission.displayName}"? This will remove it from all roles.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                category.permissions.remove(permission);
              });
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content:
                        Text('${permission.displayName} deleted successfully')),
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

class PermissionCategory {
  final String name;
  final IconData icon;
  final List<Permission> permissions;

  PermissionCategory({
    required this.name,
    required this.icon,
    required this.permissions,
  });
}

class Permission {
  final String name;
  final String displayName;
  final String description;

  Permission(this.name, this.displayName, this.description);
}
