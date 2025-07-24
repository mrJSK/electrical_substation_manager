// screens/system_logs_screen.dart
import 'package:flutter/material.dart';

class SystemLogsScreen extends StatefulWidget {
  const SystemLogsScreen({Key? key}) : super(key: key);

  @override
  State<SystemLogsScreen> createState() => _SystemLogsScreenState();
}

class _SystemLogsScreenState extends State<SystemLogsScreen> {
  String _selectedLogLevel = 'All';
  String _selectedTimeRange = 'Last 24 Hours';
  String _searchQuery = '';

  final List<SystemLog> _logs = [
    SystemLog(
      level: 'Error',
      timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
      source: 'Database Connection',
      message: 'Connection timeout to primary database server',
      details:
          'Failed to establish connection to db.company.com:5432 within 30 seconds',
    ),
    SystemLog(
      level: 'Warning',
      timestamp: DateTime.now().subtract(const Duration(minutes: 15)),
      source: 'Authentication Service',
      message: 'Multiple failed login attempts detected',
      details:
          'User admin@company.com failed login 3 times from IP 192.168.1.100',
    ),
    SystemLog(
      level: 'Info',
      timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
      source: 'System Monitor',
      message: 'Scheduled backup completed successfully',
      details: 'Daily backup completed in 2m 45s, size: 2.4GB',
    ),
    SystemLog(
      level: 'Debug',
      timestamp: DateTime.now().subtract(const Duration(hours: 1)),
      source: 'API Gateway',
      message: 'Cache invalidation triggered',
      details: 'Cleared 1,247 cache entries for /api/v1/substations endpoint',
    ),
  ];

  List<SystemLog> get _filteredLogs {
    return _logs.where((log) {
      final matchesLevel =
          _selectedLogLevel == 'All' || log.level == _selectedLogLevel;
      final matchesSearch = _searchQuery.isEmpty ||
          log.message.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          log.source.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesLevel && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('System Logs'),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refreshLogs,
            tooltip: 'Refresh Logs',
          ),
          IconButton(
            icon: const Icon(Icons.clear_all),
            onPressed: _clearLogs,
            tooltip: 'Clear Logs',
          ),
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: _downloadLogs,
            tooltip: 'Download Logs',
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
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: 'Search logs...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) => setState(() => _searchQuery = value),
                ),
              ),
              const SizedBox(width: 16),
              SizedBox(
                width: 150,
                child: DropdownButtonFormField<String>(
                  value: _selectedLogLevel,
                  decoration: const InputDecoration(
                    labelText: 'Log Level',
                    border: OutlineInputBorder(),
                  ),
                  items: const [
                    DropdownMenuItem(value: 'All', child: Text('All Levels')),
                    DropdownMenuItem(value: 'Error', child: Text('Error')),
                    DropdownMenuItem(value: 'Warning', child: Text('Warning')),
                    DropdownMenuItem(value: 'Info', child: Text('Info')),
                    DropdownMenuItem(value: 'Debug', child: Text('Debug')),
                  ],
                  onChanged: (value) =>
                      setState(() => _selectedLogLevel = value!),
                ),
              ),
              const SizedBox(width: 16),
              SizedBox(
                width: 150,
                child: DropdownButtonFormField<String>(
                  value: _selectedTimeRange,
                  decoration: const InputDecoration(
                    labelText: 'Time Range',
                    border: OutlineInputBorder(),
                  ),
                  items: const [
                    DropdownMenuItem(
                        value: 'Last Hour', child: Text('Last Hour')),
                    DropdownMenuItem(
                        value: 'Last 24 Hours', child: Text('Last 24 Hours')),
                    DropdownMenuItem(
                        value: 'Last 7 Days', child: Text('Last 7 Days')),
                    DropdownMenuItem(
                        value: 'Last 30 Days', child: Text('Last 30 Days')),
                  ],
                  onChanged: (value) =>
                      setState(() => _selectedTimeRange = value!),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLogStats() {
    final errorCount = _logs.where((log) => log.level == 'Error').length;
    final warningCount = _logs.where((log) => log.level == 'Warning').length;
    final infoCount = _logs.where((log) => log.level == 'Info').length;
    final debugCount = _logs.where((log) => log.level == 'Debug').length;

    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: _buildStatCard(
                'Errors', '$errorCount', Icons.error, Colors.red),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildStatCard(
                'Warnings', '$warningCount', Icons.warning, Colors.orange),
          ),
          const SizedBox(width: 16),
          Expanded(
            child:
                _buildStatCard('Info', '$infoCount', Icons.info, Colors.blue),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildStatCard(
                'Debug', '$debugCount', Icons.bug_report, Colors.green),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
      String title, String count, IconData icon, Color color) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, size: 24, color: color),
            const SizedBox(height: 8),
            Text(
              count,
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
        child: Text('No logs found matching the current filters'),
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
            leading: Icon(
              _getLogLevelIcon(log.level),
              color: _getLogLevelColor(log.level),
            ),
            title: Text(
              log.message,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Row(
                  children: [
                    Chip(
                      label: Text(log.level),
                      backgroundColor:
                          _getLogLevelColor(log.level).withOpacity(0.1),
                      labelStyle: TextStyle(
                        color: _getLogLevelColor(log.level),
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      log.source,
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
                    Text(
                      'Details:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade800,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      log.details,
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontFamily: 'monospace',
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton.icon(
                          onPressed: () => _copyLogDetails(log),
                          icon: const Icon(Icons.copy, size: 16),
                          label: const Text('Copy'),
                        ),
                        const SizedBox(width: 8),
                        TextButton.icon(
                          onPressed: () => _viewFullLog(log),
                          icon: const Icon(Icons.open_in_full, size: 16),
                          label: const Text('View Full'),
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

  IconData _getLogLevelIcon(String level) {
    switch (level) {
      case 'Error':
        return Icons.error;
      case 'Warning':
        return Icons.warning;
      case 'Info':
        return Icons.info;
      case 'Debug':
        return Icons.bug_report;
      default:
        return Icons.circle;
    }
  }

  Color _getLogLevelColor(String level) {
    switch (level) {
      case 'Error':
        return Colors.red;
      case 'Warning':
        return Colors.orange;
      case 'Info':
        return Colors.blue;
      case 'Debug':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  String _formatTimestamp(DateTime timestamp) {
    return '${timestamp.day.toString().padLeft(2, '0')}/${timestamp.month.toString().padLeft(2, '0')}/${timestamp.year} ${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')}:${timestamp.second.toString().padLeft(2, '0')}';
  }

  void _refreshLogs() {
    setState(() {});
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Logs refreshed')),
    );
  }

  void _clearLogs() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear Logs'),
        content: const Text(
            'Are you sure you want to clear all logs? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              setState(() => _logs.clear());
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('All logs cleared')),
              );
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Clear All'),
          ),
        ],
      ),
    );
  }

  void _downloadLogs() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Downloading system logs...')),
    );
  }

  void _copyLogDetails(SystemLog log) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Log details copied to clipboard')),
    );
  }

  void _viewFullLog(SystemLog log) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Full Log Details - ${log.level}'),
        content: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildLogDetailRow(
                    'Timestamp:', _formatTimestamp(log.timestamp)),
                _buildLogDetailRow('Level:', log.level),
                _buildLogDetailRow('Source:', log.source),
                _buildLogDetailRow('Message:', log.message),
                const SizedBox(height: 16),
                const Text(
                  'Details:',
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
                    log.details,
                    style: const TextStyle(fontFamily: 'monospace'),
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

  Widget _buildLogDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
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

class SystemLog {
  final String level;
  final DateTime timestamp;
  final String source;
  final String message;
  final String details;

  SystemLog({
    required this.level,
    required this.timestamp,
    required this.source,
    required this.message,
    required this.details,
  });
}
