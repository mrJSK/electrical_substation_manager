import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:visibility_detector/visibility_detector.dart'; // Added import
import '../../../core/models/dashboard_model.dart';
import '../../../core/providers/cached_providers.dart';

class OptimizedDashboard extends ConsumerWidget {
  final String userId;

  const OptimizedDashboard({
    super.key,
    required this.userId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardAsync = ref.watch(cachedDashboardProvider(userId));

    return dashboardAsync.when(
      data: (dashboard) {
        if (dashboard == null) {
          return const Center(
            child: Text('No dashboard available'),
          );
        }

        return ListView.builder(
          // Use ListView.builder for better memory management
          itemCount: dashboard.widgets.length,
          itemBuilder: (context, index) {
            return LazyWidget(
              widget: dashboard.widgets[index],
              userId: userId,
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text('Error loading dashboard: $error'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => ref.refresh(cachedDashboardProvider(userId)),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}

class LazyWidget extends ConsumerWidget {
  final DashboardWidget widget;
  final String userId;

  const LazyWidget({
    super.key,
    required this.widget,
    required this.userId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Only load data when widget is visible
    return VisibilityDetector(
      key: Key(widget.id),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.5) {
          // Preload data when widget becomes visible
          ref.read(cachedWidgetDataProvider(widget.id, userId));
        }
      },
      child: WidgetContent(widget: widget, userId: userId),
    );
  }
}

class WidgetContent extends ConsumerWidget {
  final DashboardWidget widget;
  final String userId;

  const WidgetContent({
    super.key,
    required this.widget,
    required this.userId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dataAsync = ref.watch(cachedWidgetDataProvider(widget.id, userId));

    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Widget title
            Row(
              children: [
                Expanded(
                  child: Text(
                    widget.title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.refresh, size: 20),
                  onPressed: () {
                    ref.refresh(cachedWidgetDataProvider(widget.id, userId));
                  },
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Widget content based on data
            SizedBox(
              height: widget.position.height * 100.0, // Convert to pixels
              child: dataAsync.when(
                data: (data) => _buildWidgetContent(context, data),
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
                error: (error, stackTrace) => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error_outline, color: Colors.red),
                      const SizedBox(height: 8),
                      Text(
                        'Error: ${error.toString()}',
                        style: const TextStyle(color: Colors.red, fontSize: 12),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
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
        return Center(
          child: Text(
            'Unsupported widget type: ${widget.type}',
            style: const TextStyle(color: Colors.grey),
          ),
        );
    }
  }

  Widget _buildKPIWidget(BuildContext context, Map<String, dynamic> data) {
    final value =
        data['total']?.toString() ?? data['message']?.toString() ?? 'No data';
    final trend = data['trend']?.toString() ?? '';
    final color = data['color']?.toString();

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: _getColorFromString(color) ??
                      Theme.of(context).primaryColor,
                ),
            textAlign: TextAlign.center,
          ),
          if (trend.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                trend,
                style: TextStyle(
                  color: trend.startsWith('+') ? Colors.green : Colors.red,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildChartWidget(BuildContext context, Map<String, dynamic> data) {
    // Simple placeholder for chart - you can integrate fl_chart here
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.bar_chart, size: 48, color: Colors.grey),
            SizedBox(height: 8),
            Text('Chart Widget', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  Widget _buildTableWidget(BuildContext context, Map<String, dynamic> data) {
    final items = data['data'] as List? ?? [];

    if (items.isEmpty) {
      return const Center(
        child: Text('No data available', style: TextStyle(color: Colors.grey)),
      );
    }

    return SingleChildScrollView(
      child: Column(
        children: items.take(3).map((item) {
          // Show only first 3 items
          final itemMap = item as Map<String, dynamic>;
          return ListTile(
            dense: true,
            leading: CircleAvatar(
              radius: 16,
              child: Text(
                itemMap['name']?.toString().substring(0, 1).toUpperCase() ??
                    '?',
                style: const TextStyle(fontSize: 12),
              ),
            ),
            title: Text(
              itemMap['name']?.toString() ?? 'Unknown',
              style: const TextStyle(fontSize: 14),
            ),
            subtitle: Text(
              itemMap['description']?.toString() ?? '',
              style: const TextStyle(fontSize: 12),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: Text(
              itemMap['value']?.toString() ?? '',
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildListWidget(BuildContext context, Map<String, dynamic> data) {
    final items = data['data'] as List? ?? data['latest_data'] as List? ?? [];

    if (items.isEmpty) {
      return const Center(
        child: Text('No items available', style: TextStyle(color: Colors.grey)),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length.clamp(0, 3), // Show max 3 items
      itemBuilder: (context, index) {
        final item = items[index] as Map<String, dynamic>;
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 2),
          child: ListTile(
            dense: true,
            leading: CircleAvatar(
              radius: 12,
              child: Text('${index + 1}', style: const TextStyle(fontSize: 10)),
            ),
            title: Text(
              item['title']?.toString() ??
                  item['name']?.toString() ??
                  'Item ${index + 1}',
              style: const TextStyle(fontSize: 12),
            ),
            subtitle: Text(
              item['subtitle']?.toString() ??
                  item['description']?.toString() ??
                  '',
              style: const TextStyle(fontSize: 10),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        );
      },
    );
  }

  Color? _getColorFromString(String? colorString) {
    if (colorString == null) return null;

    switch (colorString.toLowerCase()) {
      case 'red':
        return Colors.red;
      case 'green':
        return Colors.green;
      case 'blue':
        return Colors.blue;
      case 'orange':
        return Colors.orange;
      case 'purple':
        return Colors.purple;
      default:
        return null;
    }
  }
}
