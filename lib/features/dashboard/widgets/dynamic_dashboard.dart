// lib/features/dashboard/widgets/dynamic_dashboard.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../core/models/dashboard_model.dart';
import '../../../core/providers/dashboard_provider.dart';

class DynamicDashboard extends ConsumerWidget {
  const DynamicDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardAsync = ref.watch(userDashboardProvider);

    return dashboardAsync.when(
      data: (dashboard) => dashboard != null
          ? DashboardGrid(dashboard: dashboard)
          : const Center(child: Text('No dashboard configured')),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(child: Text('Error: $error')),
    );
  }
}

class DashboardGrid extends StatelessWidget {
  final DashboardConfig dashboard;

  const DashboardGrid({super.key, required this.dashboard});

  @override
  Widget build(BuildContext context) {
    final columns = dashboard.layoutConfig['columns'] as int? ?? 2;
    final rowHeight = dashboard.layoutConfig['rowHeight'] as double? ?? 150.0;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            dashboard.name,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 16),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: columns,
            childAspectRatio: 2.0,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            children: dashboard.widgets.map((widget) {
              return DynamicWidget(widget: widget);
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class DynamicWidget extends ConsumerWidget {
  final DashboardWidget widget;

  const DynamicWidget({super.key, required this.widget});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dataAsync = ref.watch(widgetDataProvider(widget));

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Expanded(
              child: dataAsync.when(
                data: (data) => _buildWidgetContent(context, data),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, _) => Text('Error: $error'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWidgetContent(BuildContext context, Map<String, dynamic> data) {
    switch (widget.type) {
      case 'kpi':
        return _buildKPIWidget(context, data);
      case 'chart':
        return _buildChartWidget(context, data);
      case 'table':
        return _buildTableWidget(context, data);
      case 'list':
        return _buildListWidget(context, data);
      default:
        return Text('Unsupported widget type: ${widget.type}');
    }
  }

  Widget _buildKPIWidget(BuildContext context, Map<String, dynamic> data) {
    final value = data['total']?.toString() ?? '0';
    final trend = data['trend']?.toString() ?? '';

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
        ),
        if (trend.isNotEmpty)
          Text(
            trend,
            style: TextStyle(
              color: trend.startsWith('+') ? Colors.green : Colors.red,
              fontWeight: FontWeight.w500,
            ),
          ),
      ],
    );
  }

  Widget _buildChartWidget(BuildContext context, Map<String, dynamic> data) {
    // Simple bar chart example
    return BarChart(
      BarChartData(
        barGroups: [
          BarChartGroupData(
              x: 0, barRods: [BarChartRodData(toY: 8, color: Colors.blue)]),
          BarChartGroupData(
              x: 1, barRods: [BarChartRodData(toY: 10, color: Colors.blue)]),
          BarChartGroupData(
              x: 2, barRods: [BarChartRodData(toY: 14, color: Colors.blue)]),
          BarChartGroupData(
              x: 3, barRods: [BarChartRodData(toY: 15, color: Colors.blue)]),
        ],
      ),
    );
  }

  Widget _buildTableWidget(BuildContext context, Map<String, dynamic> data) {
    final items = data['data'] as List? ?? [];

    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index] as Map<String, dynamic>;
        return ListTile(
          title: Text(item['name']?.toString() ?? 'Item $index'),
          subtitle: Text(item['description']?.toString() ?? ''),
          trailing: Text(item['value']?.toString() ?? ''),
        );
      },
    );
  }

  Widget _buildListWidget(BuildContext context, Map<String, dynamic> data) {
    final items = data['data'] as List? ?? [];

    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index] as Map<String, dynamic>;
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 2),
          child: ListTile(
            leading: CircleAvatar(
              child: Text('${index + 1}'),
            ),
            title: Text(item['title']?.toString() ?? 'Item ${index + 1}'),
            subtitle: Text(item['subtitle']?.toString() ?? ''),
          ),
        );
      },
    );
  }
}
