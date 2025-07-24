// screens/substations_screen.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SubstationsScreen extends StatefulWidget {
  const SubstationsScreen({Key? key}) : super(key: key);

  @override
  State<SubstationsScreen> createState() => _SubstationsScreenState();
}

class _SubstationsScreenState extends State<SubstationsScreen> {
  final List<Substation> _substations = [
    Substation(
      id: '1',
      name: 'Central Substation',
      location: 'Downtown District',
      voltage: '132kV',
      status: 'Online',
      capacity: '50 MVA',
      lastMaintenance: DateTime.now().subtract(const Duration(days: 30)),
      equipmentCount: 15,
    ),
    Substation(
      id: '2',
      name: 'North Grid Station',
      location: 'Industrial Zone',
      voltage: '220kV',
      status: 'Online',
      capacity: '100 MVA',
      lastMaintenance: DateTime.now().subtract(const Duration(days: 45)),
      equipmentCount: 22,
    ),
    Substation(
      id: '3',
      name: 'East Distribution Point',
      location: 'Residential Area',
      voltage: '66kV',
      status: 'Maintenance',
      capacity: '25 MVA',
      lastMaintenance: DateTime.now().subtract(const Duration(days: 15)),
      equipmentCount: 8,
    ),
  ];

  String _searchQuery = '';
  String _selectedStatus = 'All';
  String _selectedVoltage = 'All';

  List<Substation> get _filteredSubstations {
    return _substations.where((substation) {
      final matchesSearch =
          substation.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              substation.location
                  .toLowerCase()
                  .contains(_searchQuery.toLowerCase());
      final matchesStatus =
          _selectedStatus == 'All' || substation.status == _selectedStatus;
      final matchesVoltage =
          _selectedVoltage == 'All' || substation.voltage == _selectedVoltage;

      return matchesSearch && matchesStatus && matchesVoltage;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Substations Management'),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.monitor),
            onPressed: () => context.goNamed('substation-monitoring'),
            tooltip: 'Monitoring Dashboard',
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => setState(() {}),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildFilterSection(),
          _buildStatsCards(),
          Expanded(child: _buildSubstationsList()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.goNamed('create-substation'),
        backgroundColor: Colors.blue.shade700,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildFilterSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.grey.shade50,
      child: Column(
        children: [
          TextField(
            decoration: const InputDecoration(
              hintText: 'Search substations...',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
            onChanged: (value) => setState(() => _searchQuery = value),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: _selectedStatus,
                  decoration: const InputDecoration(
                    labelText: 'Status',
                    border: OutlineInputBorder(),
                  ),
                  items: ['All', 'Online', 'Offline', 'Maintenance']
                      .map((status) =>
                          DropdownMenuItem(value: status, child: Text(status)))
                      .toList(),
                  onChanged: (value) =>
                      setState(() => _selectedStatus = value!),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: _selectedVoltage,
                  decoration: const InputDecoration(
                    labelText: 'Voltage Level',
                    border: OutlineInputBorder(),
                  ),
                  items: ['All', '66kV', '132kV', '220kV', '400kV']
                      .map((voltage) => DropdownMenuItem(
                          value: voltage, child: Text(voltage)))
                      .toList(),
                  onChanged: (value) =>
                      setState(() => _selectedVoltage = value!),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatsCards() {
    final onlineCount = _substations.where((s) => s.status == 'Online').length;
    final maintenanceCount =
        _substations.where((s) => s.status == 'Maintenance').length;
    final totalCapacity = _substations.fold(
        0.0, (sum, s) => sum + double.parse(s.capacity.split(' ')[0]));

    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: _buildStatCard(
              'Total Substations',
              '${_substations.length}',
              Icons.electrical_services,
              Colors.blue,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildStatCard(
              'Online',
              '$onlineCount',
              Icons.power,
              Colors.green,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildStatCard(
              'Under Maintenance',
              '$maintenanceCount',
              Icons.build,
              Colors.orange,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildStatCard(
              'Total Capacity',
              '${totalCapacity.toInt()} MVA',
              Icons.flash_on,
              Colors.purple,
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

  Widget _buildSubstationsList() {
    final filteredSubstations = _filteredSubstations;

    if (filteredSubstations.isEmpty) {
      return const Center(child: Text('No substations found'));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: filteredSubstations.length,
      itemBuilder: (context, index) {
        final substation = filteredSubstations[index];
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
                      size: 32,
                      color: _getStatusColor(substation.status),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            substation.name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(substation.location),
                          Text(
                              '${substation.voltage} • ${substation.capacity}'),
                        ],
                      ),
                    ),
                    Chip(
                      label: Text(substation.status),
                      backgroundColor:
                          _getStatusColor(substation.status).withOpacity(0.1),
                      labelStyle:
                          TextStyle(color: _getStatusColor(substation.status)),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Icon(Icons.build, size: 16, color: Colors.grey.shade600),
                    const SizedBox(width: 4),
                    Text(
                      'Last Maintenance: ${_formatDate(substation.lastMaintenance)}',
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                    const SizedBox(width: 16),
                    Icon(Icons.devices, size: 16, color: Colors.grey.shade600),
                    const SizedBox(width: 4),
                    Text(
                      '${substation.equipmentCount} Equipment',
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton.icon(
                      onPressed: () => _showMaintenanceDialog(substation),
                      icon: const Icon(Icons.build),
                      label: const Text('Maintenance'),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton.icon(
                      onPressed: () => context.goNamed('substation-details',
                          pathParameters: {'id': substation.id}),
                      icon: const Icon(Icons.visibility),
                      label: const Text('View Details'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade700,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Online':
        return Colors.green;
      case 'Offline':
        return Colors.red;
      case 'Maintenance':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  void _showMaintenanceDialog(Substation substation) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Schedule Maintenance - ${substation.name}'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Maintenance Type',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Scheduled Date',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.calendar_today),
              ),
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
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('Maintenance scheduled successfully')),
              );
            },
            child: const Text('Schedule'),
          ),
        ],
      ),
    );
  }
}

class Substation {
  final String id;
  final String name;
  final String location;
  final String voltage;
  final String status;
  final String capacity;
  final DateTime lastMaintenance;
  final int equipmentCount;

  Substation({
    required this.id,
    required this.name,
    required this.location,
    required this.voltage,
    required this.status,
    required this.capacity,
    required this.lastMaintenance,
    required this.equipmentCount,
  });
}
