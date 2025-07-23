import 'package:flutter/material.dart';

class SubdivisionDashboard extends StatelessWidget {
  final String subdivisionId;

  const SubdivisionDashboard({super.key, required this.subdivisionId});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            'Subdivision Dashboard',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          Text('Subdivision ID: $subdivisionId',
              style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 20),
          Expanded(
            child: Column(
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            const Icon(Icons.electrical_services,
                                size: 40, color: Colors.green),
                            const Text('Substations'),
                            const Text('5',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        Column(
                          children: [
                            const Icon(Icons.online_prediction,
                                size: 40, color: Colors.blue),
                            const Text('Online'),
                            const Text('4',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
