// screens/analytics_screen.dart
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class AnalyticsScreen extends StatefulWidget {
  final String? initialTab;

  const AnalyticsScreen({
    Key? key,
    this.initialTab,
  }) : super(key: key);

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);

    // Set initial tab based on parameter
    if (widget.initialTab != null) {
      switch (widget.initialTab) {
        case 'users':
          _tabController.index = 0;
          break;
        case 'organizations':
          _tabController.index = 1;
          break;
        case 'substations':
          _tabController.index = 2;
          break;
        case 'performance':
          _tabController.index = 3;
          break;
      }
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Analytics & Reports'),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.file_download),
            onPressed: _exportData,
            tooltip: 'Export Data',
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => setState(() {}),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(text: 'Users', icon: Icon(Icons.people)),
            Tab(text: 'Organizations', icon: Icon(Icons.business)),
            Tab(text: 'Substations', icon: Icon(Icons.electrical_services)),
            Tab(text: 'Performance', icon: Icon(Icons.analytics)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildUserAnalytics(),
          _buildOrganizationAnalytics(),
          _buildSubstationAnalytics(),
          _buildPerformanceAnalytics(),
        ],
      ),
    );
  }

  Widget _buildUserAnalytics() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Summary Cards
          Row(
            children: [
              Expanded(
                  child: _buildSummaryCard(
                      'Total Users', '1,247', Icons.people, Colors.blue)),
              const SizedBox(width: 16),
              Expanded(
                  child: _buildSummaryCard(
                      'Active Users', '892', Icons.check, Colors.green)),
              const SizedBox(width: 16),
              Expanded(
                  child: _buildSummaryCard('New This Month', '156',
                      Icons.person_add, Colors.orange)),
              const SizedBox(width: 16),
              Expanded(
                  child: _buildSummaryCard(
                      'Pending Approval', '23', Icons.pending, Colors.red)),
            ],
          ),
          const SizedBox(height: 24),

          // User Growth Chart
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'User Growth Over Time',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 300,
                    child: LineChart(
                      LineChartData(
                        gridData: FlGridData(show: true),
                        titlesData: FlTitlesData(
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: true),
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                const months = [
                                  'Jan',
                                  'Feb',
                                  'Mar',
                                  'Apr',
                                  'May',
                                  'Jun'
                                ];
                                if (value.toInt() < months.length) {
                                  return Text(months[value.toInt()]);
                                }
                                return const Text('');
                              },
                            ),
                          ),
                          topTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false)),
                          rightTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false)),
                        ),
                        borderData: FlBorderData(show: true),
                        lineBarsData: [
                          LineChartBarData(
                            spots: const [
                              FlSpot(0, 800),
                              FlSpot(1, 850),
                              FlSpot(2, 920),
                              FlSpot(3, 1050),
                              FlSpot(4, 1150),
                              FlSpot(5, 1247),
                            ],
                            isCurved: true,
                            color: Colors.blue,
                            barWidth: 3,
                            dotData: FlDotData(show: true),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // User Role Distribution
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
                          'User Role Distribution',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          height: 200,
                          child: PieChart(
                            PieChartData(
                              sections: [
                                PieChartSectionData(
                                  value: 45,
                                  title: 'Viewers\n45%',
                                  color: Colors.blue,
                                  radius: 80,
                                ),
                                PieChartSectionData(
                                  value: 35,
                                  title: 'Operators\n35%',
                                  color: Colors.green,
                                  radius: 80,
                                ),
                                PieChartSectionData(
                                  value: 20,
                                  title: 'Admins\n20%',
                                  color: Colors.orange,
                                  radius: 80,
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
              const SizedBox(width: 16),
              Expanded(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Recent User Activities',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 16),
                        _buildActivityItem(
                            'John Doe', 'Logged in', '2 mins ago'),
                        _buildActivityItem(
                            'Jane Smith', 'Updated profile', '15 mins ago'),
                        _buildActivityItem(
                            'Mike Johnson', 'Created report', '1 hour ago'),
                        _buildActivityItem(
                            'Sarah Wilson', 'Approved user', '2 hours ago'),
                        _buildActivityItem(
                            'Tom Brown', 'Modified settings', '3 hours ago'),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOrganizationAnalytics() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Organization Summary
          Row(
            children: [
              Expanded(
                  child: _buildSummaryCard('Total Organizations', '45',
                      Icons.business, Colors.purple)),
              const SizedBox(width: 16),
              Expanded(
                  child: _buildSummaryCard('Active Organizations', '42',
                      Icons.business_center, Colors.green)),
              const SizedBox(width: 16),
              Expanded(
                  child: _buildSummaryCard('New This Quarter', '8',
                      Icons.add_business, Colors.blue)),
              const SizedBox(width: 16),
              Expanded(
                  child: _buildSummaryCard(
                      'Total Users', '1,247', Icons.people, Colors.orange)),
            ],
          ),
          const SizedBox(height: 24),

          // Organization Size Distribution
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Organization Size Distribution',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 300,
                    child: BarChart(
                      BarChartData(
                        alignment: BarChartAlignment.spaceAround,
                        barGroups: [
                          BarChartGroupData(x: 0, barRods: [
                            BarChartRodData(
                                toY: 12, color: Colors.blue, width: 30)
                          ]),
                          BarChartGroupData(x: 1, barRods: [
                            BarChartRodData(
                                toY: 18, color: Colors.green, width: 30)
                          ]),
                          BarChartGroupData(x: 2, barRods: [
                            BarChartRodData(
                                toY: 10, color: Colors.orange, width: 30)
                          ]),
                          BarChartGroupData(x: 3, barRods: [
                            BarChartRodData(
                                toY: 5, color: Colors.red, width: 30)
                          ]),
                        ],
                        titlesData: FlTitlesData(
                          leftTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: true)),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                const sizes = [
                                  'Small\n(1-10)',
                                  'Medium\n(11-50)',
                                  'Large\n(51-200)',
                                  'Enterprise\n(200+)'
                                ];
                                if (value.toInt() < sizes.length) {
                                  return Text(sizes[value.toInt()],
                                      textAlign: TextAlign.center);
                                }
                                return const Text('');
                              },
                            ),
                          ),
                          topTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false)),
                          rightTitles: AxisTitles(
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
          const SizedBox(height: 24),

          // Top Organizations
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Top Organizations by User Count',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  DataTable(
                    columns: const [
                      DataColumn(label: Text('Organization')),
                      DataColumn(label: Text('Users'), numeric: true),
                      DataColumn(label: Text('Substations'), numeric: true),
                      DataColumn(label: Text('Status')),
                    ],
                    rows: const [
                      DataRow(cells: [
                        DataCell(Text('Power Grid Corp')),
                        DataCell(Text('247')),
                        DataCell(Text('15')),
                        DataCell(Chip(
                            label: Text('Active'),
                            backgroundColor: Colors.green)),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('Energy Systems Ltd')),
                        DataCell(Text('186')),
                        DataCell(Text('12')),
                        DataCell(Chip(
                            label: Text('Active'),
                            backgroundColor: Colors.green)),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('Metro Electric')),
                        DataCell(Text('124')),
                        DataCell(Text('8')),
                        DataCell(Chip(
                            label: Text('Active'),
                            backgroundColor: Colors.green)),
                      ]),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubstationAnalytics() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Substation Summary
          Row(
            children: [
              Expanded(
                  child: _buildSummaryCard('Total Substations', '89',
                      Icons.electrical_services, Colors.indigo)),
              const SizedBox(width: 16),
              Expanded(
                  child: _buildSummaryCard(
                      'Online', '82', Icons.power, Colors.green)),
              const SizedBox(width: 16),
              Expanded(
                  child: _buildSummaryCard(
                      'Under Maintenance', '5', Icons.build, Colors.orange)),
              const SizedBox(width: 16),
              Expanded(
                  child: _buildSummaryCard(
                      'Offline', '2', Icons.power_off, Colors.red)),
            ],
          ),
          const SizedBox(height: 24),

          // Status Distribution and Voltage Levels
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
                          'Status Distribution',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          height: 200,
                          child: PieChart(
                            PieChartData(
                              sections: [
                                PieChartSectionData(
                                  value: 82,
                                  title: 'Online\n92%',
                                  color: Colors.green,
                                  radius: 80,
                                ),
                                PieChartSectionData(
                                  value: 5,
                                  title: 'Maintenance\n6%',
                                  color: Colors.orange,
                                  radius: 80,
                                ),
                                PieChartSectionData(
                                  value: 2,
                                  title: 'Offline\n2%',
                                  color: Colors.red,
                                  radius: 80,
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
              const SizedBox(width: 16),
              Expanded(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Voltage Level Distribution',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          height: 200,
                          child: BarChart(
                            BarChartData(
                              alignment: BarChartAlignment.spaceAround,
                              barGroups: [
                                BarChartGroupData(x: 0, barRods: [
                                  BarChartRodData(
                                      toY: 25, color: Colors.blue, width: 25)
                                ]),
                                BarChartGroupData(x: 1, barRods: [
                                  BarChartRodData(
                                      toY: 35, color: Colors.green, width: 25)
                                ]),
                                BarChartGroupData(x: 2, barRods: [
                                  BarChartRodData(
                                      toY: 20, color: Colors.orange, width: 25)
                                ]),
                                BarChartGroupData(x: 3, barRods: [
                                  BarChartRodData(
                                      toY: 9, color: Colors.purple, width: 25)
                                ]),
                              ],
                              titlesData: FlTitlesData(
                                leftTitles: AxisTitles(
                                    sideTitles: SideTitles(showTitles: true)),
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    getTitlesWidget: (value, meta) {
                                      const levels = [
                                        '66kV',
                                        '132kV',
                                        '220kV',
                                        '400kV'
                                      ];
                                      if (value.toInt() < levels.length) {
                                        return Text(levels[value.toInt()]);
                                      }
                                      return const Text('');
                                    },
                                  ),
                                ),
                                topTitles: AxisTitles(
                                    sideTitles: SideTitles(showTitles: false)),
                                rightTitles: AxisTitles(
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
            ],
          ),
          const SizedBox(height: 24),

          // Maintenance Schedule
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Upcoming Maintenance Schedule',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  DataTable(
                    columns: const [
                      DataColumn(label: Text('Substation')),
                      DataColumn(label: Text('Type')),
                      DataColumn(label: Text('Scheduled Date')),
                      DataColumn(label: Text('Priority')),
                    ],
                    rows: const [
                      DataRow(cells: [
                        DataCell(Text('Central Substation')),
                        DataCell(Text('Routine')),
                        DataCell(Text('15/08/2025')),
                        DataCell(Chip(
                            label: Text('Medium'),
                            backgroundColor: Colors.orange)),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('North Grid Station')),
                        DataCell(Text('Emergency')),
                        DataCell(Text('18/08/2025')),
                        DataCell(Chip(
                            label: Text('High'), backgroundColor: Colors.red)),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('East Distribution')),
                        DataCell(Text('Inspection')),
                        DataCell(Text('22/08/2025')),
                        DataCell(Chip(
                            label: Text('Low'), backgroundColor: Colors.green)),
                      ]),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceAnalytics() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Performance Summary
          Row(
            children: [
              Expanded(
                  child: _buildSummaryCard('System Uptime', '99.8%',
                      Icons.trending_up, Colors.green)),
              const SizedBox(width: 16),
              Expanded(
                  child: _buildSummaryCard(
                      'Avg Response Time', '1.2s', Icons.speed, Colors.blue)),
              const SizedBox(width: 16),
              Expanded(
                  child: _buildSummaryCard('Total Alerts', '15',
                      Icons.notifications, Colors.orange)),
              const SizedBox(width: 16),
              Expanded(
                  child: _buildSummaryCard(
                      'Energy Efficiency', '94.5%', Icons.eco, Colors.purple)),
            ],
          ),
          const SizedBox(height: 24),

          // Performance Trends
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'System Performance Trends',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 300,
                    child: LineChart(
                      LineChartData(
                        gridData: FlGridData(show: true),
                        titlesData: FlTitlesData(
                          leftTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: true)),
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
                                if (value.toInt() < days.length) {
                                  return Text(days[value.toInt()]);
                                }
                                return const Text('');
                              },
                            ),
                          ),
                          topTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false)),
                          rightTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false)),
                        ),
                        borderData: FlBorderData(show: true),
                        lineBarsData: [
                          LineChartBarData(
                            spots: const [
                              FlSpot(0, 99.5),
                              FlSpot(1, 99.7),
                              FlSpot(2, 99.8),
                              FlSpot(3, 99.6),
                              FlSpot(4, 99.9),
                              FlSpot(5, 99.8),
                              FlSpot(6, 99.8),
                            ],
                            isCurved: true,
                            color: Colors.green,
                            barWidth: 3,
                            dotData: FlDotData(show: true),
                          ),
                          LineChartBarData(
                            spots: const [
                              FlSpot(0, 1.5),
                              FlSpot(1, 1.3),
                              FlSpot(2, 1.2),
                              FlSpot(3, 1.4),
                              FlSpot(4, 1.1),
                              FlSpot(5, 1.2),
                              FlSpot(6, 1.2),
                            ],
                            isCurved: true,
                            color: Colors.blue,
                            barWidth: 3,
                            dotData: FlDotData(show: true),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildLegendItem('Uptime (%)', Colors.green),
                      const SizedBox(width: 24),
                      _buildLegendItem('Response Time (s)', Colors.blue),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Alert Summary
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Recent System Alerts',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  DataTable(
                    columns: const [
                      DataColumn(label: Text('Alert Type')),
                      DataColumn(label: Text('Location')),
                      DataColumn(label: Text('Severity')),
                      DataColumn(label: Text('Time')),
                      DataColumn(label: Text('Status')),
                    ],
                    rows: const [
                      DataRow(cells: [
                        DataCell(Text('High Temperature')),
                        DataCell(Text('Central Substation')),
                        DataCell(Chip(
                            label: Text('High'), backgroundColor: Colors.red)),
                        DataCell(Text('2 mins ago')),
                        DataCell(Chip(
                            label: Text('Active'),
                            backgroundColor: Colors.orange)),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('Voltage Fluctuation')),
                        DataCell(Text('North Grid')),
                        DataCell(Chip(
                            label: Text('Medium'),
                            backgroundColor: Colors.orange)),
                        DataCell(Text('15 mins ago')),
                        DataCell(Chip(
                            label: Text('Resolved'),
                            backgroundColor: Colors.green)),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('Equipment Fault')),
                        DataCell(Text('East Distribution')),
                        DataCell(Chip(
                            label: Text('Low'), backgroundColor: Colors.green)),
                        DataCell(Text('1 hour ago')),
                        DataCell(Chip(
                            label: Text('Under Review'),
                            backgroundColor: Colors.blue)),
                      ]),
                    ],
                  ),
                ],
              ),
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

  Widget _buildActivityItem(String user, String action, String time) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: Colors.blue.shade100,
            child: Text(
              user.substring(0, 1),
              style: TextStyle(color: Colors.blue.shade700, fontSize: 12),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(action, style: TextStyle(color: Colors.grey.shade600)),
              ],
            ),
          ),
          Text(time,
              style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
        ],
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
        Text(label),
      ],
    );
  }

  void _exportData() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Export Data'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.file_copy),
              title: Text('Export as CSV'),
            ),
            ListTile(
              leading: Icon(Icons.picture_as_pdf),
              title: Text('Export as PDF'),
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
}
