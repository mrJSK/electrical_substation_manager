// screens/settings_screen.dart
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  final String? initialTab;

  const SettingsScreen({
    Key? key,
    this.initialTab,
  }) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);

    // Set initial tab based on parameter
    if (widget.initialTab != null) {
      switch (widget.initialTab) {
        case 'general':
          _tabController.index = 0;
          break;
        case 'security':
          _tabController.index = 1;
          break;
        case 'integrations':
          _tabController.index = 2;
          break;
        case 'backup':
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
        title: const Text('System Settings'),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveAllSettings,
            tooltip: 'Save All Settings',
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
            Tab(text: 'General', icon: Icon(Icons.settings)),
            Tab(text: 'Security', icon: Icon(Icons.security)),
            Tab(
                text: 'Integrations',
                icon: Icon(Icons.integration_instructions)),
            Tab(text: 'Backup', icon: Icon(Icons.backup)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildGeneralSettings(),
          _buildSecuritySettings(),
          _buildIntegrationSettings(),
          _buildBackupSettings(),
        ],
      ),
    );
  }

  Widget _buildGeneralSettings() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // System Information Card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'System Information',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          initialValue: 'Electrical Substation Manager',
                          decoration: const InputDecoration(
                            labelText: 'System Name',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.business),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          initialValue: 'v2.1.5',
                          decoration: const InputDecoration(
                            labelText: 'Version',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.info),
                          ),
                          readOnly: true,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    initialValue:
                        'Central monitoring and management system for electrical substations',
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.description),
                    ),
                    maxLines: 2,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Display Settings Card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Display Settings',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  SwitchListTile(
                    title: const Text('Dark Mode'),
                    subtitle: const Text('Enable dark theme for the interface'),
                    value: false,
                    onChanged: (value) => setState(() {}),
                    secondary: const Icon(Icons.dark_mode),
                  ),
                  SwitchListTile(
                    title: const Text('Show Advanced Features'),
                    subtitle:
                        const Text('Display advanced configuration options'),
                    value: true,
                    onChanged: (value) => setState(() {}),
                    secondary: const Icon(Icons.tune),
                  ),
                  const Divider(),
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: 'English',
                          decoration: const InputDecoration(
                            labelText: 'Language',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.language),
                          ),
                          items: const [
                            DropdownMenuItem(
                                value: 'English', child: Text('English')),
                            DropdownMenuItem(
                                value: 'Spanish', child: Text('Spanish')),
                            DropdownMenuItem(
                                value: 'French', child: Text('French')),
                          ],
                          onChanged: (value) {},
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: 'UTC',
                          decoration: const InputDecoration(
                            labelText: 'Timezone',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.access_time),
                          ),
                          items: const [
                            DropdownMenuItem(value: 'UTC', child: Text('UTC')),
                            DropdownMenuItem(value: 'EST', child: Text('EST')),
                            DropdownMenuItem(value: 'PST', child: Text('PST')),
                          ],
                          onChanged: (value) {},
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Notification Settings Card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Notification Settings',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  SwitchListTile(
                    title: const Text('Email Notifications'),
                    subtitle: const Text('Send email alerts for system events'),
                    value: true,
                    onChanged: (value) => setState(() {}),
                    secondary: const Icon(Icons.email),
                  ),
                  SwitchListTile(
                    title: const Text('SMS Notifications'),
                    subtitle: const Text('Send SMS for critical alerts'),
                    value: false,
                    onChanged: (value) => setState(() {}),
                    secondary: const Icon(Icons.sms),
                  ),
                  SwitchListTile(
                    title: const Text('Push Notifications'),
                    subtitle: const Text('Browser push notifications'),
                    value: true,
                    onChanged: (value) => setState(() {}),
                    secondary: const Icon(Icons.notifications),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSecuritySettings() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Authentication Settings Card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Authentication Settings',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  SwitchListTile(
                    title: const Text('Two-Factor Authentication'),
                    subtitle: const Text('Require 2FA for all admin users'),
                    value: true,
                    onChanged: (value) => setState(() {}),
                    secondary: const Icon(Icons.security),
                  ),
                  SwitchListTile(
                    title: const Text('Force Password Reset'),
                    subtitle: const Text('Force password reset every 90 days'),
                    value: false,
                    onChanged: (value) => setState(() {}),
                    secondary: const Icon(Icons.password),
                  ),
                  const Divider(),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          initialValue: '30',
                          decoration: const InputDecoration(
                            labelText: 'Session Timeout (minutes)',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.timer),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          initialValue: '5',
                          decoration: const InputDecoration(
                            labelText: 'Max Login Attempts',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.lock),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Password Policy Card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Password Policy',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          initialValue: '8',
                          decoration: const InputDecoration(
                            labelText: 'Minimum Length',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          initialValue: '5',
                          decoration: const InputDecoration(
                            labelText: 'Password History',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  CheckboxListTile(
                    title: const Text('Require Uppercase Letters'),
                    value: true,
                    onChanged: (value) => setState(() {}),
                  ),
                  CheckboxListTile(
                    title: const Text('Require Numbers'),
                    value: true,
                    onChanged: (value) => setState(() {}),
                  ),
                  CheckboxListTile(
                    title: const Text('Require Special Characters'),
                    value: false,
                    onChanged: (value) => setState(() {}),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Access Control Card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Access Control',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  const Text('Allowed IP Ranges:'),
                  const SizedBox(height: 8),
                  TextFormField(
                    initialValue: '192.168.1.0/24, 10.0.0.0/8',
                    decoration: const InputDecoration(
                      hintText: 'Enter IP ranges separated by commas',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.public),
                    ),
                    maxLines: 2,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => _showAuditLog(),
                          icon: const Icon(Icons.history),
                          label: const Text('View Audit Log'),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => _showActiveSessions(),
                          icon: const Icon(Icons.people),
                          label: const Text('Active Sessions'),
                        ),
                      ),
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

  Widget _buildIntegrationSettings() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // SCADA Integration Card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.electrical_services,
                          color: Colors.blue.shade700),
                      const SizedBox(width: 8),
                      Text(
                        'SCADA Integration',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const Spacer(),
                      Chip(
                        label: const Text('Connected'),
                        backgroundColor: Colors.green.shade100,
                        labelStyle: TextStyle(color: Colors.green.shade700),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          initialValue: '192.168.100.10',
                          decoration: const InputDecoration(
                            labelText: 'SCADA Server IP',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.dns),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          initialValue: '502',
                          decoration: const InputDecoration(
                            labelText: 'Port',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.electrical_services),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SwitchListTile(
                    title: const Text('Real-time Data Sync'),
                    subtitle: const Text('Sync data every 5 seconds'),
                    value: true,
                    onChanged: (value) => setState(() {}),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => _testConnection('SCADA'),
                        child: const Text('Test Connection'),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () => _reconnectService('SCADA'),
                        child: const Text('Reconnect'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Database Integration Card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.storage, color: Colors.green.shade700),
                      const SizedBox(width: 8),
                      Text(
                        'Database Configuration',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const Spacer(),
                      Chip(
                        label: const Text('Active'),
                        backgroundColor: Colors.green.shade100,
                        labelStyle: TextStyle(color: Colors.green.shade700),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: 'PostgreSQL',
                          decoration: const InputDecoration(
                            labelText: 'Database Type',
                            border: OutlineInputBorder(),
                          ),
                          items: const [
                            DropdownMenuItem(
                                value: 'PostgreSQL', child: Text('PostgreSQL')),
                            DropdownMenuItem(
                                value: 'MySQL', child: Text('MySQL')),
                            DropdownMenuItem(
                                value: 'Oracle', child: Text('Oracle')),
                          ],
                          onChanged: (value) {},
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          initialValue: 'db.substation.local',
                          decoration: const InputDecoration(
                            labelText: 'Host',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Email Settings Card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.email, color: Colors.orange.shade700),
                      const SizedBox(width: 8),
                      Text(
                        'Email Configuration',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          initialValue: 'smtp.company.com',
                          decoration: const InputDecoration(
                            labelText: 'SMTP Server',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          initialValue: '587',
                          decoration: const InputDecoration(
                            labelText: 'Port',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    initialValue: 'alerts@substation.com',
                    decoration: const InputDecoration(
                      labelText: 'From Email',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SwitchListTile(
                    title: const Text('Use TLS/SSL'),
                    value: true,
                    onChanged: (value) => setState(() {}),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackupSettings() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Backup Configuration Card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Backup Configuration',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  SwitchListTile(
                    title: const Text('Automatic Backups'),
                    subtitle: const Text('Enable scheduled automatic backups'),
                    value: true,
                    onChanged: (value) => setState(() {}),
                    secondary: const Icon(Icons.backup),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: 'Daily',
                          decoration: const InputDecoration(
                            labelText: 'Backup Frequency',
                            border: OutlineInputBorder(),
                          ),
                          items: const [
                            DropdownMenuItem(
                                value: 'Hourly', child: Text('Hourly')),
                            DropdownMenuItem(
                                value: 'Daily', child: Text('Daily')),
                            DropdownMenuItem(
                                value: 'Weekly', child: Text('Weekly')),
                            DropdownMenuItem(
                                value: 'Monthly', child: Text('Monthly')),
                          ],
                          onChanged: (value) {},
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          initialValue: '02:00',
                          decoration: const InputDecoration(
                            labelText: 'Backup Time',
                            border: OutlineInputBorder(),
                            suffixIcon: Icon(Icons.access_time),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    initialValue: '/backups/substation/',
                    decoration: const InputDecoration(
                      labelText: 'Backup Location',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.folder),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Backup History Card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Recent Backups',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const Spacer(),
                      ElevatedButton.icon(
                        onPressed: () => _createManualBackup(),
                        icon: const Icon(Icons.backup),
                        label: const Text('Create Backup'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue.shade700,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  DataTable(
                    columns: const [
                      DataColumn(label: Text('Date')),
                      DataColumn(label: Text('Type')),
                      DataColumn(label: Text('Size')),
                      DataColumn(label: Text('Status')),
                      DataColumn(label: Text('Actions')),
                    ],
                    rows: [
                      DataRow(cells: [
                        const DataCell(Text('2024-01-15 02:00')),
                        const DataCell(Text('Automatic')),
                        const DataCell(Text('2.4 GB')),
                        DataCell(Chip(
                          label: const Text('Success'),
                          backgroundColor: Colors.green.shade100,
                          labelStyle: TextStyle(color: Colors.green.shade700),
                        )),
                        DataCell(Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.download),
                              onPressed: () =>
                                  _downloadBackup('backup_20240115'),
                            ),
                            IconButton(
                              icon: const Icon(Icons.restore),
                              onPressed: () =>
                                  _restoreBackup('backup_20240115'),
                            ),
                          ],
                        )),
                      ]),
                      DataRow(cells: [
                        const DataCell(Text('2024-01-14 02:00')),
                        const DataCell(Text('Automatic')),
                        const DataCell(Text('2.3 GB')),
                        DataCell(Chip(
                          label: const Text('Success'),
                          backgroundColor: Colors.green.shade100,
                          labelStyle: TextStyle(color: Colors.green.shade700),
                        )),
                        DataCell(Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.download),
                              onPressed: () =>
                                  _downloadBackup('backup_20240114'),
                            ),
                            IconButton(
                              icon: const Icon(Icons.restore),
                              onPressed: () =>
                                  _restoreBackup('backup_20240114'),
                            ),
                          ],
                        )),
                      ]),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Retention Policy Card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Retention Policy',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          initialValue: '30',
                          decoration: const InputDecoration(
                            labelText: 'Keep Daily Backups (days)',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          initialValue: '12',
                          decoration: const InputDecoration(
                            labelText: 'Keep Monthly Backups (months)',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SwitchListTile(
                    title: const Text('Compress Backups'),
                    subtitle: const Text('Reduce backup file size'),
                    value: true,
                    onChanged: (value) => setState(() {}),
                  ),
                  SwitchListTile(
                    title: const Text('Encrypt Backups'),
                    subtitle: const Text('Encrypt backup files'),
                    value: true,
                    onChanged: (value) => setState(() {}),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _saveAllSettings() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Save Settings'),
        content: const Text(
            'Are you sure you want to save all settings? This will apply the changes immediately.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Settings saved successfully')),
              );
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _testConnection(String service) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Testing $service Connection'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Testing connection...'),
          ],
        ),
      ),
    );

    // Simulate connection test
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$service connection test successful')),
      );
    });
  }

  void _reconnectService(String service) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Reconnecting to $service...')),
    );
  }

  void _showAuditLog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Audit Log'),
        content: SizedBox(
          width: double.maxFinite,
          height: 400,
          child: ListView(
            children: const [
              ListTile(
                leading: Icon(Icons.login),
                title: Text('User admin logged in'),
                subtitle: Text('2024-01-15 09:30:25'),
              ),
              ListTile(
                leading: Icon(Icons.edit),
                title: Text('Settings modified'),
                subtitle: Text('2024-01-15 09:25:10'),
              ),
              ListTile(
                leading: Icon(Icons.backup),
                title: Text('Backup completed'),
                subtitle: Text('2024-01-15 02:00:15'),
              ),
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

  void _showActiveSessions() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Active Sessions'),
        content: SizedBox(
          width: double.maxFinite,
          height: 300,
          child: ListView(
            children: const [
              ListTile(
                leading: Icon(Icons.person),
                title: Text('admin@company.com'),
                subtitle: Text('192.168.1.100 - Chrome\nActive for 2h 15m'),
                trailing: Icon(Icons.circle, color: Colors.green, size: 12),
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text('operator@company.com'),
                subtitle: Text('192.168.1.101 - Firefox\nActive for 45m'),
                trailing: Icon(Icons.circle, color: Colors.green, size: 12),
              ),
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

  void _createManualBackup() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create Manual Backup'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Creating backup...'),
          ],
        ),
      ),
    );

    Future.delayed(const Duration(seconds: 5), () {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Manual backup created successfully')),
      );
    });
  }

  void _downloadBackup(String backupId) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Downloading backup $backupId...')),
    );
  }

  void _restoreBackup(String backupId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Restore Backup'),
        content: Text(
            'Are you sure you want to restore backup $backupId? This will overwrite current data.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Restoring backup $backupId...')),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
            child: const Text('Restore', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
