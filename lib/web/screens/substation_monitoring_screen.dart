// screens/substation_monitoring_screen.dart
import 'package:flutter/material.dart';
import 'dart:async';

class SubstationMonitoringScreen extends StatefulWidget {
  const SubstationMonitoringScreen({Key? key}) : super(key: key);

  @override
  State<SubstationMonitoringScreen> createState() =>
      _SubstationMonitoringScreenState();
}

class _SubstationMonitoringScreenState
    extends State<SubstationMonitoringScreen> {
  Timer? _timer;
  final List<MonitoringData> _monitoringData = [
    MonitoringData(
      substationName: 'Central Substation',
      voltage: 132.5,
      current: 245.8,
      power: 32.4,
      frequency: 50.02,
      status: 'Normal',
      alerts: [],
    ),
    MonitoringData(
      substationName: 'North Grid Station',
      voltage: 220.1,
      current: 156.3,
      power: 34.4,
      frequency: 49.98,
      status: 'Normal',
      alerts: ['High Temperature Transformer 2'],
    ),
    MonitoringData(
      substationName: 'East Distribution Point',
      voltage: 65.8,
      current: 89.2,
      power: 5.9,
      frequency: 50.05,
      status: 'Warning',
      alerts: ['Voltage Fluctuation', 'Maintenance Due'],
    ),
  ];

  @override
  void initState() {
    super.initState();
    _startRealTimeUpdates();
  }

  void _startRealTimeUpdates() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      setState(() {
        // Simulate real-time data updates
        for (var data in _monitoringData) {
          data.updateValues();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Substation Monitoring'),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => setState(() {}),
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => _showSettingsDialog(),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildOverviewCards(),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _monitoringData.length,
              itemBuilder: (context, index) {
                return _buildMonitoringCard(_monitoringData[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewCards() {
    final totalAlerts =
        _monitoringData.fold(0, (sum, data) => sum + data.alerts.length);
    final onlineCount =
        _monitoringData.where((data) => data.status != 'Offline').length;
    final avgPower =
        _monitoringData.fold(0.0, (sum, data) => sum + data.power) /
            _monitoringData.length;

    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: _buildOverviewCard(
              'Online Substations',
              '$onlineCount/${_monitoringData.length}',
              Icons.power,
              Colors.green,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildOverviewCard(
              'Active Alerts',
              '$totalAlerts',
              Icons.warning,
              totalAlerts > 0 ? Colors.orange : Colors.green,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildOverviewCard(
              'Avg Power',
              '${avgPower.toStringAsFixed(1)} MW',
              Icons.flash_on,
              Colors.blue,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewCard(
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

  Widget _buildMonitoringCard(MonitoringData data) {
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
                  Icons.electrical_services,
                  size: 24,
                  color: _getStatusColor(data.status),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    data.substationName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Chip(
                  label: Text(data.status),
                  backgroundColor:
                      _getStatusColor(data.status).withOpacity(0.1),
                  labelStyle: TextStyle(color: _getStatusColor(data.status)),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildParameterTile(
                      'Voltage', '${data.voltage} kV', Icons.bolt),
                ),
                Expanded(
                  child: _buildParameterTile(
                      'Current', '${data.current} A', Icons.timeline),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: _buildParameterTile(
                      'Power', '${data.power} MW', Icons.flash_on),
                ),
                Expanded(
                  child: _buildParameterTile(
                      'Frequency', '${data.frequency} Hz', Icons.graphic_eq),
                ),
              ],
            ),
            if (data.alerts.isNotEmpty) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.orange.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.warning,
                            color: Colors.orange.shade700, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          'Active Alerts (${data.alerts.length})',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.orange.shade700,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ...data.alerts.map((alert) => Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Text(
                            '• $alert',
                            style: TextStyle(color: Colors.orange.shade700),
                          ),
                        )),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildParameterTile(String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Icon(icon, size: 20, color: Colors.blue.shade700),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade700,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Normal':
        return Colors.green;
      case 'Warning':
        return Colors.orange;
      case 'Critical':
        return Colors.red;
      case 'Offline':
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }

  void _showSettingsDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Monitoring Settings'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SwitchListTile(
              title: Text('Auto Refresh'),
              value: true,
              onChanged: null,
            ),
            ListTile(
              title: Text('Refresh Interval'),
              subtitle: Text('5 seconds'),
              trailing: Icon(Icons.keyboard_arrow_right),
            ),
            ListTile(
              title: Text('Alert Notifications'),
              subtitle: Text('Enabled'),
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

class MonitoringData {
  final String substationName;
  double voltage;
  double current;
  double power;
  double frequency;
  String status;
  List<String> alerts;

  MonitoringData({
    required this.substationName,
    required this.voltage,
    required this.current,
    required this.power,
    required this.frequency,
    required this.status,
    required this.alerts,
  });

  void updateValues() {
    // Simulate small variations in real-time data
    voltage += (DateTime.now().millisecond % 10 - 5) * 0.1;
    current += (DateTime.now().millisecond % 20 - 10) * 0.5;
    power += (DateTime.now().millisecond % 6 - 3) * 0.1;
    frequency += (DateTime.now().millisecond % 4 - 2) * 0.01;
  }
}
