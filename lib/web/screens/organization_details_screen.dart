// screens/organization_details_screen.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OrganizationDetailsScreen extends StatefulWidget {
  final String? organizationId;
  final bool isCreating;
  final bool isEditing;

  const OrganizationDetailsScreen({
    Key? key,
    this.organizationId,
    this.isCreating = false,
    this.isEditing = false,
  }) : super(key: key);

  @override
  State<OrganizationDetailsScreen> createState() =>
      _OrganizationDetailsScreenState();
}

class _OrganizationDetailsScreenState extends State<OrganizationDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _websiteController = TextEditingController();
  final _licenseNumberController = TextEditingController();

  String _selectedStatus = 'Active';
  String _selectedType = 'Private';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (!widget.isCreating) {
      _loadOrganizationData();
    }
  }

  void _loadOrganizationData() {
    // Simulate loading organization data
    if (widget.organizationId != null) {
      _nameController.text = 'Power Grid Corporation';
      _emailController.text = 'contact@powergrid.com';
      _phoneController.text = '+1-555-0123';
      _addressController.text = '123 Energy Street, Power City, PC 12345';
      _websiteController.text = 'https://www.powergrid.com';
      _licenseNumberController.text = 'ELC-2024-001';
      _selectedStatus = 'Active';
      _selectedType = 'Public';
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _websiteController.dispose();
    _licenseNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isReadOnly = !widget.isCreating && !widget.isEditing;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isCreating
            ? 'Create Organization'
            : widget.isEditing
                ? 'Edit Organization'
                : 'Organization Details'),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
        actions: [
          if (!isReadOnly)
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: _isLoading ? null : _saveOrganization,
            ),
          if (isReadOnly)
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () => context.goNamed('edit-organization',
                  pathParameters: {'id': widget.organizationId!}),
            ),
          if (isReadOnly)
            PopupMenuButton<String>(
              onSelected: (value) {
                switch (value) {
                  case 'users':
                    _showOrganizationUsers();
                    break;
                  case 'substations':
                    _showOrganizationSubstations();
                    break;
                  case 'reports':
                    _generateReport();
                    break;
                  case 'delete':
                    _showDeleteDialog();
                    break;
                }
              },
              itemBuilder: (context) => const [
                PopupMenuItem(value: 'users', child: Text('View Users')),
                PopupMenuItem(
                    value: 'substations', child: Text('View Substations')),
                PopupMenuItem(value: 'reports', child: Text('Generate Report')),
                PopupMenuItem(
                    value: 'delete', child: Text('Delete Organization')),
              ],
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
                          labelText: 'Organization Name',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.business),
                        ),
                        readOnly: isReadOnly,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Organization name is required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _emailController,
                              decoration: const InputDecoration(
                                labelText: 'Email',
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.email),
                              ),
                              readOnly: isReadOnly,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Email is required';
                                }
                                if (!value.contains('@')) {
                                  return 'Enter a valid email';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: TextFormField(
                              controller: _phoneController,
                              decoration: const InputDecoration(
                                labelText: 'Phone',
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.phone),
                              ),
                              readOnly: isReadOnly,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _addressController,
                        decoration: const InputDecoration(
                          labelText: 'Address',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.location_on),
                        ),
                        readOnly: isReadOnly,
                        maxLines: 2,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _websiteController,
                        decoration: const InputDecoration(
                          labelText: 'Website',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.web),
                        ),
                        readOnly: isReadOnly,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Classification & Status Card
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Classification & Status',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              value: _selectedType,
                              decoration: const InputDecoration(
                                labelText: 'Organization Type',
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.category),
                              ),
                              items: const [
                                DropdownMenuItem(
                                    value: 'Public',
                                    child: Text('Public Utility')),
                                DropdownMenuItem(
                                    value: 'Private',
                                    child: Text('Private Company')),
                                DropdownMenuItem(
                                    value: 'Cooperative',
                                    child: Text('Cooperative')),
                                DropdownMenuItem(
                                    value: 'Municipal',
                                    child: Text('Municipal')),
                              ],
                              onChanged: isReadOnly
                                  ? null
                                  : (value) =>
                                      setState(() => _selectedType = value!),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              value: _selectedStatus,
                              decoration: const InputDecoration(
                                labelText: 'Status',
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.flag),
                              ),
                              items: const [
                                DropdownMenuItem(
                                    value: 'Active', child: Text('Active')),
                                DropdownMenuItem(
                                    value: 'Inactive', child: Text('Inactive')),
                                DropdownMenuItem(
                                    value: 'Suspended',
                                    child: Text('Suspended')),
                                DropdownMenuItem(
                                    value: 'Pending', child: Text('Pending')),
                              ],
                              onChanged: isReadOnly
                                  ? null
                                  : (value) =>
                                      setState(() => _selectedStatus = value!),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _licenseNumberController,
                        decoration: const InputDecoration(
                          labelText: 'License Number',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.assignment),
                        ),
                        readOnly: isReadOnly,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Statistics Card (Only shown when viewing existing organization)
              if (!widget.isCreating) ...[
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Organization Statistics',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: _buildStatTile(
                                'Total Users',
                                '247',
                                Icons.people,
                                Colors.blue,
                              ),
                            ),
                            Expanded(
                              child: _buildStatTile(
                                'Substations',
                                '15',
                                Icons.electrical_services,
                                Colors.green,
                              ),
                            ),
                            Expanded(
                              child: _buildStatTile(
                                'Active Projects',
                                '8',
                                Icons.work,
                                Colors.orange,
                              ),
                            ),
                            Expanded(
                              child: _buildStatTile(
                                'Created',
                                '2022',
                                Icons.calendar_today,
                                Colors.purple,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Recent Activity Card
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Recent Activity',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 16),
                        _buildActivityItem(
                          'New user registration',
                          'John Doe joined the organization',
                          '2 hours ago',
                          Icons.person_add,
                          Colors.green,
                        ),
                        _buildActivityItem(
                          'Substation maintenance',
                          'Central Substation scheduled for maintenance',
                          '1 day ago',
                          Icons.build,
                          Colors.orange,
                        ),
                        _buildActivityItem(
                          'Report generated',
                          'Monthly performance report created',
                          '3 days ago',
                          Icons.description,
                          Colors.blue,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],

              // Save Button (Only shown when creating/editing)
              if (!isReadOnly) ...[
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _saveOrganization,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: Colors.blue.shade700,
                      foregroundColor: Colors.white,
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Text(widget.isCreating
                            ? 'Create Organization'
                            : 'Update Organization'),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatTile(
      String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Icon(icon, size: 32, color: color),
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
    );
  }

  Widget _buildActivityItem(
      String title, String subtitle, String time, IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: color.withOpacity(0.1),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  subtitle,
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
          Text(
            time,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _saveOrganization() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(widget.isCreating
                ? 'Organization created successfully'
                : 'Organization updated successfully'),
          ),
        );
        context.goNamed('organizations');
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

  void _showOrganizationUsers() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Organization Users'),
        content: SizedBox(
          width: double.maxFinite,
          height: 400,
          child: ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) => ListTile(
              leading: CircleAvatar(
                child: Text('U${index + 1}'),
              ),
              title: Text('User ${index + 1}'),
              subtitle: Text('user${index + 1}@powergrid.com'),
              trailing: const Text('Admin'),
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

  void _showOrganizationSubstations() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Organization Substations'),
        content: SizedBox(
          width: double.maxFinite,
          height: 400,
          child: ListView.builder(
            itemCount: 3,
            itemBuilder: (context, index) => ListTile(
              leading: const Icon(Icons.electrical_services),
              title: Text('Substation ${index + 1}'),
              subtitle: Text('${132 + index * 88}kV - Online'),
              trailing: Chip(
                label: const Text('Online'),
                backgroundColor: Colors.green.shade100,
                labelStyle: TextStyle(color: Colors.green.shade700),
              ),
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

  void _generateReport() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Generate Report'),
        content:
            const Text('Generate a detailed report for this organization?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Report generation started')),
              );
            },
            child: const Text('Generate'),
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Organization'),
        content: Text(
            'Are you sure you want to delete ${_nameController.text}? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              context.goNamed('organizations');
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('Organization deleted successfully')),
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
