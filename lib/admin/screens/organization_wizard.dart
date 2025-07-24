import 'package:flutter/material.dart';
import '../models/organization_config.dart';
import '../widgets/hierarchy_builder.dart';
import '../widgets/permission_matrix.dart';
import '../widgets/integration_config.dart'; // Add this import

class OrganizationWizard extends StatefulWidget {
  const OrganizationWizard({super.key}); // Add proper constructor

  @override
  State<OrganizationWizard> createState() =>
      _OrganizationWizardState(); // Fix return type
}

class _OrganizationWizardState extends State<OrganizationWizard> {
  int _currentStep = 0;
  OrganizationConfig _orgConfig =
      OrganizationConfig.empty(); // Use proper initialization

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Organization Setup Wizard'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Stepper(
        currentStep: _currentStep,
        onStepTapped: (step) => setState(() => _currentStep = step),
        controlsBuilder: (context, details) {
          return Row(
            children: [
              if (details.stepIndex > 0)
                TextButton(
                  onPressed: details.onStepCancel,
                  child: const Text('Previous'),
                ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: details.stepIndex == 3
                    ? _saveOrganization
                    : details.onStepContinue,
                child: Text(
                    details.stepIndex == 3 ? 'Create Organization' : 'Next'),
              ),
            ],
          );
        },
        steps: [
          // Step 1: Basic Info
          Step(
            title: const Text('Organization Details'),
            content: Column(
              children: [
                TextFormField(
                  decoration:
                      const InputDecoration(labelText: 'Organization Name'),
                  onChanged: (value) {
                    setState(() {
                      _orgConfig =
                          _orgConfig.copyWith(name: value); // Use copyWith
                    });
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration:
                      const InputDecoration(labelText: 'Organization ID'),
                  onChanged: (value) {
                    setState(() {
                      _orgConfig = _orgConfig.copyWith(id: value);
                    });
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Logo URL'),
                  onChanged: (value) {
                    setState(() {
                      _orgConfig = _orgConfig.copyWith(logoUrl: value);
                    });
                  },
                ),
              ],
            ),
            isActive: _currentStep >= 0,
          ),

          // Step 2: Hierarchy Builder
          Step(
            title: const Text('Build Hierarchy'),
            content: HierarchyBuilder(
              onChanged: (hierarchy) {
                setState(() {
                  _orgConfig =
                      _orgConfig.copyWith(hierarchy: hierarchy); // Use copyWith
                });
              },
            ),
            isActive: _currentStep >= 1,
          ),

          // Step 3: Permissions
          Step(
            title: const Text('Set Permissions'),
            content: PermissionMatrix(
              hierarchy: _orgConfig.hierarchy,
              onChanged: (permissions) {
                setState(() {
                  _orgConfig = _orgConfig.copyWith(
                      rolePermissions: permissions); // Use copyWith
                });
              },
            ),
            isActive: _currentStep >= 2,
          ),

          // Step 4: Database & Auth
          Step(
            title: const Text('Integration Setup'),
            content: IntegrationConfig(
              onChanged: (config) {
                setState(() {
                  _orgConfig =
                      _orgConfig.copyWith(integrations: config); // Use copyWith
                });
              },
            ),
            isActive: _currentStep >= 3,
          ),
        ],
      ),
    );
  }

  void _saveOrganization() {
    // Validate the configuration
    if (_orgConfig.name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter organization name'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (_orgConfig.hierarchy.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please add at least one hierarchy level'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // TODO: Save to database
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Organization created successfully!'),
        backgroundColor: Colors.green,
      ),
    );

    // Navigate back or to dashboard
    Navigator.pop(context);
  }
}
