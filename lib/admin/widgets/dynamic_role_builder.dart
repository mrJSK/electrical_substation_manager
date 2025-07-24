import 'package:flutter/material.dart';
import '../../models/dynamic_role.dart';

class DynamicRoleBuilder extends StatefulWidget {
  final Function(List<DynamicRole>) onChanged; // ← Fix generic type
  final String organizationId;

  const DynamicRoleBuilder({
    super.key,
    required this.onChanged,
    required this.organizationId,
  });

  @override
  State<DynamicRoleBuilder> createState() =>
      _DynamicRoleBuilderState(); // ← Fix return type
}

class _DynamicRoleBuilderState extends State<DynamicRoleBuilder> {
  List<DynamicRole> _roles = []; // ← Fix generic type

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Organization Roles',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Template-free approach - start with empty canvas
            if (_roles.isEmpty) _buildEmptyState() else _buildRoleHierarchy(),

            const SizedBox(height: 16),

            // Add Role Button
            ElevatedButton.icon(
              onPressed: _addCustomRole,
              icon: const Icon(Icons.add),
              label: const Text('Add Role Level'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Template-free empty state
  Widget _buildEmptyState() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          const Icon(Icons.account_tree, size: 64, color: Colors.grey),
          const SizedBox(height: 16),
          const Text(
            'Build Your Organization Structure',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Start by adding your top-level role (CEO, Chairman, Managing Director, etc.)',
            style: TextStyle(color: Colors.grey.shade600),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: _addFirstRole,
            icon: const Icon(Icons.add),
            label: const Text('Add First Role'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoleHierarchy() {
    return Column(
      children: _roles.asMap().entries.map((entry) {
        int index = entry.key;
        DynamicRole role = entry.value;

        return Container(
          margin: EdgeInsets.only(
            left: (role.hierarchyLevel - 1) * 20.0,
            bottom: 8,
          ),
          child: Card(
            elevation: 2,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: _getColorForLevel(role.hierarchyLevel),
                child: Text(
                  '${role.hierarchyLevel}',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              title: TextFormField(
                initialValue: role.displayName,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter role name (e.g., Chief Executive Officer)',
                ),
                onChanged: (value) {
                  _updateRole(index, role.copyWith(displayName: value));
                },
              ),
              subtitle: Text(
                  'Level ${role.hierarchyLevel} • ${role.permissions.length} permissions'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.settings, color: Colors.blue),
                    tooltip: 'Configure Role',
                    onPressed: () => _configureRole(role, index),
                  ),
                  if (index > 0) // Can't delete first role
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      tooltip: 'Delete Role',
                      onPressed: () => _removeRole(index),
                    ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  void _addFirstRole() {
    showDialog(
      context: context,
      builder: (context) => _AddRoleDialog(
        isFirstRole: true,
        onAdd: (roleName) {
          final newRole = DynamicRole(
            id: 'role_1',
            name: roleName.toLowerCase().replaceAll(' ', '_'),
            displayName: roleName,
            hierarchyLevel: 1,
            organizationId: widget.organizationId,
            permissions: [
              'view_all',
              'manage_all'
            ], // Default top-level permissions
            config: {
              'hierarchyAccess': 'all',
              'dashboardType': 'executive',
            },
          );

          setState(() {
            _roles.add(newRole);
          });
          widget.onChanged(_roles);
        },
      ),
    );
  }

  void _addCustomRole() {
    showDialog(
      context: context,
      builder: (context) => _AddRoleDialog(
        isFirstRole: false,
        currentLevel: _roles.length + 1,
        onAdd: (roleName) {
          final newRole = DynamicRole(
            id: 'role_${_roles.length + 1}',
            name: roleName.toLowerCase().replaceAll(' ', '_'),
            displayName: roleName,
            hierarchyLevel: _roles.length + 1,
            organizationId: widget.organizationId,
            parentRoleId: _roles.isNotEmpty ? _roles.last.id : null,
            permissions: _getDefaultPermissionsForLevel(_roles.length + 1),
            config: {
              'hierarchyAccess': _roles.length > 2 ? 'own' : 'subordinate',
              'dashboardType': _roles.length > 2 ? 'operational' : 'managerial',
            },
          );

          setState(() {
            _roles.add(newRole);
          });
          widget.onChanged(_roles);
        },
      ),
    );
  }

  void _updateRole(int index, DynamicRole updatedRole) {
    setState(() {
      _roles[index] = updatedRole;
    });
    widget.onChanged(_roles);
  }

  void _removeRole(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Role'),
        content: Text(
            'Are you sure you want to delete "${_roles[index].displayName}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _roles.removeAt(index);
                // Update hierarchy levels for remaining roles
                for (int i = index; i < _roles.length; i++) {
                  _roles[i] = _roles[i].copyWith(hierarchyLevel: i + 1);
                }
              });
              widget.onChanged(_roles);
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _configureRole(DynamicRole role, int index) {
    showDialog(
      context: context,
      builder: (context) => _RoleConfigDialog(
        role: role,
        onSaved: (updatedRole) => _updateRole(index, updatedRole),
      ),
    );
  }

  List<String> _getDefaultPermissionsForLevel(int level) {
    switch (level) {
      case 1:
        return ['view_all', 'manage_all', 'admin_access'];
      case 2:
        return ['view_department', 'manage_teams'];
      case 3:
        return ['view_team', 'manage_projects'];
      default:
        return ['view_own', 'basic_operations'];
    }
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

// Add Role Dialog
class _AddRoleDialog extends StatefulWidget {
  final bool isFirstRole;
  final int? currentLevel;
  final Function(String) onAdd;

  const _AddRoleDialog({
    required this.isFirstRole,
    this.currentLevel,
    required this.onAdd,
  });

  @override
  State<_AddRoleDialog> createState() => _AddRoleDialogState();
}

class _AddRoleDialogState extends State<_AddRoleDialog> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.isFirstRole
          ? 'Add Top Level Role'
          : 'Add Role Level ${widget.currentLevel}'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: _controller,
            decoration: InputDecoration(
              labelText: 'Role Name',
              hintText: widget.isFirstRole
                  ? 'e.g., Chief Executive Officer, Chairman, Managing Director'
                  : 'e.g., General Manager, Department Head, Team Lead',
              border: const OutlineInputBorder(),
            ),
            autofocus: true,
          ),
          if (!widget.isFirstRole) ...[
            const SizedBox(height: 16),
            Text(
              'This will be Level ${widget.currentLevel} in your hierarchy',
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ],
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_controller.text.trim().isNotEmpty) {
              widget.onAdd(_controller.text.trim());
              Navigator.pop(context);
            }
          },
          child: const Text('Add Role'),
        ),
      ],
    );
  }
}

// Role Configuration Dialog
class _RoleConfigDialog extends StatelessWidget {
  final DynamicRole role;
  final Function(DynamicRole) onSaved;

  const _RoleConfigDialog({required this.role, required this.onSaved});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Configure ${role.displayName}'),
      content: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Role configuration options:'),
          Text('• Permissions management'),
          Text('• Dashboard customization'),
          Text('• Access level settings'),
          Text('• Reporting structure'),
          SizedBox(height: 16),
          Text('This feature will be available in the next update.'),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Close'),
        ),
      ],
    );
  }
}
