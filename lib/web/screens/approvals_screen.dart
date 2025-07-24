// screens/approvals_screen.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ApprovalsScreen extends StatefulWidget {
  final String? initialTab;

  const ApprovalsScreen({
    Key? key,
    this.initialTab,
  }) : super(key: key);

  @override
  State<ApprovalsScreen> createState() => _ApprovalsScreenState();
}

class _ApprovalsScreenState extends State<ApprovalsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<UserApproval> _pendingApprovals = [
    UserApproval(
      id: '1',
      name: 'Alice Johnson',
      email: 'alice@example.com',
      organization: 'Power Corp',
      requestedRole: 'Operator',
      submittedDate: DateTime.now().subtract(const Duration(days: 2)),
      status: 'Pending',
    ),
    UserApproval(
      id: '2',
      name: 'Bob Smith',
      email: 'bob@example.com',
      organization: 'Energy Ltd',
      requestedRole: 'Viewer',
      submittedDate: DateTime.now().subtract(const Duration(days: 1)),
      status: 'Pending',
    ),
  ];

  final List<UserApproval> _approvedUsers = [
    UserApproval(
      id: '3',
      name: 'Carol Davis',
      email: 'carol@example.com',
      organization: 'Grid Systems',
      requestedRole: 'Admin',
      submittedDate: DateTime.now().subtract(const Duration(days: 5)),
      status: 'Approved',
      processedDate: DateTime.now().subtract(const Duration(days: 3)),
    ),
  ];

  final List<UserApproval> _rejectedUsers = [
    UserApproval(
      id: '4',
      name: 'David Wilson',
      email: 'david@example.com',
      organization: 'Unknown Corp',
      requestedRole: 'Admin',
      submittedDate: DateTime.now().subtract(const Duration(days: 7)),
      status: 'Rejected',
      processedDate: DateTime.now().subtract(const Duration(days: 5)),
      rejectionReason: 'Invalid organization',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    // Set initial tab based on parameter
    if (widget.initialTab != null) {
      switch (widget.initialTab) {
        case 'pending':
          _tabController.index = 0;
          break;
        case 'approved':
          _tabController.index = 1;
          break;
        case 'rejected':
          _tabController.index = 2;
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
        title: const Text('User Approvals'),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.white,
          tabs: [
            Tab(
              text: 'Pending (${_pendingApprovals.length})',
              icon: const Icon(Icons.pending_actions),
            ),
            Tab(
              text: 'Approved (${_approvedUsers.length})',
              icon: const Icon(Icons.check_circle),
            ),
            Tab(
              text: 'Rejected (${_rejectedUsers.length})',
              icon: const Icon(Icons.cancel),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildPendingApprovals(),
          _buildApprovedUsers(),
          _buildRejectedUsers(),
        ],
      ),
    );
  }

  Widget _buildPendingApprovals() {
    if (_pendingApprovals.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.inbox, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text('No pending approvals', style: TextStyle(fontSize: 18)),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _pendingApprovals.length,
      itemBuilder: (context, index) {
        final approval = _pendingApprovals[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.orange.shade100,
                      child: Icon(Icons.person, color: Colors.orange.shade700),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            approval.name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(approval.email),
                          Text(
                              '${approval.organization} • ${approval.requestedRole}'),
                        ],
                      ),
                    ),
                    Chip(
                      label: const Text('Pending'),
                      backgroundColor: Colors.orange.shade100,
                      labelStyle: TextStyle(color: Colors.orange.shade700),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  'Submitted: ${_formatDate(approval.submittedDate)}',
                  style: TextStyle(color: Colors.grey.shade600),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => _showRejectDialog(approval),
                      child: const Text('Reject'),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () => _approveUser(approval),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Approve'),
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

  Widget _buildApprovedUsers() {
    return _buildUserList(_approvedUsers, Colors.green, Icons.check_circle);
  }

  Widget _buildRejectedUsers() {
    return _buildUserList(_rejectedUsers, Colors.red, Icons.cancel);
  }

  Widget _buildUserList(List<UserApproval> users, Color color, IconData icon) {
    if (users.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.inbox, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            Text('No users found', style: TextStyle(fontSize: 18)),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: color.withOpacity(0.1),
              child: Icon(icon, color: color),
            ),
            title: Text(user.name),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user.email),
                Text('${user.organization} • ${user.requestedRole}'),
                if (user.processedDate != null)
                  Text('Processed: ${_formatDate(user.processedDate!)}'),
                if (user.rejectionReason != null)
                  Text(
                    'Reason: ${user.rejectionReason}',
                    style: TextStyle(color: Colors.red.shade700),
                  ),
              ],
            ),
            trailing: Chip(
              label: Text(user.status),
              backgroundColor: color.withOpacity(0.1),
              labelStyle: TextStyle(color: color),
            ),
          ),
        );
      },
    );
  }

  void _approveUser(UserApproval approval) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Approve User'),
        content: Text('Are you sure you want to approve ${approval.name}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _pendingApprovals.remove(approval);
                _approvedUsers.add(approval.copyWith(
                  status: 'Approved',
                  processedDate: DateTime.now(),
                ));
              });
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text('${approval.name} approved successfully')),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: const Text('Approve', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showRejectDialog(UserApproval approval) {
    final reasonController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reject User'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Are you sure you want to reject ${approval.name}?'),
            const SizedBox(height: 16),
            TextField(
              controller: reasonController,
              decoration: const InputDecoration(
                labelText: 'Rejection Reason',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
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
              setState(() {
                _pendingApprovals.remove(approval);
                _rejectedUsers.add(approval.copyWith(
                  status: 'Rejected',
                  processedDate: DateTime.now(),
                  rejectionReason: reasonController.text.isEmpty
                      ? 'No reason provided'
                      : reasonController.text,
                ));
              });
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${approval.name} rejected')),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Reject', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}

class UserApproval {
  final String id;
  final String name;
  final String email;
  final String organization;
  final String requestedRole;
  final DateTime submittedDate;
  final String status;
  final DateTime? processedDate;
  final String? rejectionReason;

  UserApproval({
    required this.id,
    required this.name,
    required this.email,
    required this.organization,
    required this.requestedRole,
    required this.submittedDate,
    required this.status,
    this.processedDate,
    this.rejectionReason,
  });

  UserApproval copyWith({
    String? id,
    String? name,
    String? email,
    String? organization,
    String? requestedRole,
    DateTime? submittedDate,
    String? status,
    DateTime? processedDate,
    String? rejectionReason,
  }) {
    return UserApproval(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      organization: organization ?? this.organization,
      requestedRole: requestedRole ?? this.requestedRole,
      submittedDate: submittedDate ?? this.submittedDate,
      status: status ?? this.status,
      processedDate: processedDate ?? this.processedDate,
      rejectionReason: rejectionReason ?? this.rejectionReason,
    );
  }
}
