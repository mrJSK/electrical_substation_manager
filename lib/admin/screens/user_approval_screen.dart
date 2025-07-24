// lib/features/admin/presentation/screens/user_approval_screen.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../auth/multi_tenant_auth.dart';
import '../widgets/approval_request_card.dart';
import '../../../auth/auth_provider.dart';
import '../providers/approval_requests_provider.dart'; // Add this import

// ADD THIS PART DIRECTIVE FOR CODE GENERATION
part 'user_approval_screen.g.dart';

class UserApprovalScreen extends ConsumerStatefulWidget {
  const UserApprovalScreen({super.key});

  @override
  ConsumerState<UserApprovalScreen> createState() => _UserApprovalScreenState();
}

class _UserApprovalScreenState extends ConsumerState<UserApprovalScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  String _selectedFilter = 'pending';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final pendingRequests = ref.watch(pendingApprovalRequestsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('User Approval Requests'),
        elevation: 2,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.refresh(pendingApprovalRequestsProvider),
            tooltip: 'Refresh requests',
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _showFilterDialog,
            tooltip: 'Filter requests',
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Pending', icon: Icon(Icons.schedule)),
            Tab(text: 'Approved', icon: Icon(Icons.check_circle)),
            Tab(text: 'Rejected', icon: Icon(Icons.cancel)),
          ],
          onTap: (index) {
            setState(() {
              switch (index) {
                case 0:
                  _selectedFilter = 'pending';
                  break;
                case 1:
                  _selectedFilter = 'approved';
                  break;
                case 2:
                  _selectedFilter = 'rejected';
                  break;
              }
            });
          },
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildRequestsList('pending'),
          _buildRequestsList('approved'),
          _buildRequestsList('rejected'),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => ref.refresh(pendingApprovalRequestsProvider),
        icon: const Icon(Icons.refresh),
        label: const Text('Refresh'),
      ),
    );
  }

  Widget _buildRequestsList(String status) {
    return Consumer(
      builder: (context, ref, child) {
        final requestsAsync = status == 'pending'
            ? ref.watch(pendingApprovalRequestsProvider)
            : ref.watch(filteredApprovalRequestsProvider(status));

        return requestsAsync.when(
          data: (requests) {
            if (requests.isEmpty) {
              return _buildEmptyState(status);
            }

            return RefreshIndicator(
              onRefresh: () async {
                ref.refresh(pendingApprovalRequestsProvider);
                if (status != 'pending') {
                  ref.refresh(filteredApprovalRequestsProvider(status));
                }
              },
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                itemCount: requests.length,
                itemBuilder: (context, index) {
                  final request = requests[index];
                  return ApprovalRequestCard(request: request);
                },
              ),
            );
          },
          loading: () => const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text('Loading approval requests...'),
              ],
            ),
          ),
          error: (error, stack) => _buildErrorState(error, stack),
        );
      },
    );
  }

  Widget _buildEmptyState(String status) {
    IconData icon;
    String title;
    String subtitle;

    switch (status) {
      case 'pending':
        icon = Icons.schedule;
        title = 'No Pending Requests';
        subtitle = 'All user registration requests have been processed.';
        break;
      case 'approved':
        icon = Icons.check_circle_outline;
        title = 'No Approved Requests';
        subtitle = 'No users have been approved recently.';
        break;
      case 'rejected':
        icon = Icons.cancel_outlined;
        title = 'No Rejected Requests';
        subtitle = 'No user requests have been rejected recently.';
        break;
      default:
        icon = Icons.inbox;
        title = 'No Requests';
        subtitle = 'No requests found for this category.';
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 80,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 24),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey.shade500,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () => ref.refresh(pendingApprovalRequestsProvider),
            icon: const Icon(Icons.refresh),
            label: const Text('Refresh'),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(Object error, StackTrace stack) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 80,
            color: Colors.red.shade400,
          ),
          const SizedBox(height: 24),
          Text(
            'Error Loading Requests',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.red.shade600,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            error.toString(),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey.shade600,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () => ref.refresh(pendingApprovalRequestsProvider),
            icon: const Icon(Icons.refresh),
            label: const Text('Retry'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Filter Requests'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Sort by Date'),
              trailing: const Icon(Icons.sort),
              onTap: () {
                Navigator.pop(context);
                // Implement date sorting
              },
            ),
            ListTile(
              title: const Text('Filter by Organization'),
              trailing: const Icon(Icons.business),
              onTap: () {
                Navigator.pop(context);
                _showOrganizationFilter();
              },
            ),
            ListTile(
              title: const Text('Export Requests'),
              trailing: const Icon(Icons.download),
              onTap: () {
                Navigator.pop(context);
                _exportRequests();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showOrganizationFilter() {
    // Implement organization-specific filtering
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Organization filter coming soon')),
    );
  }

  void _exportRequests() {
    // Implement CSV/PDF export functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Export functionality coming soon')),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}

// Provider for filtered approval requests
@riverpod
Stream<List<Map<String, dynamic>>> filteredApprovalRequests(
  FilteredApprovalRequestsRef ref,
  String status,
) {
  final currentUser = ref.watch(currentUserProvider);
  if (currentUser == null) return Stream.value([]);

  return FirebaseFirestore.instance
      .collection('approval_requests')
      .where('approvers', arrayContains: currentUser.uid)
      .where('status', isEqualTo: status)
      .orderBy('requestedAt', descending: true)
      .limit(50) // Limit for performance
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => {'id': doc.id, ...doc.data()}).toList());
}
