// screens/system_alerts_screen.dart
import 'package:flutter/material.dart';
import 'dart:async';

import 'system_monitoring_screen.dart';

class SystemAlertsScreen extends StatefulWidget {
  const SystemAlertsScreen({Key? key}) : super(key: key);

  @override
  State<SystemAlertsScreen> createState() => _SystemAlertsScreenState();
}

class _SystemAlertsScreenState extends State<SystemAlertsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  Timer? _refreshTimer;

  String _selectedSeverity = 'All';
  String _selectedSource = 'All';
  String _searchQuery = '';

  final List<SystemAlert> _alerts = [
    SystemAlert(
      id: 'alert_001',
      type: AlertType.error,
      severity: AlertSeverity.high,
      title: 'Database Connection Failed',
      message:
          'Unable to connect to primary database server. Connection timeout after 30 seconds.',
      source: 'Database Service',
      timestamp: DateTime.now().subtract(const Duration(minutes: 2)),
      status: AlertStatus.active,
      affectedSystems: ['User Authentication', 'Data Storage', 'Reports'],
      resolution: null,
    ),
    SystemAlert(
      id: 'alert_002',
      type: AlertType.warning,
      severity: AlertSeverity.medium,
      title: 'High CPU Usage Detected',
      message:
          'CPU usage has exceeded 85% for the last 10 minutes on server node-02.',
      source: 'System Monitor',
      timestamp: DateTime.now().subtract(const Duration(minutes: 8)),
      status: AlertStatus.acknowledged,
      affectedSystems: ['API Server', 'Background Jobs'],
      resolution: 'Investigation in progress - checking for runaway processes',
    ),
    SystemAlert(
      id: 'alert_003',
      type: AlertType.warning,
      severity: AlertSeverity.medium,
      title: 'Memory Usage Critical',
      message: 'Available memory has dropped below 10% on application server.',
      source: 'Resource Monitor',
      timestamp: DateTime.now().subtract(const Duration(minutes: 15)),
      status: AlertStatus.resolved,
      affectedSystems: ['Web Interface', 'API Endpoints'],
      resolution:
          'Memory cleaned up by restarting background services. Memory usage now at 65%.',
    ),
    SystemAlert(
      id: 'alert_004',
      type: AlertType.info,
      severity: AlertSeverity.low,
      title: 'Scheduled Backup Completed',
      message:
          'Daily system backup completed successfully. Size: 2.4GB, Duration: 8m 32s.',
      source: 'Backup Service',
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      status: AlertStatus.resolved,
      affectedSystems: ['Data Storage'],
      resolution: 'Backup completed successfully and verified.',
    ),
    SystemAlert(
      id: 'alert_005',
      type: AlertType.error,
      severity: AlertSeverity.high,
      title: 'Substation Communication Lost',
      message:
          'Lost communication with Central Substation. Last successful contact 5 minutes ago.',
      source: 'SCADA Interface',
      timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
      status: AlertStatus.active,
      affectedSystems: [
        'Monitoring Dashboard',
        'Alert System',
        'Data Collection'
      ],
      resolution: null,
    ),
  ];

  List<SystemAlert> get _filteredAlerts {
    return _alerts.where((alert) {
      final matchesSeverity = _selectedSeverity == 'All' ||
          alert.severity.name == _selectedSeverity.toLowerCase();
      final matchesSource =
          _selectedSource == 'All' || alert.source == _selectedSource;
      final matchesSearch = _searchQuery.isEmpty ||
          alert.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          alert.message.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesSeverity && matchesSource && matchesSearch;
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _startAutoRefresh();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _refreshTimer?.cancel();
    super.dispose();
  }

  void _startAutoRefresh() {
    _refreshTimer = Timer.periodic(const Duration(seconds: 30), (timer) {
      setState(() {
        // Simulate new alerts or status changes
        _simulateAlertUpdates();
      });
    });
  }

  void _simulateAlertUpdates() {
    // Simulate random alert status changes for demo
    if (_alerts.isNotEmpty) {
      final random = DateTime.now().millisecond % _alerts.length;
      final alert = _alerts[random];
      if (alert.status == AlertStatus.active &&
          DateTime.now().millisecond % 3 == 0) {
        _alerts[random] = alert.copyWith(status: AlertStatus.acknowledged);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('System Alerts'),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _showFilterDialog,
            tooltip: 'Filter Alerts',
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: _showAlertSettings,
            tooltip: 'Alert Settings',
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refreshAlerts,
            tooltip: 'Refresh',
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.white,
          tabs: [
            Tab(
              text:
                  'Active (${_alerts.where((a) => a.status == AlertStatus.active).length})',
              icon: const Icon(Icons.warning),
            ),
            Tab(
              text:
                  'Acknowledged (${_alerts.where((a) => a.status == AlertStatus.acknowledged).length})',
              icon: const Icon(Icons.assignment_turned_in),
            ),
            Tab(
              text:
                  'Resolved (${_alerts.where((a) => a.status == AlertStatus.resolved).length})',
              icon: const Icon(Icons.check_circle),
            ),
            Tab(
              text: 'All (${_alerts.length})',
              icon: const Icon(Icons.list),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          _buildSearchAndStats(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildAlertsList(AlertStatus.active),
                _buildAlertsList(AlertStatus.acknowledged),
                _buildAlertsList(AlertStatus.resolved),
                _buildAlertsList(null), // All alerts
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchAndStats() {
    final criticalCount =
        _alerts.where((a) => a.severity == AlertSeverity.high).length;
    final warningCount =
        _alerts.where((a) => a.severity == AlertSeverity.medium).length;
    final infoCount =
        _alerts.where((a) => a.severity == AlertSeverity.low).length;

    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.grey.shade50,
      child: Column(
        children: [
          TextField(
            decoration: const InputDecoration(
              hintText: 'Search alerts...',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
            onChanged: (value) => setState(() => _searchQuery = value),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                    'Critical', '$criticalCount', Icons.error, Colors.red),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildStatCard(
                    'Warning', '$warningCount', Icons.warning, Colors.orange),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildStatCard(
                    'Info', '$infoCount', Icons.info, Colors.blue),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildStatCard('Total', '${_alerts.length}',
                    Icons.notifications, Colors.purple),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
      String title, String count, IconData icon, Color color) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Icon(icon, size: 20, color: color),
            const SizedBox(height: 4),
            Text(
              count,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              title,
              style: const TextStyle(fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAlertsList(AlertStatus? filterStatus) {
    final filteredAlerts = _filteredAlerts.where((alert) {
      return filterStatus == null || alert.status == filterStatus;
    }).toList();

    if (filteredAlerts.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle_outline,
              size: 64,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 16),
            Text(
              filterStatus == null
                  ? 'No alerts found'
                  : 'No ${filterStatus.name} alerts',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: filteredAlerts.length,
      itemBuilder: (context, index) {
        final alert = filteredAlerts[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ExpansionTile(
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: _getSeverityColor(alert.severity).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                _getAlertIcon(alert.type),
                color: _getSeverityColor(alert.severity),
                size: 20,
              ),
            ),
            title: Text(
              alert.title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text(
                  alert.message,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Chip(
                      label: Text(alert.severity.name.toUpperCase()),
                      backgroundColor:
                          _getSeverityColor(alert.severity).withOpacity(0.1),
                      labelStyle: TextStyle(
                        color: _getSeverityColor(alert.severity),
                        fontSize: 10,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Chip(
                      label: Text(alert.status.name.toUpperCase()),
                      backgroundColor:
                          _getStatusColor(alert.status).withOpacity(0.1),
                      labelStyle: TextStyle(
                        color: _getStatusColor(alert.status),
                        fontSize: 10,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      _formatDateTime(alert.timestamp),
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
                    _buildDetailRow('Alert ID:', alert.id),
                    _buildDetailRow('Source:', alert.source),
                    _buildDetailRow(
                        'Timestamp:', _formatFullDateTime(alert.timestamp)),
                    _buildDetailRow('Status:', alert.status.name.toUpperCase()),
                    _buildDetailRow(
                        'Severity:', alert.severity.name.toUpperCase()),
                    const SizedBox(height: 12),
                    const Text(
                      'Affected Systems:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 4,
                      children: alert.affectedSystems
                          .map((system) => Chip(
                                label: Text(system),
                                backgroundColor: Colors.blue.shade100,
                                labelStyle: TextStyle(
                                  color: Colors.blue.shade700,
                                  fontSize: 10,
                                ),
                              ))
                          .toList(),
                    ),
                    if (alert.resolution != null) ...[
                      const SizedBox(height: 12),
                      const Text(
                        'Resolution:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.green.shade50,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.green.shade200),
                        ),
                        child: Text(
                          alert.resolution!,
                          style: TextStyle(color: Colors.green.shade700),
                        ),
                      ),
                    ],
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (alert.status == AlertStatus.active) ...[
                          TextButton.icon(
                            onPressed: () => _acknowledgeAlert(alert),
                            icon: const Icon(Icons.assignment_turned_in,
                                size: 16),
                            label: const Text('Acknowledge'),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton.icon(
                            onPressed: () => _resolveAlert(alert),
                            icon: const Icon(Icons.check, size: 16),
                            label: const Text('Resolve'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ] else if (alert.status ==
                            AlertStatus.acknowledged) ...[
                          ElevatedButton.icon(
                            onPressed: () => _resolveAlert(alert),
                            icon: const Icon(Icons.check, size: 16),
                            label: const Text('Resolve'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ],
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

  IconData _getAlertIcon(AlertType type) {
    switch (type) {
      case AlertType.error:
        return Icons.error;
      case AlertType.warning:
        return Icons.warning;
      case AlertType.info:
        return Icons.info;
      case AlertType.success:
        return Icons.check_circle;
    }
  }

  Color _getSeverityColor(AlertSeverity severity) {
    switch (severity) {
      case AlertSeverity.high:
        return Colors.red;
      case AlertSeverity.medium:
        return Colors.orange;
      case AlertSeverity.low:
        return Colors.blue;
    }
  }

  Color _getStatusColor(AlertStatus status) {
    switch (status) {
      case AlertStatus.active:
        return Colors.red;
      case AlertStatus.acknowledged:
        return Colors.orange;
      case AlertStatus.resolved:
        return Colors.green;
    }
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

  String _formatFullDateTime(DateTime dateTime) {
    return '${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.year} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}:${dateTime.second.toString().padLeft(2, '0')}';
  }

  void _acknowledgeAlert(SystemAlert alert) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Acknowledge Alert'),
        content: Text('Acknowledge "${alert.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                final index = _alerts.indexOf(alert);
                _alerts[index] =
                    alert.copyWith(status: AlertStatus.acknowledged);
              });
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Alert acknowledged')),
              );
            },
            child: const Text('Acknowledge'),
          ),
        ],
      ),
    );
  }

  void _resolveAlert(SystemAlert alert) {
    final resolutionController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Resolve Alert'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Resolve "${alert.title}"?'),
            const SizedBox(height: 16),
            TextField(
              controller: resolutionController,
              decoration: const InputDecoration(
                labelText: 'Resolution Notes',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                final index = _alerts.indexOf(alert);
                _alerts[index] = alert.copyWith(
                  status: AlertStatus.resolved,
                  resolution: resolutionController.text.isEmpty
                      ? 'Alert resolved by user'
                      : resolutionController.text,
                );
              });
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Alert resolved')),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: const Text('Resolve', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Filter Alerts'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<String>(
              value: _selectedSeverity,
              decoration: const InputDecoration(
                labelText: 'Severity',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(value: 'All', child: Text('All Severities')),
                DropdownMenuItem(value: 'High', child: Text('High')),
                DropdownMenuItem(value: 'Medium', child: Text('Medium')),
                DropdownMenuItem(value: 'Low', child: Text('Low')),
              ],
              onChanged: (value) => setState(() => _selectedSeverity = value!),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedSource,
              decoration: const InputDecoration(
                labelText: 'Source',
                border: OutlineInputBorder(),
              ),
              items: [
                const DropdownMenuItem(
                    value: 'All', child: Text('All Sources')),
                ..._alerts.map((alert) => alert.source).toSet().map(
                      (source) =>
                          DropdownMenuItem(value: source, child: Text(source)),
                    ),
              ],
              onChanged: (value) => setState(() => _selectedSource = value!),
            ),
          ],
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

  void _showAlertSettings() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Alert Settings'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SwitchListTile(
              title: Text('Email Notifications'),
              subtitle: Text('Send alerts via email'),
              value: true,
              onChanged: null,
            ),
            SwitchListTile(
              title: Text('SMS Notifications'),
              subtitle: Text('Send critical alerts via SMS'),
              value: false,
              onChanged: null,
            ),
            SwitchListTile(
              title: Text('Auto-refresh'),
              subtitle: Text('Automatically refresh alerts'),
              value: true,
              onChanged: null,
            ),
          ],
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

  void _refreshAlerts() {
    setState(() {
      _simulateAlertUpdates();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Alerts refreshed')),
    );
  }
}

// Enhanced Alert Model
class SystemAlert {
  final String id;
  final AlertType type;
  final AlertSeverity severity;
  final String title;
  final String message;
  final String source;
  final DateTime timestamp;
  final AlertStatus status;
  final List<String> affectedSystems;
  final String? resolution;

  SystemAlert({
    required this.id,
    required this.type,
    required this.severity,
    required this.title,
    required this.message,
    required this.source,
    required this.timestamp,
    required this.status,
    required this.affectedSystems,
    this.resolution,
  });

  SystemAlert copyWith({
    String? id,
    AlertType? type,
    AlertSeverity? severity,
    String? title,
    String? message,
    String? source,
    DateTime? timestamp,
    AlertStatus? status,
    List<String>? affectedSystems,
    String? resolution,
  }) {
    return SystemAlert(
      id: id ?? this.id,
      type: type ?? this.type,
      severity: severity ?? this.severity,
      title: title ?? this.title,
      message: message ?? this.message,
      source: source ?? this.source,
      timestamp: timestamp ?? this.timestamp,
      status: status ?? this.status,
      affectedSystems: affectedSystems ?? this.affectedSystems,
      resolution: resolution ?? this.resolution,
    );
  }
}

enum AlertStatus { active, acknowledged, resolved }
