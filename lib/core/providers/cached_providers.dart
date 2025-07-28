import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'dart:async';

import '../models/dashboard_model.dart';
import '../models/dynamic_model.dart';
import '../models/user_model.dart';
import '../services/dashboard_service.dart';
import '../services/enhanced_isar_service.dart';
import '../services/permission_service.dart';
import '../services/connectivity_service.dart';
import 'global_providers.dart';

part 'cached_providers.g.dart';

// =============================================================================
// CORE SERVICE PROVIDERS
// =============================================================================

final permissionServiceProvider =
    Provider<PermissionService>((ref) => PermissionService());
final dashboardServiceProvider =
    Provider<DashboardService>((ref) => DashboardService());

// =============================================================================
// CACHED USER DATA PROVIDERS
// =============================================================================

/// Cached user permissions with enhanced error handling
@riverpod
class CachedUserPermissions extends _$CachedUserPermissions {
  @override
  Future<List<String>> build(String userId) async {
    final connectivity = ref.watch(connectivityServiceProvider);

    try {
      // Try Isar cache first
      final cached = await EnhancedIsarService.getCachedUserPermissions(userId);
      if (cached != null) {
        // If offline, return cached data immediately
        if (connectivity.status != ConnectivityStatus.online) {
          return cached;
        }

        // If online, return cached data and refresh in background
        if (cached.isNotEmpty) {
          _refreshPermissionsInBackground(userId);
          return cached;
        }
      }

      // Fetch from service and cache
      final permissionService = ref.read(permissionServiceProvider);
      final permissions = await permissionService.getUserPermissions(userId);

      // Cache in Isar with extended duration for critical data
      await EnhancedIsarService.cacheUserPermissions(
        userId,
        permissions,
        const Duration(hours: 4), // Extended cache duration
      );

      return permissions;
    } catch (e) {
      // Try to return cached data on error
      final cached = await EnhancedIsarService.getCachedUserPermissions(userId);
      if (cached != null) {
        return cached;
      }

      // Return empty permissions as fallback
      return <String>[];
    }
  }

  /// Refresh permissions in background for better UX
  void _refreshPermissionsInBackground(String userId) {
    Future.microtask(() async {
      try {
        final permissionService = ref.read(permissionServiceProvider);
        final freshPermissions =
            await permissionService.getUserPermissions(userId);

        await EnhancedIsarService.cacheUserPermissions(
          userId,
          freshPermissions,
          const Duration(hours: 4),
        );
      } catch (e) {
        // Silent fail - user already has cached data
      }
    });
  }

  /// Force refresh permissions
  Future<void> forceRefresh(String userId) async {
    try {
      final permissionService = ref.read(permissionServiceProvider);
      final permissions = await permissionService.getUserPermissions(userId);

      await EnhancedIsarService.cacheUserPermissions(
        userId,
        permissions,
        const Duration(hours: 4),
      );

      // Invalidate to trigger rebuild
      ref.invalidateSelf();
    } catch (e) {
      throw Exception('Failed to refresh permissions: $e');
    }
  }
}

/// Cached user profile with organization context
@riverpod
class CachedUserProfile extends _$CachedUserProfile {
  @override
  Future<UserProfile?> build(String userId) async {
    final connectivity = ref.watch(connectivityServiceProvider);

    try {
      // Try Isar cache first
      final cached = await EnhancedIsarService.getCachedUserProfile(userId);
      if (cached != null) {
        if (connectivity.status != ConnectivityStatus.online) {
          return cached;
        }

        // Return cached and refresh in background
        _refreshProfileInBackground(userId);
        return cached;
      }

      // Fetch from service (you'll need to implement this)
      // final userService = ref.read(userServiceProvider);
      // final profile = await userService.getUserProfile(userId);

      // For now, return null - implement based on your user service
      return null;
    } catch (e) {
      final cached = await EnhancedIsarService.getCachedUserProfile(userId);
      return cached;
    }
  }

  void _refreshProfileInBackground(String userId) {
    Future.microtask(() async {
      try {
        // Implement profile refresh logic
        // Similar to permissions refresh
      } catch (e) {
        // Silent fail
      }
    });
  }
}

// =============================================================================
// CACHED DASHBOARD PROVIDERS
// =============================================================================

/// Enhanced cached dashboard with organization context
@riverpod
class CachedDashboard extends _$CachedDashboard {
  @override
  Future<DashboardConfig?> build(String userId) async {
    final connectivity = ref.watch(connectivityServiceProvider);

    try {
      // Try Isar cache first
      final cached = await EnhancedIsarService.getCachedDashboard(userId);
      if (cached != null) {
        // If offline, return cached data immediately
        if (connectivity.status != ConnectivityStatus.online) {
          return cached;
        }

        // If online, return cached data and refresh in background
        _refreshDashboardInBackground(userId);
        return cached;
      }

      // Fetch from service and cache
      final dashboardService = ref.read(dashboardServiceProvider);
      final dashboard = await dashboardService.getUserDashboard(userId);

      if (dashboard != null) {
        await EnhancedIsarService.cacheDashboard(
          userId,
          dashboard,
          const Duration(hours: 2), // Extended cache duration
        );
      }

      return dashboard;
    } catch (e) {
      // Try to return cached data on error
      final cached = await EnhancedIsarService.getCachedDashboard(userId);
      if (cached != null) {
        return cached;
      }

      throw Exception('Failed to load dashboard: $e');
    }
  }

  void _refreshDashboardInBackground(String userId) {
    Future.microtask(() async {
      try {
        final dashboardService = ref.read(dashboardServiceProvider);
        final freshDashboard = await dashboardService.getUserDashboard(userId);

        if (freshDashboard != null) {
          await EnhancedIsarService.cacheDashboard(
            userId,
            freshDashboard,
            const Duration(hours: 2),
          );
        }
      } catch (e) {
        // Silent fail - user already has cached data
      }
    });
  }

  /// Force refresh dashboard
  Future<void> forceRefresh(String userId) async {
    try {
      final dashboardService = ref.read(dashboardServiceProvider);
      final dashboard = await dashboardService.getUserDashboard(userId);

      if (dashboard != null) {
        await EnhancedIsarService.cacheDashboard(
          userId,
          dashboard,
          const Duration(hours: 2),
        );
      }

      // Invalidate to trigger rebuild
      ref.invalidateSelf();
    } catch (e) {
      throw Exception('Failed to refresh dashboard: $e');
    }
  }
}

/// Cached widget data with enhanced error handling
@riverpod
class CachedWidgetData extends _$CachedWidgetData {
  @override
  Future<Map<String, dynamic>> build(String widgetId, String userId) async {
    final connectivity = ref.watch(connectivityServiceProvider);

    try {
      // Try Isar cache first
      final cached =
          await EnhancedIsarService.getCachedWidgetData(widgetId, userId);
      if (cached != null) {
        // If offline, return cached data immediately
        if (connectivity.status != ConnectivityStatus.online) {
          return cached;
        }

        // If online and cache is not too old, return cached and refresh in background
        _refreshWidgetDataInBackground(widgetId, userId);
        return cached;
      }

      // Fetch from service and cache
      final dashboardService = ref.read(dashboardServiceProvider);
      final data = await dashboardService.getWidgetData(widgetId, userId, {});

      await EnhancedIsarService.cacheWidgetData(
        widgetId,
        userId,
        data,
        const Duration(minutes: 30), // Extended cache duration
      );

      return data;
    } catch (e) {
      // Try to return cached data on error
      final cached =
          await EnhancedIsarService.getCachedWidgetData(widgetId, userId);
      if (cached != null) {
        return cached;
      }

      // Return empty data as fallback
      return <String, dynamic>{
        'error': true,
        'message': 'Failed to load widget data',
        'offline': connectivity.status != ConnectivityStatus.online,
      };
    }
  }

  void _refreshWidgetDataInBackground(String widgetId, String userId) {
    Future.microtask(() async {
      try {
        final dashboardService = ref.read(dashboardServiceProvider);
        final freshData =
            await dashboardService.getWidgetData(widgetId, userId, {});

        await EnhancedIsarService.cacheWidgetData(
          widgetId,
          userId,
          freshData,
          const Duration(minutes: 30),
        );
      } catch (e) {
        // Silent fail - user already has cached data
      }
    });
  }

  /// Force refresh widget data
  Future<void> forceRefresh(String widgetId, String userId) async {
    try {
      final dashboardService = ref.read(dashboardServiceProvider);
      final data = await dashboardService.getWidgetData(widgetId, userId, {});

      await EnhancedIsarService.cacheWidgetData(
        widgetId,
        userId,
        data,
        const Duration(minutes: 30),
      );

      // Invalidate to trigger rebuild
      ref.invalidateSelf();
    } catch (e) {
      throw Exception('Failed to refresh widget data: $e');
    }
  }
}

// =============================================================================
// CACHED DYNAMIC MODEL PROVIDERS
// =============================================================================

/// Cached dynamic models for the application
@riverpod
class CachedDynamicModels extends _$CachedDynamicModels {
  @override
  Future<List<DynamicModel>> build() async {
    final connectivity = ref.watch(connectivityServiceProvider);

    try {
      // Try Isar cache first
      final cached = await EnhancedIsarService.getCachedDynamicModels();
      if (cached != null && cached.isNotEmpty) {
        if (connectivity.status != ConnectivityStatus.online) {
          return cached;
        }

        // Return cached and refresh in background
        _refreshModelsInBackground();
        return cached;
      }

      // Fetch from Firestore (implement in your service)
      // final dynamicModelService = ref.read(dynamicModelServiceProvider);
      // final models = await dynamicModelService.getAllModels();

      // For now, return empty list - implement based on your service
      return <DynamicModel>[];
    } catch (e) {
      final cached = await EnhancedIsarService.getCachedDynamicModels();
      if (cached != null) {
        return cached;
      }

      return <DynamicModel>[];
    }
  }

  void _refreshModelsInBackground() {
    Future.microtask(() async {
      try {
        // Implement models refresh logic
        // Similar to other refresh methods
      } catch (e) {
        // Silent fail
      }
    });
  }
}

/// Cached organization-specific dynamic models
@riverpod
class CachedOrgDynamicModels extends _$CachedOrgDynamicModels {
  @override
  Future<List<DynamicModel>> build(String organizationId) async {
    final connectivity = ref.watch(connectivityServiceProvider);

    try {
      // Try Isar cache first
      final cached =
          await EnhancedIsarService.getCachedOrgModels(organizationId);
      if (cached != null && cached.isNotEmpty) {
        if (connectivity.status != ConnectivityStatus.online) {
          return cached;
        }

        // Return cached and refresh in background
        _refreshOrgModelsInBackground(organizationId);
        return cached;
      }

      // Fetch from service - implement based on your needs
      return <DynamicModel>[];
    } catch (e) {
      final cached =
          await EnhancedIsarService.getCachedOrgModels(organizationId);
      return cached ?? <DynamicModel>[];
    }
  }

  void _refreshOrgModelsInBackground(String organizationId) {
    Future.microtask(() async {
      try {
        // Implement org models refresh logic
      } catch (e) {
        // Silent fail
      }
    });
  }
}

// =============================================================================
// ENHANCED CACHE MANAGER
// =============================================================================

/// Enhanced cache manager with comprehensive functionality
@riverpod
class CacheManager extends _$CacheManager {
  @override
  FutureOr<void> build() {
    return null;
  }

  /// Invalidate user-specific cache
  Future<void> invalidateUserCache(String userId) async {
    try {
      // Invalidate Riverpod providers
      ref.invalidate(cachedUserPermissionsProvider(userId));
      ref.invalidate(cachedDashboardProvider(userId));
      ref.invalidate(cachedUserProfileProvider(userId));

      // Clear Isar cache
      await EnhancedIsarService.clearUserPermissions(userId);
      await EnhancedIsarService.clearUserDashboard(userId);
      await EnhancedIsarService.clearUserProfile(userId);

      // Clear user-specific widget data
      await EnhancedIsarService.clearUserWidgetData(userId);
    } catch (e) {
      throw Exception('Failed to invalidate user cache: $e');
    }
  }

  /// Invalidate organization-specific cache
  Future<void> invalidateOrgCache(String organizationId) async {
    try {
      // Invalidate organization models
      ref.invalidate(cachedOrgDynamicModelsProvider(organizationId));

      // Clear organization cache
      await EnhancedIsarService.clearOrgModels(organizationId);
      await EnhancedIsarService.clearOrgData(organizationId);
    } catch (e) {
      throw Exception('Failed to invalidate organization cache: $e');
    }
  }

  /// Invalidate widget-specific cache
  Future<void> invalidateWidgetCache(String widgetId, String userId) async {
    try {
      // Invalidate specific widget provider
      ref.invalidate(cachedWidgetDataProvider(widgetId, userId));

      // Clear widget cache
      await EnhancedIsarService.clearWidgetData(widgetId, userId);
    } catch (e) {
      throw Exception('Failed to invalidate widget cache: $e');
    }
  }

  /// Invalidate all cache
  Future<void> invalidateAllCache() async {
    try {
      // Clear all Isar cache
      await EnhancedIsarService.clearAllCache();

      // Invalidate all providers
      ref.invalidate(cachedDynamicModelsProvider);

      // Invalidate this manager itself to refresh everything
      ref.invalidateSelf();
    } catch (e) {
      throw Exception('Failed to invalidate all cache: $e');
    }
  }

  /// Get comprehensive cache statistics
  Future<Map<String, dynamic>> getCacheStats() async {
    try {
      final basicStats = await EnhancedIsarService.getCacheStats();

      // Add additional stats
      final enhancedStats = <String, dynamic>{
        ...basicStats,
        'cacheHealth': await _getCacheHealth(),
        'lastCleared': await _getLastClearTime(),
        'activeProviders': _getActiveProviderCount(),
        'memoryUsage': await _getMemoryUsage(),
      };

      return enhancedStats;
    } catch (e) {
      return <String, dynamic>{
        'error': true,
        'message': e.toString(),
      };
    }
  }

  /// Warm up cache for better performance
  Future<void> warmUpCache(String userId, String organizationId) async {
    try {
      // Preload critical data
      final futures = <Future>[
        ref.read(cachedUserPermissionsProvider(userId).future),
        ref.read(cachedDashboardProvider(userId).future),
        ref.read(cachedOrgDynamicModelsProvider(organizationId).future),
      ];

      // Wait for all critical data to load
      await Future.wait(futures, eagerError: false);
    } catch (e) {
      // Non-critical operation, don't throw
    }
  }

  /// Optimize cache by removing expired entries
  Future<void> optimizeCache() async {
    try {
      await EnhancedIsarService.cleanupExpiredCache();

      // Trigger garbage collection for providers
      ref.invalidateSelf();
    } catch (e) {
      throw Exception('Failed to optimize cache: $e');
    }
  }

  /// Export cache data for debugging
  Future<Map<String, dynamic>> exportCacheData() async {
    try {
      return await EnhancedIsarService.exportCacheData();
    } catch (e) {
      return <String, dynamic>{
        'error': true,
        'message': e.toString(),
      };
    }
  }

  /// Import cache data (for testing/migration)
  Future<void> importCacheData(Map<String, dynamic> cacheData) async {
    try {
      await EnhancedIsarService.importCacheData(cacheData);
      ref.invalidateSelf();
    } catch (e) {
      throw Exception('Failed to import cache data: $e');
    }
  }

  // Private helper methods
  Future<Map<String, dynamic>> _getCacheHealth() async {
    try {
      final stats = await EnhancedIsarService.getCacheStats();
      final totalItems = stats['totalItems'] as int? ?? 0;
      final expiredItems = stats['expiredItems'] as int? ?? 0;

      final healthScore = totalItems > 0
          ? ((totalItems - expiredItems) / totalItems * 100).round()
          : 100;

      return {
        'score': healthScore,
        'status': healthScore > 80
            ? 'healthy'
            : healthScore > 50
                ? 'moderate'
                : 'poor',
        'expiredRatio':
            totalItems > 0 ? (expiredItems / totalItems * 100).round() : 0,
      };
    } catch (e) {
      return {
        'score': 0,
        'status': 'error',
        'error': e.toString(),
      };
    }
  }

  Future<DateTime?> _getLastClearTime() async {
    try {
      return await EnhancedIsarService.getLastClearTime();
    } catch (e) {
      return null;
    }
  }

  int _getActiveProviderCount() {
    // This would need to be implemented based on your provider tracking needs
    return 0; // Placeholder
  }

  Future<Map<String, dynamic>> _getMemoryUsage() async {
    try {
      return await EnhancedIsarService.getMemoryUsage();
    } catch (e) {
      return {'error': e.toString()};
    }
  }
}

// =============================================================================
// CACHE REFRESH SCHEDULER
// =============================================================================

/// Automated cache refresh scheduler
@riverpod
class CacheRefreshScheduler extends _$CacheRefreshScheduler {
  Timer? _refreshTimer;

  @override
  FutureOr<void> build() {
    // Start periodic refresh
    _startPeriodicRefresh();

    // Cleanup on dispose
    ref.onDispose(() {
      _refreshTimer?.cancel();
    });

    return null;
  }

  void _startPeriodicRefresh() {
    // Refresh cache every 30 minutes
    _refreshTimer = Timer.periodic(const Duration(minutes: 30), (_) {
      _performScheduledRefresh();
    });
  }

  Future<void> _performScheduledRefresh() async {
    try {
      final connectivity = ref.read(connectivityServiceProvider);

      // Only refresh if online
      if (connectivity.status == ConnectivityStatus.online) {
        final cacheManager = ref.read(cacheManagerProvider.notifier);
        await cacheManager.optimizeCache();
      }
    } catch (e) {
      // Silent fail for background operation
    }
  }

  /// Manual refresh trigger
  Future<void> triggerRefresh() async {
    await _performScheduledRefresh();
  }
}

// =============================================================================
// PROVIDER EXTENSIONS
// =============================================================================

extension CachedProviderExtensions on WidgetRef {
  /// Refresh all user data
  Future<void> refreshUserData(String userId) async {
    final cacheManager = read(cacheManagerProvider.notifier);
    await cacheManager.invalidateUserCache(userId);
  }

  /// Refresh dashboard data
  Future<void> refreshDashboard(String userId) async {
    final dashboard = read(cachedDashboardProvider(userId).notifier);
    await dashboard.forceRefresh(userId);
  }

  /// Refresh widget data
  Future<void> refreshWidget(String widgetId, String userId) async {
    final widget = read(cachedWidgetDataProvider(widgetId, userId).notifier);
    await widget.forceRefresh(widgetId, userId);
  }

  /// Refresh permissions
  Future<void> refreshPermissions(String userId) async {
    final permissions = read(cachedUserPermissionsProvider(userId).notifier);
    await permissions.forceRefresh(userId);
  }

  /// Warm up cache for user
  Future<void> warmUpUserCache(String userId, String organizationId) async {
    final cacheManager = read(cacheManagerProvider.notifier);
    await cacheManager.warmUpCache(userId, organizationId);
  }

  /// Get cache health
  Future<Map<String, dynamic>> getCacheHealth() async {
    final cacheManager = read(cacheManagerProvider.notifier);
    return await cacheManager.getCacheStats();
  }

  /// Refresh connectivity and update cache strategy
  void refreshConnectivity() {
    refresh(connectivityServiceProvider);
  }
}
