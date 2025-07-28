import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'dart:async';

import '../models/dashboard_model.dart';
import '../services/dashboard_service.dart';
import '../services/enhanced_isar_service.dart';
import '../services/hybrid_cache_service.dart';
import '../services/permission_service.dart';

part 'cached_providers.g.dart';

// Core service providers
final permissionServiceProvider =
    Provider<PermissionService>((ref) => PermissionService());
final dashboardServiceProvider =
    Provider<DashboardService>((ref) => DashboardService());

// Cached user permissions with Riverpod + Isar
@riverpod
class CachedUserPermissions extends _$CachedUserPermissions {
  @override
  Future<List<String>> build(String userId) async {
    final hybrid = HybridCacheService();
    final permissionService = ref.read(permissionServiceProvider);

    return await hybrid.get<List<String>>(
          'permissions_$userId',
          () => permissionService.getUserPermissions(userId),
          cacheDuration: const Duration(hours: 2),
          isarCache: (key, data, duration) async {
            // Fix: Add async and handle the return type properly
            await EnhancedIsarService.cacheUserPermissions(
                userId, data, duration);
          },
          isarRetrieve: (key) =>
              EnhancedIsarService.getCachedUserPermissions(userId),
        ) ??
        [];
  }

  // Invalidate cache when needed
  Future<void> invalidate() async {
    ref.invalidateSelf();
    await EnhancedIsarService.clearUserPermissions(userId);
  }
}

// Cached dashboard with Riverpod + Isar
@riverpod
class CachedDashboard extends _$CachedDashboard {
  @override
  Future<DashboardConfig?> build(String userId) async {
    final hybrid = HybridCacheService();
    final dashboardService = ref.read(dashboardServiceProvider);

    return await hybrid.get<DashboardConfig?>(
      'dashboard_$userId',
      () => dashboardService.getUserDashboard(userId),
      cacheDuration: const Duration(hours: 1),
      isarCache: (key, data, duration) async {
        // Fix: Handle null data properly
        if (data != null) {
          await EnhancedIsarService.cacheDashboard(userId, data, duration);
        }
      },
      isarRetrieve: (key) => EnhancedIsarService.getCachedDashboard(userId),
    );
  }
}

// Cached widget data
@riverpod
class CachedWidgetData extends _$CachedWidgetData {
  @override
  Future<Map<String, dynamic>> build(String widgetId, String userId) async {
    final hybrid = HybridCacheService();
    final dashboardService = ref.read(dashboardServiceProvider);

    return await hybrid.get<Map<String, dynamic>>(
          'widget_${widgetId}_$userId',
          () => dashboardService.getWidgetData(widgetId, userId, {}),
          cacheDuration: const Duration(minutes: 15),
          isarCache: (key, data, duration) async {
            // Fix: Add async
            await EnhancedIsarService.cacheWidgetData(
                widgetId, userId, data, duration);
          },
          isarRetrieve: (key) =>
              EnhancedIsarService.getCachedWidgetData(widgetId, userId),
        ) ??
        {};
  }
}

// Cache invalidation utilities
@riverpod
class CacheManager extends _$CacheManager {
  @override
  FutureOr<void> build() {
    return null;
  }

  Future<void> invalidateUserCache(String userId) async {
    ref.invalidate(cachedUserPermissionsProvider(userId));
    ref.invalidate(cachedDashboardProvider(userId));

    // Clear Isar cache
    await EnhancedIsarService.clearUserPermissions(userId);
    await EnhancedIsarService.clearUserDashboard(userId);
  }

  // FIX: Replace invalidateAll() with proper cache clearing
  Future<void> invalidateAllCache() async {
    // Clear all Isar cache first
    await EnhancedIsarService.clearAllCache();

    // Invalidate this provider to trigger rebuild
    ref.invalidateSelf();

    // Note: For family providers (providers that take parameters),
    // you need to track active instances or invalidate them individually
    // when specific user IDs are known
  }

  Future<Map<String, dynamic>> getCacheStats() async {
    return await EnhancedIsarService.getCacheStats();
  }
}

// Helper provider for global cache management
final globalCacheManagerProvider = Provider<GlobalCacheManager>((ref) {
  return GlobalCacheManager(ref);
});

class GlobalCacheManager {
  final ProviderRef _ref;

  GlobalCacheManager(this._ref);

  // Method to invalidate caches for specific users
  Future<void> invalidateUsersCache(List<String> userIds) async {
    for (final userId in userIds) {
      _ref.invalidate(cachedUserPermissionsProvider(userId));
      _ref.invalidate(cachedDashboardProvider(userId));
    }

    // Clear corresponding Isar cache
    for (final userId in userIds) {
      await EnhancedIsarService.clearUserPermissions(userId);
      await EnhancedIsarService.clearUserDashboard(userId);
    }
  }

  // Method to clear all caches (nuclear option)
  Future<void> clearAllCaches() async {
    await EnhancedIsarService.clearAllCache();

    // Invalidate cache manager
    _ref.invalidate(cacheManagerProvider);
  }
}
