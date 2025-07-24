import 'package:flutter/material.dart';

class IntegrationConfig extends StatefulWidget {
  final Function(Map<String, dynamic>) onChanged;
  final Map<String, dynamic>? initialConfig;

  const IntegrationConfig({
    super.key,
    required this.onChanged,
    this.initialConfig,
  });

  @override
  State<IntegrationConfig> createState() => _IntegrationConfigState();
}

class _IntegrationConfigState extends State<IntegrationConfig> {
  late Map<String, dynamic> _config;

  @override
  void initState() {
    super.initState();
    _config = widget.initialConfig ?? {};
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Integration Configuration',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Database Integration
            ExpansionTile(
              leading: const Icon(Icons.storage),
              title: const Text('Database Integration'),
              children: [
                ListTile(
                  title: const Text('Database Type'),
                  subtitle: DropdownButton<String>(
                    value: _config['databaseType'] ?? 'firebase',
                    items: const [
                      DropdownMenuItem(
                          value: 'firebase', child: Text('Firebase')),
                      DropdownMenuItem(value: 'mysql', child: Text('MySQL')),
                      DropdownMenuItem(
                          value: 'postgresql', child: Text('PostgreSQL')),
                      DropdownMenuItem(value: 'oracle', child: Text('Oracle')),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _config['databaseType'] = value;
                      });
                      widget.onChanged(_config);
                    },
                  ),
                ),
              ],
            ),

            // Authentication Integration
            ExpansionTile(
              leading: const Icon(Icons.security),
              title: const Text('Authentication Integration'),
              children: [
                ListTile(
                  title: const Text('Auth Method'),
                  subtitle: DropdownButton<String>(
                    value: _config['authMethod'] ?? 'firebase',
                    items: const [
                      DropdownMenuItem(
                          value: 'firebase', child: Text('Firebase Auth')),
                      DropdownMenuItem(value: 'azure', child: Text('Azure AD')),
                      DropdownMenuItem(value: 'ldap', child: Text('LDAP')),
                      DropdownMenuItem(value: 'custom', child: Text('Custom')),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _config['authMethod'] = value;
                      });
                      widget.onChanged(_config);
                    },
                  ),
                ),
              ],
            ),

            // API Integration
            ExpansionTile(
              leading: const Icon(Icons.api),
              title: const Text('API Integration'),
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'API Base URL',
                          hintText: 'https://api.yourorg.com',
                        ),
                        onChanged: (value) {
                          _config['apiBaseUrl'] = value;
                          widget.onChanged(_config);
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'API Key',
                          hintText: 'Enter API key',
                        ),
                        obscureText: true,
                        onChanged: (value) {
                          _config['apiKey'] = value;
                          widget.onChanged(_config);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
