// lib/features/admin/presentation/widgets/role_selection_dialog.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/dynamic_role.dart';
import '../../providers/organization_provider.dart';

class RoleSelectionDialog extends ConsumerStatefulWidget {
  final Map<String, dynamic> request;
  final Function(Map<String, dynamic>) onRoleSelected;

  const RoleSelectionDialog({
    super.key,
    required this.request,
    required this.onRoleSelected,
  });

  @override
  ConsumerState<RoleSelectionDialog> createState() =>
      _RoleSelectionDialogState();
}

class _RoleSelectionDialogState extends ConsumerState<RoleSelectionDialog> {
  Map<String, dynamic>? _selectedRole;
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final orgConfig = ref.watch(organizationConfigProvider);
    final roles = _getAvailableRoles(orgConfig);
    final filteredRoles = _filterRoles(roles);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.7,
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            _buildHeader(),
            const SizedBox(height: 20),

            // Search bar
            _buildSearchBar(),
            const SizedBox(height: 16),

            // Role list
            Expanded(child: _buildRoleList(filteredRoles)),

            // Actions
            const SizedBox(height: 20),
            _buildActions(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    final userDetails = widget.request['userDetails'] as Map<String, dynamic>;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'Assign Role',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.close),
              tooltip: 'Close',
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'Select a role for ${userDetails['name']} (${userDetails['email']})',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey.shade600,
              ),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      controller: _searchController,
      decoration: InputDecoration(
        hintText: 'Search roles...',
        prefixIcon: const Icon(Icons.search),
        suffixIcon: _searchQuery.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  _searchController.clear();
                  setState(() {
                    _searchQuery = '';
                  });
                },
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      onChanged: (value) {
        setState(() {
          _searchQuery = value.toLowerCase();
        });
      },
    );
  }

  Widget _buildRoleList(List<Map<String, dynamic>> roles) {
    if (roles.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 64,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 16),
            Text(
              'No roles found',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.grey.shade600,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              _searchQuery.isNotEmpty
                  ? 'Try adjusting your search query'
                  : 'No roles available for assignment',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey.shade500,
                  ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: roles.length,
      itemBuilder: (context, index) {
        final role = roles[index];
        final isSelected = _selectedRole?['id'] == role['id'];

        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color: isSelected
                  ? Theme.of(context).primaryColor
                  : Colors.grey.shade300,
              width: isSelected ? 2 : 1,
            ),
          ),
          child: InkWell(
            onTap: () {
              setState(() {
                _selectedRole = role;
              });
            },
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          role['displayName'] ?? 'Unknown Role',
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: isSelected
                                        ? Theme.of(context).primaryColor
                                        : null,
                                  ),
                        ),
                      ),
                      if (isSelected)
                        Icon(
                          Icons.check_circle,
                          color: Theme.of(context).primaryColor,
                        ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  _buildHierarchyLevel(role['hierarchyLevel'] as int?),
                  const SizedBox(height: 8),
                  _buildPermissions(role['permissions'] as List?),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHierarchyLevel(int? level) {
    String levelText = _getHierarchyLevelText(level ?? 999);
    Color levelColor = _getHierarchyLevelColor(level ?? 999);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: levelColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: levelColor.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.layers, size: 14, color: levelColor),
          const SizedBox(width: 4),
          Text(
            'Level $level - $levelText',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: levelColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPermissions(List? permissions) {
    if (permissions == null || permissions.isEmpty) {
      return const Text(
        'No specific permissions',
        style: TextStyle(
          fontSize: 12,
          color: Colors.grey,
          fontStyle: FontStyle.italic,
        ),
      );
    }

    final permissionList = List<String>.from(permissions);
    final displayPermissions = permissionList.take(3).toList();
    final hasMore = permissionList.length > 3;

    return Wrap(
      spacing: 4,
      runSpacing: 4,
      children: [
        ...displayPermissions.map((permission) => Chip(
              label: Text(
                permission.replaceAll('_', ' ').toUpperCase(),
                style: const TextStyle(fontSize: 10),
              ),
              backgroundColor: Colors.blue.shade50,
              side: BorderSide(color: Colors.blue.shade200),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              visualDensity: VisualDensity.compact,
            )),
        if (hasMore)
          Chip(
            label: Text(
              '+${permissionList.length - 3} more',
              style: const TextStyle(fontSize: 10),
            ),
            backgroundColor: Colors.grey.shade100,
            side: BorderSide(color: Colors.grey.shade300),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: VisualDensity.compact,
          ),
      ],
    );
  }

  Widget _buildActions() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton(
            onPressed: _selectedRole != null
                ? () {
                    Navigator.of(context).pop();
                    widget.onRoleSelected(_selectedRole!);
                  }
                : null,
            child: const Text('Assign Role'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<Map<String, dynamic>> _getAvailableRoles(
      Map<String, dynamic> orgConfig) {
    final roles = orgConfig['roles'] as List<dynamic>? ?? [];
    return roles.cast<Map<String, dynamic>>();
  }

  List<Map<String, dynamic>> _filterRoles(List<Map<String, dynamic>> roles) {
    if (_searchQuery.isEmpty) return roles;

    return roles.where((role) {
      final displayName = (role['displayName'] as String? ?? '').toLowerCase();
      final name = (role['name'] as String? ?? '').toLowerCase();
      final permissions = role['permissions'] as List? ?? [];
      final permissionText = permissions.join(' ').toLowerCase();

      return displayName.contains(_searchQuery) ||
          name.contains(_searchQuery) ||
          permissionText.contains(_searchQuery);
    }).toList();
  }

  String _getHierarchyLevelText(int level) {
    if (level <= 10) return 'Executive';
    if (level <= 30) return 'Manager';
    if (level <= 50) return 'Supervisor';
    if (level <= 70) return 'Operator';
    return 'Basic';
  }

  Color _getHierarchyLevelColor(int level) {
    if (level <= 10) return Colors.purple;
    if (level <= 30) return Colors.blue;
    if (level <= 50) return Colors.green;
    if (level <= 70) return Colors.orange;
    return Colors.grey;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
