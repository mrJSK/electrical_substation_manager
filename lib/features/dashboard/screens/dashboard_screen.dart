import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/providers/global_providers.dart';
import '../../../core/providers/cached_providers.dart';
import '../../../core/constants/app_constants.dart';
import '../widgets/connectivity_indicator.dart';
import '../widgets/online_operation_guard.dart';
import '../widgets/optimized_dashboard.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  bool _showFab = true;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _setupScrollListener();
  }

  void _setupScrollListener() {
    _scrollController.addListener(() {
      final showFab = _scrollController.offset <= 100;
      if (showFab != _showFab) {
        setState(() => _showFab = showFab);
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = ref.read(authServiceProvider);
    final currentUser = auth.currentUser;

    return Scaffold(
      appBar: _buildAppBar(context, currentUser),
      body: currentUser != null
          ? _buildDashboardContent(currentUser.uid)
          : _buildNotSignedInState(),
      floatingActionButton:
          _showFab ? _buildFloatingActionButton(context) : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      drawer: _buildNavigationDrawer(context, currentUser),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context, currentUser) {
    return AppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Dashboard',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          if (currentUser != null)
            Text(
              'Welcome, ${currentUser.displayName?.split(' ').first ?? 'User'}',
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
            ),
        ],
      ),
      backgroundColor: Theme.of(context).primaryColor,
      foregroundColor: Colors.white,
      elevation: 2,
      actions: _buildAppBarActions(context, currentUser),
      bottom: currentUser != null ? _buildTabBar() : null,
    );
  }

  List<Widget> _buildAppBarActions(BuildContext context, currentUser) {
    return [
      // Connectivity indicator
      const ConnectivityIndicator(showText: false),
      const SizedBox(width: 8),

      // Notifications
      IconButton(
        icon: Stack(
          children: [
            const Icon(Icons.notifications_outlined),
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                constraints: const BoxConstraints(
                  minWidth: 8,
                  minHeight: 8,
                ),
              ),
            ),
          ],
        ),
        onPressed: () => context.goNamed('notifications'),
        tooltip: 'Notifications',
      ),

      // Search
      IconButton(
        icon: const Icon(Icons.search),
        onPressed: () => context.goNamed('search'),
        tooltip: 'Search',
      ),

      // Refresh
      OnlineOperationGuard(
        onTap: () => _refreshDashboard(currentUser?.uid),
        offlineMessage: 'Refresh requires internet connection',
        child: IconButton(
          icon: const Icon(Icons.refresh_rounded),
          onPressed: () => _refreshDashboard(currentUser?.uid),
          tooltip: 'Refresh Dashboard',
        ),
      ),

      // Profile menu
      _buildProfileMenu(context, currentUser),

      const SizedBox(width: 8),
    ];
  }

  Widget _buildProfileMenu(BuildContext context, currentUser) {
    return PopupMenuButton<String>(
      icon: CircleAvatar(
        radius: 16,
        backgroundImage: currentUser?.photoURL != null
            ? NetworkImage(currentUser!.photoURL!)
            : null,
        backgroundColor: Colors.white24,
        child: currentUser?.photoURL == null
            ? Text(
                currentUser?.displayName?.substring(0, 1).toUpperCase() ?? 'U',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              )
            : null,
      ),
      offset: const Offset(0, 45),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      onSelected: (value) =>
          _handleProfileMenuAction(context, value, currentUser),
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 'profile',
          child: _buildMenuTile(Icons.person_outline, 'Profile'),
        ),
        PopupMenuItem(
          value: 'preferences',
          child: _buildMenuTile(Icons.settings_outlined, 'Preferences'),
        ),
        PopupMenuItem(
          value: 'help',
          child: _buildMenuTile(Icons.help_outline, 'Help & Support'),
        ),
        const PopupMenuDivider(),
        PopupMenuItem(
          value: 'cache_stats',
          child: _buildMenuTile(Icons.analytics_outlined, 'Cache Statistics'),
        ),
        const PopupMenuDivider(),
        PopupMenuItem(
          value: 'logout',
          child: _buildMenuTile(
            Icons.logout,
            'Sign Out',
            color: Colors.red,
          ),
        ),
      ],
    );
  }

  Widget _buildMenuTile(IconData icon, String title, {Color? color}) {
    return ListTile(
      leading: Icon(icon, color: color, size: 20),
      title: Text(
        title,
        style: TextStyle(color: color, fontSize: 14),
      ),
      contentPadding: EdgeInsets.zero,
      dense: true,
    );
  }

  PreferredSizeWidget _buildTabBar() {
    return TabBar(
      controller: _tabController,
      indicatorColor: Colors.white,
      indicatorWeight: 3,
      labelColor: Colors.white,
      unselectedLabelColor: Colors.white70,
      labelStyle: const TextStyle(fontWeight: FontWeight.w600),
      tabs: const [
        Tab(
          icon: Icon(Icons.dashboard_outlined, size: 20),
          text: 'Overview',
        ),
        Tab(
          icon: Icon(Icons.electrical_services, size: 20),
          text: 'Equipment',
        ),
        Tab(
          icon: Icon(Icons.build_outlined, size: 20),
          text: 'Maintenance',
        ),
        Tab(
          icon: Icon(Icons.analytics_outlined, size: 20),
          text: 'Analytics',
        ),
      ],
    );
  }

  Widget _buildDashboardContent(String userId) {
    return TabBarView(
      controller: _tabController,
      children: [
        // Overview Tab
        RefreshIndicator(
          onRefresh: () => _refreshDashboard(userId),
          child: OptimizedDashboard(
            userId: userId,
            scrollController: _scrollController,
          ),
        ),

        // Equipment Tab
        _buildEquipmentTab(),

        // Maintenance Tab
        _buildMaintenanceTab(),

        // Analytics Tab
        _buildAnalyticsTab(),
      ],
    );
  }

  Widget _buildEquipmentTab() {
    return RefreshIndicator(
      onRefresh: () async {
        // Refresh equipment data
        await Future.delayed(const Duration(milliseconds: 500));
      },
      child: SingleChildScrollView(
        controller: _scrollController,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Equipment Status Cards
            _buildEquipmentStatusCards(),
            const SizedBox(height: 24),

            // Recent Equipment Activities
            _buildSectionHeader('Recent Activities', Icons.history),
            const SizedBox(height: 12),
            _buildRecentActivitiesList(),
          ],
        ),
      ),
    );
  }

  Widget _buildMaintenanceTab() {
    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(const Duration(milliseconds: 500));
      },
      child: SingleChildScrollView(
        controller: _scrollController,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Upcoming Maintenance
            _buildSectionHeader('Upcoming Maintenance', Icons.schedule),
            const SizedBox(height: 12),
            _buildUpcomingMaintenanceList(),
            const SizedBox(height: 24),

            // Quick Actions
            _buildSectionHeader('Quick Actions', Icons.flash_on),
            const SizedBox(height: 12),
            _buildMaintenanceQuickActions(),
          ],
        ),
      ),
    );
  }

  Widget _buildAnalyticsTab() {
    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(const Duration(milliseconds: 500));
      },
      child: SingleChildScrollView(
        controller: _scrollController,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Performance Metrics
            _buildSectionHeader('Performance Metrics', Icons.trending_up),
            const SizedBox(height: 12),
            _buildPerformanceMetrics(),
            const SizedBox(height: 24),

            // Charts placeholder
            _buildSectionHeader('System Analytics', Icons.bar_chart),
            const SizedBox(height: 12),
            _buildAnalyticsPlaceholder(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          color: Theme.of(context).primaryColor,
          size: 20,
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
        ),
      ],
    );
  }

  Widget _buildEquipmentStatusCards() {
    final statusData = [
      {
        'title': 'Operational',
        'count': '45',
        'color': Colors.green,
        'icon': Icons.check_circle
      },
      {
        'title': 'Maintenance',
        'count': '3',
        'color': Colors.orange,
        'icon': Icons.build
      },
      {
        'title': 'Offline',
        'count': '2',
        'color': Colors.red,
        'icon': Icons.error
      },
      {
        'title': 'Total',
        'count': '50',
        'color': Colors.blue,
        'icon': Icons.electrical_services
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.5,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: statusData.length,
      itemBuilder: (context, index) {
        final data = statusData[index];
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  data['icon'] as IconData,
                  color: data['color'] as Color,
                  size: 32,
                ),
                const SizedBox(height: 8),
                Text(
                  data['count'] as String,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  data['title'] as String,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildRecentActivitiesList() {
    final activities = [
      {
        'title': 'Transformer T1 - Inspection completed',
        'time': '2 hours ago',
        'type': 'maintenance'
      },
      {
        'title': 'Circuit Breaker CB2 - Status changed to operational',
        'time': '4 hours ago',
        'type': 'status'
      },
      {
        'title': 'Generator G1 - Maintenance scheduled',
        'time': '1 day ago',
        'type': 'schedule'
      },
    ];

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: activities.length,
      itemBuilder: (context, index) {
        final activity = activities[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
              child: Icon(
                _getActivityIcon(activity['type'] as String),
                color: Theme.of(context).primaryColor,
                size: 20,
              ),
            ),
            title: Text(
              activity['title'] as String,
              style: const TextStyle(fontSize: 14),
            ),
            subtitle: Text(
              activity['time'] as String,
              style: const TextStyle(fontSize: 12),
            ),
            trailing: const Icon(Icons.chevron_right, size: 16),
            onTap: () {
              // Navigate to activity detail
            },
          ),
        );
      },
    );
  }

  Widget _buildUpcomingMaintenanceList() {
    final maintenanceItems = [
      {'equipment': 'Transformer T2', 'type': 'Preventive', 'date': 'Tomorrow'},
      {'equipment': 'Generator G3', 'type': 'Corrective', 'date': 'In 3 days'},
      {'equipment': 'Switch S1', 'type': 'Inspection', 'date': 'Next week'},
    ];

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: maintenanceItems.length,
      itemBuilder: (context, index) {
        final item = maintenanceItems[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            leading: const Icon(Icons.schedule, color: Colors.orange),
            title: Text(item['equipment'] as String),
            subtitle: Text('${item['type']} - ${item['date']}'),
            trailing: IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () => _showMaintenanceOptions(context, item),
            ),
          ),
        );
      },
    );
  }

  Widget _buildMaintenanceQuickActions() {
    final actions = [
      {
        'title': 'Create Work Order',
        'icon': Icons.add_task,
        'route': '/maintenance/create'
      },
      {
        'title': 'Schedule Maintenance',
        'icon': Icons.event,
        'route': '/maintenance/schedule'
      },
      {
        'title': 'View Reports',
        'icon': Icons.assessment,
        'route': '/reports/maintenance'
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: actions.length,
      itemBuilder: (context, index) {
        final action = actions[index];
        return Card(
          child: InkWell(
            onTap: () => context.go(action['route'] as String),
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    action['icon'] as IconData,
                    color: Theme.of(context).primaryColor,
                    size: 28,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    action['title'] as String,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPerformanceMetrics() {
    final metrics = [
      {'title': 'System Uptime', 'value': '99.2%', 'trend': '+0.1%'},
      {'title': 'Energy Efficiency', 'value': '94.5%', 'trend': '+2.3%'},
      {'title': 'Maintenance Cost', 'value': '₹45K', 'trend': '-5.2%'},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio: 4,
        mainAxisSpacing: 8,
      ),
      itemCount: metrics.length,
      itemBuilder: (context, index) {
        final metric = metrics[index];
        final isPositive = (metric['trend'] as String).startsWith('+');

        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        metric['title'] as String,
                        style:
                            const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      Text(
                        metric['value'] as String,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: isPositive
                        ? Colors.green.withOpacity(0.1)
                        : Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    metric['trend'] as String,
                    style: TextStyle(
                      color: isPositive ? Colors.green : Colors.red,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAnalyticsPlaceholder() {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.bar_chart,
            size: 48,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            'Analytics Charts',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Performance charts and analytics coming soon',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotSignedInState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.person_outline, size: 64, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            'Please sign in to view your dashboard',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () => _showQuickActions(context),
      icon: const Icon(Icons.add),
      label: const Text('Quick Action'),
      backgroundColor: Theme.of(context).colorScheme.secondary,
    );
  }

  Widget _buildNavigationDrawer(BuildContext context, currentUser) {
    if (currentUser == null) return const SizedBox.shrink();

    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(currentUser.displayName ?? 'User'),
            accountEmail: Text(currentUser.email ?? ''),
            currentAccountPicture: CircleAvatar(
              backgroundImage: currentUser.photoURL != null
                  ? NetworkImage(currentUser.photoURL!)
                  : null,
              child: currentUser.photoURL == null
                  ? Text(
                      currentUser.displayName?.substring(0, 1).toUpperCase() ??
                          'U')
                  : null,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildDrawerTile(
                    Icons.dashboard, 'Dashboard', () => context.go('/')),
                _buildDrawerTile(Icons.electrical_services, 'Equipment',
                    () => context.go('/equipment')),
                _buildDrawerTile(Icons.apartment, 'Substations',
                    () => context.go('/substations')),
                _buildDrawerTile(Icons.build, 'Maintenance',
                    () => context.go('/maintenance')),
                _buildDrawerTile(
                    Icons.assessment, 'Reports', () => context.go('/reports')),
                _buildDrawerTile(
                    Icons.people, 'Users', () => context.go('/users')),
                const Divider(),
                _buildDrawerTile(Icons.settings, 'Settings',
                    () => context.go('/profile/preferences')),
                _buildDrawerTile(Icons.help, 'Help', () => _showHelp(context)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerTile(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
    );
  }

  IconData _getActivityIcon(String type) {
    switch (type) {
      case 'maintenance':
        return Icons.build;
      case 'status':
        return Icons.info;
      case 'schedule':
        return Icons.schedule;
      default:
        return Icons.circle;
    }
  }

  Future<void> _refreshDashboard(String? userId) async {
    if (userId == null) return;

    try {
      // Show loading indicator
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Row(
            children: [
              SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
              SizedBox(width: 12),
              Text('Refreshing dashboard...'),
            ],
          ),
          duration: Duration(seconds: 2),
        ),
      );

      // Refresh all dashboard data
      ref.refresh(cachedDashboardProvider(userId));

      // Success message
      if (mounted) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Row(
              children: [
                Icon(Icons.check_circle, color: Colors.white),
                SizedBox(width: 12),
                Text('Dashboard refreshed successfully'),
              ],
            ),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Refresh failed: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _handleProfileMenuAction(
      BuildContext context, String action, currentUser) async {
    switch (action) {
      case 'profile':
        context.goNamed('profile');
        break;
      case 'preferences':
        context.goNamed('preferences');
        break;
      case 'help':
        _showHelp(context);
        break;
      case 'cache_stats':
        await _showCacheStats(context);
        break;
      case 'logout':
        await _handleSignOut(context);
        break;
    }
  }

  Future<void> _showCacheStats(BuildContext context) async {
    try {
      final cacheManager = ref.read(cacheManagerProvider.notifier);
      final stats = await cacheManager.getCacheStats();

      if (context.mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Cache Statistics'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: stats.entries.map((entry) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Text('${entry.key}: ${entry.value}'),
                  );
                }).toList(),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  await cacheManager.invalidateAllCache();
                  Navigator.pop(context);
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Cache cleared successfully'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  }
                },
                child: const Text('Clear Cache'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Close'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to get cache stats: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _handleSignOut(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sign Out'),
        content: const Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Sign Out'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        final auth = ref.read(authServiceProvider);
        await auth.signOut();

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Signed out successfully'),
              backgroundColor: Colors.green,
            ),
          );
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Sign out failed: $e'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  void _showQuickActions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Quick Actions',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 24),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 3,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                _buildQuickActionTile(
                  Icons.add_box,
                  'Add Equipment',
                  () => context.go('/equipment/add'),
                ),
                _buildQuickActionTile(
                  Icons.build,
                  'Create Work Order',
                  () => context.go('/maintenance/create'),
                ),
                _buildQuickActionTile(
                  Icons.assessment,
                  'Generate Report',
                  () => context.go('/reports'),
                ),
                _buildQuickActionTile(
                  Icons.search,
                  'Search',
                  () => context.goNamed('search'),
                ),
                _buildQuickActionTile(
                  Icons.people,
                  'Manage Users',
                  () => context.go('/users'),
                ),
                _buildQuickActionTile(
                  Icons.settings,
                  'Settings',
                  () => context.go('/admin/settings'),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionTile(
      IconData icon, String label, VoidCallback onTap) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        onTap();
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 32,
              color: Theme.of(context).primaryColor,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  void _showMaintenanceOptions(
      BuildContext context, Map<String, dynamic> item) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Edit Maintenance'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.schedule),
              title: const Text('Reschedule'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('View Details'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  void _showHelp(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Help & Support'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('For assistance, please contact:'),
            SizedBox(height: 16),
            Text('📧 Email: support@substationmanager.com'),
            Text('📞 Phone: +91-XXXX-XXXXXX'),
            Text('🕒 Hours: 9 AM - 6 PM IST (Mon-Fri)'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}

// Extension for OptimizedDashboard to accept scroll controller
extension OptimizedDashboardExtension on OptimizedDashboard {
  Widget withScrollController(ScrollController controller) {
    return OptimizedDashboard(
      userId: userId,
      // Add scroll controller parameter to OptimizedDashboard if needed
    );
  }
}
