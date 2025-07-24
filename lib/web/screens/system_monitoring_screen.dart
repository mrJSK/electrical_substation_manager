// screens/system_monitoring_screen.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:async';

class SystemMonitoringScreen extends StatefulWidget {
  const SystemMonitoringScreen({Key? key}) : super(key: key);

  @override
  State<SystemMonitoringScreen> createState() => _SystemMonitoringScreenState();
}

class _SystemMonitoringScreenState extends State<SystemMonitoringScreen> {
  Timer? _refreshTimer;
  bool _autoRefresh = true;

  final SystemMetrics _metrics = SystemMetrics(
    cpuUsage: 45.2,
    memoryUsage: 68.7,
    diskUsage: 34.1,
    networkInbound: 125.6,
    networkOutbound: 89.3,
    uptime: const Duration(days: 15, hours: 8, minutes: 32),
    activeConnections: 247,
    systemLoad: 0.85,
    temperature: 42.5,
  );

  final List<SystemAlert> _recentAlerts = [
    SystemAlert(
      id: 'alert_001',
      type: AlertType.warning,
      title: 'High CPU Usage',
      message: 'CPU usage has exceeded 80% for the last 5 minutes',
      timestamp: DateTime.now().subtract(const Duration(minutes: 3)),
      source: 'System Monitor',
      severity: AlertSeverity.medium,
    ),
    SystemAlert(
      id: 'alert_002',
      type: AlertType.info,
      title: 'Database Connection Pool',
      message: 'Connection pool reached 90% capacity',
      timestamp: DateTime.now().subtract(const Duration(minutes: 15)),
      source: 'Database',
      severity: AlertSeverity.low,
    ),
    SystemAlert(
      id: 'alert_003',
      type: AlertType.error,
      title: 'Disk Space Critical',
      message: 'Available disk space is below 5GB',
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      source: 'Storage',
      severity: AlertSeverity.high,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _startAutoRefresh();
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    super.dispose();
  }

  void _startAutoRefresh() {
    if (_autoRefresh) {
      _refreshTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
        setState(() {
          _updateMetrics();
        });
      });
    }
  }

  void _updateMetrics() {
    // Simulate real-time metric updates
    _metrics.cpuUsage += (DateTime.now().millisecond % 10 - 5) * 0.5;
    _metrics.memoryUsage += (DateTime.now().millisecond % 8 - 4) * 0.3;
    _metrics.networkInbound += (DateTime.now().millisecond % 20 - 10) * 2.0;
    _metrics.networkOutbound += (DateTime.now().millisecond % 15 - 7) * 1.5;

    // Keep values within reasonable bounds
    _metrics.cpuUsage = _metrics.cpuUsage.clamp(10.0, 95.0);
    _metrics.memoryUsage = _metrics.memoryUsage.clamp(30.0, 90.0);
    _metrics.networkInbound = _metrics.networkInbound.clamp(50.0, 500.0);
    _metrics.networkOutbound = _metrics.networkOutbound.clamp(30.0, 300.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('System Monitoring'),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(_autoRefresh ? Icons.pause : Icons.play_arrow),
            onPressed: _toggleAutoRefresh,
            tooltip: _autoRefresh ? 'Pause Auto Refresh' : 'Start Auto Refresh',
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refreshNow,
            tooltip: 'Refresh Now',
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              switch (value) {
                case 'performance':
                  context.goNamed('performance-monitoring');
                  break;
                case 'alerts':
                  context.goNamed('system-alerts');
                  break;
                case 'health':
                  context.goNamed('system-health');
                  break;
                case 'settings':
                  _showMonitoringSettings();
                  break;
              }
            },
            itemBuilder: (context) => const [
              PopupMenuItem(
                  value: 'performance', child: Text('Performance Details')),
              PopupMenuItem(value: 'alerts', child: Text('System Alerts')),
              PopupMenuItem(value: 'health', child: Text('System Health')),
              PopupMenuItem(
                  value: 'settings', child: Text('Monitoring Settings')),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSystemOverview(),
          Expanded(
            child: Row(
              children: [
                Expanded(flex: 2, child: _buildMetricsGrid()),
                Expanded(flex: 1, child: _buildRecentAlerts()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSystemOverview() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.grey.shade50,
      child: Row(
        children: [
          Expanded(
            child: _buildOverviewCard(
              'System Status',
              'Operational',
              Icons.check_circle,
              Colors.green,
              subtitle: 'All systems running normally',
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildOverviewCard(
              'Uptime',
              _formatUptime(_metrics.uptime),
              Icons.access_time,
              Colors.blue,
              subtitle: 'Since last restart',
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildOverviewCard(
              'Active Alerts',
              '${_recentAlerts.where((a) => a.type == AlertType.error).length}',
              Icons.warning,
              Colors.orange,
              subtitle: '${_recentAlerts.length} total alerts',
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildOverviewCard(
              'Connections',
              '${_metrics.activeConnections}',
              Icons.device_hub,
              Colors.purple,
              subtitle: 'Active connections',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewCard(
      String title, String value, IconData icon, Color color,
      {String? subtitle}) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 24),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            if (subtitle != null) ...[
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildMetricsGrid() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'System Metrics',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 1.2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                _buildMetricCard(
                  'CPU Usage',
                  '${_metrics.cpuUsage.toStringAsFixed(1)}%',
                  _metrics.cpuUsage,
                  Icons.memory,
                  Colors.blue,
                ),
                _buildMetricCard(
                  'Memory Usage',
                  '${_metrics.memoryUsage.toStringAsFixed(1)}%',
                  _metrics.memoryUsage,
                  Icons.storage,
                  Colors.green,
                ),
                _buildMetricCard(
                  'Disk Usage',
                  '${_metrics.diskUsage.toStringAsFixed(1)}%',
                  _metrics.diskUsage,
                  Icons.sd_storage,
                  Colors.orange,
                ),
                _buildMetricCard(
                  'Network In',
                  '${_metrics.networkInbound.toStringAsFixed(1)} MB/s',
                  _metrics.networkInbound / 10,
                  Icons.download,
                  Colors.purple,
                ),
                _buildMetricCard(
                  'Network Out',
                  '${_metrics.networkOutbound.toStringAsFixed(1)} MB/s',
                  _metrics.networkOutbound / 10,
                  Icons.upload,
                  Colors.indigo,
                ),
                _buildMetricCard(
                  'Temperature',
                  '${_metrics.temperature.toStringAsFixed(1)}°C',
                  _metrics.temperature / 2,
                  Icons.thermostat,
                  Colors.red,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, double percentage,
      IconData icon, Color color) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: percentage / 100,
              backgroundColor: Colors.grey.shade300,
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
            const SizedBox(height: 4),
            Text(
              '${percentage.toStringAsFixed(1)}%',
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

  Widget _buildRecentAlerts() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 16, 16, 16),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Text(
                    'Recent System Alerts',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () => context.goNamed('system-alerts'),
                    child: const Text('View All'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _recentAlerts.length,
                itemBuilder: (context, index) {
                  final alert = _recentAlerts[index];
                  return ListTile(
                    leading: Icon(
                      _getAlertIcon(alert.type),
                      color: _getAlertColor(alert.type),
                      size: 20,
                    ),
                    title: Text(
                      alert.title,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          alert.message,
                          style: const TextStyle(fontSize: 12),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _formatDateTime(alert.timestamp),
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                    trailing: Chip(
                      label: Text(
                        alert.severity.name.toUpperCase(),
                        style: const TextStyle(fontSize: 10),
                      ),
                      backgroundColor:
                          _getSeverityColor(alert.severity).withOpacity(0.1),
                      labelStyle:
                          TextStyle(color: _getSeverityColor(alert.severity)),
                    ),
                    dense: true,
                  );
                },
              ),
            ),
          ],
        ),
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

  Color _getAlertColor(AlertType type) {
    switch (type) {
      case AlertType.error:
        return Colors.red;
      case AlertType.warning:
        return Colors.orange;
      case AlertType.info:
        return Colors.blue;
      case AlertType.success:
        return Colors.green;
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

  String _formatUptime(Duration uptime) {
    if (uptime.inDays > 0) {
      return '${uptime.inDays}d ${uptime.inHours % 24}h ${uptime.inMinutes % 60}m';
    } else if (uptime.inHours > 0) {
      return '${uptime.inHours}h ${uptime.inMinutes % 60}m';
    } else {
      return '${uptime.inMinutes}m';
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

  void _toggleAutoRefresh() {
    setState(() {
      _autoRefresh = !_autoRefresh;
      if (_autoRefresh) {
        _startAutoRefresh();
      } else {
        _refreshTimer?.cancel();
      }
    });
  }

  void _refreshNow() {
    setState(() {
      _updateMetrics();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('System metrics refreshed')),
    );
  }

  void _showMonitoringSettings() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Monitoring Settings'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SwitchListTile(
              title: const Text('Auto Refresh'),
              subtitle:
                  const Text('Automatically update metrics every 5 seconds'),
              value: _autoRefresh,
              onChanged: (value) {
                Navigator.of(context).pop();
                _toggleAutoRefresh();
              },
            ),
            const ListTile(
              title: Text('Refresh Interval'),
              subtitle: Text('5 seconds'),
              trailing: Icon(Icons.keyboard_arrow_right),
            ),
            const ListTile(
              title: Text('Alert Thresholds'),
              subtitle: Text('Configure alert thresholds'),
              trailing: Icon(Icons.keyboard_arrow_right),
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
}

// Data Models
class SystemMetrics {
  double cpuUsage;
  double memoryUsage;
  double diskUsage;
  double networkInbound;
  double networkOutbound;
  Duration uptime;
  int activeConnections;
  double systemLoad;
  double temperature;

  SystemMetrics({
    required this.cpuUsage,
    required this.memoryUsage,
    required this.diskUsage,
    required this.networkInbound,
    required this.networkOutbound,
    required this.uptime,
    required this.activeConnections,
    required this.systemLoad,
    required this.temperature,
  });
}

class SystemAlert {
  final String id;
  final AlertType type;
  final String title;
  final String message;
  final DateTime timestamp;
  final String source;
  final AlertSeverity severity;

  SystemAlert({
    required this.id,
    required this.type,
    required this.title,
    required this.message,
    required this.timestamp,
    required this.source,
    required this.severity,
  });
}

enum AlertType { error, warning, info, success }

enum AlertSeverity { high, medium, low }
