import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import '../layouts/admin_layout.dart';
import '../widgets/dashboard_card.dart';
import '../widgets/chart_card.dart';

class AdminDashboard extends ConsumerStatefulWidget {
  const AdminDashboard({super.key});

  @override
  ConsumerState<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends ConsumerState<AdminDashboard>
    with TickerProviderStateMixin {
  late List<AnimationController> _cardControllers;
  late List<Animation<double>> _cardAnimations;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
  }

  void _setupAnimations() {
    _cardControllers = List.generate(
      8,
      (index) => AnimationController(
        duration: Duration(milliseconds: 600 + (index * 100)),
        vsync: this,
      ),
    );

    _cardAnimations = _cardControllers.map((controller) {
      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: controller, curve: Curves.elasticOut),
      );
    }).toList();

    // Start animations with delay
    for (int i = 0; i < _cardControllers.length; i++) {
      Future.delayed(Duration(milliseconds: i * 150), () {
        if (mounted) _cardControllers[i].forward();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdminLayout(
      title: 'Dashboard',
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Section
            Container(
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
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Welcome back, Admin!',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Manage electrical substations across India',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            _buildQuickStat('Active Organizations', '156'),
                            const SizedBox(width: 32),
                            _buildQuickStat('Total Users', '2,847'),
                            const SizedBox(width: 32),
                            _buildQuickStat('Pending Approvals', '23'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(60),
                    ),
                    child: const Icon(
                      Icons.electrical_services_rounded,
                      size: 60,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Stats Cards
            LayoutBuilder(
              builder: (context, constraints) {
                final crossAxisCount = constraints.maxWidth > 1200
                    ? 4
                    : constraints.maxWidth > 800
                        ? 3
                        : constraints.maxWidth > 600
                            ? 2
                            : 1;

                return GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 24,
                  mainAxisSpacing: 24,
                  childAspectRatio: 1.2,
                  children: [
                    AnimatedBuilder(
                      animation: _cardAnimations[0],
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _cardAnimations[0].value,
                          child: DashboardCard(
                            title: 'Total Organizations',
                            value: '156',
                            subtitle: '+12 this month',
                            icon: Icons.business_rounded,
                            gradient: [Color(0xFF10B981), Color(0xFF059669)],
                            trend: 7.2,
                          ),
                        );
                      },
                    ),
                    AnimatedBuilder(
                      animation: _cardAnimations[1],
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _cardAnimations[1].value,
                          child: DashboardCard(
                            title: 'Active Users',
                            value: '2,847',
                            subtitle: '+89 this week',
                            icon: Icons.people_rounded,
                            gradient: [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
                            trend: 12.5,
                          ),
                        );
                      },
                    ),
                    AnimatedBuilder(
                      animation: _cardAnimations[2],
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _cardAnimations[2].value,
                          child: DashboardCard(
                            title: 'Substations',
                            value: '1,234',
                            subtitle: '+45 this month',
                            icon: Icons.electrical_services_rounded,
                            gradient: [Color(0xFFEF4444), Color(0xFFDC2626)],
                            trend: 15.8,
                          ),
                        );
                      },
                    ),
                    AnimatedBuilder(
                      animation: _cardAnimations[3],
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _cardAnimations[3].value,
                          child: DashboardCard(
                            title: 'Pending Approvals',
                            value: '23',
                            subtitle: 'Requires attention',
                            icon: Icons.approval_rounded,
                            gradient: [Color(0xFFF59E0B), Color(0xFFD97706)],
                            trend: -2.1,
                          ),
                        );
                      },
                    ),
                  ],
                );
              },
            ),

            const SizedBox(height: 32),

            // Charts Section
            LayoutBuilder(
              builder: (context, constraints) {
                final isDesktop = constraints.maxWidth > 1024;

                if (isDesktop) {
                  return Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: AnimatedBuilder(
                          animation: _cardAnimations[4],
                          builder: (context, child) {
                            return Transform.scale(
                              scale: _cardAnimations[4].value,
                              child: ChartCard(
                                title: 'User Growth',
                                chart: _buildLineChart(),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        child: AnimatedBuilder(
                          animation: _cardAnimations[5],
                          builder: (context, child) {
                            return Transform.scale(
                              scale: _cardAnimations[5].value,
                              child: ChartCard(
                                title: 'Organization Distribution',
                                chart: _buildPieChart(),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                } else {
                  return Column(
                    children: [
                      AnimatedBuilder(
                        animation: _cardAnimations[4],
                        builder: (context, child) {
                          return Transform.scale(
                            scale: _cardAnimations[4].value,
                            child: ChartCard(
                              title: 'User Growth',
                              chart: _buildLineChart(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 24),
                      AnimatedBuilder(
                        animation: _cardAnimations[5],
                        builder: (context, child) {
                          return Transform.scale(
                            scale: _cardAnimations[5].value,
                            child: ChartCard(
                              title: 'Organization Distribution',
                              chart: _buildPieChart(),
                            ),
                          );
                        },
                      ),
                    ],
                  );
                }
              },
            ),

            const SizedBox(height: 32),

            // Recent Activity
            AnimatedBuilder(
              animation: _cardAnimations[6],
              builder: (context, child) {
                return Transform.scale(
                  scale: _cardAnimations[6].value,
                  child: _buildRecentActivity(),
                );
              },
            ),
          ],
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

  Widget _buildLineChart() {
    return LineChart(
      LineChartData(
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(show: false),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
            spots: [
              FlSpot(0, 1000),
              FlSpot(1, 1200),
              FlSpot(2, 1100),
              FlSpot(3, 1400),
              FlSpot(4, 1600),
              FlSpot(5, 1800),
              FlSpot(6, 2000),
            ],
            isCurved: true,
            gradient: const LinearGradient(
              colors: [Color(0xFF3B82F6), Color(0xFF06B6D4)],
            ),
            barWidth: 3,
            dotData: FlDotData(show: false),
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
            title: '40%',
            radius: 60,
            titleStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          PieChartSectionData(
            color: const Color(0xFF3B82F6),
            value: 30,
            title: '30%',
            radius: 60,
            titleStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          PieChartSectionData(
            color: const Color(0xFFF59E0B),
            value: 20,
            title: '20%',
            radius: 60,
            titleStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          PieChartSectionData(
            color: const Color(0xFFEF4444),
            value: 10,
            title: '10%',
            radius: 60,
            titleStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentActivity() {
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
              const Icon(Icons.history_rounded, color: Color(0xFF3B82F6)),
              const SizedBox(width: 12),
              const Text(
                'Recent Activity',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {},
                child: const Text('View All'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 5,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              final activities = [
                {
                  'title': 'New organization registered',
                  'subtitle': 'PowerGrid Corp submitted registration',
                  'time': '2 minutes ago',
                  'icon': Icons.business_rounded,
                  'color': Color(0xFF10B981),
                },
                {
                  'title': 'User approved',
                  'subtitle':
                      'Rajesh Kumar approved for Substation Manager role',
                  'time': '15 minutes ago',
                  'icon': Icons.check_circle_rounded,
                  'color': Color(0xFF3B82F6),
                },
                {
                  'title': 'New substation added',
                  'subtitle': 'Delhi North 132kV substation configured',
                  'time': '1 hour ago',
                  'icon': Icons.electrical_services_rounded,
                  'color': Color(0xFFEF4444),
                },
                {
                  'title': 'Role permissions updated',
                  'subtitle': 'Division Manager role permissions modified',
                  'time': '2 hours ago',
                  'icon': Icons.security_rounded,
                  'color': Color(0xFF8B5CF6),
                },
                {
                  'title': 'System backup completed',
                  'subtitle': 'Daily backup completed successfully',
                  'time': '4 hours ago',
                  'icon': Icons.backup_rounded,
                  'color': Color(0xFF06B6D4),
                },
              ];

              final activity = activities[index];

              return ListTile(
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: (activity['color'] as Color).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    activity['icon'] as IconData,
                    color: activity['color'] as Color,
                    size: 20,
                  ),
                ),
                title: Text(
                  activity['title'] as String,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                subtitle: Text(
                  activity['subtitle'] as String,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
                trailing: Text(
                  activity['time'] as String,
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 11,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    for (final controller in _cardControllers) {
      controller.dispose();
    }
    super.dispose();
  }
}
