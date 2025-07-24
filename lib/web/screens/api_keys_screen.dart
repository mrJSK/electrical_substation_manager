// screens/api_keys_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ApiKeysScreen extends StatefulWidget {
  const ApiKeysScreen({Key? key}) : super(key: key);

  @override
  State<ApiKeysScreen> createState() => _ApiKeysScreenState();
}

class _ApiKeysScreenState extends State<ApiKeysScreen> {
  final List<ApiKey> _apiKeys = [
    ApiKey(
      id: 'key_001',
      name: 'Production API Key',
      key:
          'sk_live_51H7x2yJ9z8K3mN4p5Q6r7S8t9U0v1W2x3Y4z5A6b7C8d9E0f1G2h3I4j5K6l7M8',
      permissions: ['read', 'write', 'delete'],
      status: 'Active',
      createdDate: DateTime.now().subtract(const Duration(days: 30)),
      lastUsed: DateTime.now().subtract(const Duration(hours: 2)),
      requestCount: 15420,
    ),
    ApiKey(
      id: 'key_002',
      name: 'Development API Key',
      key:
          'sk_test_51H7x2yJ9z8K3mN4p5Q6r7S8t9U0v1W2x3Y4z5A6b7C8d9E0f1G2h3I4j5K6l7M8',
      permissions: ['read', 'write'],
      status: 'Active',
      createdDate: DateTime.now().subtract(const Duration(days: 15)),
      lastUsed: DateTime.now().subtract(const Duration(days: 1)),
      requestCount: 3456,
    ),
    ApiKey(
      id: 'key_003',
      name: 'Mobile App Key',
      key:
          'sk_mobile_51H7x2yJ9z8K3mN4p5Q6r7S8t9U0v1W2x3Y4z5A6b7C8d9E0f1G2h3I4j5K6l7M8',
      permissions: ['read'],
      status: 'Revoked',
      createdDate: DateTime.now().subtract(const Duration(days: 60)),
      lastUsed: DateTime.now().subtract(const Duration(days: 10)),
      requestCount: 8932,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API Keys Management'),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => setState(() {}),
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: Column(
        children: [
          _buildKeyStats(),
          Expanded(child: _buildKeysList()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showCreateKeyDialog,
        backgroundColor: Colors.blue.shade700,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildKeyStats() {
    final activeKeys = _apiKeys.where((key) => key.status == 'Active').length;
    final revokedKeys = _apiKeys.where((key) => key.status == 'Revoked').length;
    final totalRequests =
        _apiKeys.fold(0, (sum, key) => sum + key.requestCount);

    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.grey.shade50,
      child: Row(
        children: [
          Expanded(
            child: _buildStatCard(
              'Total Keys',
              '${_apiKeys.length}',
              Icons.vpn_key,
              Colors.blue,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildStatCard(
              'Active Keys',
              '$activeKeys',
              Icons.check_circle,
              Colors.green,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildStatCard(
              'Revoked Keys',
              '$revokedKeys',
              Icons.cancel,
              Colors.red,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildStatCard(
              'Total Requests',
              _formatNumber(totalRequests),
              Icons.api,
              Colors.orange,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
      String title, String value, IconData icon, Color color) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, size: 24, color: color),
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
      ),
    );
  }

  Widget _buildKeysList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _apiKeys.length,
      itemBuilder: (context, index) {
        final apiKey = _apiKeys[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.vpn_key,
                      color: _getStatusColor(apiKey.status),
                      size: 24,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            apiKey.name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'ID: ${apiKey.id}',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Chip(
                      label: Text(apiKey.status),
                      backgroundColor:
                          _getStatusColor(apiKey.status).withOpacity(0.1),
                      labelStyle:
                          TextStyle(color: _getStatusColor(apiKey.status)),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          apiKey.key,
                          style: const TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 12,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.copy, size: 16),
                        onPressed: () => _copyToClipboard(apiKey.key),
                        tooltip: 'Copy API Key',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  children: apiKey.permissions
                      .map((permission) => Chip(
                            label: Text(permission.toUpperCase()),
                            backgroundColor: Colors.blue.shade100,
                            labelStyle: TextStyle(
                              color: Colors.blue.shade700,
                              fontSize: 10,
                            ),
                          ))
                      .toList(),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(Icons.calendar_today,
                        size: 16, color: Colors.grey.shade600),
                    const SizedBox(width: 4),
                    Text(
                      'Created: ${_formatDate(apiKey.createdDate)}',
                      style:
                          TextStyle(color: Colors.grey.shade600, fontSize: 12),
                    ),
                    const SizedBox(width: 16),
                    Icon(Icons.access_time,
                        size: 16, color: Colors.grey.shade600),
                    const SizedBox(width: 4),
                    Text(
                      'Last used: ${_formatDateTime(apiKey.lastUsed)}',
                      style:
                          TextStyle(color: Colors.grey.shade600, fontSize: 12),
                    ),
                    const Spacer(),
                    Text(
                      '${_formatNumber(apiKey.requestCount)} requests',
                      style:
                          TextStyle(color: Colors.grey.shade600, fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (apiKey.status == 'Active') ...[
                      TextButton.icon(
                        onPressed: () => _revokeKey(apiKey),
                        icon: const Icon(Icons.block, size: 16),
                        label: const Text('Revoke'),
                        style:
                            TextButton.styleFrom(foregroundColor: Colors.red),
                      ),
                      const SizedBox(width: 8),
                    ],
                    TextButton.icon(
                      onPressed: () => _editKey(apiKey),
                      icon: const Icon(Icons.edit, size: 16),
                      label: const Text('Edit'),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton.icon(
                      onPressed: () => _viewKeyDetails(apiKey),
                      icon: const Icon(Icons.visibility, size: 16),
                      label: const Text('Details'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade700,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Active':
        return Colors.green;
      case 'Revoked':
        return Colors.red;
      case 'Expired':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  String _formatNumber(int number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    }
    return number.toString();
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  String _formatDateTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inDays}d ago';
    }
  }

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('API key copied to clipboard')),
    );
  }

  void _showCreateKeyDialog() {
    final nameController = TextEditingController();
    final selectedPermissions = <String>{'read'};

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Create New API Key'),
          content: SizedBox(
            width: 400,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'API Key Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Permissions:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                CheckboxListTile(
                  title: const Text('Read'),
                  value: selectedPermissions.contains('read'),
                  onChanged: (value) {
                    setState(() {
                      if (value!) {
                        selectedPermissions.add('read');
                      } else {
                        selectedPermissions.remove('read');
                      }
                    });
                  },
                ),
                CheckboxListTile(
                  title: const Text('Write'),
                  value: selectedPermissions.contains('write'),
                  onChanged: (value) {
                    setState(() {
                      if (value!) {
                        selectedPermissions.add('write');
                      } else {
                        selectedPermissions.remove('write');
                      }
                    });
                  },
                ),
                CheckboxListTile(
                  title: const Text('Delete'),
                  value: selectedPermissions.contains('delete'),
                  onChanged: (value) {
                    setState(() {
                      if (value!) {
                        selectedPermissions.add('delete');
                      } else {
                        selectedPermissions.remove('delete');
                      }
                    });
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (nameController.text.isNotEmpty &&
                    selectedPermissions.isNotEmpty) {
                  final newKey = ApiKey(
                    id: 'key_${DateTime.now().millisecondsSinceEpoch}',
                    name: nameController.text,
                    key:
                        'sk_${DateTime.now().millisecondsSinceEpoch}_generated_key',
                    permissions: selectedPermissions.toList(),
                    status: 'Active',
                    createdDate: DateTime.now(),
                    lastUsed: DateTime.now(),
                    requestCount: 0,
                  );

                  this.setState(() {
                    _apiKeys.add(newKey);
                  });

                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('API key created successfully')),
                  );
                }
              },
              child: const Text('Create'),
            ),
          ],
        ),
      ),
    );
  }

  void _revokeKey(ApiKey apiKey) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Revoke API Key'),
        content: Text(
            'Are you sure you want to revoke "${apiKey.name}"? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                final index = _apiKeys.indexOf(apiKey);
                _apiKeys[index] = ApiKey(
                  id: apiKey.id,
                  name: apiKey.name,
                  key: apiKey.key,
                  permissions: apiKey.permissions,
                  status: 'Revoked',
                  createdDate: apiKey.createdDate,
                  lastUsed: apiKey.lastUsed,
                  requestCount: apiKey.requestCount,
                );
              });
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('API key revoked successfully')),
              );
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Revoke'),
          ),
        ],
      ),
    );
  }

  void _editKey(ApiKey apiKey) {
    final nameController = TextEditingController(text: apiKey.name);
    final selectedPermissions = Set<String>.from(apiKey.permissions);

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Edit API Key'),
          content: SizedBox(
            width: 400,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'API Key Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Permissions:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                CheckboxListTile(
                  title: const Text('Read'),
                  value: selectedPermissions.contains('read'),
                  onChanged: apiKey.status == 'Active'
                      ? (value) {
                          setState(() {
                            if (value!) {
                              selectedPermissions.add('read');
                            } else {
                              selectedPermissions.remove('read');
                            }
                          });
                        }
                      : null,
                ),
                CheckboxListTile(
                  title: const Text('Write'),
                  value: selectedPermissions.contains('write'),
                  onChanged: apiKey.status == 'Active'
                      ? (value) {
                          setState(() {
                            if (value!) {
                              selectedPermissions.add('write');
                            } else {
                              selectedPermissions.remove('write');
                            }
                          });
                        }
                      : null,
                ),
                CheckboxListTile(
                  title: const Text('Delete'),
                  value: selectedPermissions.contains('delete'),
                  onChanged: apiKey.status == 'Active'
                      ? (value) {
                          setState(() {
                            if (value!) {
                              selectedPermissions.add('delete');
                            } else {
                              selectedPermissions.remove('delete');
                            }
                          });
                        }
                      : null,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (nameController.text.isNotEmpty &&
                    selectedPermissions.isNotEmpty) {
                  this.setState(() {
                    final index = _apiKeys.indexOf(apiKey);
                    _apiKeys[index] = ApiKey(
                      id: apiKey.id,
                      name: nameController.text,
                      key: apiKey.key,
                      permissions: selectedPermissions.toList(),
                      status: apiKey.status,
                      createdDate: apiKey.createdDate,
                      lastUsed: apiKey.lastUsed,
                      requestCount: apiKey.requestCount,
                    );
                  });

                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('API key updated successfully')),
                  );
                }
              },
              child: const Text('Update'),
            ),
          ],
        ),
      ),
    );
  }

  void _viewKeyDetails(ApiKey apiKey) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(apiKey.name),
        content: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDetailRow('ID:', apiKey.id),
              _buildDetailRow('Status:', apiKey.status),
              _buildDetailRow('Created:', _formatDate(apiKey.createdDate)),
              _buildDetailRow('Last Used:', _formatDateTime(apiKey.lastUsed)),
              _buildDetailRow(
                  'Total Requests:', _formatNumber(apiKey.requestCount)),
              _buildDetailRow('Permissions:', apiKey.permissions.join(', ')),
            ],
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

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}

class ApiKey {
  final String id;
  final String name;
  final String key;
  final List<String> permissions;
  final String status;
  final DateTime createdDate;
  final DateTime lastUsed;
  final int requestCount;

  ApiKey({
    required this.id,
    required this.name,
    required this.key,
    required this.permissions,
    required this.status,
    required this.createdDate,
    required this.lastUsed,
    required this.requestCount,
  });
}
