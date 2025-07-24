// screens/user_activity_report_screen.dart
import 'package:flutter/material.dart';

class UserActivityReportScreen extends StatefulWidget {
  const UserActivityReportScreen({Key? key}) : super(key: key);

  @override
  State<UserActivityReportScreen> createState() =>
      _UserActivityReportScreenState();
}

class _UserActivityReportScreenState extends State<UserActivityReportScreen> {
  String _selectedPeriod = 'Last 7 Days';
  String _selectedReportType = 'All Activities';

  final List<UserActivity> _activities = [
    UserActivity(
      user: 'John Doe',
      email: 'john@company.com',
      action: 'Login',
      timestamp: DateTime.now().subtract(const Duration(minutes: 15)),
      ipAddress: '192.168.1.100',
      location: 'New York, US',
      device: 'Chrome Browser',
    ),
    UserActivity(
      user: 'Jane Smith',
      email: 'jane@company.com',
      action: 'Updated Profile',
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      ipAddress: '192.168.1.101',
      location: 'California, US',
      device: 'Firefox Browser',
    ),
    UserActivity(
      user: 'Bob Johnson',
      email: 'bob@company.com',
      action: 'Created Report',
      timestamp: DateTime.now().subtract(const Duration(hours: 5)),
      ipAddress: '192.168.1.102',
      location: 'Texas, US',
      device: 'Safari Browser',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Activity Reports'),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.file_download),
            onPressed: _exportReport,
            tooltip: 'Export Report',
          ),
          IconButton(
            icon: const Icon(Icons.print),
            onPressed: _printReport,
            tooltip: 'Print Report',
          ),
        ],
      ),
      body: Column(
        children: [
          _buildFilters(),
          _buildActivityStats(),
          Expanded(child: _buildActivityTable()),
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
            child: DropdownButtonFormField<String>(
              value: _selectedPeriod,
              decoration: const InputDecoration(
                labelText: 'Time Period',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.calendar_today),
              ),
              items: const [
                DropdownMenuItem(
                    value: 'Last 24 Hours', child: Text('Last 24 Hours')),
                DropdownMenuItem(
                    value: 'Last 7 Days', child: Text('Last 7 Days')),
                DropdownMenuItem(
                    value: 'Last 30 Days', child: Text('Last 30 Days')),
                DropdownMenuItem(
                    value: 'Custom Range', child: Text('Custom Range')),
              ],
              onChanged: (value) => setState(() => _selectedPeriod = value!),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: DropdownButtonFormField<String>(
              value: _selectedReportType,
              decoration: const InputDecoration(
                labelText: 'Activity Type',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.filter_list),
              ),
              items: const [
                DropdownMenuItem(
                    value: 'All Activities', child: Text('All Activities')),
                DropdownMenuItem(
                    value: 'Login/Logout', child: Text('Login/Logout')),
                DropdownMenuItem(
                    value: 'Profile Updates', child: Text('Profile Updates')),
                DropdownMenuItem(
                    value: 'Data Access', child: Text('Data Access')),
                DropdownMenuItem(
                    value: 'Settings Changes', child: Text('Settings Changes')),
              ],
              onChanged: (value) =>
                  setState(() => _selectedReportType = value!),
            ),
          ),
          const SizedBox(width: 16),
          ElevatedButton.icon(
            onPressed: _generateReport,
            icon: const Icon(Icons.refresh),
            label: const Text('Refresh'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue.shade700,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityStats() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: _buildStatCard(
              'Total Activities',
              '1,247',
              Icons.work_history,
              Colors.blue,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildStatCard(
              'Unique Users',
              '89',
              Icons.people,
              Colors.green,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildStatCard(
              'Peak Hour',
              '2-3 PM',
              Icons.trending_up,
              Colors.orange,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildStatCard(
              'Failed Logins',
              '12',
              Icons.error,
              Colors.red,
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

  Widget _buildActivityTable() {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Recent User Activities',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('User')),
                  DataColumn(label: Text('Action')),
                  DataColumn(label: Text('Timestamp')),
                  DataColumn(label: Text('IP Address')),
                  DataColumn(label: Text('Location')),
                  DataColumn(label: Text('Device')),
                ],
                rows: _activities
                    .map((activity) => DataRow(
                          cells: [
                            DataCell(
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    activity.user,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    activity.email,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            DataCell(
                              Chip(
                                label: Text(activity.action),
                                backgroundColor:
                                    _getActionColor(activity.action)
                                        .withOpacity(0.1),
                                labelStyle: TextStyle(
                                    color: _getActionColor(activity.action)),
                              ),
                            ),
                            DataCell(
                                Text(_formatTimestamp(activity.timestamp))),
                            DataCell(Text(activity.ipAddress)),
                            DataCell(Text(activity.location)),
                            DataCell(Text(activity.device)),
                          ],
                        ))
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getActionColor(String action) {
    switch (action.toLowerCase()) {
      case 'login':
        return Colors.green;
      case 'logout':
        return Colors.orange;
      case 'updated profile':
        return Colors.blue;
      case 'created report':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  String _formatTimestamp(DateTime timestamp) {
    return '${timestamp.day}/${timestamp.month}/${timestamp.year} ${timestamp.hour}:${timestamp.minute.toString().padLeft(2, '0')}';
  }

  void _generateReport() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Generating user activity report...')),
    );
  }

  void _exportReport() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Export Report'),
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

  void _printReport() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Preparing report for printing...')),
    );
  }
}

class UserActivity {
  final String user;
  final String email;
  final String action;
  final DateTime timestamp;
  final String ipAddress;
  final String location;
  final String device;

  UserActivity({
    required this.user,
    required this.email,
    required this.action,
    required this.timestamp,
    required this.ipAddress,
    required this.location,
    required this.device,
  });
}
