import 'package:flutter/material.dart';

class SubstationDashboard extends StatelessWidget {
  final String? substationId;

  const SubstationDashboard({super.key, this.substationId});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            'Substation Dashboard',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          if (substationId != null)
            Text('Substation ID: $substationId',
                style: const TextStyle(color: Colors.grey))
          else
            const Text('General Substation View',
                style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 20),
          Expanded(
            child: ListView(
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('System Status',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 16),
                        ListTile(
                          leading: const Icon(Icons.power, color: Colors.green),
                          title: const Text('Power Status'),
                          subtitle: const Text('Normal Operation'),
                          trailing: Container(
                            width: 12,
                            height: 12,
                            decoration: const BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        ListTile(
                          leading: const Icon(Icons.thermostat,
                              color: Colors.orange),
                          title: const Text('Temperature'),
                          subtitle: const Text('35°C'),
                          trailing: const Text('Normal'),
                        ),
                        ListTile(
                          leading: const Icon(Icons.battery_charging_full,
                              color: Colors.blue),
                          title: const Text('Load'),
                          subtitle: const Text('75% of capacity'),
                          trailing: const Text('Good'),
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
