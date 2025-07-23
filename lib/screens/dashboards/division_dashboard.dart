import 'package:flutter/material.dart';

class DivisionDashboard extends StatelessWidget {
  final String divisionId;

  const DivisionDashboard({super.key, required this.divisionId});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            'Division Dashboard',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          Text('Division ID: $divisionId',
              style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 20),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Text('Division Overview',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  const ListTile(
                    leading: Icon(Icons.scatter_plot, color: Colors.purple),
                    title: Text('Subdivisions'),
                    trailing: Text('3',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  const ListTile(
                    leading: Icon(Icons.power, color: Colors.orange),
                    title: Text('Power Load'),
                    trailing: Text('85%',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
