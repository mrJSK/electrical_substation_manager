// screens/audit_trail_screen.dart
import 'package:flutter/material.dart';

class AuditTrailScreen extends StatefulWidget {
  const AuditTrailScreen({Key? key}) : super(key: key);

  @override
  State<AuditTrailScreen> createState() => _AuditTrailScreenState();
}

class _AuditTrailScreenState extends State<AuditTrailScreen> {
  String _selectedAction = 'All';
  String _selectedUser = 'All Users';
  String _searchQuery = '';

  final List<AuditEntry> _auditEntries = [
    AuditEntry(
      id: 'AUD-001',
      user: 'admin@company.com',
      action: 'User Created',
      resource: 'User: john.doe@company.com',
      timestamp: DateTime.now().subtract(const Duration(minutes: 10)),
      ipAddress: '192.168.1.100',
      userAgent: 'Chrome/91.0.4472.124',
      details: {
        'user_id': 'USR-12345',
        'role': 'Operator',
        'organization': 'Power Grid Corp',
      },
      severity: 'Medium',
    ),
    AuditEntry(
      id: 'AUD-002',
      user: 'operator@company.com',
      action: 'Settings Modified',
      resource: 'System Settings: Authentication',
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      ipAddress: '192.168.1.101',
      userAgent: 'Firefox/89.0',
      details: {
        'setting': 'session_timeout',
        'old_value': '30',
        'new_value': '60',
        'unit': 'minutes',
      },
      severity: 'High',
    ),
    AuditEntry(
      id: 'AUD-003',
      user: 'maintenance@company.com',
      action: 'Data Export',
      resource: 'Substation Data: Central Station',
      timestamp: DateTime.now().subtract(const Duration(hours: 5)),
      ipAddress: '192.168.1.102',
      userAgent: 'Safari/14.1.1',
      details: {
        'export_format': 'CSV',
        'record_count': '1247',
        'date_range': 'Last 30 days',
      },
      severity: 'Low',
    ),
  ];

  List<AuditEntry> get _filteredEntries {
    return _auditEntries.where((entry) {
      final matchesAction =
          _selectedAction == 'All' || entry.action == _selectedAction;
      final matchesUser =
          _selectedUser == 'All Users' || entry.user == _selectedUser;
      final matchesSearch = _searchQuery.isEmpty ||
          entry.resource.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          entry.action.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesAction && matchesUser && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Audit Trail'),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_alt),
            onPressed: _showAdvancedFilters,
            tooltip: 'Advanced Filters',
          ),
          IconButton(
            icon: const Icon(Icons.file_download),
            onPressed: _exportAuditTrail,
            tooltip: 'Export Audit Trail',
          ),
        ],
      ),
      body: Column(
        children: [
          _buildFilters(),
          _buildAuditStats(),
          Expanded(child: _buildAuditList()),
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
                flex: 2,
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: 'Search audit entries...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) => setState(() => _searchQuery = value),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: _selectedAction,
                  decoration: const InputDecoration(
                    labelText: 'Action Type',
                    border: OutlineInputBorder(),
                  ),
                  items: const [
                    DropdownMenuItem(value: 'All', child: Text('All Actions')),
                    DropdownMenuItem(
                        value: 'User Created', child: Text('User Created')),
                    DropdownMenuItem(
                        value: 'User Deleted', child: Text('User Deleted')),
                    DropdownMenuItem(
                        value: 'Settings Modified',
                        child: Text('Settings Modified')),
                    DropdownMenuItem(
                        value: 'Data Export', child: Text('Data Export')),
                    DropdownMenuItem(value: 'Login', child: Text('Login')),
                    DropdownMenuItem(value: 'Logout', child: Text('Logout')),
                  ],
                  onChanged: (value) =>
                      setState(() => _selectedAction = value!),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: _selectedUser,
                  decoration: const InputDecoration(
                    labelText: 'User',
                    border: OutlineInputBorder(),
                  ),
                  items: const [
                    DropdownMenuItem(
                        value: 'All Users', child: Text('All Users')),
                    DropdownMenuItem(
                        value: 'admin@company.com',
                        child: Text('admin@company.com')),
                    DropdownMenuItem(
                        value: 'operator@company.com',
                        child: Text('operator@company.com')),
                    DropdownMenuItem(
                        value: 'maintenance@company.com',
                        child: Text('maintenance@company.com')),
                  ],
                  onChanged: (value) => setState(() => _selectedUser = value!),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAuditStats() {
    final totalEntries = _auditEntries.length;
    final highSeverity =
        _auditEntries.where((e) => e.severity == 'High').length;
    final mediumSeverity =
        _auditEntries.where((e) => e.severity == 'Medium').length;
    final lowSeverity = _auditEntries.where((e) => e.severity == 'Low').length;

    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: _buildStatCard(
                'Total Entries', '$totalEntries', Icons.list_alt, Colors.blue),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildStatCard(
                'High Severity', '$highSeverity', Icons.error, Colors.red),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildStatCard('Medium Severity', '$mediumSeverity',
                Icons.warning, Colors.orange),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildStatCard(
                'Low Severity', '$lowSeverity', Icons.info, Colors.green),
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
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAuditList() {
    final filteredEntries = _filteredEntries;

    if (filteredEntries.isEmpty) {
      return const Center(
        child: Text('No audit entries found matching the current filters'),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: filteredEntries.length,
      itemBuilder: (context, index) {
        final entry = filteredEntries[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ExpansionTile(
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: _getSeverityColor(entry.severity).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                _getActionIcon(entry.action),
                color: _getSeverityColor(entry.severity),
                size: 20,
              ),
            ),
            title: Text(
              entry.action,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text(entry.resource),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Chip(
                      label: Text(entry.severity),
                      backgroundColor:
                          _getSeverityColor(entry.severity).withOpacity(0.1),
                      labelStyle: TextStyle(
                        color: _getSeverityColor(entry.severity),
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'by ${entry.user}',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      _formatTimestamp(entry.timestamp),
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
                    _buildDetailRow('Audit ID:', entry.id),
                    _buildDetailRow('User:', entry.user),
                    _buildDetailRow('IP Address:', entry.ipAddress),
                    _buildDetailRow('User Agent:', entry.userAgent),
                    _buildDetailRow(
                        'Timestamp:', _formatFullTimestamp(entry.timestamp)),
                    const SizedBox(height: 12),
                    const Text(
                      'Additional Details:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: entry.details.entries
                            .map((e) => Padding(
                                  padding: const EdgeInsets.only(bottom: 4),
                                  child: Text(
                                    '${e.key}: ${e.value}',
                                    style: const TextStyle(
                                      fontFamily: 'monospace',
                                      fontSize: 12,
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton.icon(
                          onPressed: () => _viewRelatedEntries(entry),
                          icon: const Icon(Icons.link, size: 16),
                          label: const Text('Related'),
                        ),
                        const SizedBox(width: 8),
                        TextButton.icon(
                          onPressed: () => _exportSingleEntry(entry),
                          icon: const Icon(Icons.download, size: 16),
                          label: const Text('Export'),
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
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  IconData _getActionIcon(String action) {
    switch (action.toLowerCase()) {
      case 'user created':
        return Icons.person_add;
      case 'user deleted':
        return Icons.person_remove;
      case 'settings modified':
        return Icons.settings;
      case 'data export':
        return Icons.file_download;
      case 'login':
        return Icons.login;
      case 'logout':
        return Icons.logout;
      default:
        return Icons.event_note;
    }
  }

  Color _getSeverityColor(String severity) {
    switch (severity) {
      case 'High':
        return Colors.red;
      case 'Medium':
        return Colors.orange;
      case 'Low':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  String _formatTimestamp(DateTime timestamp) {
    return '${timestamp.day}/${timestamp.month}/${timestamp.year} ${timestamp.hour}:${timestamp.minute.toString().padLeft(2, '0')}';
  }

  String _formatFullTimestamp(DateTime timestamp) {
    return '${timestamp.day.toString().padLeft(2, '0')}/${timestamp.month.toString().padLeft(2, '0')}/${timestamp.year} ${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')}:${timestamp.second.toString().padLeft(2, '0')}';
  }

  void _showAdvancedFilters() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Advanced Filters'),
        content: SizedBox(
          width: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Severity Level',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(value: 'All', child: Text('All Severities')),
                  DropdownMenuItem(value: 'High', child: Text('High')),
                  DropdownMenuItem(value: 'Medium', child: Text('Medium')),
                  DropdownMenuItem(value: 'Low', child: Text('Low')),
                ],
                onChanged: (value) {},
              ),
              const SizedBox(height: 16),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'IP Address',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                        labelText: 'From Date',
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.calendar_today),
                      ),
                      readOnly: true,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                        labelText: 'To Date',
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.calendar_today),
                      ),
                      readOnly: true,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Apply Filters'),
          ),
        ],
      ),
    );
  }

  void _exportAuditTrail() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Export Audit Trail'),
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

  void _viewRelatedEntries(AuditEntry entry) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Showing related entries for ${entry.id}')),
    );
  }

  void _exportSingleEntry(AuditEntry entry) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Exporting audit entry ${entry.id}')),
    );
  }
}

class AuditEntry {
  final String id;
  final String user;
  final String action;
  final String resource;
  final DateTime timestamp;
  final String ipAddress;
  final String userAgent;
  final Map<String, String> details;
  final String severity;

  AuditEntry({
    required this.id,
    required this.user,
    required this.action,
    required this.resource,
    required this.timestamp,
    required this.ipAddress,
    required this.userAgent,
    required this.details,
    required this.severity,
  });
}
