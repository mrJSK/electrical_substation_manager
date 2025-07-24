import 'package:flutter/material.dart';
import '../models/hierarchy_level.dart';
import '../models/organization_config.dart';

class HierarchyBuilder extends StatefulWidget {
  final Function(List<HierarchyLevel>) onChanged;
  final List<HierarchyLevel>? initialLevels;

  const HierarchyBuilder({
    super.key,
    required this.onChanged,
    this.initialLevels,
  });

  @override
  State<HierarchyBuilder> createState() => _HierarchyBuilderState();
}

class _HierarchyBuilderState extends State<HierarchyBuilder> {
  List<HierarchyLevel> _levels = [];

  @override
  void initState() {
    super.initState();
    _levels = widget.initialLevels ?? [];
  }

  @override
  Widget build(BuildContext context) {
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
                  'Organization Hierarchy',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                ElevatedButton.icon(
                  onPressed: _addLevel,
                  icon: const Icon(Icons.add),
                  label: const Text('Add Level'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            if (_levels.isEmpty)
              Container(
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.grey.shade300, style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Column(
                    children: [
                      Icon(Icons.account_tree, size: 48, color: Colors.grey),
                      SizedBox(height: 16),
                      Text(
                        'No hierarchy levels added yet',
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Click "Add Level" to start building your organization hierarchy',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              )
            else
              // Hierarchy Tree
              Column(
                children: _levels.asMap().entries.map((entry) {
                  int index = entry.key;
                  HierarchyLevel level = entry.value;

                  return Container(
                    margin: EdgeInsets.only(
                      left: index * 20.0,
                      bottom: 8.0,
                    ),
                    child: Card(
                      elevation: 2,
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: _getColorForLevel(index),
                          child: Icon(
                            _getIconForLevel(index),
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                        title: TextFormField(
                          initialValue: level.displayName,
                          decoration: InputDecoration(
                            labelText: 'Level ${index + 1} Name',
                            border: InputBorder.none,
                            hintText: 'Enter level name (e.g., Chief Engineer)',
                          ),
                          onChanged: (value) {
                            _updateLevel(
                                index, level.copyWith(displayName: value));
                          },
                        ),
                        subtitle: Text(
                          'Level ${index + 1} • ${level.permissions.length} permissions',
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.settings,
                                  color: Colors.blue),
                              tooltip: 'Configure Permissions',
                              onPressed: () =>
                                  _configureLevelPermissions(level, index),
                            ),
                            if (index > 0) // Can't delete first level
                              IconButton(
                                icon:
                                    const Icon(Icons.delete, color: Colors.red),
                                tooltip: 'Delete Level',
                                onPressed: () => _removeLevel(index),
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),

            const SizedBox(height: 16),

            // Quick Templates
            if (_levels.isEmpty)
              Wrap(
                spacing: 8,
                children: [
                  const Text('Quick templates: '),
                  ActionChip(
                    label: const Text('Government (5 levels)'),
                    onPressed: () => _applyTemplate(_governmentTemplate),
                  ),
                  ActionChip(
                    label: const Text('Private (3 levels)'),
                    onPressed: () => _applyTemplate(_privateTemplate),
                  ),
                  ActionChip(
                    label: const Text('UPPCL'),
                    onPressed: () => _applyTemplate(_uppcLTemplate),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  void _addLevel() {
    final newLevel = HierarchyLevel(
      id: 'level_${_levels.length + 1}',
      name: 'level${_levels.length + 1}',
      displayName: '',
      level: _levels.length + 1,
      parentId: _levels.isNotEmpty ? _levels.last.id : null,
      permissions: _getDefaultPermissions(_levels.length + 1),
      dashboardConfig: _getDefaultDashboardConfig(_levels.length + 1),
    );

    setState(() {
      _levels.add(newLevel);
    });

    widget.onChanged(_levels);
  }

  void _removeLevel(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Level'),
        content: Text(
            'Are you sure you want to delete "${_levels[index].displayName}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _levels.removeAt(index);
                // Update level numbers for remaining levels
                for (int i = index; i < _levels.length; i++) {
                  _levels[i] = _levels[i].copyWith(level: i + 1);
                }
              });
              widget.onChanged(_levels);
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _updateLevel(int index, HierarchyLevel updatedLevel) {
    setState(() {
      _levels[index] = updatedLevel;
    });
    widget.onChanged(_levels);
  }

  void _configureLevelPermissions(HierarchyLevel level, int index) {
    showDialog(
      context: context,
      builder: (context) => _PermissionConfigDialog(
        level: level,
        onSaved: (updatedLevel) {
          _updateLevel(index, updatedLevel);
        },
      ),
    );
  }

  void _applyTemplate(List<HierarchyLevel> template) {
    setState(() {
      _levels = template;
    });
    widget.onChanged(_levels);
  }

  IconData _getIconForLevel(int index) {
    final icons = [
      Icons.business,
      Icons.location_city,
      Icons.account_tree,
      Icons.group,
      Icons.electrical_services,
    ];
    return icons[index % icons.length];
  }

  Color _getColorForLevel(int index) {
    final colors = [
      Colors.purple,
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.red,
    ];
    return colors[index % colors.length];
  }

  List<String> _getDefaultPermissions(int level) {
    switch (level) {
      case 1:
        return ['view_all', 'manage_all', 'admin_access'];
      case 2:
        return ['view_region', 'manage_zones'];
      case 3:
        return ['view_zone', 'manage_circles'];
      case 4:
        return ['view_circle', 'manage_substations'];
      default:
        return ['view_substation', 'add_readings'];
    }
  }

  Map<String, dynamic> _getDefaultDashboardConfig(int level) {
    return {
      'showStatusCard': true,
      'showEquipmentGrid': level >= 4,
      'showAnalytics': level <= 2,
      'showUserManagement': level <= 3,
    };
  }

  // Template data
  List<HierarchyLevel> get _governmentTemplate => [
        HierarchyLevel(
          id: 'state',
          name: 'state',
          displayName: 'State Director',
          level: 1,
          permissions: ['view_all', 'manage_all'],
          dashboardConfig: {'showStatusCard': true, 'showAnalytics': true},
        ),
        HierarchyLevel(
          id: 'zone',
          name: 'zone',
          displayName: 'Zonal Head',
          level: 2,
          parentId: 'state',
          permissions: ['view_zone', 'manage_circles'],
          dashboardConfig: {'showStatusCard': true},
        ),
        // Add more template levels...
      ];

  List<HierarchyLevel> get _privateTemplate => [
        HierarchyLevel(
          id: 'corporate',
          name: 'corporate',
          displayName: 'Corporate Head',
          level: 1,
          permissions: ['full_access'],
          dashboardConfig: {'showStatusCard': true, 'showAnalytics': true},
        ),
        // Add more template levels...
      ];

  List<HierarchyLevel> get _uppcLTemplate => [
        HierarchyLevel(
          id: 'hq',
          name: 'headquarters',
          displayName: 'HQ Director',
          level: 1,
          permissions: ['view_all', 'manage_all'],
          dashboardConfig: {'showStatusCard': true, 'showAnalytics': true},
        ),
        HierarchyLevel(
          id: 'zone',
          name: 'zone',
          displayName: 'Chief Engineer (CE)',
          level: 2,
          parentId: 'hq',
          permissions: ['view_zone', 'manage_circles'],
          dashboardConfig: {'showStatusCard': true},
        ),
        // Add more UPPCL levels...
      ];
}

// Permission Configuration Dialog
class _PermissionConfigDialog extends StatefulWidget {
  final HierarchyLevel level;
  final Function(HierarchyLevel) onSaved;

  const _PermissionConfigDialog({
    required this.level,
    required this.onSaved,
  });

  @override
  State<_PermissionConfigDialog> createState() =>
      _PermissionConfigDialogState();
}

class _PermissionConfigDialogState extends State<_PermissionConfigDialog> {
  late List<String> _selectedPermissions;

  final List<String> _availablePermissions = [
    'view_all',
    'view_region',
    'view_zone',
    'view_circle',
    'view_substation',
    'manage_all',
    'manage_users',
    'manage_substations',
    'add_readings',
    'generate_reports',
    'admin_access',
  ];

  @override
  void initState() {
    super.initState();
    _selectedPermissions = List.from(widget.level.permissions);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Configure Permissions - ${widget.level.displayName}'),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Select permissions for this level:'),
            const SizedBox(height: 16),
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _availablePermissions.length,
                itemBuilder: (context, index) {
                  final permission = _availablePermissions[index];
                  return CheckboxListTile(
                    title: Text(permission.replaceAll('_', ' ').toUpperCase()),
                    value: _selectedPermissions.contains(permission),
                    onChanged: (bool? value) {
                      setState(() {
                        if (value == true) {
                          _selectedPermissions.add(permission);
                        } else {
                          _selectedPermissions.remove(permission);
                        }
                      });
                    },
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
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            final updatedLevel = widget.level.copyWith(
              permissions: _selectedPermissions,
            );
            widget.onSaved(updatedLevel);
            Navigator.pop(context);
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
