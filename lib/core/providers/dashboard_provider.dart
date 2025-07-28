// lib/core/providers/dashboard_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/dashboard_service.dart';
import '../models/dashboard_model.dart';
import 'global_providers.dart';

final dashboardServiceProvider = Provider<DashboardService>(
  (_) => DashboardService(),
);

final userDashboardProvider =
    FutureProvider.autoDispose<DashboardConfig?>((ref) async {
  final auth = ref.watch(authServiceProvider);
  final dashboardService = ref.watch(dashboardServiceProvider);

  final user = auth.currentUser;
  if (user == null) return null;

  return await dashboardService.getUserDashboard(user.uid);
});

final widgetDataProvider =
    FutureProvider.family.autoDispose<Map<String, dynamic>, DashboardWidget>(
  (ref, widget) async {
    final auth = ref.watch(authServiceProvider);
    final dashboardService = ref.watch(dashboardServiceProvider);

    final user = auth.currentUser;
    if (user == null) return {};

    return await dashboardService.getWidgetData(
        widget.id, user.uid, widget.config);
  },
);
