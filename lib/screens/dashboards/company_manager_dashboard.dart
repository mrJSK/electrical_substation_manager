import 'package:flutter/material.dart';

class CompanyManagerDashboard extends StatelessWidget {
  final String? companyId;

  const CompanyManagerDashboard({super.key, this.companyId});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            'Company Manager Dashboard',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          if (companyId != null)
            Text('Company ID: $companyId',
                style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 20),
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  leading: const Icon(Icons.location_city, color: Colors.blue),
                  title: const Text('Zones'),
                  subtitle: const Text('8 zones under management'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                ),
                ListTile(
                  leading: const Icon(Icons.people, color: Colors.green),
                  title: const Text('Employees'),
                  subtitle: const Text('1,234 total employees'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                ),
                ListTile(
                  leading: const Icon(Icons.electrical_services,
                      color: Colors.orange),
                  title: const Text('Substations'),
                  subtitle: const Text('45 substations'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
