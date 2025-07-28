import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../../core/models/dashboard_model.dart';
import '../../../core/providers/global_providers.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/constants/app_constants.dart';
import 'connectivity_indicator.dart';
import 'online_operation_guard.dart';

class DynamicDashboard extends ConsumerStatefulWidget {
  final String? userId;
  final ScrollController? scrollController;
  final bool showHeader;
  final EdgeInsetsGeometry? padding;

  const DynamicDashboard({
    super.key,
    this.userId,
    this.scrollController,
    this.showHeader = true,
    this.padding,
  });

  @override
  ConsumerState<DynamicDashboard> createState() => _DynamicDashboardState();
}

class _DynamicDashboardState extends ConsumerState<DynamicDashboard>
    with TickerProviderStateMixin {
  late AnimationController _refreshAnimationController;
  late Animation<double> _refreshAnimation;
  bool _isRefreshing = false;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
  }

  void _setupAnimations() {
    _refreshAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _refreshAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _refreshAnimationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _refreshAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentUserId = widget.userId ?? ref.watch(currentUserIdProvider);

    if (currentUserId == null) {
      return _buildNotSignedInState();
    }

    final dashboardAsync = ref.watch(dashboardConfigProvider(currentUserId));
    final userContextAsync = ref.watch(userContextProvider);

    return RefreshIndicator(
      onRefresh: () => _handleRefresh(currentUserId),
      child: dashboardAsync.when(
        data: (dashboard) => dashboard != null
            ? userContextAsync.when(
                data: (userContext) => _buildDashboardContent(
                  context,
                  dashboard, // FIXED: This is now properly typed as DashboardConfig
                  userContext,
                  currentUserId,
                ),
                loading: () => _buildLoadingState(),
                error: (error, _) => _buildErrorState(error, currentUserId),
              )
            : _buildEmptyDashboardState(),
        loading: () => _buildLoadingState(),
        error: (error, stackTrace) => _buildErrorState(error, currentUserId),
      ),
    );
  }

  Widget _buildDashboardContent(
    BuildContext context,
    DashboardConfig dashboard, // FIXED: Proper type annotation
    UserContext? userContext,
    String userId,
  ) {
    // Filter widgets based on user permissions
    final visibleWidgets = dashboard.widgets.where((widget) {
      if (userContext == null) return true;
      return widget.requiredPermissions.every(
        (permission) => userContext.hasPermission(permission),
      );
    }).toList();

    return DashboardGrid(
      dashboard: dashboard.copyWith(widgets: visibleWidgets),
      userId: userId,
      userContext: userContext,
      scrollController: widget.scrollController,
      showHeader: widget.showHeader,
      padding: widget.padding,
      onRefresh: () => _handleRefresh(userId),
    );
  }

  Widget _buildLoadingState() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 16),
          Text(
            'Loading your dashboard...',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.grey[600],
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Please wait while we prepare your data',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey[500],
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(Object error, String userId) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64,
            color: Colors.red[300],
          ),
          const SizedBox(height: 16),
          Text(
            'Dashboard Error',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.red[700],
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Unable to load your dashboard',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.grey[600],
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            error.toString(),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey[500],
                ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () => _handleRefresh(userId),
            icon: const Icon(Icons.refresh),
            label: const Text('Retry'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyDashboardState() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.dashboard_outlined,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 24),
          Text(
            'No Dashboard Configured',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Your dashboard is being prepared.\nPlease contact your administrator for configuration.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.grey[500],
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          OutlinedButton.icon(
            onPressed: () => ref.refreshConnectivity(),
            icon: const Icon(Icons.admin_panel_settings),
            label: const Text('Contact Admin'),
            style: OutlinedButton.styleFrom(
              foregroundColor: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotSignedInState() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.person_outline,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'Please sign in to view your dashboard',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.grey[600],
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Future<void> _handleRefresh(String userId) async {
    if (_isRefreshing) return;

    setState(() => _isRefreshing = true);
    _refreshAnimationController.forward();

    try {
      // Refresh dashboard and related data
      ref.refreshDashboard(userId);

      // Add a small delay for better UX
      await Future.delayed(const Duration(milliseconds: 500));

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Row(
              children: [
                Icon(Icons.check_circle, color: Colors.white),
                SizedBox(width: 12),
                Text('Dashboard refreshed successfully'),
              ],
            ),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Refresh failed: $e'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isRefreshing = false);
        _refreshAnimationController.reverse();
      }
    }
  }
}

class DashboardGrid extends StatefulWidget {
  final DashboardConfig dashboard;
  final String userId;
  final UserContext? userContext;
  final ScrollController? scrollController;
  final bool showHeader;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onRefresh;

  const DashboardGrid({
    super.key,
    required this.dashboard,
    required this.userId,
    this.userContext,
    this.scrollController,
    this.showHeader = true,
    this.padding,
    this.onRefresh,
  });

  @override
  State<DashboardGrid> createState() => _DashboardGridState();
}

class _DashboardGridState extends State<DashboardGrid> {
  @override
  Widget build(BuildContext context) {
    final columns = widget.dashboard.layoutConfig['columns'] as int? ?? 2;
    final responsive = _getResponsiveColumns(context, columns);

    return SingleChildScrollView(
      controller: widget.scrollController,
      padding: widget.padding ?? const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.showHeader) ...[
            _buildDashboardHeader(context),
            const SizedBox(height: 24),
          ],

          _buildWidgetGrid(context, responsive),

          // Add some bottom padding for FAB
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget _buildDashboardHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.dashboard.name,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                  ),
                  if (widget.dashboard.description != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      widget.dashboard.description!,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.grey[600],
                          ),
                    ),
                  ],
                ],
              ),
            ),

            // Status indicators
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const ConnectivityIndicator(showText: false),
                const SizedBox(height: 4),
                Text(
                  'Last updated: ${_formatLastUpdate()}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey[500],
                      ),
                ),
              ],
            ),
          ],
        ),

        const SizedBox(height: 12),

        // User info and widget count
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Theme.of(context).primaryColor.withOpacity(0.2),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.widgets,
                      color: Theme.of(context).primaryColor,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${widget.dashboard.widgets.length} widgets configured',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    const Spacer(),
                    if (widget.userContext != null) ...[
                      Text(
                        widget.userContext!.organization?.name ?? 'Unknown Org',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.grey[600],
                            ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildWidgetGrid(BuildContext context, int columns) {
    final widgets = widget.dashboard.widgets;

    if (widgets.isEmpty) {
      return Container(
        height: 200,
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.widgets_outlined,
              size: 48,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'No widgets available',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Contact your administrator to configure dashboard widgets',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[500],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns,
        childAspectRatio: _getWidgetAspectRatio(context),
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: widgets.length,
      itemBuilder: (context, index) {
        final widget = widgets[index];
        return VisibilityDetector(
          key: Key('widget_${widget.id}'),
          onVisibilityChanged: (info) {
            // Preload data when widget becomes visible
            if (info.visibleFraction > 0.1) {
              // Trigger data loading
            }
          },
          child: DynamicWidget(
            widget: widget,
            userId: this.widget.userId,
            onRefresh: this.widget.onRefresh,
          ),
        );
      },
    );
  }

  int _getResponsiveColumns(BuildContext context, int defaultColumns) {
    final width = MediaQuery.of(context).size.width;
    if (width < 600) {
      return 1; // Mobile: 1 column
    } else if (width < 1200) {
      return 2; // Tablet: 2 columns
    } else {
      return defaultColumns.clamp(2, 4); // Desktop: 2-4 columns
    }
  }

  double _getWidgetAspectRatio(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 600) {
      return 1.8; // Mobile: taller widgets
    } else {
      return 1.5; // Tablet/Desktop: standard ratio
    }
  }

  String _formatLastUpdate() {
    final now = DateTime.now();
    return '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
  }
}

class DynamicWidget extends ConsumerStatefulWidget {
  final DashboardWidget widget;
  final String userId;
  final VoidCallback? onRefresh;

  const DynamicWidget({
    super.key,
    required this.widget,
    required this.userId,
    this.onRefresh,
  });

  @override
  ConsumerState<DynamicWidget> createState() => _DynamicWidgetState();
}

class _DynamicWidgetState extends ConsumerState<DynamicWidget>
    with TickerProviderStateMixin {
  late AnimationController _shimmerController;
  late Animation<double> _shimmerAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _setupShimmerAnimation();
  }

  void _setupShimmerAnimation() {
    _shimmerController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _shimmerAnimation = Tween<double>(
      begin: -1.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _shimmerController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dataAsync = ref.watch(widgetDataProvider((
      widgetId: widget.widget.id,
      userId: widget.userId,
    )));

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.identity()..scale(_isHovered ? 1.02 : 1.0),
        child: Card(
          elevation: _isHovered ? 8 : 2,
          shadowColor: Theme.of(context).primaryColor.withOpacity(0.2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(
              color: _isHovered
                  ? Theme.of(context).primaryColor.withOpacity(0.3)
                  : Colors.transparent,
              width: 1,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white,
                    Colors.grey.shade50,
                  ],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildWidgetHeader(context),
                    const SizedBox(height: 12),
                    Expanded(
                      child: dataAsync.when(
                        data: (data) => _buildWidgetContent(context, data),
                        loading: () => _buildLoadingContent(),
                        error: (error, _) => _buildErrorContent(error),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWidgetHeader(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.widget.title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              if (widget.widget.subtitle != null) ...[
                const SizedBox(height: 2),
                Text(
                  widget.widget.subtitle!,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey[600],
                      ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ],
          ),
        ),

        // Widget actions
        OnlineOperationGuard(
          onTap: () => _refreshWidget(),
          child: Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(
              Icons.refresh,
              size: 16,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoadingContent() {
    _shimmerController.repeat();

    return AnimatedBuilder(
      animation: _shimmerAnimation,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.grey[300]!,
                Colors.grey[100]!,
                Colors.grey[300]!,
              ],
              stops: [
                0.0,
                _shimmerAnimation.value,
                1.0,
              ],
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 8),
                Text(
                  'Loading...',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildErrorContent(Object error) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.red.withOpacity(0.2)),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              color: Colors.red[400],
              size: 24,
            ),
            const SizedBox(height: 8),
            Text(
              'Failed to load',
              style: TextStyle(
                color: Colors.red[600],
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              error.toString(),
              style: TextStyle(
                color: Colors.red[500],
                fontSize: 10,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWidgetContent(BuildContext context, Map<String, dynamic> data) {
    _shimmerController.stop();

    switch (widget.widget.type) {
      case 'kpi':
        return _buildKPIWidget(context, data);
      case 'chart':
        return _buildChartWidget(context, data);
      case 'table':
        return _buildTableWidget(context, data);
      case 'list':
        return _buildListWidget(context, data);
      case 'gauge':
        return _buildGaugeWidget(context, data);
      case 'progress':
        return _buildProgressWidget(context, data);
      default:
        return _buildUnsupportedWidget();
    }
  }

  Widget _buildKPIWidget(BuildContext context, Map<String, dynamic> data) {
    final value = data['total']?.toString() ??
        data['value']?.toString() ??
        data['message']?.toString() ??
        '0';
    final trend = data['trend']?.toString() ?? '';
    final unit = data['unit']?.toString() ?? '';
    final subtitle = data['subtitle']?.toString() ?? '';

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Main value
        Text(
          value,
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppTheme.getEquipmentStatusColor(
                    data['status']?.toString() ?? 'operational'),
              ),
          textAlign: TextAlign.center,
        ),

        // Unit
        if (unit.isNotEmpty) ...[
          Text(
            unit,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
          ),
        ],

        // Subtitle
        if (subtitle.isNotEmpty) ...[
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey[600],
                ),
            textAlign: TextAlign.center,
          ),
        ],

        // Trend indicator
        if (trend.isNotEmpty) ...[
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: trend.startsWith('+') || trend.contains('up')
                  ? Colors.green.withOpacity(0.1)
                  : Colors.red.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  trend.startsWith('+') || trend.contains('up')
                      ? Icons.trending_up
                      : Icons.trending_down,
                  size: 14,
                  color: trend.startsWith('+') || trend.contains('up')
                      ? Colors.green[700]
                      : Colors.red[700],
                ),
                const SizedBox(width: 4),
                Text(
                  trend,
                  style: TextStyle(
                    color: trend.startsWith('+') || trend.contains('up')
                        ? Colors.green[700]
                        : Colors.red[700],
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildChartWidget(BuildContext context, Map<String, dynamic> data) {
    final chartData = data['chartData'] as List? ?? [];

    if (chartData.isEmpty) {
      return _buildEmptyChart();
    }

    // Create bar chart data from the provided data
    final barGroups = chartData.asMap().entries.map((entry) {
      final index = entry.key;
      final item = entry.value as Map<String, dynamic>;
      final value = (item['value'] as num?)?.toDouble() ?? 0.0;

      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: value,
            color: AppTheme.getVoltageColor(item['category']?.toString() ?? ''),
            width: 16,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
          ),
        ],
      );
    }).toList();

    return BarChart(
      BarChartData(
        barGroups: barGroups,
        alignment: BarChartAlignment.spaceAround,
        maxY: chartData
                .map((e) => (e['value'] as num?)?.toDouble() ?? 0.0)
                .reduce((a, b) => a > b ? a : b) *
            1.2,
        barTouchData: BarTouchData(
          touchTooltipData: BarTouchTooltipData(
            // FIXED: Updated parameter name
            getTooltipColor: (group) => Theme.of(context).primaryColor,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              final item = chartData[groupIndex] as Map<String, dynamic>;
              return BarTooltipItem(
                '${item['label'] ?? 'Item $groupIndex'}\n${rod.toY.toStringAsFixed(1)}',
                const TextStyle(color: Colors.white, fontSize: 12),
              );
            },
          ),
        ),
        titlesData: FlTitlesData(
          show: true,
          topTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                final index = value.toInt();
                if (index < chartData.length) {
                  final item = chartData[index] as Map<String, dynamic>;
                  return Text(
                    item['label']?.toString() ?? '$index',
                    style: const TextStyle(fontSize: 10),
                  );
                }
                return const Text('');
              },
            ),
          ),
        ),
        gridData: FlGridData(
          show: true,
          horizontalInterval: 1,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: Colors.grey.withOpacity(0.2),
              strokeWidth: 1,
            );
          },
        ),
        borderData: FlBorderData(show: false),
      ),
    );
  }

  Widget _buildEmptyChart() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.bar_chart_rounded,
            size: 32,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 8),
          Text(
            'No chart data',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableWidget(BuildContext context, Map<String, dynamic> data) {
    final items = data['data'] as List? ?? [];
    const maxItems = 3; // Limit items for widget view

    if (items.isEmpty) {
      return _buildEmptyTable();
    }

    return Column(
      children: [
        // Header
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.1),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
          ),
          child: const Row(
            children: [
              Expanded(
                  child: Text('Name',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 12))),
              SizedBox(
                  width: 60,
                  child: Text('Value',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 12))),
            ],
          ),
        ),

        // Rows
        Expanded(
          child: ListView.builder(
            itemCount: items.length.clamp(0, maxItems),
            itemBuilder: (context, index) {
              final item = items[index] as Map<String, dynamic>;
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey.shade200),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        item['name']?.toString() ?? 'Item $index',
                        style: const TextStyle(fontSize: 11),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(
                      width: 60,
                      child: Text(
                        item['value']?.toString() ?? '',
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),

        // Show more indicator
        if (items.length > maxItems)
          Container(
            padding: const EdgeInsets.all(4),
            child: Text(
              '+${items.length - maxItems} more',
              style: TextStyle(
                fontSize: 10,
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildEmptyTable() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.table_chart_outlined, size: 32, color: Colors.grey[400]),
          const SizedBox(height: 8),
          Text(
            'No data available',
            style: TextStyle(color: Colors.grey[600], fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildListWidget(BuildContext context, Map<String, dynamic> data) {
    final items = data['data'] as List? ?? data['latest_data'] as List? ?? [];
    const maxItems = 4;

    if (items.isEmpty) {
      return _buildEmptyList();
    }

    return ListView.builder(
      itemCount: items.length.clamp(0, maxItems),
      itemBuilder: (context, index) {
        final item = items[index] as Map<String, dynamic>;
        return Container(
          margin: const EdgeInsets.only(bottom: 4),
          child: ListTile(
            dense: true,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            leading: CircleAvatar(
              radius: 12,
              backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
              child: Text(
                '${index + 1}',
                style: TextStyle(
                  fontSize: 10,
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            title: Text(
              item['title']?.toString() ??
                  item['name']?.toString() ??
                  'Item ${index + 1}',
              style: const TextStyle(fontSize: 11),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: item['subtitle'] != null || item['description'] != null
                ? Text(
                    item['subtitle']?.toString() ??
                        item['description']?.toString() ??
                        '',
                    style: const TextStyle(fontSize: 10),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )
                : null,
            trailing: item['value'] != null
                ? Text(
                    item['value'].toString(),
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : null,
          ),
        );
      },
    );
  }

  Widget _buildEmptyList() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.list_outlined, size: 32, color: Colors.grey[400]),
          const SizedBox(height: 8),
          Text(
            'No items available',
            style: TextStyle(color: Colors.grey[600], fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildGaugeWidget(BuildContext context, Map<String, dynamic> data) {
    final value = (data['value'] as num?)?.toDouble() ?? 0.0;
    final max = (data['max'] as num?)?.toDouble() ?? 100.0;
    final unit = data['unit']?.toString() ?? '%';
    final percentage = (value / max).clamp(0.0, 1.0);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Circular progress
        SizedBox(
          width: 80,
          height: 80,
          child: CircularProgressIndicator(
            value: percentage,
            strokeWidth: 8,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(
              AppTheme.getEquipmentStatusColor(percentage > 0.8
                  ? 'operational'
                  : percentage > 0.5
                      ? 'maintenance'
                      : 'faulty'),
            ),
          ),
        ),
        const SizedBox(height: 8),

        // Value text
        Text(
          '${value.toStringAsFixed(1)}$unit',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),

        // Max value
        Text(
          'of ${max.toStringAsFixed(0)}$unit',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey[600],
              ),
        ),
      ],
    );
  }

  Widget _buildProgressWidget(BuildContext context, Map<String, dynamic> data) {
    final completed = (data['completed'] as num?)?.toInt() ?? 0;
    final total = (data['total'] as num?)?.toInt() ?? 1;
    final percentage = (completed / total).clamp(0.0, 1.0);
    final title = data['title']?.toString() ?? 'Progress';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: percentage,
          backgroundColor: Colors.grey[300],
          valueColor: AlwaysStoppedAnimation<Color>(
            Theme.of(context).primaryColor,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '$completed of $total',
              style: const TextStyle(fontSize: 11),
            ),
            Text(
              '${(percentage * 100).toStringAsFixed(1)}%',
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildUnsupportedWidget() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.orange.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.orange.withOpacity(0.3)),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.widgets_outlined,
              size: 32,
              color: Colors.orange[600],
            ),
            const SizedBox(height: 8),
            Text(
              'Unsupported Widget',
              style: TextStyle(
                color: Colors.orange[700],
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              'Type: ${widget.widget.type}',
              style: TextStyle(
                color: Colors.orange[600],
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _refreshWidget() {
    // Refresh widget data
    ref.refresh(widgetDataProvider((
      widgetId: widget.widget.id,
      userId: widget.userId,
    )));

    // Call parent refresh if available
    widget.onRefresh?.call();
  }
}
