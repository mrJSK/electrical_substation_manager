// screens/api_management_screen.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ApiManagementScreen extends StatefulWidget {
  const ApiManagementScreen({Key? key}) : super(key: key);

  @override
  State<ApiManagementScreen> createState() => _ApiManagementScreenState();
}

class _ApiManagementScreenState extends State<ApiManagementScreen> {
  final List<ApiEndpoint> _endpoints = [
    ApiEndpoint(
      name: 'User Management API',
      path: '/api/v1/users',
      method: 'GET, POST, PUT, DELETE',
      status: 'Active',
      requestCount: 15420,
      lastUsed: DateTime.now().subtract(const Duration(minutes: 5)),
      responseTime: 120,
    ),
    ApiEndpoint(
      name: 'Substation Data API',
      path: '/api/v1/substations',
      method: 'GET, POST, PUT',
      status: 'Active',
      requestCount: 8932,
      lastUsed: DateTime.now().subtract(const Duration(minutes: 15)),
      responseTime: 85,
    ),
    ApiEndpoint(
      name: 'Analytics API',
      path: '/api/v1/analytics',
      method: 'GET',
      status: 'Active',
      requestCount: 3456,
      lastUsed: DateTime.now().subtract(const Duration(hours: 1)),
      responseTime: 200,
    ),
    ApiEndpoint(
      name: 'Authentication API',
      path: '/api/v1/auth',
      method: 'POST',
      status: 'Active',
      requestCount: 2890,
      lastUsed: DateTime.now().subtract(const Duration(minutes: 30)),
      responseTime: 150,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API Management'),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.key),
            onPressed: () => context.goNamed('api-keys'),
            tooltip: 'API Keys',
          ),
          IconButton(
            icon: const Icon(Icons.description),
            onPressed: () => context.goNamed('api-documentation'),
            tooltip: 'Documentation',
          ),
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () => context.goNamed('api-logs'),
            tooltip: 'API Logs',
          ),
        ],
      ),
      body: Column(
        children: [
          _buildApiStats(),
          _buildQuickActions(),
          Expanded(child: _buildEndpointsList()),
        ],
      ),
    );
  }

  Widget _buildApiStats() {
    final totalRequests =
        _endpoints.fold(0, (sum, endpoint) => sum + endpoint.requestCount);
    final activeEndpoints =
        _endpoints.where((e) => e.status == 'Active').length;
    final avgResponseTime =
        _endpoints.fold(0, (sum, endpoint) => sum + endpoint.responseTime) /
            _endpoints.length;

    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.grey.shade50,
      child: Row(
        children: [
          Expanded(
            child: _buildStatCard(
              'Total Requests',
              _formatNumber(totalRequests),
              Icons.api,
              Colors.blue,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildStatCard(
              'Active Endpoints',
              '$activeEndpoints',
              Icons.router,
              Colors.green,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildStatCard(
              'Avg Response Time',
              '${avgResponseTime.round()}ms',
              Icons.speed,
              Colors.orange,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildStatCard(
              'API Keys',
              '12',
              Icons.vpn_key,
              Colors.purple,
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
            Icon(icon, size: 32, color: color),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
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

  Widget _buildQuickActions() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: Card(
              child: InkWell(
                onTap: () => context.goNamed('api-keys'),
                borderRadius: BorderRadius.circular(8),
                child: const Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Icon(Icons.key, size: 32, color: Colors.blue),
                      SizedBox(height: 8),
                      Text('Manage API Keys',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('Create and manage API keys',
                          style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Card(
              child: InkWell(
                onTap: () => context.goNamed('api-documentation'),
                borderRadius: BorderRadius.circular(8),
                child: const Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Icon(Icons.description, size: 32, color: Colors.green),
                      SizedBox(height: 8),
                      Text('View Documentation',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('API reference and guides',
                          style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Card(
              child: InkWell(
                onTap: () => context.goNamed('api-logs'),
                borderRadius: BorderRadius.circular(8),
                child: const Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Icon(Icons.history, size: 32, color: Colors.orange),
                      SizedBox(height: 8),
                      Text('View API Logs',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('Monitor API usage and errors',
                          style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEndpointsList() {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'API Endpoints',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _endpoints.length,
              itemBuilder: (context, index) {
                final endpoint = _endpoints[index];
                return ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: _getStatusColor(endpoint.status).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.api,
                      color: _getStatusColor(endpoint.status),
                    ),
                  ),
                  title: Text(
                    endpoint.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(endpoint.path),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Chip(
                            label: Text(endpoint.method),
                            backgroundColor: Colors.blue.shade100,
                            labelStyle: TextStyle(
                                color: Colors.blue.shade700, fontSize: 10),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '${_formatNumber(endpoint.requestCount)} requests',
                            style: TextStyle(
                                color: Colors.grey.shade600, fontSize: 12),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '${endpoint.responseTime}ms avg',
                            style: TextStyle(
                                color: Colors.grey.shade600, fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Chip(
                        label: Text(endpoint.status),
                        backgroundColor:
                            _getStatusColor(endpoint.status).withOpacity(0.1),
                        labelStyle:
                            TextStyle(color: _getStatusColor(endpoint.status)),
                      ),
                      Text(
                        _formatDateTime(endpoint.lastUsed),
                        style: TextStyle(
                            color: Colors.grey.shade600, fontSize: 10),
                      ),
                    ],
                  ),
                  onTap: () => _showEndpointDetails(endpoint),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Active':
        return Colors.green;
      case 'Inactive':
        return Colors.red;
      case 'Deprecated':
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

  void _showEndpointDetails(ApiEndpoint endpoint) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(endpoint.name),
        content: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDetailRow('Endpoint:', endpoint.path),
              _buildDetailRow('Methods:', endpoint.method),
              _buildDetailRow('Status:', endpoint.status),
              _buildDetailRow(
                  'Total Requests:', _formatNumber(endpoint.requestCount)),
              _buildDetailRow(
                  'Avg Response Time:', '${endpoint.responseTime}ms'),
              _buildDetailRow('Last Used:', _formatDateTime(endpoint.lastUsed)),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              context.goNamed('api-logs');
            },
            child: const Text('View Logs'),
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
            width: 120,
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

class ApiEndpoint {
  final String name;
  final String path;
  final String method;
  final String status;
  final int requestCount;
  final DateTime lastUsed;
  final int responseTime;

  ApiEndpoint({
    required this.name,
    required this.path,
    required this.method,
    required this.status,
    required this.requestCount,
    required this.lastUsed,
    required this.responseTime,
  });
}
