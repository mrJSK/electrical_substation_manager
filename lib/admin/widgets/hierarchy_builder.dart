import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/hierarchy_level.dart';
import '../../services/location_service.dart';

class HierarchyBuilder extends ConsumerStatefulWidget {
  final Function(List<HierarchyLevel>) onChanged;
  final List<HierarchyLevel>? initialLevels;
  final String? organizationId; // 🔥 NEW: For SaaS multi-tenancy

  const HierarchyBuilder({
    super.key,
    required this.onChanged,
    this.initialLevels,
    this.organizationId,
  });

  @override
  ConsumerState<HierarchyBuilder> createState() => _HierarchyBuilderState();
}

class _HierarchyBuilderState extends ConsumerState<HierarchyBuilder>
    with TickerProviderStateMixin {
  List<HierarchyLevel> _levels = [];
  bool _isLoadingLocation = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _levels = widget.initialLevels ?? [];
    _initializeLocationService();

    // Animation setup
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  Future<void> _initializeLocationService() async {
    setState(() => _isLoadingLocation = true);
    try {
      await LocationService.initializeLocationData();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to load location data: $e'),
            backgroundColor: Colors.orange,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoadingLocation = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _fadeAnimation,
      builder: (context, child) {
        return Opacity(
          opacity: _fadeAnimation.value,
          child: Card(
            elevation: 4,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 20),
                  _buildContent(),
                  const SizedBox(height: 20),
                  _buildFooter(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade600, Colors.blue.shade400],
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(
            Icons.account_tree_rounded,
            color: Colors.white,
            size: 24,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Organization Hierarchy',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade800,
                    ),
              ),
              Text(
                'Define your organizational structure with location support',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey.shade600,
                    ),
              ),
            ],
          ),
        ),
        _buildActionButtons(),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // 🔥 NEW: Location-aware level creation
        ElevatedButton.icon(
          onPressed: _isLoadingLocation ? null : _addLocationAwareLevel,
          icon: _isLoadingLocation
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Icon(Icons.add_location_alt),
          label: const Text('Add Level'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green.shade600,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        const SizedBox(width: 8),
        // 🔥 NEW: Bulk import with location
        PopupMenuButton<String>(
          icon: Icon(Icons.more_vert, color: Colors.grey.shade600),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'import',
              child: Row(
                children: [
                  Icon(Icons.cloud_download, size: 20),
                  SizedBox(width: 12),
                  Text('Import Template'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 'export',
              child: Row(
                children: [
                  Icon(Icons.cloud_upload, size: 20),
                  SizedBox(width: 12),
                  Text('Export Structure'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 'validate',
              child: Row(
                children: [
                  Icon(Icons.check_circle, size: 20),
                  SizedBox(width: 12),
                  Text('Validate Structure'),
                ],
              ),
            ),
          ],
          onSelected: _handleMenuAction,
        ),
      ],
    );
  }

  Widget _buildContent() {
    if (_levels.isEmpty) {
      return _buildEmptyState();
    } else {
      return _buildHierarchyTree();
    }
  }

  Widget _buildEmptyState() {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Icon(
            Icons.account_tree_rounded,
            size: 64,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 20),
          Text(
            'No hierarchy levels added yet',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Create your organizational structure with location-aware levels',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey.shade500,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          _buildQuickTemplates(),
        ],
      ),
    );
  }

  Widget _buildQuickTemplates() {
    return Column(
      children: [
        Text(
          'Quick Start Templates:',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade700,
              ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 8,
          children: [
            _buildTemplateChip(
              'Power Utility (6 levels)',
              Icons.electrical_services,
              Colors.red,
              () => _applyTemplate(_powerUtilityTemplate),
            ),
            _buildTemplateChip(
              'Government (5 levels)',
              Icons.account_balance,
              Colors.blue,
              () => _applyTemplate(_governmentTemplate),
            ),
            _buildTemplateChip(
              'Corporate (4 levels)',
              Icons.business,
              Colors.green,
              () => _applyTemplate(_corporateTemplate),
            ),
            _buildTemplateChip(
              'Manufacturing (5 levels)',
              Icons.factory,
              Colors.orange,
              () => _applyTemplate(_manufacturingTemplate),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTemplateChip(
    String label,
    IconData icon,
    Color color,
    VoidCallback onPressed,
  ) {
    return ActionChip(
      avatar: Icon(icon, size: 18, color: color),
      label: Text(label),
      onPressed: onPressed,
      backgroundColor: color.withOpacity(0.1),
      side: BorderSide(color: color.withOpacity(0.3)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    );
  }

  Widget _buildHierarchyTree() {
    return Column(
      children: [
        // Structure Overview
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.blue.shade200),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline, color: Colors.blue.shade600),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  '${_levels.length} hierarchy levels defined • Location-aware structure',
                  style: TextStyle(
                    color: Colors.blue.shade700,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              TextButton.icon(
                onPressed: _showStructurePreview,
                icon: const Icon(Icons.visibility),
                label: const Text('Preview'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // Hierarchy Levels
        ...List.generate(_levels.length, (index) {
          return _buildHierarchyLevelCard(_levels[index], index);
        }),
      ],
    );
  }

  Widget _buildHierarchyLevelCard(HierarchyLevel level, int index) {
    return Container(
      margin: EdgeInsets.only(
        left: index * 24.0,
        bottom: 12.0,
      ),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              colors: [
                Colors.white,
                _getColorForLevel(index).withOpacity(0.05),
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.all(16),
            leading: _buildLevelIcon(index),
            title: _buildLevelTitle(level, index),
            subtitle: _buildLevelSubtitle(level, index),
            trailing: _buildLevelActions(level, index),
          ),
        ),
      ),
    );
  }

  Widget _buildLevelIcon(int index) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            _getColorForLevel(index),
            _getColorForLevel(index).withOpacity(0.7),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: _getColorForLevel(index).withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Icon(
        _getIconForLevel(index),
        color: Colors.white,
        size: 24,
      ),
    );
  }

  Widget _buildLevelTitle(HierarchyLevel level, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          initialValue: level.displayName,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
          decoration: InputDecoration(
            hintText: 'Enter level name (e.g., Regional Manager)',
            border: InputBorder.none,
            isDense: true,
            suffixIcon: Icon(
              Icons.edit,
              size: 16,
              color: Colors.grey.shade400,
            ),
          ),
          onChanged: (value) {
            _updateLevel(index, level.copyWith(displayName: value));
          },
        ),
      ],
    );
  }

  Widget _buildLevelSubtitle(HierarchyLevel level, int index) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: _getColorForLevel(index).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              'Level ${index + 1}',
              style: TextStyle(
                color: _getColorForLevel(index),
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Icon(Icons.security, size: 14, color: Colors.grey.shade500),
          const SizedBox(width: 4),
          Text(
            '${level.permissions.length} permissions',
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 12,
            ),
          ),
          const SizedBox(width: 8),
          Icon(Icons.location_on, size: 14, color: Colors.grey.shade500),
          const SizedBox(width: 4),
          Text(
            'Location-aware',
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLevelActions(HierarchyLevel level, int index) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // 🔥 NEW: Location configuration
        IconButton(
          icon: Icon(Icons.map, color: Colors.blue.shade600),
          tooltip: 'Configure Location Settings',
          onPressed: () => _configureLocationSettings(level, index),
        ),
        IconButton(
          icon: Icon(Icons.security, color: Colors.green.shade600),
          tooltip: 'Configure Permissions',
          onPressed: () => _configureLevelPermissions(level, index),
        ),
        if (index > 0)
          IconButton(
            icon: Icon(Icons.delete, color: Colors.red.shade600),
            tooltip: 'Delete Level',
            onPressed: () => _removeLevel(index),
          ),
      ],
    );
  }

  Widget _buildFooter() {
    if (_levels.isEmpty) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline, color: Colors.grey.shade600),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Each level can have location-specific configurations and custom fields.',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 13,
              ),
            ),
          ),
          TextButton(
            onPressed: _showHierarchyHelp,
            child: const Text('Learn More'),
          ),
        ],
      ),
    );
  }

  // 🔥 NEW: Location-aware level creation
  void _addLocationAwareLevel() {
    showDialog(
      context: context,
      builder: (context) => LocationAwareLevelDialog(
        levelNumber: _levels.length + 1,
        onLevelCreated: (newLevel) {
          setState(() {
            _levels.add(newLevel);
          });
          widget.onChanged(_levels);
        },
      ),
    );
  }

  // 🔥 NEW: Location settings configuration
  void _configureLocationSettings(HierarchyLevel level, int index) {
    showDialog(
      context: context,
      builder: (context) => LocationSettingsDialog(
        level: level,
        onSettingsChanged: (updatedLevel) {
          _updateLevel(index, updatedLevel);
        },
      ),
    );
  }

  void _removeLevel(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Delete Hierarchy Level'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Are you sure you want to delete "${_levels[index].displayName}"?',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.red.shade200),
              ),
              child: Row(
                children: [
                  Icon(Icons.warning, color: Colors.red.shade600),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'This action cannot be undone and will affect all child levels.',
                      style: TextStyle(
                        color: Colors.red.shade700,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
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
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
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
      builder: (context) => EnhancedPermissionConfigDialog(
        level: level,
        onSaved: (updatedLevel) {
          _updateLevel(index, updatedLevel);
        },
      ),
    );
  }

  void _applyTemplate(List<HierarchyLevel> template) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Apply Template'),
        content: const Text(
          'This will replace your current hierarchy structure. Continue?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _levels = List.from(template);
              });
              widget.onChanged(_levels);
              Navigator.pop(context);
            },
            child: const Text('Apply'),
          ),
        ],
      ),
    );
  }

  void _handleMenuAction(String action) {
    switch (action) {
      case 'import':
        _showImportDialog();
        break;
      case 'export':
        _exportStructure();
        break;
      case 'validate':
        _validateStructure();
        break;
    }
  }

  void _showImportDialog() {
    // Implementation for importing hierarchy structures
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Import functionality coming soon!')),
    );
  }

  void _exportStructure() {
    // Implementation for exporting hierarchy structures
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Export functionality coming soon!')),
    );
  }

  void _validateStructure() {
    // Implementation for validating hierarchy structure
    final issues = <String>[];

    if (_levels.isEmpty) {
      issues.add('No hierarchy levels defined');
    }

    for (int i = 0; i < _levels.length; i++) {
      if (_levels[i].displayName.isEmpty) {
        issues.add('Level ${i + 1} has no name');
      }
      if (_levels[i].permissions.isEmpty) {
        issues.add('Level ${i + 1} has no permissions');
      }
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(
              issues.isEmpty ? Icons.check_circle : Icons.warning,
              color: issues.isEmpty ? Colors.green : Colors.orange,
            ),
            const SizedBox(width: 8),
            Text('Structure ${issues.isEmpty ? 'Valid' : 'Issues Found'}'),
          ],
        ),
        content: issues.isEmpty
            ? const Text('Your hierarchy structure looks good!')
            : Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Issues found:'),
                  const SizedBox(height: 8),
                  ...issues.map((issue) => Padding(
                        padding: const EdgeInsets.only(left: 16, bottom: 4),
                        child: Text('• $issue'),
                      )),
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

  void _showStructurePreview() {
    showDialog(
      context: context,
      builder: (context) => StructurePreviewDialog(levels: _levels),
    );
  }

  void _showHierarchyHelp() {
    showDialog(
      context: context,
      builder: (context) => const HierarchyHelpDialog(),
    );
  }

  // Enhanced template data with location awareness
  List<HierarchyLevel> get _powerUtilityTemplate => [
        HierarchyLevel(
          id: 'head_office',
          name: 'head_office',
          displayName: 'Head Office Director',
          level: 1,
          permissions: ['view_all', 'manage_all', 'admin_access'],
          dashboardConfig: {'showStatusCard': true, 'showAnalytics': true},
        ),
        HierarchyLevel(
          id: 'regional',
          name: 'regional',
          displayName: 'Regional Manager',
          level: 2,
          parentId: 'head_office',
          permissions: ['view_region', 'manage_zones'],
          dashboardConfig: {'showStatusCard': true, 'showRegionalData': true},
        ),
        HierarchyLevel(
          id: 'zone',
          name: 'zone',
          displayName: 'Zone Manager',
          level: 3,
          parentId: 'regional',
          permissions: ['view_zone', 'manage_circles'],
          dashboardConfig: {'showStatusCard': true},
        ),
        HierarchyLevel(
          id: 'circle',
          name: 'circle',
          displayName: 'Circle Manager',
          level: 4,
          parentId: 'zone',
          permissions: ['view_circle', 'manage_substations'],
          dashboardConfig: {'showStatusCard': true, 'showEquipmentGrid': true},
        ),
        HierarchyLevel(
          id: 'division',
          name: 'division',
          displayName: 'Division Manager',
          level: 5,
          parentId: 'circle',
          permissions: ['view_division', 'manage_operators'],
          dashboardConfig: {'showStatusCard': true, 'showEquipmentGrid': true},
        ),
        HierarchyLevel(
          id: 'substation',
          name: 'substation',
          displayName: 'Substation Operator',
          level: 6,
          parentId: 'division',
          permissions: ['view_substation', 'add_readings', 'maintenance_log'],
          dashboardConfig: {'showStatusCard': true, 'showEquipmentGrid': true},
        ),
      ];

  // Additional template implementations...
  List<HierarchyLevel> get _governmentTemplate => [
        // Implementation for government template
      ];

  List<HierarchyLevel> get _corporateTemplate => [
        // Implementation for corporate template
      ];

  List<HierarchyLevel> get _manufacturingTemplate => [
        // Implementation for manufacturing template
      ];

  IconData _getIconForLevel(int index) {
    final icons = [
      Icons.business_rounded,
      Icons.location_city_rounded,
      Icons.account_tree_rounded,
      Icons.group_rounded,
      Icons.electrical_services_rounded,
      Icons.settings_rounded,
    ];
    return icons[index % icons.length];
  }

  Color _getColorForLevel(int index) {
    final colors = [
      Colors.deepPurple,
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.red,
      Colors.teal,
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
      'showLocationMap': true, // 🔥 NEW: Location map feature
    };
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

// 🔥 NEW: Enhanced Permission Configuration Dialog
class EnhancedPermissionConfigDialog extends StatefulWidget {
  final HierarchyLevel level;
  final Function(HierarchyLevel) onSaved;

  const EnhancedPermissionConfigDialog({
    Key? key,
    required this.level,
    required this.onSaved,
  }) : super(key: key);

  @override
  State<EnhancedPermissionConfigDialog> createState() =>
      _EnhancedPermissionConfigDialogState();
}

class _EnhancedPermissionConfigDialogState
    extends State<EnhancedPermissionConfigDialog> {
  late List<String> _selectedPermissions;

  final Map<String, List<String>> _permissionCategories = {
    'Data Access': [
      'view_all',
      'view_region',
      'view_zone',
      'view_circle',
      'view_substation',
    ],
    'Management': [
      'manage_all',
      'manage_users',
      'manage_substations',
      'manage_maintenance',
    ],
    'Operations': [
      'add_readings',
      'update_readings',
      'delete_readings',
      'maintenance_log',
    ],
    'Reporting': [
      'generate_reports',
      'export_data',
      'view_analytics',
      'schedule_reports',
    ],
    'Administration': [
      'admin_access',
      'system_config',
      'user_approval',
      'audit_logs',
    ],
  };

  @override
  void initState() {
    super.initState();
    _selectedPermissions = List.from(widget.level.permissions);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: 600,
        height: 500,
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(Icons.security, color: Colors.blue.shade600),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Configure Permissions',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(
                        widget.level.displayName,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.grey.shade600,
                            ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _permissionCategories.length,
                itemBuilder: (context, index) {
                  final category = _permissionCategories.keys.elementAt(index);
                  final permissions = _permissionCategories[category]!;

                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ExpansionTile(
                      title: Text(
                        category,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      initiallyExpanded: true,
                      children: permissions.map((permission) {
                        return CheckboxListTile(
                          title: Text(
                            permission.replaceAll('_', ' ').toUpperCase(),
                            style: const TextStyle(fontSize: 14),
                          ),
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
                      }).toList(),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.info_outline,
                        size: 16, color: Colors.grey.shade600),
                    const SizedBox(width: 8),
                    Text(
                      '${_selectedPermissions.length} permissions selected',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        final updatedLevel = widget.level.copyWith(
                          permissions: _selectedPermissions,
                        );
                        widget.onSaved(updatedLevel);
                        Navigator.pop(context);
                      },
                      child: const Text('Save Permissions'),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// 🔥 NEW: Location-Aware Level Dialog
class LocationAwareLevelDialog extends StatefulWidget {
  final int levelNumber;
  final Function(HierarchyLevel) onLevelCreated;

  const LocationAwareLevelDialog({
    Key? key,
    required this.levelNumber,
    required this.onLevelCreated,
  }) : super(key: key);

  @override
  State<LocationAwareLevelDialog> createState() =>
      _LocationAwareLevelDialogState();
}

class _LocationAwareLevelDialogState extends State<LocationAwareLevelDialog> {
  final _nameController = TextEditingController();
  StateModel? _selectedState;
  CityModel? _selectedCity;
  List<StateModel> _states = [];
  List<CityModel> _cities = [];
  bool _requiresLocation = true;

  @override
  void initState() {
    super.initState();
    _loadStates();
  }

  void _loadStates() async {
    final states = LocationService.getAllStates();
    setState(() {
      _states = states;
    });
  }

  void _onStateChanged(StateModel? state) {
    setState(() {
      _selectedState = state;
      _selectedCity = null;
      _cities =
          state != null ? LocationService.getCitiesForState(state.id) : [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: 500,
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Add Hierarchy Level ${widget.levelNumber}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Level Name',
                hintText: 'e.g., Regional Manager, Zone Head',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text('Requires Location Assignment'),
              subtitle: const Text(
                  'Users at this level must be assigned to specific locations'),
              value: _requiresLocation,
              onChanged: (value) => setState(() => _requiresLocation = value),
            ),
            if (_requiresLocation) ...[
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<StateModel>(
                      value: _selectedState,
                      decoration: InputDecoration(
                        labelText: 'Default State (Optional)',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      items: _states.map((state) {
                        return DropdownMenuItem(
                          value: state,
                          child: Text(state.name),
                        );
                      }).toList(),
                      onChanged: _onStateChanged,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: DropdownButtonFormField<CityModel>(
                      value: _selectedCity,
                      decoration: InputDecoration(
                        labelText: 'Default City (Optional)',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      items: _cities.map((city) {
                        return DropdownMenuItem(
                          value: city,
                          child: Text(city.name),
                        );
                      }).toList(),
                      onChanged: (city) => setState(() => _selectedCity = city),
                    ),
                  ),
                ],
              ),
            ],
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _nameController.text.isEmpty ? null : _createLevel,
                  child: const Text('Create Level'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _createLevel() {
    final newLevel = HierarchyLevel(
      id: 'level_${widget.levelNumber}',
      name: 'level${widget.levelNumber}',
      displayName: _nameController.text,
      level: widget.levelNumber,
      parentId:
          widget.levelNumber > 1 ? 'level_${widget.levelNumber - 1}' : null,
      permissions: _getDefaultPermissions(widget.levelNumber),
      dashboardConfig: _getDefaultDashboardConfig(widget.levelNumber),
    );

    widget.onLevelCreated(newLevel);
    Navigator.pop(context);
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
      'showLocationMap': _requiresLocation,
      'requiresLocation': _requiresLocation,
      'defaultState': _selectedState?.name,
      'defaultCity': _selectedCity?.name,
    };
  }
}

// 🔥 NEW: Location Settings Dialog
class LocationSettingsDialog extends StatefulWidget {
  final HierarchyLevel level;
  final Function(HierarchyLevel) onSettingsChanged;

  const LocationSettingsDialog({
    Key? key,
    required this.level,
    required this.onSettingsChanged,
  }) : super(key: key);

  @override
  State<LocationSettingsDialog> createState() => _LocationSettingsDialogState();
}

class _LocationSettingsDialogState extends State<LocationSettingsDialog> {
  // Implementation for location settings configuration
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Location Settings'),
      content: const Text('Location settings configuration coming soon!'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Close'),
        ),
      ],
    );
  }
}

// 🔥 NEW: Structure Preview Dialog
class StructurePreviewDialog extends StatelessWidget {
  final List<HierarchyLevel> levels;

  const StructurePreviewDialog({
    Key? key,
    required this.levels,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: 600,
        height: 500,
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.visibility, color: Colors.blue.shade600),
                const SizedBox(width: 12),
                Text(
                  'Structure Preview',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const Spacer(),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: levels.length,
                itemBuilder: (context, index) {
                  final level = levels[index];
                  return Container(
                    margin: EdgeInsets.only(
                      left: index * 20.0,
                      bottom: 8,
                    ),
                    child: Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: _getColorForLevel(index),
                          child: Text('${index + 1}'),
                        ),
                        title: Text(level.displayName),
                        subtitle:
                            Text('${level.permissions.length} permissions'),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getColorForLevel(int index) {
    final colors = [
      Colors.deepPurple,
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.red,
      Colors.teal,
    ];
    return colors[index % colors.length];
  }
}

// 🔥 NEW: Hierarchy Help Dialog
class HierarchyHelpDialog extends StatelessWidget {
  const HierarchyHelpDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: 500,
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.help_outline, color: Colors.blue.shade600),
                const SizedBox(width: 12),
                Text(
                  'Hierarchy Builder Help',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const Spacer(),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Building Your Organization Hierarchy:',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            const SizedBox(height: 12),
            const Text('• Start with the highest level (e.g., Head Office)'),
            const Text(
                '• Add progressively lower levels (Region → Zone → Circle)'),
            const Text('• Configure permissions for each level'),
            const Text('• Set up location requirements as needed'),
            const Text('• Use templates for quick setup'),
            const SizedBox(height: 16),
            const Text(
              'Tips:',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            const SizedBox(height: 12),
            const Text('• Higher levels typically have broader permissions'),
            const Text('• Location-aware levels improve organization'),
            const Text('• Validate your structure before finalizing'),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Got it!'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
