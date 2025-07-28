// lib/core/providers/enhanced_providers.dart
import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/dashboard_model.dart';
import 'global_providers.dart';
import 'dashboard_provider.dart' hide dashboardServiceProvider;

part 'enhanced_providers.g.dart';

// Auto-disposing provider with custom cache duration
@riverpod
class UserPermissions extends _$UserPermissions {
  @override
  Future<List<String>> build(String userId) async {
    // Auto-dispose after 2 hours of inactivity
    ref.cacheFor(const Duration(hours: 2));

    final permissionService = ref.watch(permissionServiceProvider);
    return await permissionService.getUserPermissions(userId);
  }
}

// Keyed provider with intelligent invalidation
@riverpod
class DashboardData extends _$DashboardData {
  @override
  Future<DashboardConfig?> build(String userId) async {
    // Link to user permissions - auto-invalidate when permissions change
    ref.watch(userPermissionsProvider(userId));

    final dashboardService = ref.watch(dashboardServiceProvider);
    return await dashboardService.getUserDashboard(userId);
  }
}

// Family provider for widget data with fine-grained caching
@riverpod
class WidgetDataCache extends _$WidgetDataCache {
  @override
  Future<Map<String, dynamic>> build(String widgetId, String userId) async {
    // Cache for 15 minutes
    ref.cacheFor(const Duration(minutes: 15));

    // Auto-invalidate when user switches
    ref.watch(currentUserProvider);

    final dashboardService = ref.watch(dashboardServiceProvider);
    // Implementation here
    return {};
  }
}

// Extension for cache duration
extension CacheForExtension on Ref {
  void cacheFor(Duration duration) {
    Timer(duration, () {
      invalidateSelf();
    });
  }
}
