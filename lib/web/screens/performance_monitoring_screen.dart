// screens/performance_monitoring_screen.dart
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:async';

class PerformanceMonitoringScreen extends StatefulWidget {
  const PerformanceMonitoringScreen({Key? key}) : super(key: key);

  @override
  State<PerformanceMonitoringScreen> createState() =>
      _PerformanceMonitoringScreenState();
}

class _PerformanceMonitoringScreenState
    extends State<PerformanceMonitoringScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  Timer? _updateTimer;

  final List<FlSpot> _cpuData = [];
  final List<FlSpot> _memoryData = [];
  final List<FlSpot> _networkData = [];
  final List<FlSpot> _diskData = [];

  double _currentTime = 0;

  final List<PerformanceMetric> _performanceHistory = [
    PerformanceMetric(
      timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
      cpuUsage: 45.2,
      memoryUsage: 68.7,
      diskIO: 234.5,
      networkThroughput: 125.6,
      responseTime: 145,
      requestsPerSecond: 89,
    ),
    PerformanceMetric(
      timestamp: DateTime.now().subtract(const Duration(minutes: 4)),
      cpuUsage: 52.1,
      memoryUsage: 71.2,
      diskIO: 189.3,
      networkThroughput: 167.8,
      responseTime: 165,
      requestsPerSecond: 102,
    ),
    PerformanceMetric(
      timestamp: DateTime.now().subtract(const Duration(minutes: 3)),
      cpuUsage: 38.9,
      memoryUsage: 65.4,
      diskIO: 298.7,
      networkThroughput: 98.4,
      responseTime: 132,
      requestsPerSecond: 76,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _initializeData();
    _startRealTimeUpdates();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _updateTimer?.cancel();
    super.dispose();
  }

  void _initializeData() {
    // Initialize chart data with some sample points
    for (int i = 0; i < 20; i++) {
      _cpuData.add(FlSpot(i.toDouble(), 30 + (i * 2) % 40));
      _memoryData.add(FlSpot(i.toDouble(), 50 + (i * 3) % 30));
      _networkData.add(FlSpot(i.toDouble(), 80 + (i * 4) % 50));
      _diskData.add(FlSpot(i.toDouble(), 20 + (i * 1.5) % 25));
    }
    _currentTime = 20;
  }

  void _startRealTimeUpdates() {
    _updateTimer = Timer.periodic(const Duration(seconds: 2), (timer) {
      setState(() {
        _updateChartData();
      });
    });
  }

  void _updateChartData() {
    // Simulate real-time data updates
    final random = DateTime.now().millisecond;

    // Add new data points
    _cpuData.add(FlSpot(_currentTime, 30 + (random % 40).toDouble()));
    _memoryData.add(FlSpot(_currentTime, 50 + ((random * 2) % 30).toDouble()));
    _networkData.add(FlSpot(_currentTime, 80 + ((random * 3) % 50).toDouble()));
    _diskData.add(FlSpot(_currentTime, 20 + ((random * 0.5) % 25).toDouble()));

    // Keep only last 50 points for performance
    if (_cpuData.length > 50) {
      _cpuData.removeAt(0);
      _memoryData.removeAt(0);
      _networkData.removeAt(0);
      _diskData.removeAt(0);
    }

    _currentTime++;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Performance Monitoring'),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: _showPerformanceSettings,
            tooltip: 'Performance Settings',
          ),
          IconButton(
            icon: const Icon(Icons.file_download),
            onPressed: _exportPerformanceData,
            tooltip: 'Export Data',
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(text: 'CPU & Memory', icon: Icon(Icons.memory)),
            Tab(text: 'Network', icon: Icon(Icons.network_check)),
            Tab(text: 'Disk I/O', icon: Icon(Icons.storage)),
            Tab(text: 'Application', icon: Icon(Icons.apps)),
          ],
        ),
      ),
      body: Column(
        children: [
          _buildPerformanceSummary(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildCpuMemoryTab(),
                _buildNetworkTab(),
                _buildDiskTab(),
                _buildApplicationTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceSummary() {
    final latest =
        _performanceHistory.isNotEmpty ? _performanceHistory.last : null;

    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.grey.shade50,
      child: Row(
        children: [
          Expanded(
            child: _buildSummaryCard(
              'CPU Usage',
              '${latest?.cpuUsage.toStringAsFixed(1) ?? '0.0'}%',
              Icons.memory,
              Colors.blue,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildSummaryCard(
              'Memory Usage',
              '${latest?.memoryUsage.toStringAsFixed(1) ?? '0.0'}%',
              Icons.storage,
              Colors.green,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildSummaryCard(
              'Response Time',
              '${latest?.responseTime ?? 0}ms',
              Icons.speed,
              Colors.orange,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildSummaryCard(
              'Requests/sec',
              '${latest?.requestsPerSecond ?? 0}',
              Icons.trending_up,
              Colors.purple,
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

  Widget _buildCpuMemoryTab() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Expanded(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'CPU & Memory Usage Over Time',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: LineChart(
                        LineChartData(
                          gridData: const FlGridData(show: true),
                          titlesData: FlTitlesData(
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 40,
                                getTitlesWidget: (value, meta) {
                                  return Text('${value.toInt()}%',
                                      style: const TextStyle(fontSize: 10));
                                },
                              ),
                            ),
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (value, meta) {
                                  return Text('${value.toInt()}s',
                                      style: const TextStyle(fontSize: 10));
                                },
                              ),
                            ),
                            topTitles: const AxisTitles(
                                sideTitles: SideTitles(showTitles: false)),
                            rightTitles: const AxisTitles(
                                sideTitles: SideTitles(showTitles: false)),
                          ),
                          borderData: FlBorderData(show: true),
                          lineBarsData: [
                            LineChartBarData(
                              spots: _cpuData,
                              isCurved: true,
                              color: Colors.blue,
                              barWidth: 2,
                              dotData: const FlDotData(show: false),
                            ),
                            LineChartBarData(
                              spots: _memoryData,
                              isCurved: true,
                              color: Colors.green,
                              barWidth: 2,
                              dotData: const FlDotData(show: false),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildLegendItem('CPU Usage', Colors.blue),
                        const SizedBox(width: 24),
                        _buildLegendItem('Memory Usage', Colors.green),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          _buildMetricsGrid([
            {
              'title': 'CPU Cores',
              'value': '8',
              'icon': Icons.memory,
              'color': Colors.blue
            },
            {
              'title': 'Total RAM',
              'value': '32 GB',
              'icon': Icons.storage,
              'color': Colors.green
            },
            {
              'title': 'CPU Load',
              'value': '0.85',
              'icon': Icons.trending_up,
              'color': Colors.orange
            },
            {
              'title': 'Free Memory',
              'value': '8.2 GB',
              'icon': Icons.memory,
              'color': Colors.purple
            },
          ]),
        ],
      ),
    );
  }

  Widget _buildNetworkTab() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Expanded(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Network Throughput',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: LineChart(
                        LineChartData(
                          gridData: const FlGridData(show: true),
                          titlesData: FlTitlesData(
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 50,
                                getTitlesWidget: (value, meta) {
                                  return Text('${value.toInt()}MB/s',
                                      style: const TextStyle(fontSize: 10));
                                },
                              ),
                            ),
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (value, meta) {
                                  return Text('${value.toInt()}s',
                                      style: const TextStyle(fontSize: 10));
                                },
                              ),
                            ),
                            topTitles: const AxisTitles(
                                sideTitles: SideTitles(showTitles: false)),
                            rightTitles: const AxisTitles(
                                sideTitles: SideTitles(showTitles: false)),
                          ),
                          borderData: FlBorderData(show: true),
                          lineBarsData: [
                            LineChartBarData(
                              spots: _networkData,
                              isCurved: true,
                              color: Colors.purple,
                              barWidth: 2,
                              dotData: const FlDotData(show: false),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildLegendItem('Network Throughput', Colors.purple),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          _buildMetricsGrid([
            {
              'title': 'Bandwidth',
              'value': '1 Gbps',
              'icon': Icons.network_check,
              'color': Colors.blue
            },
            {
              'title': 'Latency',
              'value': '12ms',
              'icon': Icons.access_time,
              'color': Colors.green
            },
            {
              'title': 'Packet Loss',
              'value': '0.01%',
              'icon': Icons.error_outline,
              'color': Colors.orange
            },
            {
              'title': 'Connections',
              'value': '247',
              'icon': Icons.device_hub,
              'color': Colors.purple
            },
          ]),
        ],
      ),
    );
  }

  Widget _buildDiskTab() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Expanded(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Disk I/O Performance',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: LineChart(
                        LineChartData(
                          gridData: const FlGridData(show: true),
                          titlesData: FlTitlesData(
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 50,
                                getTitlesWidget: (value, meta) {
                                  return Text('${value.toInt()}MB/s',
                                      style: const TextStyle(fontSize: 10));
                                },
                              ),
                            ),
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (value, meta) {
                                  return Text('${value.toInt()}s',
                                      style: const TextStyle(fontSize: 10));
                                },
                              ),
                            ),
                            topTitles: const AxisTitles(
                                sideTitles: SideTitles(showTitles: false)),
                            rightTitles: const AxisTitles(
                                sideTitles: SideTitles(showTitles: false)),
                          ),
                          borderData: FlBorderData(show: true),
                          lineBarsData: [
                            LineChartBarData(
                              spots: _diskData,
                              isCurved: true,
                              color: Colors.orange,
                              barWidth: 2,
                              dotData: const FlDotData(show: false),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildLegendItem('Disk I/O', Colors.orange),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          _buildMetricsGrid([
            {
              'title': 'Total Storage',
              'value': '2 TB',
              'icon': Icons.sd_storage,
              'color': Colors.blue
            },
            {
              'title': 'Free Space',
              'value': '1.3 TB',
              'icon': Icons.storage,
              'color': Colors.green
            },
            {
              'title': 'Read Speed',
              'value': '125 MB/s',
              'icon': Icons.download,
              'color': Colors.orange
            },
            {
              'title': 'Write Speed',
              'value': '89 MB/s',
              'icon': Icons.upload,
              'color': Colors.purple
            },
          ]),
        ],
      ),
    );
  }

  Widget _buildApplicationTab() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Response Time Trends',
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          height: 200,
                          child: BarChart(
                            BarChartData(
                              alignment: BarChartAlignment.spaceAround,
                              barGroups: List.generate(7, (index) {
                                return BarChartGroupData(
                                  x: index,
                                  barRods: [
                                    BarChartRodData(
                                      toY:
                                          100 + (index * 20) + (index * 5) % 50,
                                      color: Colors.blue,
                                      width: 20,
                                    ),
                                  ],
                                );
                              }),
                              titlesData: FlTitlesData(
                                leftTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    getTitlesWidget: (value, meta) {
                                      return Text('${value.toInt()}ms',
                                          style: const TextStyle(fontSize: 10));
                                    },
                                  ),
                                ),
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    getTitlesWidget: (value, meta) {
                                      const days = [
                                        'Mon',
                                        'Tue',
                                        'Wed',
                                        'Thu',
                                        'Fri',
                                        'Sat',
                                        'Sun'
                                      ];
                                      return Text(
                                          days[value.toInt() % days.length],
                                          style: const TextStyle(fontSize: 10));
                                    },
                                  ),
                                ),
                                topTitles: const AxisTitles(
                                    sideTitles: SideTitles(showTitles: false)),
                                rightTitles: const AxisTitles(
                                    sideTitles: SideTitles(showTitles: false)),
                              ),
                              borderData: FlBorderData(show: true),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Request Distribution',
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          height: 200,
                          child: PieChart(
                            PieChartData(
                              sections: [
                                PieChartSectionData(
                                  value: 45,
                                  title: 'API\n45%',
                                  color: Colors.blue,
                                  radius: 60,
                                ),
                                PieChartSectionData(
                                  value: 30,
                                  title: 'Web\n30%',
                                  color: Colors.green,
                                  radius: 60,
                                ),
                                PieChartSectionData(
                                  value: 25,
                                  title: 'Mobile\n25%',
                                  color: Colors.orange,
                                  radius: 60,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildMetricsGrid([
            {
              'title': 'Active Sessions',
              'value': '1,247',
              'icon': Icons.people,
              'color': Colors.blue
            },
            {
              'title': 'Avg Response',
              'value': '145ms',
              'icon': Icons.speed,
              'color': Colors.green
            },
            {
              'title': 'Error Rate',
              'value': '0.02%',
              'icon': Icons.error_outline,
              'color': Colors.orange
            },
            {
              'title': 'Uptime',
              'value': '99.9%',
              'icon': Icons.check_circle,
              'color': Colors.purple
            },
          ]),
        ],
      ),
    );
  }

  Widget _buildMetricsGrid(List<Map<String, dynamic>> metrics) {
    return SizedBox(
      height: 120,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 2.5,
          crossAxisSpacing: 16,
        ),
        itemCount: metrics.length,
        itemBuilder: (context, index) {
          final metric = metrics[index];
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    metric['icon'] as IconData,
                    color: metric['color'] as Color,
                    size: 20,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    metric['value'] as String,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: metric['color'] as Color,
                    ),
                  ),
                  Text(
                    metric['title'] as String,
                    style: const TextStyle(fontSize: 10),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  void _showPerformanceSettings() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Performance Settings'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text('Data Collection Interval'),
              subtitle: Text('2 seconds'),
              trailing: Icon(Icons.keyboard_arrow_right),
            ),
            ListTile(
              title: Text('History Retention'),
              subtitle: Text('7 days'),
              trailing: Icon(Icons.keyboard_arrow_right),
            ),
            SwitchListTile(
              title: Text('Real-time Updates'),
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

  void _exportPerformanceData() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Export Performance Data'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.file_copy),
              title: Text('Export as CSV'),
            ),
            ListTile(
              leading: Icon(Icons.picture_as_pdf),
              title: Text('Export as PDF Report'),
            ),
            ListTile(
              leading: Icon(Icons.code),
              title: Text('Export as JSON'),
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
}

class PerformanceMetric {
  final DateTime timestamp;
  final double cpuUsage;
  final double memoryUsage;
  final double diskIO;
  final double networkThroughput;
  final int responseTime;
  final int requestsPerSecond;

  PerformanceMetric({
    required this.timestamp,
    required this.cpuUsage,
    required this.memoryUsage,
    required this.diskIO,
    required this.networkThroughput,
    required this.responseTime,
    required this.requestsPerSecond,
  });
}
