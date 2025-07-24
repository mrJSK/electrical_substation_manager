// screens/api_logs_screen.dart
import 'package:flutter/material.dart';

class ApiLogsScreen extends StatefulWidget {
  const ApiLogsScreen({Key? key}) : super(key: key);

  @override
  State<ApiLogsScreen> createState() => _ApiLogsScreenState();
}

class _ApiLogsScreenState extends State<ApiLogsScreen> {
  String _selectedMethod = 'All';
  String _selectedStatus = 'All';
  String _searchQuery = '';

  final List<ApiLogEntry> _logs = [
    ApiLogEntry(
      id: 'log_001',
      timestamp: DateTime.now().subtract(const Duration(minutes: 2)),
      method: 'GET',
      endpoint: '/api/v1/users',
      statusCode: 200,
      responseTime: 120,
      userAgent: 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36',
      ipAddress: '192.168.1.100',
      apiKey: 'sk_live_51H7x2yJ...',
      requestSize: 0,
      responseSize: 2048,
    ),
    ApiLogEntry(
      id: 'log_002',
      timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
      method: 'POST',
      endpoint: '/api/v1/users',
      statusCode: 201,
      responseTime: 250,
      userAgent: 'curl/7.68.0',
      ipAddress: '192.168.1.101',
      apiKey: 'sk_test_51H7x2yJ...',
      requestSize: 512,
      responseSize: 1024,
    ),
    ApiLogEntry(
      id: 'log_003',
      timestamp: DateTime.now().subtract(const Duration(minutes: 8)),
      method: 'GET',
      endpoint: '/api/v1/substations/monitoring',
      statusCode: 401,
      responseTime: 45,
      userAgent: 'PostmanRuntime/7.29.0',
      ipAddress: '192.168.1.102',
      apiKey: 'invalid_key',
      requestSize: 0,
      responseSize: 128,
    ),
    ApiLogEntry(
      id: 'log_004',
      timestamp: DateTime.now().subtract(const Duration(minutes: 12)),
      method: 'PUT',
      endpoint: '/api/v1/substations/1',
      statusCode: 500,
      responseTime: 5000,
      userAgent: 'axios/0.24.0',
      ipAddress: '192.168.1.103',
      apiKey: 'sk_live_51H7x2yJ...',
      requestSize: 1024,
      responseSize: 256,
    ),
  ];

  List<ApiLogEntry> get _filteredLogs {
    return _logs.where((log) {
      final matchesMethod =
          _selectedMethod == 'All' || log.method == _selectedMethod;
      final matchesStatus = _selectedStatus == 'All' ||
          _getStatusCategory(log.statusCode) == _selectedStatus;
      final matchesSearch = _searchQuery.isEmpty ||
          log.endpoint.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          log.ipAddress.contains(_searchQuery);
      return matchesMethod && matchesStatus && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API Logs'),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refreshLogs,
            tooltip: 'Refresh Logs',
          ),
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: _exportLogs,
            tooltip: 'Export Logs',
          ),
        ],
      ),
      body: Column(
        children: [
          _buildFilters(),
          _buildLogStats(),
          Expanded(child: _buildLogsList()),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.grey.shade50,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Search by endpoint or IP...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => setState(() => _searchQuery = value),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: DropdownButtonFormField<String>(
              value: _selectedMethod,
              decoration: const InputDecoration(
                labelText: 'Method',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(value: 'All', child: Text('All Methods')),
                DropdownMenuItem(value: 'GET', child: Text('GET')),
                DropdownMenuItem(value: 'POST', child: Text('POST')),
                DropdownMenuItem(value: 'PUT', child: Text('PUT')),
                DropdownMenuItem(value: 'DELETE', child: Text('DELETE')),
              ],
              onChanged: (value) => setState(() => _selectedMethod = value!),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: DropdownButtonFormField<String>(
              value: _selectedStatus,
              decoration: const InputDecoration(
                labelText: 'Status',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(value: 'All', child: Text('All Status')),
                DropdownMenuItem(
                    value: 'Success', child: Text('Success (2xx)')),
                DropdownMenuItem(
                    value: 'Client Error', child: Text('Client Error (4xx)')),
                DropdownMenuItem(
                    value: 'Server Error', child: Text('Server Error (5xx)')),
              ],
              onChanged: (value) => setState(() => _selectedStatus = value!),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogStats() {
    final totalRequests = _logs.length;
    final successCount = _logs
        .where((log) => log.statusCode >= 200 && log.statusCode < 300)
        .length;
    final errorCount = _logs.where((log) => log.statusCode >= 400).length;
    final avgResponseTime =
        _logs.fold(0, (sum, log) => sum + log.responseTime) / _logs.length;

    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: _buildStatCard(
              'Total Requests',
              '$totalRequests',
              Icons.api,
              Colors.blue,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildStatCard(
              'Successful',
              '$successCount',
              Icons.check_circle,
              Colors.green,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildStatCard(
              'Errors',
              '$errorCount',
              Icons.error,
              Colors.red,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildStatCard(
              'Avg Response',
              '${avgResponseTime.round()}ms',
              Icons.speed,
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

  Widget _buildLogsList() {
    final filteredLogs = _filteredLogs;

    if (filteredLogs.isEmpty) {
      return const Center(
        child: Text('No API logs found matching the current filters'),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: filteredLogs.length,
      itemBuilder: (context, index) {
        final log = filteredLogs[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ExpansionTile(
            leading: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: _getMethodColor(log.method),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                log.method,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                ),
              ),
            ),
            title: Text(
              log.endpoint,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: _getStatusColor(log.statusCode),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '${log.statusCode}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${log.responseTime}ms',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      log.ipAddress,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      _formatTimestamp(log.timestamp),
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                color: Colors.grey.shade50,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLogDetailRow('Log ID:', log.id),
                    _buildLogDetailRow(
                        'Timestamp:', _formatFullTimestamp(log.timestamp)),
                    _buildLogDetailRow('Method:', log.method),
                    _buildLogDetailRow('Endpoint:', log.endpoint),
                    _buildLogDetailRow('Status Code:', '${log.statusCode}'),
                    _buildLogDetailRow(
                        'Response Time:', '${log.responseTime}ms'),
                    _buildLogDetailRow('IP Address:', log.ipAddress),
                    _buildLogDetailRow('User Agent:', log.userAgent),
                    _buildLogDetailRow(
                        'API Key:', '${log.apiKey.substring(0, 20)}...'),
                    _buildLogDetailRow(
                        'Request Size:', '${log.requestSize} bytes'),
                    _buildLogDetailRow(
                        'Response Size:', '${log.responseSize} bytes'),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton.icon(
                          onPressed: () => _viewFullLog(log),
                          icon: const Icon(Icons.open_in_full, size: 16),
                          label: const Text('View Details'),
                        ),
                        const SizedBox(width: 8),
                        TextButton.icon(
                          onPressed: () => _copyLogId(log.id),
                          icon: const Icon(Icons.copy, size: 16),
                          label: const Text('Copy ID'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLogDetailRow(String label, String value) {
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

  Color _getMethodColor(String method) {
    switch (method.toUpperCase()) {
      case 'GET':
        return Colors.blue;
      case 'POST':
        return Colors.green;
      case 'PUT':
        return Colors.orange;
      case 'DELETE':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Color _getStatusColor(int statusCode) {
    if (statusCode >= 200 && statusCode < 300) {
      return Colors.green;
    } else if (statusCode >= 400 && statusCode < 500) {
      return Colors.orange;
    } else if (statusCode >= 500) {
      return Colors.red;
    }
    return Colors.grey;
  }

  String _getStatusCategory(int statusCode) {
    if (statusCode >= 200 && statusCode < 300) {
      return 'Success';
    } else if (statusCode >= 400 && statusCode < 500) {
      return 'Client Error';
    } else if (statusCode >= 500) {
      return 'Server Error';
    }
    return 'Other';
  }

  String _formatTimestamp(DateTime timestamp) {
    return '${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')}:${timestamp.second.toString().padLeft(2, '0')}';
  }

  String _formatFullTimestamp(DateTime timestamp) {
    return '${timestamp.day.toString().padLeft(2, '0')}/${timestamp.month.toString().padLeft(2, '0')}/${timestamp.year} ${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')}:${timestamp.second.toString().padLeft(2, '0')}';
  }

  void _refreshLogs() {
    setState(() {});
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('API logs refreshed')),
    );
  }

  void _exportLogs() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Export API Logs'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.file_copy),
              title: Text('Export as CSV'),
            ),
            ListTile(
              leading: Icon(Icons.code),
              title: Text('Export as JSON'),
            ),
            ListTile(
              leading: Icon(Icons.table_chart),
              title: Text('Export as Excel'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void _viewFullLog(ApiLogEntry log) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('API Log Details - ${log.id}'),
        content: SizedBox(
          width: double.maxFinite,
          height: 400,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildLogDetailRow('Log ID:', log.id),
                _buildLogDetailRow(
                    'Timestamp:', _formatFullTimestamp(log.timestamp)),
                _buildLogDetailRow('Method:', log.method),
                _buildLogDetailRow('Endpoint:', log.endpoint),
                _buildLogDetailRow('Status Code:', '${log.statusCode}'),
                _buildLogDetailRow('Response Time:', '${log.responseTime}ms'),
                _buildLogDetailRow('IP Address:', log.ipAddress),
                _buildLogDetailRow('API Key:', log.apiKey),
                _buildLogDetailRow('Request Size:', '${log.requestSize} bytes'),
                _buildLogDetailRow(
                    'Response Size:', '${log.responseSize} bytes'),
                const SizedBox(height: 16),
                const Text(
                  'User Agent:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    log.userAgent,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
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

  void _copyLogId(String logId) {
    // Copy log ID to clipboard functionality would go here
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Log ID $logId copied to clipboard')),
    );
  }
}

class ApiLogEntry {
  final String id;
  final DateTime timestamp;
  final String method;
  final String endpoint;
  final int statusCode;
  final int responseTime;
  final String userAgent;
  final String ipAddress;
  final String apiKey;
  final int requestSize;
  final int responseSize;

  ApiLogEntry({
    required this.id,
    required this.timestamp,
    required this.method,
    required this.endpoint,
    required this.statusCode,
    required this.responseTime,
    required this.userAgent,
    required this.ipAddress,
    required this.apiKey,
    required this.requestSize,
    required this.responseSize,
  });
}
