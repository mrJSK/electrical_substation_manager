import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../layouts/admin_layout.dart';
import '../widgets/organization_card.dart';
import '../widgets/add_organization_dialog.dart';
import '../providers/organizations_provider.dart';

class OrganizationsScreen extends ConsumerStatefulWidget {
  const OrganizationsScreen({super.key});

  @override
  ConsumerState<OrganizationsScreen> createState() =>
      _OrganizationsScreenState();
}

class _OrganizationsScreenState extends ConsumerState<OrganizationsScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  String _searchQuery = '';
  String _selectedFilter = 'all';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final organizationsAsync = ref.watch(organizationsProvider);

    return AdminLayout(
      title: 'Organizations',
      child: Column(
        children: [
          // Header with Actions
          _buildHeader(),

          const SizedBox(height: 24),

          // Filters and Search
          _buildFiltersAndSearch(),

          const SizedBox(height: 24),

          // Tab Bar
          _buildTabBar(),

          const SizedBox(height: 24),

          // Content
          Expanded(
            child: organizationsAsync.when(
              data: (organizations) => _buildOrganizationsList(organizations),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => _buildErrorState(error),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        // Stats Cards
        Expanded(
          child: Row(
            children: [
              _buildStatCard('Total', '156', Colors.blue),
              const SizedBox(width: 16),
              _buildStatCard('Active', '142', Colors.green),
              const SizedBox(width: 16),
              _buildStatCard('Pending', '8', Colors.orange),
              const SizedBox(width: 16),
              _buildStatCard('Inactive', '6', Colors.red),
            ],
          ),
        ),

        const SizedBox(width: 24),

        // Add Organization Button
        ElevatedButton.icon(
          onPressed: () => _showAddOrganizationDialog(),
          icon: const Icon(Icons.add_business_rounded, size: 20),
          label: const Text('Add Organization'),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF3B82F6),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(String label, String value, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.2)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFiltersAndSearch() {
    return Row(
      children: [
        // Search Bar
        Expanded(
          flex: 2,
          child: Container(
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: TextField(
              onChanged: (value) => setState(() => _searchQuery = value),
              decoration: InputDecoration(
                hintText: 'Search organizations...',
                prefixIcon: Icon(Icons.search, color: Colors.grey[500]),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),
        ),

        const SizedBox(width: 16),

        // Filter Dropdown
        Container(
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedFilter,
              items: const [
                DropdownMenuItem(
                    value: 'all', child: Text('All Organizations')),
                DropdownMenuItem(value: 'active', child: Text('Active')),
                DropdownMenuItem(value: 'pending', child: Text('Pending')),
                DropdownMenuItem(value: 'inactive', child: Text('Inactive')),
              ],
              onChanged: (value) => setState(() => _selectedFilter = value!),
            ),
          ),
        ),

        const SizedBox(width: 16),

        // Export Button
        IconButton(
          onPressed: () => _exportOrganizations(),
          icon: const Icon(Icons.file_download_rounded),
          tooltip: 'Export Organizations',
          style: IconButton.styleFrom(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: Colors.grey[300]!),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTabBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TabBar(
        controller: _tabController,
        tabs: const [
          Tab(text: 'All Organizations'),
          Tab(text: 'Power Grid Companies'),
          Tab(text: 'State Electricity Boards'),
          Tab(text: 'Private Companies'),
        ],
        labelColor: const Color(0xFF3B82F6),
        unselectedLabelColor: Colors.grey[600],
        indicatorColor: const Color(0xFF3B82F6),
        dividerColor: Colors.transparent,
      ),
    );
  }

  Widget _buildOrganizationsList(List<Map<String, dynamic>> organizations) {
    final filteredOrgs = _filterOrganizations(organizations);

    if (filteredOrgs.isEmpty) {
      return _buildEmptyState();
    }

    return TabBarView(
      controller: _tabController,
      children: [
        _buildOrganizationsGrid(filteredOrgs),
        _buildOrganizationsGrid(
            filteredOrgs.where((org) => org['type'] == 'power_grid').toList()),
        _buildOrganizationsGrid(
            filteredOrgs.where((org) => org['type'] == 'state_board').toList()),
        _buildOrganizationsGrid(
            filteredOrgs.where((org) => org['type'] == 'private').toList()),
      ],
    );
  }

  Widget _buildOrganizationsGrid(List<Map<String, dynamic>> organizations) {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: MediaQuery.of(context).size.width > 1200
            ? 4
            : MediaQuery.of(context).size.width > 800
                ? 3
                : 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.2,
      ),
      itemCount: organizations.length,
      itemBuilder: (context, index) {
        return OrganizationCard(
          organization: organizations[index],
          onEdit: () => _editOrganization(organizations[index]),
          onDelete: () => _deleteOrganization(organizations[index]['id']),
          onViewUsers: () => _viewOrganizationUsers(organizations[index]),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.business_rounded,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'No organizations found',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Add your first organization to get started',
            style: TextStyle(color: Colors.grey[500]),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () => _showAddOrganizationDialog(),
            icon: const Icon(Icons.add),
            label: const Text('Add Organization'),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(Object error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 80,
            color: Colors.red[400],
          ),
          const SizedBox(height: 16),
          Text(
            'Error loading organizations',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.red[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            error.toString(),
            style: TextStyle(color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () => ref.refresh(organizationsProvider),
            icon: const Icon(Icons.refresh),
            label: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _filterOrganizations(
      List<Map<String, dynamic>> organizations) {
    var filtered = organizations;

    // Apply status filter
    if (_selectedFilter != 'all') {
      filtered =
          filtered.where((org) => org['status'] == _selectedFilter).toList();
    }

    // Apply search filter
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((org) {
        final name = (org['name'] as String? ?? '').toLowerCase();
        final location = (org['location'] as String? ?? '').toLowerCase();
        final query = _searchQuery.toLowerCase();
        return name.contains(query) || location.contains(query);
      }).toList();
    }

    return filtered;
  }

  void _showAddOrganizationDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const AddOrganizationDialog(),
    );
  }

  void _editOrganization(Map<String, dynamic> organization) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AddOrganizationDialog(organization: organization),
    );
  }

  void _deleteOrganization(String organizationId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Organization'),
        content: const Text(
          'Are you sure you want to delete this organization? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ref
                  .read(organizationsNotifierProvider.notifier)
                  .deleteOrganization(organizationId);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _viewOrganizationUsers(Map<String, dynamic> organization) {
    // Navigate to users screen with organization filter
    // Implementation depends on your routing setup
  }

  void _exportOrganizations() {
    // Implement CSV/PDF export
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Export functionality coming soon')),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
