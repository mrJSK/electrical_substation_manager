import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/organizations_provider.dart';

class AddOrganizationDialog extends ConsumerStatefulWidget {
  final Map<String, dynamic>? organization;

  const AddOrganizationDialog({super.key, this.organization});

  @override
  ConsumerState<AddOrganizationDialog> createState() =>
      _AddOrganizationDialogState();
}

class _AddOrganizationDialogState extends ConsumerState<AddOrganizationDialog>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final _formKey = GlobalKey<FormState>();

  // Basic Info Controllers
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _websiteController = TextEditingController();

  // Address Controllers
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _pinCodeController = TextEditingController();

  String _selectedType = 'power_grid';
  String _selectedState = 'Delhi';
  bool _isLoading = false;

  final List<String> _organizationTypes = [
    'power_grid',
    'state_board',
    'private',
    'government',
    'cooperative',
  ];

  final List<String> _indianStates = [
    'Andhra Pradesh',
    'Arunachal Pradesh',
    'Assam',
    'Bihar',
    'Chhattisgarh',
    'Delhi',
    'Goa',
    'Gujarat',
    'Haryana',
    'Himachal Pradesh',
    'Jharkhand',
    'Karnataka',
    'Kerala',
    'Madhya Pradesh',
    'Maharashtra',
    'Manipur',
    'Meghalaya',
    'Mizoram',
    'Nagaland',
    'Odisha',
    'Punjab',
    'Rajasthan',
    'Sikkim',
    'Tamil Nadu',
    'Telangana',
    'Tripura',
    'Uttar Pradesh',
    'Uttarakhand',
    'West Bengal',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    // Pre-fill form if editing
    if (widget.organization != null) {
      _prefillForm();
    }
  }

  void _prefillForm() {
    final org = widget.organization!;
    _nameController.text = org['name'] ?? '';
    _descriptionController.text = org['description'] ?? '';
    _emailController.text = org['email'] ?? '';
    _phoneController.text = org['phone'] ?? '';
    _websiteController.text = org['website'] ?? '';
    _addressController.text = org['address'] ?? '';
    _cityController.text = org['city'] ?? '';
    _stateController.text = org['state'] ?? '';
    _pinCodeController.text = org['pinCode'] ?? '';
    _selectedType = org['type'] ?? 'power_grid';
    _selectedState = org['state'] ?? 'Delhi';
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.8,
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            _buildHeader(),

            const SizedBox(height: 24),

            // Tab Bar
            _buildTabBar(),

            const SizedBox(height: 24),

            // Form Content
            Expanded(
              child: Form(
                key: _formKey,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildBasicInfoTab(),
                    _buildAddressTab(),
                    _buildConfigurationTab(),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Actions
            _buildActions(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF10B981), Color(0xFF059669)],
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(
            Icons.business_rounded,
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
                widget.organization == null
                    ? 'Add New Organization'
                    : 'Edit Organization',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Configure organization details and settings',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
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
    );
  }

  Widget _buildTabBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: TabBar(
        controller: _tabController,
        tabs: const [
          Tab(text: 'Basic Info'),
          Tab(text: 'Address'),
          Tab(text: 'Configuration'),
        ],
        labelColor: const Color(0xFF3B82F6),
        unselectedLabelColor: Colors.grey[600],
        indicator: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        dividerColor: Colors.transparent,
      ),
    );
  }

  Widget _buildBasicInfoTab() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              // Organization Name
              Expanded(
                flex: 2,
                child: TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Organization Name *',
                    hintText: 'e.g., Delhi Electricity Board',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      value?.isEmpty == true ? 'Required' : null,
                ),
              ),
              const SizedBox(width: 16),

              // Organization Type
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: _selectedType,
                  decoration: const InputDecoration(
                    labelText: 'Organization Type *',
                    border: OutlineInputBorder(),
                  ),
                  items: _organizationTypes.map((type) {
                    return DropdownMenuItem(
                      value: type,
                      child: Text(_getTypeDisplayName(type)),
                    );
                  }).toList(),
                  onChanged: (value) => setState(() => _selectedType = value!),
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Description
          TextFormField(
            controller: _descriptionController,
            maxLines: 3,
            decoration: const InputDecoration(
              labelText: 'Description',
              hintText: 'Brief description of the organization...',
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 24),

          Row(
            children: [
              // Email
              Expanded(
                child: TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email *',
                    hintText: 'contact@organization.com',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                  ),
                  validator: (value) {
                    if (value?.isEmpty == true) return 'Required';
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                        .hasMatch(value!)) {
                      return 'Invalid email';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(width: 16),

              // Phone
              Expanded(
                child: TextFormField(
                  controller: _phoneController,
                  decoration: const InputDecoration(
                    labelText: 'Phone *',
                    hintText: '+91 9876543210',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.phone),
                  ),
                  validator: (value) =>
                      value?.isEmpty == true ? 'Required' : null,
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Website
          TextFormField(
            controller: _websiteController,
            decoration: const InputDecoration(
              labelText: 'Website',
              hintText: 'https://www.organization.com',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.language),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddressTab() {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Address
          TextFormField(
            controller: _addressController,
            maxLines: 2,
            decoration: const InputDecoration(
              labelText: 'Address *',
              hintText: 'Street address, building number...',
              border: OutlineInputBorder(),
            ),
            validator: (value) => value?.isEmpty == true ? 'Required' : null,
          ),

          const SizedBox(height: 24),

          Row(
            children: [
              // City
              Expanded(
                child: TextFormField(
                  controller: _cityController,
                  decoration: const InputDecoration(
                    labelText: 'City *',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      value?.isEmpty == true ? 'Required' : null,
                ),
              ),
              const SizedBox(width: 16),

              // State
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: _selectedState,
                  decoration: const InputDecoration(
                    labelText: 'State *',
                    border: OutlineInputBorder(),
                  ),
                  items: _indianStates.map((state) {
                    return DropdownMenuItem(value: state, child: Text(state));
                  }).toList(),
                  onChanged: (value) => setState(() => _selectedState = value!),
                ),
              ),
              const SizedBox(width: 16),

              // PIN Code
              Expanded(
                child: TextFormField(
                  controller: _pinCodeController,
                  decoration: const InputDecoration(
                    labelText: 'PIN Code *',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value?.isEmpty == true) return 'Required';
                    if (!RegExp(r'^\d{6}$').hasMatch(value!)) {
                      return 'Invalid PIN code';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildConfigurationTab() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Default Configuration',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'These settings will be applied as defaults for this organization',
            style: TextStyle(color: Colors.grey[600]),
          ),

          const SizedBox(height: 24),

          // Configuration options can be added here
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.info_outline, color: Colors.blue[600]),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Default roles and permissions will be created automatically based on the organization type.',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Icon(Icons.security, color: Colors.green[600]),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Admin user will be created and approval workflow will be enabled.',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActions() {
    return Row(
      children: [
        // Previous/Next Tab Navigation
        if (_tabController.index > 0)
          TextButton.icon(
            onPressed: () => _tabController.animateTo(_tabController.index - 1),
            icon: const Icon(Icons.arrow_back),
            label: const Text('Previous'),
          ),

        const Spacer(),

        // Cancel Button
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),

        const SizedBox(width: 16),

        // Next/Save Button
        ElevatedButton.icon(
          onPressed: _isLoading ? null : () => _handleAction(),
          icon: _isLoading
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Icon(
                  _tabController.index < 2 ? Icons.arrow_forward : Icons.save),
          label: Text(_tabController.index < 2 ? 'Next' : 'Save Organization'),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF3B82F6),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
        ),
      ],
    );
  }

  void _handleAction() {
    if (_tabController.index < 2) {
      // Move to next tab
      _tabController.animateTo(_tabController.index + 1);
    } else {
      // Save organization
      _saveOrganization();
    }
  }

  void _saveOrganization() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final organizationData = {
        'name': _nameController.text.trim(),
        'description': _descriptionController.text.trim(),
        'type': _selectedType,
        'email': _emailController.text.trim(),
        'phone': _phoneController.text.trim(),
        'website': _websiteController.text.trim(),
        'address': _addressController.text.trim(),
        'city': _cityController.text.trim(),
        'state': _selectedState,
        'pinCode': _pinCodeController.text.trim(),
        'status': 'active',
        'createdAt': DateTime.now().toIso8601String(),
      };

      if (widget.organization == null) {
        // Create new organization
        await ref
            .read(organizationsNotifierProvider.notifier)
            .createOrganization(organizationData);

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Organization created successfully!'),
              backgroundColor: Colors.green,
            ),
          );
        }
      } else {
        // Update existing organization
        await ref
            .read(organizationsNotifierProvider.notifier)
            .updateOrganization(widget.organization!['id'], organizationData);

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Organization updated successfully!'),
              backgroundColor: Colors.green,
            ),
          );
        }
      }

      if (mounted) Navigator.pop(context);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  String _getTypeDisplayName(String type) {
    switch (type) {
      case 'power_grid':
        return 'Power Grid Company';
      case 'state_board':
        return 'State Electricity Board';
      case 'private':
        return 'Private Company';
      case 'government':
        return 'Government Entity';
      case 'cooperative':
        return 'Cooperative Society';
      default:
        return type;
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _nameController.dispose();
    _descriptionController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _websiteController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _pinCodeController.dispose();
    super.dispose();
  }
}
