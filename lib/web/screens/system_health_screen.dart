// screens/system_health_screen.dart
import 'package:flutter/material.dart';
import 'dart:async';

class SystemHealthScreen extends StatefulWidget {
  const SystemHealthScreen({Key? key}) : super(key: key);

  @override
  State<SystemHealthScreen> createState() => _SystemHealthScreenState();
}

class _SystemHealthScreenState extends State<SystemHealthScreen> {
  Timer? _healthCheckTimer;

  final List<HealthCheckResult> _healthChecks = [
    HealthCheckResult(
      name: 'Database Connection',
      category: 'Infrastructure',
      status: HealthStatus.healthy,
      responseTime: const Duration(milliseconds: 45),
      lastChecked: DateTime.now().subtract(const Duration(seconds: 30)),
      details: 'Primary database responding normally',
      endpoint: 'postgresql://db.company.com:5432',
    ),
    HealthCheckResult(
      name: 'API Server',
      category: 'Application',
      status: HealthStatus.healthy,
      responseTime: const Duration(milliseconds: 120),
      lastChecked: DateTime.now().subtract(const Duration(seconds: 30)),
      details: 'All endpoints responding within acceptable limits',
      endpoint: 'https://api.company.com/health',
    ),
    HealthCheckResult(
      name: 'SCADA Interface',
      category: 'External',
      status: HealthStatus.degraded,
      responseTime: const Duration(milliseconds: 2500),
      lastChecked: DateTime.now().subtract(const Duration(seconds: 30)),
      details: 'Response time elevated but within operational parameters',
      endpoint: 'modbus://scada.company.com:502',
    ),
    HealthCheckResult(
      name: 'Authentication Service',
      category: 'Security',
      status: HealthStatus.healthy,
      responseTime: const Duration(milliseconds: 89),
      lastChecked: DateTime.now().subtract(const Duration(seconds: 30)),
      details: 'Authentication and authorization services operational',
      endpoint: 'https://auth.company.com/health',
    ),
    HealthCheckResult(
      name: 'Backup System',
      category: 'Infrastructure',
      status: HealthStatus.unhealthy,
      responseTime: const Duration(milliseconds: 0),
      lastChecked: DateTime.now().subtract(const Duration(minutes: 5)),
      details: 'Backup service not responding - manual intervention required',
      endpoint: 'https://backup.company.com/status',
    ),
    HealthCheckResult(
      name: 'Email Service',
      category: 'Communication',
      status: HealthStatus.healthy,
      responseTime: const Duration(milliseconds: 156),
      lastChecked: DateTime.now().subtract(const Duration(seconds: 30)),
      details: 'SMTP server operational, queue processing normally',
      endpoint: 'smtp://mail.company.com:587',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _startHealthChecks();
  }

  @override
  void dispose() {
    _healthCheckTimer?.cancel();
    super.dispose();
  }

  void _startHealthChecks() {
    _healthCheckTimer = Timer.periodic(const Duration(seconds: 30), (timer) {
      setState(() {
        _performHealthChecks();
      });
    });
  }

  void _performHealthChecks() {
    // Simulate health check updates
    for (int i = 0; i < _healthChecks.length; i++) {
      final random = DateTime.now().millisecond;

      // Randomly update some health checks
      if (random % 7 == i % 7) {
        final currentCheck = _healthChecks[i];
        final newResponseTime = Duration(
            milliseconds: currentCheck.responseTime.inMilliseconds +
                ((random % 200) - 100));

        HealthStatus newStatus = currentCheck.status;
        if (newResponseTime.inMilliseconds > 3000) {
          newStatus = HealthStatus.unhealthy;
        } else if (newResponseTime.inMilliseconds > 1000) {
          newStatus = HealthStatus.degraded;
        } else {
          newStatus = HealthStatus.healthy;
        }

        _healthChecks[i] = currentCheck.copyWith(
          status: newStatus,
          responseTime: newResponseTime,
          lastChecked: DateTime.now(),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('System Health'),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _performHealthCheck,
            tooltip: 'Run Health Check',
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: _showHealthSettings,
            tooltip: 'Health Check Settings',
          ),
        ],
      ),
      body: Column(
        children: [
          _buildOverallHealth(),
          _buildHealthSummary(),
          Expanded(child: _buildHealthChecksList()),
        ],
      ),
    );
  }

  Widget _buildOverallHealth() {
    final healthyCount =
        _healthChecks.where((h) => h.status == HealthStatus.healthy).length;
    final degradedCount =
        _healthChecks.where((h) => h.status == HealthStatus.degraded).length;
    final unhealthyCount =
        _healthChecks.where((h) => h.status == HealthStatus.unhealthy).length;

    String overallStatus;
    Color statusColor;
    IconData statusIcon;

    if (unhealthyCount > 0) {
      overallStatus = 'Critical Issues Detected';
      statusColor = Colors.red;
      statusIcon = Icons.error;
    } else if (degradedCount > 0) {
      overallStatus = 'Performance Degraded';
      statusColor = Colors.orange;
      statusIcon = Icons.warning;
    } else {
      overallStatus = 'All Systems Operational';
      statusColor = Colors.green;
      statusIcon = Icons.check_circle;
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [statusColor.withOpacity(0.1), statusColor.withOpacity(0.05)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          Icon(statusIcon, size: 48, color: statusColor),
          const SizedBox(height: 12),
          Text(
            overallStatus,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: statusColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Last updated: ${_formatDateTime(DateTime.now())}',
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHealthSummary() {
    final healthyCount =
        _healthChecks.where((h) => h.status == HealthStatus.healthy).length;
    final degradedCount =
        _healthChecks.where((h) => h.status == HealthStatus.degraded).length;
    final unhealthyCount =
        _healthChecks.where((h) => h.status == HealthStatus.unhealthy).length;
    final avgResponseTime =
        _healthChecks.fold(0, (sum, h) => sum + h.responseTime.inMilliseconds) /
            _healthChecks.length;

    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: _buildSummaryCard(
              'Healthy',
              '$healthyCount',
              Icons.check_circle,
              Colors.green,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildSummaryCard(
              'Degraded',
              '$degradedCount',
              Icons.warning,
              Colors.orange,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildSummaryCard(
              'Unhealthy',
              '$unhealthyCount',
              Icons.error,
              Colors.red,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildSummaryCard(
              'Avg Response',
              '${avgResponseTime.round()}ms',
              Icons.speed,
              Colors.blue,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(
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
                fontSize: 18,
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

  Widget _buildHealthChecksList() {
    // Group health checks by category
    final categories = <String, List<HealthCheckResult>>{};
    for (final check in _healthChecks) {
      categories.putIfAbsent(check.category, () => []).add(check);
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: categories.entries.map((entry) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                entry.key,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            ...entry.value.map((check) => _buildHealthCheckCard(check)),
            const SizedBox(height: 16),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildHealthCheckCard(HealthCheckResult check) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ExpansionTile(
        leading: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: _getStatusColor(check.status).withOpacity(0.1),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(
            _getStatusIcon(check.status),
            color: _getStatusColor(check.status),
            size: 16,
          ),
        ),
        title: Text(
          check.name,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Row(
              children: [
                Chip(
                  label: Text(check.status.name.toUpperCase()),
                  backgroundColor:
                      _getStatusColor(check.status).withOpacity(0.1),
                  labelStyle: TextStyle(
                    color: _getStatusColor(check.status),
                    fontSize: 10,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '${check.responseTime.inMilliseconds}ms',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),
                const Spacer(),
                Text(
                  _formatDateTime(check.lastChecked),
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
                _buildDetailRow('Endpoint:', check.endpoint),
                _buildDetailRow('Category:', check.category),
                _buildDetailRow('Status:', check.status.name.toUpperCase()),
                _buildDetailRow(
                    'Response Time:', '${check.responseTime.inMilliseconds}ms'),
                _buildDetailRow(
                    'Last Checked:', _formatFullDateTime(check.lastChecked)),
                const SizedBox(height: 12),
                const Text(
                  'Details:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: _getStatusColor(check.status).withOpacity(0.05),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: _getStatusColor(check.status).withOpacity(0.2),
                    ),
                  ),
                  child: Text(
                    check.details,
                    style: TextStyle(
                      color: _getStatusColor(check.status).withOpacity(0.8),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton.icon(
                      onPressed: () => _runIndividualCheck(check),
                      icon: const Icon(Icons.refresh, size: 16),
                      label: const Text('Test Now'),
                    ),
                    const SizedBox(width: 8),
                    if (check.status != HealthStatus.healthy)
                      ElevatedButton.icon(
                        onPressed: () => _showTroubleshooting(check),
                        icon: const Icon(Icons.help_outline, size: 16),
                        label: const Text('Troubleshoot'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          foregroundColor: Colors.white,
                        ),
                      ),
                  ],
                ),
              ],
            ),
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

  IconData _getStatusIcon(HealthStatus status) {
    switch (status) {
      case HealthStatus.healthy:
        return Icons.check_circle;
      case HealthStatus.degraded:
        return Icons.warning;
      case HealthStatus.unhealthy:
        return Icons.error;
    }
  }

  Color _getStatusColor(HealthStatus status) {
    switch (status) {
      case HealthStatus.healthy:
        return Colors.green;
      case HealthStatus.degraded:
        return Colors.orange;
      case HealthStatus.unhealthy:
        return Colors.red;
    }
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}:${dateTime.second.toString().padLeft(2, '0')}';
  }

  String _formatFullDateTime(DateTime dateTime) {
    return '${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.year} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}:${dateTime.second.toString().padLeft(2, '0')}';
  }

  void _performHealthCheck() {
    setState(() {
      _performHealthChecks();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Health check completed')),
    );
  }

  void _runIndividualCheck(HealthCheckResult check) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Testing ${check.name}'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Running health check...'),
          ],
        ),
      ),
    );

    // Simulate individual health check
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pop();
      setState(() {
        final index = _healthChecks.indexOf(check);
        _healthChecks[index] = check.copyWith(
          lastChecked: DateTime.now(),
          responseTime:
              Duration(milliseconds: 50 + (DateTime.now().millisecond % 200)),
        );
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${check.name} health check completed')),
      );
    });
  }

  void _showTroubleshooting(HealthCheckResult check) {
    final troubleshootingSteps = <String>[];

    switch (check.status) {
      case HealthStatus.degraded:
        troubleshootingSteps.addAll([
          '1. Check network connectivity to ${check.endpoint}',
          '2. Verify service configuration',
          '3. Monitor resource usage',
          '4. Review recent changes',
        ]);
        break;
      case HealthStatus.unhealthy:
        troubleshootingSteps.addAll([
          '1. Verify service is running',
          '2. Check connectivity to ${check.endpoint}',
          '3. Review error logs',
          '4. Restart service if necessary',
          '5. Contact system administrator',
        ]);
        break;
      case HealthStatus.healthy:
        troubleshootingSteps.add('Service is operating normally');
        break;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Troubleshooting: ${check.name}'),
        content: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Current Status: ${check.status.name.toUpperCase()}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: _getStatusColor(check.status),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Recommended Steps:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              ...troubleshootingSteps.map((step) => Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text(step),
                  )),
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

  void _showHealthSettings() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Health Check Settings'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text('Check Interval'),
              subtitle: Text('30 seconds'),
              trailing: Icon(Icons.keyboard_arrow_right),
            ),
            ListTile(
              title: Text('Timeout Threshold'),
              subtitle: Text('5 seconds'),
              trailing: Icon(Icons.keyboard_arrow_right),
            ),
            SwitchListTile(
              title: Text('Auto Health Checks'),
              subtitle: Text('Automatically run health checks'),
              value: true,
              onChanged: null,
            ),
            SwitchListTile(
              title: Text('Alert on Failure'),
              subtitle: Text('Send alerts when health checks fail'),
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
}

// Health Check Models
class HealthCheckResult {
  final String name;
  final String category;
  final HealthStatus status;
  final Duration responseTime;
  final DateTime lastChecked;
  final String details;
  final String endpoint;

  HealthCheckResult({
    required this.name,
    required this.category,
    required this.status,
    required this.responseTime,
    required this.lastChecked,
    required this.details,
    required this.endpoint,
  });

  HealthCheckResult copyWith({
    String? name,
    String? category,
    HealthStatus? status,
    Duration? responseTime,
    DateTime? lastChecked,
    String? details,
    String? endpoint,
  }) {
    return HealthCheckResult(
      name: name ?? this.name,
      category: category ?? this.category,
      status: status ?? this.status,
      responseTime: responseTime ?? this.responseTime,
      lastChecked: lastChecked ?? this.lastChecked,
      details: details ?? this.details,
      endpoint: endpoint ?? this.endpoint,
    );
  }
}

enum HealthStatus { healthy, degraded, unhealthy }
