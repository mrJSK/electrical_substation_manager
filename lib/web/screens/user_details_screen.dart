// screens/user_details_screen.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UserDetailsScreen extends StatefulWidget {
  final String? userId;
  final bool isCreating;
  final bool isEditing;

  const UserDetailsScreen({
    Key? key,
    this.userId,
    this.isCreating = false,
    this.isEditing = false,
  }) : super(key: key);

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  String _selectedRole = 'Viewer';
  String _selectedStatus = 'Active';
  String _selectedOrganization = 'Organization 1';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (!widget.isCreating) {
      _loadUserData();
    }
  }

  void _loadUserData() {
    // Simulate loading user data
    if (widget.userId != null) {
      _nameController.text = 'John Doe';
      _emailController.text = 'john@example.com';
      _phoneController.text = '+1234567890';
      _selectedRole = 'Admin';
      _selectedStatus = 'Active';
      _selectedOrganization = 'Organization 1';
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _saveUser() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(widget.isCreating
                ? 'User created successfully'
                : 'User updated successfully'),
          ),
        );
        context.goNamed('users');
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

  @override
  Widget build(BuildContext context) {
    final isReadOnly = !widget.isCreating && !widget.isEditing;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isCreating
            ? 'Create User'
            : widget.isEditing
                ? 'Edit User'
                : 'User Details'),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
        actions: [
          if (!isReadOnly)
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: _isLoading ? null : _saveUser,
            ),
          if (isReadOnly)
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () => context
                  .goNamed('edit-user', pathParameters: {'id': widget.userId!}),
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
                          labelText: 'Full Name',
                          border: OutlineInputBorder(),
                        ),
                        readOnly: isReadOnly,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Name is required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(),
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
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _phoneController,
                        decoration: const InputDecoration(
                          labelText: 'Phone',
                          border: OutlineInputBorder(),
                        ),
                        readOnly: isReadOnly,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Role & Permissions',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<String>(
                        value: _selectedRole,
                        decoration: const InputDecoration(
                          labelText: 'Role',
                          border: OutlineInputBorder(),
                        ),
                        items: ['Admin', 'Operator', 'Viewer']
                            .map((role) => DropdownMenuItem(
                                value: role, child: Text(role)))
                            .toList(),
                        onChanged: isReadOnly
                            ? null
                            : (value) => setState(() => _selectedRole = value!),
                      ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<String>(
                        value: _selectedOrganization,
                        decoration: const InputDecoration(
                          labelText: 'Organization',
                          border: OutlineInputBorder(),
                        ),
                        items: [
                          'Organization 1',
                          'Organization 2',
                          'Organization 3'
                        ]
                            .map((org) =>
                                DropdownMenuItem(value: org, child: Text(org)))
                            .toList(),
                        onChanged: isReadOnly
                            ? null
                            : (value) =>
                                setState(() => _selectedOrganization = value!),
                      ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<String>(
                        value: _selectedStatus,
                        decoration: const InputDecoration(
                          labelText: 'Status',
                          border: OutlineInputBorder(),
                        ),
                        items: ['Active', 'Inactive']
                            .map((status) => DropdownMenuItem(
                                value: status, child: Text(status)))
                            .toList(),
                        onChanged: isReadOnly
                            ? null
                            : (value) =>
                                setState(() => _selectedStatus = value!),
                      ),
                    ],
                  ),
                ),
              ),
              if (!isReadOnly) ...[
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _saveUser,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: Colors.blue.shade700,
                      foregroundColor: Colors.white,
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Text(
                            widget.isCreating ? 'Create User' : 'Update User'),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
