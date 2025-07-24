import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import '../layouts/admin_layout.dart';
import '../widgets/dashboard_card.dart';
import '../widgets/chart_card.dart';

// 🔥 NEW: Data providers for real-time dashboard data
final dashboardStatsProvider = FutureProvider<DashboardStats>((ref) async {
  // Simulate API call - replace with your actual data service
  await Future.delayed(const Duration(seconds: 1));
  return DashboardStats(
    totalOrganizations: 156,
    activeUsers: 2847,
    totalSubstations: 1234,
    pendingApprovals: 23,
    organizationGrowth: 12,
    userGrowth: 89,
    substationGrowth: 45,
    approvalTrend: -2.1,
  );
});

final recentActivitiesProvider =
    FutureProvider<List<ActivityItem>>((ref) async {
  await Future.delayed(const Duration(milliseconds: 800));
  return [
    ActivityItem(
      title: 'New organization registered',
      subtitle: 'PowerGrid Corp submitted registration',
      time: '2 minutes ago',
      icon: Icons.business_rounded,
      color: const Color(0xFF10B981),
      priority: ActivityPriority.high,
    ),
    ActivityItem(
      title: 'User approved',
      subtitle: 'Rajesh Kumar approved for Substation Manager role',
      time: '15 minutes ago',
      icon: Icons.check_circle_rounded,
      color: const Color(0xFF3B82F6),
      priority: ActivityPriority.medium,
    ),
    ActivityItem(
      title: 'New substation added',
      subtitle: 'Delhi North 132kV substation configured',
      time: '1 hour ago',
      icon: Icons.electrical_services_rounded,
      color: const Color(0xFFEF4444),
      priority: ActivityPriority.high,
    ),
    ActivityItem(
      title: 'System maintenance completed',
      subtitle: 'Scheduled maintenance completed successfully',
      time: '2 hours ago',
      icon: Icons.engineering_rounded,
      color: const Color(0xFF8B5CF6),
      priority: ActivityPriority.low,
    ),
    ActivityItem(
      title: 'Alert: High power consumption',
      subtitle: 'Mumbai Central 220kV station exceeding threshold',
      time: '3 hours ago',
      icon: Icons.warning_rounded,
      color: const Color(0xFFF59E0B),
      priority: ActivityPriority.critical,
    ),
  ];
});

// 🔥 NEW: Chart data providers
final userGrowthChartProvider = FutureProvider<List<FlSpot>>((ref) async {
  await Future.delayed(const Duration(milliseconds: 600));
  return [
    FlSpot(0, 1000),
    FlSpot(1, 1200),
    FlSpot(2, 1100),
    FlSpot(3, 1400),
    FlSpot(4, 1600),
    FlSpot(5, 1800),
    FlSpot(6, 2000),
  ];
});

class AdminDashboard extends ConsumerStatefulWidget {
  const AdminDashboard({super.key});

  @override
  ConsumerState<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends ConsumerState<AdminDashboard>
    with TickerProviderStateMixin {
  late AnimationController _headerController;
  late AnimationController _cardsController;
  late Animation<double> _headerAnimation;
  late Animation<double> _cardsAnimation;

  // 🔥 NEW: Refresh functionality
  bool _isRefreshing = false;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
  }

  void _setupAnimations() {
    _headerController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _cardsController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _headerAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _headerController, curve: Curves.easeOutCubic),
    );

    _cardsAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _cardsController, curve: Curves.easeOutBack),
    );

    // Start animations
    _headerController.forward();
    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) _cardsController.forward();
    });
  }

  // 🔥 NEW: Refresh functionality
  Future<void> _refreshDashboard() async {
    if (_isRefreshing) return;

    setState(() => _isRefreshing = true);

    // Invalidate providers to trigger refresh
    ref.invalidate(dashboardStatsProvider);
    ref.invalidate(recentActivitiesProvider);
    ref.invalidate(userGrowthChartProvider);

    await Future.delayed(const Duration(seconds: 1));

    setState(() => _isRefreshing = false);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            children: [
              Icon(Icons.check_circle, color: Colors.white),
              SizedBox(width: 8),
              Text('Dashboard refreshed successfully'),
            ],
          ),
          backgroundColor: const Color(0xFF10B981),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final dashboardStats = ref.watch(dashboardStatsProvider);
    final recentActivities = ref.watch(recentActivitiesProvider);

    return AdminLayout(
      title: 'Dashboard',
      child: RefreshIndicator(
        onRefresh: _refreshDashboard,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔥 IMPROVED: Enhanced Welcome Section with real-time data
              AnimatedBuilder(
                animation: _headerAnimation,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(0, 50 * (1 - _headerAnimation.value)),
                    child: Opacity(
                      opacity: _headerAnimation.value,
                      child: _buildWelcomeSection(dashboardStats),
                    ),
                  );
                },
              ),

              const SizedBox(height: 32),

              // 🔥 IMPROVED: Enhanced Stats Cards with loading states
              AnimatedBuilder(
                animation: _cardsAnimation,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(0, 30 * (1 - _cardsAnimation.value)),
                    child: Opacity(
                      opacity: _cardsAnimation.value,
                      child: _buildStatCards(dashboardStats),
                    ),
                  );
                },
              ),

              const SizedBox(height: 32),

              // 🔥 NEW: System Status Overview
              _buildSystemStatusOverview(),

              const SizedBox(height: 32),

              // 🔥 IMPROVED: Enhanced Charts Section
              _buildChartsSection(),

              const SizedBox(height: 32),

              // 🔥 IMPROVED: Enhanced Recent Activity with real-time data
              _buildRecentActivitySection(recentActivities),

              const SizedBox(height: 32),

              // 🔥 NEW: Quick Actions Section
              _buildQuickActionsSection(),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeSection(AsyncValue<DashboardStats> statsAsync) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF1E3A8A),
            Color(0xFF3B82F6),
            Color(0xFF06B6D4),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF3B82F6).withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      'Welcome back, Super Admin!',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 12),
                    if (_isRefreshing)
                      const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Manage electrical substations across India with real-time insights',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
                const SizedBox(height: 20),
                // 🔥 IMPROVED: Real-time quick stats
                statsAsync.when(
                  data: (stats) => Row(
                    children: [
                      _buildQuickStat('Active Organizations',
                          '${stats.totalOrganizations}'),
                      const SizedBox(width: 32),
                      _buildQuickStat('Total Users', '${stats.activeUsers}'),
                      const SizedBox(width: 32),
                      _buildQuickStat(
                          'Pending Approvals', '${stats.pendingApprovals}'),
                    ],
                  ),
                  loading: () => const Row(
                    children: [
                      _QuickStatSkeleton(),
                      SizedBox(width: 32),
                      _QuickStatSkeleton(),
                      SizedBox(width: 32),
                      _QuickStatSkeleton(),
                    ],
                  ),
                  error: (error, stack) => Text(
                    'Failed to load stats',
                    style: TextStyle(color: Colors.white.withOpacity(0.7)),
                  ),
                ),
              ],
            ),
          ),
          // 🔥 IMPROVED: Interactive icon with pulse animation
          TweenAnimationBuilder(
            duration: const Duration(seconds: 2),
            tween: Tween<double>(begin: 0, end: 1),
            builder: (context, value, child) {
              return Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(60),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.3 * value),
                      blurRadius: 20 * value,
                      spreadRadius: 10 * value,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.electric_bolt_rounded,
                  size: 60,
                  color: Colors.white,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStatCards(AsyncValue<DashboardStats> statsAsync) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth > 1200
            ? 4
            : constraints.maxWidth > 800
                ? 3
                : constraints.maxWidth > 600
                    ? 2
                    : 1;

        return statsAsync.when(
          data: (stats) => GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 24,
            mainAxisSpacing: 24,
            childAspectRatio: 1.3,
            children: [
              DashboardCard(
                title: 'Total Organizations',
                value: '${stats.totalOrganizations}',
                subtitle: '+${stats.organizationGrowth} this month',
                icon: Icons.business_rounded,
                gradient: const [Color(0xFF10B981), Color(0xFF059669)],
                trend: 7.2,
                onTap: () => _navigateToSection('organizations'),
              ),
              DashboardCard(
                title: 'Active Users',
                value: '${stats.activeUsers}',
                subtitle: '+${stats.userGrowth} this week',
                icon: Icons.people_rounded,
                gradient: const [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
                trend: 12.5,
                onTap: () => _navigateToSection('users'),
              ),
              DashboardCard(
                title: 'Total Substations',
                value: '${stats.totalSubstations}',
                subtitle: '+${stats.substationGrowth} this month',
                icon: Icons.electrical_services_rounded,
                gradient: const [Color(0xFFEF4444), Color(0xFFDC2626)],
                trend: 15.8,
                onTap: () => _navigateToSection('substations'),
              ),
              DashboardCard(
                title: 'Pending Approvals',
                value: '${stats.pendingApprovals}',
                subtitle: 'Requires attention',
                icon: Icons.approval_rounded,
                gradient: const [Color(0xFFF59E0B), Color(0xFFD97706)],
                trend: stats.approvalTrend,
                onTap: () => _navigateToSection('approvals'),
                isUrgent: stats.pendingApprovals > 20,
              ),
            ],
          ),
          loading: () => GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 24,
            mainAxisSpacing: 24,
            childAspectRatio: 1.3,
            children:
                List.generate(4, (index) => const _DashboardCardSkeleton()),
          ),
          error: (error, stack) => Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.red.shade200),
            ),
            child: Column(
              children: [
                Icon(Icons.error_outline, color: Colors.red.shade600, size: 48),
                const SizedBox(height: 12),
                Text(
                  'Failed to load dashboard statistics',
                  style: TextStyle(
                    color: Colors.red.shade700,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                ElevatedButton.icon(
                  onPressed: () => ref.invalidate(dashboardStatsProvider),
                  icon: const Icon(Icons.refresh),
                  label: const Text('Retry'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade600,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // 🔥 NEW: System Status Overview
  Widget _buildSystemStatusOverview() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.monitor_heart_rounded,
                  color: Color(0xFF10B981),
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'System Health Overview',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Color(0xFF10B981),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Text(
                      'All Systems Operational',
                      style: TextStyle(
                        color: Color(0xFF10B981),
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _buildSystemStatusItem(
                  'Database',
                  'Operational',
                  const Color(0xFF10B981),
                  Icons.storage_rounded,
                  '99.9% uptime',
                ),
              ),
              Expanded(
                child: _buildSystemStatusItem(
                  'API Server',
                  'Operational',
                  const Color(0xFF10B981),
                  Icons.cloud_rounded,
                  '< 50ms response',
                ),
              ),
              Expanded(
                child: _buildSystemStatusItem(
                  'Monitoring',
                  'Active',
                  const Color(0xFF3B82F6),
                  Icons.visibility_rounded,
                  '2.8K events/min',
                ),
              ),
              Expanded(
                child: _buildSystemStatusItem(
                  'Backups',
                  'Completed',
                  const Color(0xFF8B5CF6),
                  Icons.backup_rounded,
                  'Last: 2h ago',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSystemStatusItem(
    String title,
    String status,
    Color color,
    IconData icon,
    String subtitle,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            status,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChartsSection() {
    final userGrowthData = ref.watch(userGrowthChartProvider);

    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth > 1024;

        if (isDesktop) {
          return Row(
            children: [
              Expanded(
                flex: 2,
                child: userGrowthData.when(
                  data: (data) => ChartCard(
                    title: 'User Growth Trend',
                    subtitle: 'Monthly active users over time',
                    chart: _buildLineChart(data),
                    actions: [
                      IconButton(
                        onPressed: () =>
                            ref.invalidate(userGrowthChartProvider),
                        icon: const Icon(Icons.refresh, size: 20),
                        tooltip: 'Refresh Chart',
                      ),
                      IconButton(
                        onPressed: () => _exportChart('user_growth'),
                        icon: const Icon(Icons.download, size: 20),
                        tooltip: 'Export Chart',
                      ),
                    ],
                  ),
                  loading: () =>
                      const _ChartCardSkeleton(title: 'User Growth Trend'),
                  error: (error, stack) => ChartCard(
                    title: 'User Growth Trend',
                    chart: _buildErrorChart('Failed to load user growth data'),
                  ),
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: ChartCard(
                  title: 'Organization Distribution',
                  subtitle: 'By industry type',
                  chart: _buildPieChart(),
                  actions: [
                    IconButton(
                      onPressed: () => _exportChart('org_distribution'),
                      icon: const Icon(Icons.download, size: 20),
                      tooltip: 'Export Chart',
                    ),
                  ],
                ),
              ),
            ],
          );
        } else {
          return Column(
            children: [
              userGrowthData.when(
                data: (data) => ChartCard(
                  title: 'User Growth Trend',
                  chart: _buildLineChart(data),
                ),
                loading: () =>
                    const _ChartCardSkeleton(title: 'User Growth Trend'),
                error: (error, stack) => ChartCard(
                  title: 'User Growth Trend',
                  chart: _buildErrorChart('Failed to load data'),
                ),
              ),
              const SizedBox(height: 24),
              ChartCard(
                title: 'Organization Distribution',
                chart: _buildPieChart(),
              ),
            ],
          );
        }
      },
    );
  }

  Widget _buildRecentActivitySection(
      AsyncValue<List<ActivityItem>> activitiesAsync) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF3B82F6).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.history_rounded,
                  color: Color(0xFF3B82F6),
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Recent Activity',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              // 🔥 NEW: Filter and refresh buttons
              IconButton(
                onPressed: () => _showActivityFilters(),
                icon: const Icon(Icons.filter_list),
                tooltip: 'Filter Activities',
              ),
              IconButton(
                onPressed: () => ref.invalidate(recentActivitiesProvider),
                icon: const Icon(Icons.refresh),
                tooltip: 'Refresh',
              ),
              TextButton.icon(
                onPressed: () => _navigateToSection('activity-log'),
                icon: const Icon(Icons.open_in_new, size: 16),
                label: const Text('View All'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          activitiesAsync.when(
            data: (activities) => ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: activities.length,
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final activity = activities[index];
                return _buildActivityItem(activity);
              },
            ),
            loading: () => Column(
              children:
                  List.generate(5, (index) => const _ActivityItemSkeleton()),
            ),
            error: (error, stack) => Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Icon(Icons.error_outline,
                      color: Colors.red.shade400, size: 32),
                  const SizedBox(height: 8),
                  Text(
                    'Failed to load recent activities',
                    style: TextStyle(color: Colors.red.shade600),
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: () => ref.invalidate(recentActivitiesProvider),
                    child: const Text('Try Again'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityItem(ActivityItem activity) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: activity.color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: activity.priority == ActivityPriority.critical
              ? Border.all(color: activity.color, width: 2)
              : null,
        ),
        child: Icon(
          activity.icon,
          color: activity.color,
          size: 20,
        ),
      ),
      title: Row(
        children: [
          Expanded(
            child: Text(
              activity.title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
          if (activity.priority == ActivityPriority.critical)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.red.shade100,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'CRITICAL',
                style: TextStyle(
                  color: Colors.red.shade700,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4),
          Text(
            activity.subtitle,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            activity.time,
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: 11,
            ),
          ),
        ],
      ),
      onTap: () => _showActivityDetails(activity),
    );
  }

  // 🔥 NEW: Quick Actions Section
  Widget _buildQuickActionsSection() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Quick Actions',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _buildQuickActionButton(
                'Add Organization',
                Icons.add_business,
                const Color(0xFF10B981),
                () => _navigateToSection('add-organization'),
              ),
              _buildQuickActionButton(
                'Organization Builder',
                Icons.account_tree,
                const Color(0xFF3B82F6),
                () => _navigateToSection('organization-builder'),
              ),
              _buildQuickActionButton(
                'User Approvals',
                Icons.how_to_reg,
                const Color(0xFFF59E0B),
                () => _navigateToSection('approvals'),
              ),
              _buildQuickActionButton(
                'System Health',
                Icons.health_and_safety,
                const Color(0xFF8B5CF6),
                () => _navigateToSection('system-health'),
              ),
              _buildQuickActionButton(
                'Generate Report',
                Icons.assessment,
                const Color(0xFF06B6D4),
                () => _showReportGenerator(),
              ),
              _buildQuickActionButton(
                'Export Data',
                Icons.file_download,
                const Color(0xFFEF4444),
                () => _showExportOptions(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionButton(
    String label,
    IconData icon,
    Color color,
    VoidCallback onPressed,
  ) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 18),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: color.withOpacity(0.1),
        foregroundColor: color,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: color.withOpacity(0.3)),
        ),
      ),
    );
  }

  Widget _buildQuickStat(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.white.withOpacity(0.8),
          ),
        ),
      ],
    );
  }

  Widget _buildLineChart(List<FlSpot> spots) {
    return LineChart(
      LineChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: 200,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: Colors.grey.shade200,
              strokeWidth: 1,
            );
          },
        ),
        titlesData: FlTitlesData(
          show: true,
          topTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              getTitlesWidget: (value, meta) {
                return Text(
                  '${(value / 1000).toStringAsFixed(0)}K',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 10,
                  ),
                );
              },
            ),
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
                  'Jun',
                  'Jul'
                ];
                return Text(
                  months[value.toInt() % months.length],
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 10,
                  ),
                );
              },
            ),
          ),
        ),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            gradient: const LinearGradient(
              colors: [Color(0xFF3B82F6), Color(0xFF06B6D4)],
            ),
            barWidth: 3,
            dotData: FlDotData(
              show: true,
              getDotPainter: (spot, percent, barData, index) {
                return FlDotCirclePainter(
                  radius: 4,
                  color: Colors.white,
                  strokeWidth: 2,
                  strokeColor: const Color(0xFF3B82F6),
                );
              },
            ),
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF3B82F6).withOpacity(0.3),
                  const Color(0xFF06B6D4).withOpacity(0.1),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPieChart() {
    return PieChart(
      PieChartData(
        sectionsSpace: 2,
        centerSpaceRadius: 40,
        sections: [
          PieChartSectionData(
            color: const Color(0xFF10B981),
            value: 40,
            title: 'Power\n40%',
            radius: 60,
            titleStyle: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          PieChartSectionData(
            color: const Color(0xFF3B82F6),
            value: 30,
            title: 'Telecom\n30%',
            radius: 60,
            titleStyle: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          PieChartSectionData(
            color: const Color(0xFFF59E0B),
            value: 20,
            title: 'Manufacturing\n20%',
            radius: 60,
            titleStyle: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          PieChartSectionData(
            color: const Color(0xFFEF4444),
            value: 10,
            title: 'Others\n10%',
            radius: 60,
            titleStyle: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorChart(String message) {
    return Container(
      height: 200,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, color: Colors.red.shade400, size: 32),
          const SizedBox(height: 8),
          Text(
            message,
            style: TextStyle(color: Colors.red.shade600),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // 🔥 NEW: Navigation and action methods
  void _navigateToSection(String section) {
    // Navigate to specific admin sections
    switch (section) {
      case 'organizations':
        // Navigator.pushNamed(context, '/admin/organizations');
        break;
      case 'users':
        // Navigator.pushNamed(context, '/admin/users');
        break;
      case 'substations':
        // Navigator.pushNamed(context, '/admin/substations');
        break;
      case 'approvals':
        // Navigator.pushNamed(context, '/admin/approvals');
        break;
      case 'organization-builder':
        // Navigator.pushNamed(context, '/admin/organization-builder');
        break;
      case 'activity-log':
        // Navigator.pushNamed(context, '/admin/activity-log');
        break;
      default:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Navigating to $section...')),
        );
    }
  }

  void _showActivityFilters() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Filter Activities'),
        content:
            const Text('Activity filtering options will be implemented here.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showActivityDetails(ActivityItem activity) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(activity.title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(activity.subtitle),
            const SizedBox(height: 8),
            Text(
              'Time: ${activity.time}',
              style: TextStyle(color: Colors.grey.shade600),
            ),
            Text(
              'Priority: ${activity.priority.name.toUpperCase()}',
              style: TextStyle(color: activity.color),
            ),
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

  void _exportChart(String chartType) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Exporting $chartType chart...')),
    );
  }

  void _showReportGenerator() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Generate Report'),
        content:
            const Text('Report generation options will be implemented here.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showExportOptions() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Export Data'),
        content: const Text('Data export options will be implemented here.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _headerController.dispose();
    _cardsController.dispose();
    super.dispose();
  }
}

// 🔥 NEW: Data models
class DashboardStats {
  final int totalOrganizations;
  final int activeUsers;
  final int totalSubstations;
  final int pendingApprovals;
  final int organizationGrowth;
  final int userGrowth;
  final int substationGrowth;
  final double approvalTrend;

  DashboardStats({
    required this.totalOrganizations,
    required this.activeUsers,
    required this.totalSubstations,
    required this.pendingApprovals,
    required this.organizationGrowth,
    required this.userGrowth,
    required this.substationGrowth,
    required this.approvalTrend,
  });
}

class ActivityItem {
  final String title;
  final String subtitle;
  final String time;
  final IconData icon;
  final Color color;
  final ActivityPriority priority;

  ActivityItem({
    required this.title,
    required this.subtitle,
    required this.time,
    required this.icon,
    required this.color,
    required this.priority,
  });
}

enum ActivityPriority { low, medium, high, critical }

// 🔥 NEW: Skeleton loading widgets
class _QuickStatSkeleton extends StatelessWidget {
  const _QuickStatSkeleton();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 60,
          height: 24,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.3),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(height: 4),
        Container(
          width: 80,
          height: 12,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ],
    );
  }
}

class _DashboardCardSkeleton extends StatelessWidget {
  const _DashboardCardSkeleton();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            width: 100,
            height: 16,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: 80,
            height: 32,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ],
      ),
    );
  }
}

class _ChartCardSkeleton extends StatelessWidget {
  final String title;

  const _ChartCardSkeleton({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActivityItemSkeleton extends StatelessWidget {
  const _ActivityItemSkeleton();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 14,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  width: 200,
                  height: 12,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 60,
            height: 12,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ],
      ),
    );
  }
}
