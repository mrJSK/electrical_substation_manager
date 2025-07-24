// screens/reports_screen.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({Key? key}) : super(key: key);

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  final List<ReportCategory> _reportCategories = [
    ReportCategory(
      title: 'User Activity Reports',
      description:
          'Track user login patterns, session durations, and activity trends',
      icon: Icons.people_outline,
      color: Colors.blue,
      route: 'user-activity-report',
      reportCount: 15,
      lastGenerated: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    ReportCategory(
      title: 'System Logs',
      description: 'Monitor system events, errors, and performance metrics',
      icon: Icons.description,
      color: Colors.green,
      route: 'system-logs',
      reportCount: 8,
      lastGenerated: DateTime.now().subtract(const Duration(minutes: 30)),
    ),
    ReportCategory(
      title: 'Audit Trail',
      description: 'Comprehensive tracking of all system changes and actions',
      icon: Icons.security,
      color: Colors.orange,
      route: 'audit-trail',
      reportCount: 23,
      lastGenerated: DateTime.now().subtract(const Duration(hours: 1)),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reports & Documentation'),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.schedule),
            onPressed: _showScheduledReports,
            tooltip: 'Scheduled Reports',
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: _showReportSettings,
            tooltip: 'Report Settings',
          ),
        ],
      ),
      body: Column(
        children: [
          _buildReportSummary(),
          Expanded(child: _buildReportCategories()),
        ],
      ),
    );
  }

  Widget _buildReportSummary() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.grey.shade50,
      child: Row(
        children: [
          Expanded(
            child: _buildSummaryCard(
              'Total Reports',
              '46',
              Icons.assignment,
              Colors.blue,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildSummaryCard(
              'Generated Today',
              '12',
              Icons.today,
              Colors.green,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildSummaryCard(
              'Scheduled',
              '8',
              Icons.schedule,
              Colors.orange,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildSummaryCard(
              'Automated',
              '15',
              Icons.autorenew,
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

  Widget _buildReportCategories() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _reportCategories.length,
      itemBuilder: (context, index) {
        final category = _reportCategories[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          child: InkWell(
            onTap: () => context.goNamed(category.route),
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: category.color.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          category.icon,
                          size: 32,
                          color: category.color,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              category.title,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              category.description,
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey.shade400,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Chip(
                        label: Text('${category.reportCount} reports'),
                        backgroundColor: category.color.withOpacity(0.1),
                        labelStyle: TextStyle(color: category.color),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Last generated: ${_formatDateTime(category.lastGenerated)}',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  String _formatDateTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else {
      return '${difference.inDays} days ago';
    }
  }

  void _showScheduledReports() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Scheduled Reports'),
        content: SizedBox(
          width: double.maxFinite,
          height: 300,
          child: ListView(
            children: const [
              ListTile(
                leading: Icon(Icons.schedule, color: Colors.blue),
                title: Text('Daily User Activity Report'),
                subtitle: Text('Every day at 6:00 AM'),
                trailing: Chip(label: Text('Active')),
              ),
              ListTile(
                leading: Icon(Icons.schedule, color: Colors.green),
                title: Text('Weekly System Performance'),
                subtitle: Text('Every Monday at 8:00 AM'),
                trailing: Chip(label: Text('Active')),
              ),
              ListTile(
                leading: Icon(Icons.schedule, color: Colors.orange),
                title: Text('Monthly Audit Summary'),
                subtitle: Text('First day of each month'),
                trailing: Chip(label: Text('Active')),
              ),
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
              // Navigate to schedule management
            },
            child: const Text('Manage Schedules'),
          ),
        ],
      ),
    );
  }

  void _showReportSettings() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Report Settings'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SwitchListTile(
              title: Text('Email Notifications'),
              subtitle: Text('Send reports via email'),
              value: true,
              onChanged: null,
            ),
            SwitchListTile(
              title: Text('Auto-generate Reports'),
              subtitle: Text('Generate reports automatically'),
              value: true,
              onChanged: null,
            ),
            SwitchListTile(
              title: Text('Include Charts'),
              subtitle: Text('Add visual charts to reports'),
              value: false,
              onChanged: null,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}

class ReportCategory {
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final String route;
  final int reportCount;
  final DateTime lastGenerated;

  ReportCategory({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.route,
    required this.reportCount,
    required this.lastGenerated,
  });
}
