// screens/substation_details_screen.dart
import 'package:flutter/material.dart';

class SubstationDetailsScreen extends StatefulWidget {
  final String? substationId;
  final bool isCreating;

  const SubstationDetailsScreen({
    Key? key,
    this.substationId,
    this.isCreating = false,
  }) : super(key: key);

  @override
  State<SubstationDetailsScreen> createState() =>
      _SubstationDetailsScreenState();
}

class _SubstationDetailsScreenState extends State<SubstationDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _locationController = TextEditingController();
  final _capacityController = TextEditingController();

  String _selectedVoltage = '132kV';
  String _selectedStatus = 'Online';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (!widget.isCreating) {
      _loadSubstationData();
    }
  }

  void _loadSubstationData() {
    // Simulate loading substation data
    if (widget.substationId != null) {
      _nameController.text = 'Central Substation';
      _locationController.text = 'Downtown District';
      _capacityController.text = '50';
      _selectedVoltage = '132kV';
      _selectedStatus = 'Online';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.isCreating ? 'Create Substation' : 'Substation Details'),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
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
                          labelText: 'Substation Name',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Name is required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _locationController,
                        decoration: const InputDecoration(
                          labelText: 'Location',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Location is required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              value: _selectedVoltage,
                              decoration: const InputDecoration(
                                labelText: 'Voltage Level',
                                border: OutlineInputBorder(),
                              ),
                              items: ['66kV', '132kV', '220kV', '400kV']
                                  .map((voltage) => DropdownMenuItem(
                                      value: voltage, child: Text(voltage)))
                                  .toList(),
                              onChanged: (value) =>
                                  setState(() => _selectedVoltage = value!),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: TextFormField(
                              controller: _capacityController,
                              decoration: const InputDecoration(
                                labelText: 'Capacity (MVA)',
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Capacity is required';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<String>(
                        value: _selectedStatus,
                        decoration: const InputDecoration(
                          labelText: 'Status',
                          border: OutlineInputBorder(),
                        ),
                        items: ['Online', 'Offline', 'Maintenance']
                            .map((status) => DropdownMenuItem(
                                value: status, child: Text(status)))
                            .toList(),
                        onChanged: (value) =>
                            setState(() => _selectedStatus = value!),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _saveSubstation,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Colors.blue.shade700,
                    foregroundColor: Colors.white,
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text(widget.isCreating
                          ? 'Create Substation'
                          : 'Update Substation'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _saveSubstation() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      await Future.delayed(const Duration(seconds: 2));

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(widget.isCreating
                ? 'Substation created successfully'
                : 'Substation updated successfully'),
          ),
        );
        Navigator.of(context).pop();
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
  void dispose() {
    _nameController.dispose();
    _locationController.dispose();
    _capacityController.dispose();
    super.dispose();
  }
}
