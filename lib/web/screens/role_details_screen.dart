// screens/role_details_screen.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RoleDetailsScreen extends StatefulWidget {
  final String? roleId;
  final bool isCreating;

  const RoleDetailsScreen({
    Key? key,
    this.roleId,
    this.isCreating = false,
  }) : super(key: key);

  @override
  State<RoleDetailsScreen> createState() => _RoleDetailsScreenState();
}

class _RoleDetailsScreenState extends State<RoleDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  bool _isLoading = false;
  Map<String, bool> _permissions = {
    'user_management': false,
    'system_settings': false,
    'analytics': false,
    'substations': false,
    'organizations': false,
    'monitoring': false,
    'reports': false,
    'maintenance': false,
    'api_access': false,
    'backup_restore': false,
  };

  @override
  void initState() {
    super.initState();
    if (!widget.isCreating) {
      _loadRoleData();
    }
  }

  void _loadRoleData() {
    // Simulate loading role data
    if (widget.roleId != null) {
      _nameController.text = 'Admin';
      _descriptionController.text = 'Administrative access to most features';
      _permissions = {
        'user_management': true,
        'system_settings': false,
        'analytics': true,
        'substations': true,
        'organizations': true,
        'monitoring': true,
        'reports': true,
        'maintenance': false,
        'api_access': false,
        'backup_restore': false,
      };
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isCreating ? 'Create Role' : 'Role Details'),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _isLoading ? null : _saveRole,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Basic Information Card
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Basic Information',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          labelText: 'Role Name',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.admin_panel_settings),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Role name is required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _descriptionController,
                        decoration: const InputDecoration(
                          labelText: 'Description',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.description),
                        ),
                        maxLines: 3,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Description is required';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Permissions Card
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Permissions',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const Spacer(),
                          TextButton(
                            onPressed: _selectAllPermissions,
                            child: const Text('Select All'),
                          ),
                          TextButton(
                            onPressed: _clearAllPermissions,
                            child: const Text('Clear All'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      _buildPermissionSection('Core Features', [
                        'user_management',
                        'organizations',
                        'substations',
                      ]),
                      const SizedBox(height: 16),
                      _buildPermissionSection('Monitoring & Analytics', [
                        'monitoring',
                        'analytics',
                        'reports',
                      ]),
                      const SizedBox(height: 16),
                      _buildPermissionSection('System Administration', [
                        'system_settings',
                        'maintenance',
                        'api_access',
                        'backup_restore',
                      ]),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Permission Summary Card
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Permission Summary',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Icon(Icons.security, color: Colors.blue.shade700),
                          const SizedBox(width: 8),
                          Text(
                            'Selected Permissions: ${_permissions.values.where((v) => v).length}/${_permissions.length}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 4,
                        children: _permissions.entries
                            .where((entry) => entry.value)
                            .map((entry) => Chip(
                                  label: Text(_formatPermissionName(entry.key)),
                                  backgroundColor: Colors.blue.shade100,
                                  labelStyle:
                                      TextStyle(color: Colors.blue.shade700),
                                ))
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Save Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _saveRole,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Colors.blue.shade700,
                    foregroundColor: Colors.white,
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text(widget.isCreating ? 'Create Role' : 'Update Role'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPermissionSection(String title, List<String> permissions) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        ...permissions.map((permission) => CheckboxListTile(
              title: Text(_formatPermissionName(permission)),
              subtitle: Text(_getPermissionDescription(permission)),
              value: _permissions[permission] ?? false,
              onChanged: (value) {
                setState(() {
                  _permissions[permission] = value ?? false;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            )),
      ],
    );
  }

  String _formatPermissionName(String permission) {
    return permission
        .replaceAll('_', ' ')
        .split(' ')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }

  String _getPermissionDescription(String permission) {
    const descriptions = {
      'user_management': 'Create, edit, and manage user accounts',
      'system_settings': 'Configure system-wide settings and preferences',
      'analytics': 'Access analytics dashboards and reports',
      'substations': 'Manage substation configurations and operations',
      'organizations': 'Create and manage organization profiles',
      'monitoring': 'View real-time monitoring data and alerts',
      'reports': 'Generate and export system reports',
      'maintenance': 'Schedule and manage maintenance activities',
      'api_access': 'Access system APIs and integrations',
      'backup_restore': 'Perform system backup and restore operations',
    };
    return descriptions[permission] ?? 'Permission description';
  }

  void _selectAllPermissions() {
    setState(() {
      _permissions.updateAll((key, value) => true);
    });
  }

  void _clearAllPermissions() {
    setState(() {
      _permissions.updateAll((key, value) => false);
    });
  }

  Future<void> _saveRole() async {
    if (!_formKey.currentState!.validate()) return;

    final selectedPermissions = _permissions.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();

    if (selectedPermissions.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select at least one permission')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(widget.isCreating
                ? 'Role created successfully'
                : 'Role updated successfully'),
          ),
        );
        context.goNamed('roles');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }
}
