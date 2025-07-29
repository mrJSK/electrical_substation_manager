import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'dart:async';

import '../models/dashboard_model.dart';
import '../models/dynamic_model.dart';
import '../models/user_model.dart';
import '../models/organization_model.dart';
import '../models/notification_model.dart';
import '../services/dashboard_service.dart';
import '../services/enhanced_isar_service.dart';
import '../services/permission_service.dart';
import '../services/connectivity_service.dart';
import 'global_providers.dart';

part 'cached_providers.g.dart';

// =============================================================================
// RIVERPOD + ISAR CACHE MANAGER (FIXED ALL TYPE ISSUES)
// =============================================================================

class IsarCacheManager {
  static IsarCacheManager? _instance;
  static IsarCacheManager get instance => _instance ??= IsarCacheManager._();
  IsarCacheManager._();

  /// Generic method to cache data using Isar
  Future<void> cacheData(String key, dynamic data, {Duration? timeout}) async {
    try {
      final effectiveTimeout = timeout ?? const Duration(hours: 1);

      if (data is UserModel) {
        await EnhancedIsarService.cacheUserProfile(key, data, effectiveTimeout);
      } else if (data is OrganizationModel) {
        await EnhancedIsarService.cacheOrganization(
            key, data, effectiveTimeout);
      } else if (data is DashboardConfig) {
        await EnhancedIsarService.cacheDashboard(key, data, effectiveTimeout);
      } else if (data is List<String>) {
        await EnhancedIsarService.cacheUserPermissions(
            key, data, effectiveTimeout);
      } else if (data is Map<String, bool>) {
        await EnhancedIsarService.cachePermissions(key, data, effectiveTimeout);
      } else if (data is Map<String, dynamic>) {
        await EnhancedIsarService.cacheGenericData(key, data, effectiveTimeout);
      } else if (data is List<DynamicModel>) {
        await EnhancedIsarService.cacheDynamicModels(
            key, data, effectiveTimeout);
      }
    } catch (e) {
      print('Failed to cache data for key $key: $e');
    }
  }

  /// Generic method to get cached data from Isar
  Future<T?> getCachedData<T>(String key, {Duration? timeout}) async {
    try {
      final effectiveTimeout = timeout ?? const Duration(hours: 1);

      if (T == UserModel) {
        return await EnhancedIsarService.getCachedUserProfile(key) as T?;
      } else if (T == OrganizationModel) {
        return await EnhancedIsarService.getCachedOrganization(key) as T?;
      } else if (T == DashboardConfig) {
        return await EnhancedIsarService.getCachedDashboard(key) as T?;
      } else if (T.toString().contains('List<String>')) {
        return await EnhancedIsarService.getCachedUserPermissions(key) as T?;
      } else if (T.toString().contains('Map<String, bool>')) {
        return await EnhancedIsarService.getCachedPermissions(key) as T?;
      } else if (T.toString().contains('Map<String, dynamic>')) {
        return await EnhancedIsarService.getCachedGenericData(key) as T?;
      } else if (T.toString().contains('List<DynamicModel>')) {
        return await EnhancedIsarService.getCachedDynamicModels() as T?;
      }

      return null;
    } catch (e) {
      print('Failed to get cached data for key $key: $e');
      return null;
    }
  }

  /// Remove specific cache entry
  Future<void> invalidateCache(String key) async {
    try {
      await EnhancedIsarService.clearCacheByKey(key);
    } catch (e) {
      print('Failed to invalidate cache for key $key: $e');
    }
  }

  /// Remove cache entries matching a pattern
  Future<void> invalidatePattern(String pattern) async {
    try {
      await EnhancedIsarService.clearCacheByPattern(pattern);
    } catch (e) {
      print('Failed to invalidate cache pattern $pattern: $e');
    }
  }

  /// Clear all cache
  Future<void> clearAllCache() async {
    try {
      await EnhancedIsarService.clearAllCache();
    } catch (e) {
      print('Failed to clear all cache: $e');
    }
  }

  /// Get cache statistics
  Future<Map<String, dynamic>> getCacheStatistics() async {
    try {
      return await EnhancedIsarService.getCacheStats();
    } catch (e) {
      return {
        'error': true,
        'message': e.toString(),
      };
    }
  }

  /// Specific helper methods for common cache operations
  Future<UserModel?> getCachedUserProfile(String userId) async {
    return getCachedData<UserModel>('user_profile_$userId');
  }

  Future<void> cacheUserProfile(String userId, UserModel user) async {
    return cacheData('user_profile_$userId', user);
  }

  Future<OrganizationModel?> getCachedOrganization(String orgId) async {
    return getCachedData<OrganizationModel>('organization_$orgId');
  }

  Future<void> cacheOrganization(String orgId, OrganizationModel org) async {
    return cacheData('organization_$orgId', org);
  }

  Future<Map<String, bool>?> getCachedPermissions(String userId) async {
    return getCachedData<Map<String, bool>>('permissions_$userId');
  }

  Future<void> cachePermissions(
      String userId, Map<String, bool> permissions) async {
    return cacheData('permissions_$userId', permissions);
  }

  Future<DashboardConfig?> getCachedDashboard(String userId) async {
    return getCachedData<DashboardConfig>('dashboard_$userId');
  }

  Future<void> cacheDashboard(String userId, DashboardConfig dashboard) async {
    return cacheData('dashboard_$userId', dashboard);
  }

  Future<Map<String, dynamic>?> getCachedWidgetData(String cacheKey) async {
    return getCachedData<Map<String, dynamic>>(cacheKey);
  }

  Future<void> cacheWidgetData(
      String cacheKey, Map<String, dynamic> data) async {
    return cacheData(cacheKey, data, timeout: Duration(minutes: 30));
  }
}

// =============================================================================
// CORE SERVICE PROVIDERS (FIXED TYPE ANNOTATIONS)
// =============================================================================

final permissionServiceProvider =
    Provider<PermissionService>((ref) => PermissionService());

final dashboardServiceProvider =
    Provider<DashboardService>((ref) => DashboardService());

// Isar-only cache manager provider
final isarCacheManagerProvider = Provider<IsarCacheManager>((ref) {
  return IsarCacheManager.instance;
});

// =============================================================================
// CACHED USER DATA PROVIDERS (FIXED TYPE ANNOTATIONS)
// =============================================================================

/// Cached user permissions with enhanced error handling
/// Cached user permissions with enhanced error handling
@riverpod
class CachedUserPermissions extends _$CachedUserPermissions {
  @override
  Future<Map<String, bool>> build(String userId) async {
    // Changed return type
    final connectivity = ref.watch(connectivityServiceProvider);
    final cacheManager = ref.watch(isarCacheManagerProvider);

    try {
      // Try Isar cache first
      final cached = await cacheManager.getCachedData<Map<String, bool>>(
          'user_permissions_$userId'); // Changed type
      if (cached != null && cached.isNotEmpty) {
        if (connectivity.status != ConnectivityStatus.online) {
          return cached;
        }
        _refreshPermissionsInBackground(userId);
        return cached;
      }

      // Fetch from service and cache
      final permissionService = ref.read(permissionServiceProvider);
      final permissions = await permissionService.getUserPermissions(userId);

      // Cache in Isar
      await cacheManager.cacheData(
        'user_permissions_$userId',
        permissions,
        timeout: const Duration(hours: 4),
      );

      return permissions;
    } catch (e) {
      // Try to return cached data on error
      final cached = await cacheManager.getCachedData<Map<String, bool>>(
          'user_permissions_$userId'); // Changed type
      return cached ?? <String, bool>{};
    }
  }

  void _refreshPermissionsInBackground(String userId) {
    Future.microtask(() async {
      try {
        final permissionService = ref.read(permissionServiceProvider);
        final cacheManager = ref.read(isarCacheManagerProvider);
        final freshPermissions =
            await permissionService.getUserPermissions(userId);

        await cacheManager.cacheData(
          'user_permissions_$userId',
          freshPermissions,
          timeout: const Duration(hours: 4),
        );
      } catch (e) {
        // Silent fail - user already has cached data
      }
    });
  }

  Future<void> forceRefresh(String userId) async {
    try {
      final permissionService = ref.read(permissionServiceProvider);
      final cacheManager = ref.read(isarCacheManagerProvider);
      final permissions = await permissionService.getUserPermissions(userId);

      await cacheManager.cacheData(
        'user_permissions_$userId',
        permissions,
        timeout: const Duration(hours: 4),
      );

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
  Future<UserModel?> build(String userId) async {
    final connectivity = ref.watch(connectivityServiceProvider);
    final cacheManager = ref.watch(isarCacheManagerProvider);

    try {
      // Try Isar cache first
      final cached = await cacheManager.getCachedUserProfile(userId);
      if (cached != null) {
        if (connectivity.status != ConnectivityStatus.online) {
          return cached;
        }
        _refreshProfileInBackground(userId);
        return cached;
      }

      // For now, return null - implement based on your user service
      return null;
    } catch (e) {
      return await cacheManager.getCachedUserProfile(userId);
    }
  }

  void _refreshProfileInBackground(String userId) {
    Future.microtask(() async {
      try {
        // Implement profile refresh logic when you have the service
      } catch (e) {
        // Silent fail
      }
    });
  }
}

// =============================================================================
// CACHED DASHBOARD PROVIDERS (FIXED TYPE ANNOTATIONS)
// =============================================================================

/// Enhanced cached dashboard with organization context
@riverpod
class CachedDashboard extends _$CachedDashboard {
  @override
  Future<DashboardConfig?> build(String userId) async {
    final connectivity = ref.watch(connectivityServiceProvider);
    final cacheManager = ref.watch(isarCacheManagerProvider);

    try {
      // Try Isar cache first
      final cached = await cacheManager.getCachedDashboard(userId);
      if (cached != null) {
        if (connectivity.status != ConnectivityStatus.online) {
          return cached;
        }
        _refreshDashboardInBackground(userId);
        return cached;
      }

      // Fetch from service and cache
      final dashboardService = ref.read(dashboardServiceProvider);
      final dashboard = await dashboardService.getUserDashboard(userId);

      if (dashboard != null) {
        await cacheManager.cacheDashboard(userId, dashboard);
      }

      return dashboard;
    } catch (e) {
      // Try to return cached data on error
      return await cacheManager.getCachedDashboard(userId);
    }
  }

  void _refreshDashboardInBackground(String userId) {
    Future.microtask(() async {
      try {
        final dashboardService = ref.read(dashboardServiceProvider);
        final cacheManager = ref.read(isarCacheManagerProvider);
        final freshDashboard = await dashboardService.getUserDashboard(userId);

        if (freshDashboard != null) {
          await cacheManager.cacheDashboard(userId, freshDashboard);
        }
      } catch (e) {
        // Silent fail - user already has cached data
      }
    });
  }

  Future<void> forceRefresh(String userId) async {
    try {
      final dashboardService = ref.read(dashboardServiceProvider);
      final cacheManager = ref.read(isarCacheManagerProvider);
      final dashboard = await dashboardService.getUserDashboard(userId);

      if (dashboard != null) {
        await cacheManager.cacheDashboard(userId, dashboard);
      }

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
    final cacheManager = ref.watch(isarCacheManagerProvider);
    final cacheKey = 'widget_${widgetId}_$userId';

    try {
      // Try Isar cache first
      final cached = await cacheManager.getCachedWidgetData(cacheKey);
      if (cached != null) {
        if (connectivity.status != ConnectivityStatus.online) {
          return cached;
        }
        _refreshWidgetDataInBackground(widgetId, userId);
        return cached;
      }

      // Fetch from service and cache
      final dashboardService = ref.read(dashboardServiceProvider);
      final data = await dashboardService.getWidgetData(widgetId, userId, {});

      await cacheManager.cacheWidgetData(cacheKey, data);

      return data;
    } catch (e) {
      // Try to return cached data on error
      final cached = await cacheManager.getCachedWidgetData(cacheKey);
      if (cached != null) {
        return cached;
      }

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
        final cacheManager = ref.read(isarCacheManagerProvider);
        final cacheKey = 'widget_${widgetId}_$userId';
        final freshData =
            await dashboardService.getWidgetData(widgetId, userId, {});

        await cacheManager.cacheWidgetData(cacheKey, freshData);
      } catch (e) {
        // Silent fail - user already has cached data
      }
    });
  }

  Future<void> forceRefresh(String widgetId, String userId) async {
    try {
      final dashboardService = ref.read(dashboardServiceProvider);
      final cacheManager = ref.read(isarCacheManagerProvider);
      final cacheKey = 'widget_${widgetId}_$userId';
      final data = await dashboardService.getWidgetData(widgetId, userId, {});

      await cacheManager.cacheWidgetData(cacheKey, data);

      ref.invalidateSelf();
    } catch (e) {
      throw Exception('Failed to refresh widget data: $e');
    }
  }
}

// =============================================================================
// CACHED DYNAMIC MODEL PROVIDERS (FIXED TYPE ANNOTATIONS)
// =============================================================================

/// Cached dynamic models for the application
@riverpod
class CachedDynamicModels extends _$CachedDynamicModels {
  @override
  Future<List<DynamicModel>> build() async {
    final connectivity = ref.watch(connectivityServiceProvider);
    final cacheManager = ref.watch(isarCacheManagerProvider);

    try {
      // Try Isar cache first
      final cached = await cacheManager
          .getCachedData<List<DynamicModel>>('dynamic_models');
      if (cached != null && cached.isNotEmpty) {
        if (connectivity.status != ConnectivityStatus.online) {
          return cached;
        }
        _refreshModelsInBackground();
        return cached;
      }

      // For now, return empty list - implement based on your service
      return <DynamicModel>[];
    } catch (e) {
      final cached = await cacheManager
          .getCachedData<List<DynamicModel>>('dynamic_models');
      return cached ?? <DynamicModel>[];
    }
  }

  void _refreshModelsInBackground() {
    Future.microtask(() async {
      try {
        // Implement models refresh logic when you have the service
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
    final cacheManager = ref.watch(isarCacheManagerProvider);

    try {
      // Try Isar cache first
      final cached = await cacheManager
          .getCachedData<List<DynamicModel>>('org_models_$organizationId');
      if (cached != null && cached.isNotEmpty) {
        if (connectivity.status != ConnectivityStatus.online) {
          return cached;
        }
        _refreshOrgModelsInBackground(organizationId);
        return cached;
      }

      // For now, return empty list - implement based on your service
      return <DynamicModel>[];
    } catch (e) {
      final cached = await cacheManager
          .getCachedData<List<DynamicModel>>('org_models_$organizationId');
      return cached ?? <DynamicModel>[];
    }
  }

  void _refreshOrgModelsInBackground(String organizationId) {
    Future.microtask(() async {
      try {
        // Implement org models refresh logic when you have the service
      } catch (e) {
        // Silent fail
      }
    });
  }
}

// =============================================================================
// ENHANCED CACHE MANAGER (RIVERPOD + ISAR ONLY) - FIXED ALL TYPES
// =============================================================================

/// Enhanced cache manager with comprehensive functionality
@riverpod
class CacheManager extends _$CacheManager {
  @override
  FutureOr<void> build() {
    return null;
  }

  /// Get the Isar cache manager instance
  IsarCacheManager get _cacheManager => ref.read(isarCacheManagerProvider);

  /// Generic cache operations
  Future<void> cacheData(String key, dynamic data, {Duration? timeout}) async {
    return _cacheManager.cacheData(key, data, timeout: timeout);
  }

  Future<T?> getCachedData<T>(String key, {Duration? timeout}) async {
    return _cacheManager.getCachedData<T>(key, timeout: timeout);
  }

  /// Pattern-based invalidation
  Future<void> invalidatePattern(String pattern) async {
    return _cacheManager.invalidatePattern(pattern);
  }

  /// Specific helper methods for common operations
  Future<UserModel?> getCachedUserProfile(String userId) async {
    return _cacheManager.getCachedUserProfile(userId);
  }

  Future<void> cacheUserProfile(String userId, UserModel user) async {
    return _cacheManager.cacheUserProfile(userId, user);
  }

  Future<OrganizationModel?> getCachedOrganization(String orgId) async {
    return _cacheManager.getCachedOrganization(orgId);
  }

  Future<void> cacheOrganization(String orgId, OrganizationModel org) async {
    return _cacheManager.cacheOrganization(orgId, org);
  }

  Future<Map<String, bool>?> getCachedPermissions(String userId) async {
    return _cacheManager.getCachedPermissions(userId);
  }

  Future<void> cachePermissions(
      String userId, Map<String, bool> permissions) async {
    return _cacheManager.cachePermissions(userId, permissions);
  }

  Future<DashboardConfig?> getCachedDashboard(String userId) async {
    return _cacheManager.getCachedDashboard(userId);
  }

  Future<void> cacheDashboard(String userId, DashboardConfig dashboard) async {
    return _cacheManager.cacheDashboard(userId, dashboard);
  }

  Future<Map<String, dynamic>?> getCachedWidgetData(String cacheKey) async {
    return _cacheManager.getCachedWidgetData(cacheKey);
  }

  Future<void> cacheWidgetData(
      String cacheKey, Map<String, dynamic> data) async {
    return _cacheManager.cacheWidgetData(cacheKey, data);
  }

  /// Invalidate user-specific cache
  Future<void> invalidateUserCache(String userId) async {
    try {
      // Invalidate Riverpod providers
      ref.invalidate(cachedUserPermissionsProvider(userId));
      ref.invalidate(cachedDashboardProvider(userId));
      ref.invalidate(cachedUserProfileProvider(userId));

      // Clear Isar cache using pattern matching
      await _cacheManager.invalidatePattern('*_$userId');
    } catch (e) {
      throw Exception('Failed to invalidate user cache: $e');
    }
  }

  /// Invalidate organization-specific cache
  Future<void> invalidateOrgCache(String organizationId) async {
    try {
      // Invalidate organization models
      ref.invalidate(cachedOrgDynamicModelsProvider(organizationId));

      // Clear Isar cache using pattern matching
      await _cacheManager.invalidatePattern('*_$organizationId');
    } catch (e) {
      throw Exception('Failed to invalidate organization cache: $e');
    }
  }

  /// Invalidate widget-specific cache
  Future<void> invalidateWidgetCache(String widgetId, String userId) async {
    try {
      // Invalidate specific widget provider
      ref.invalidate(cachedWidgetDataProvider(widgetId, userId));

      // Clear Isar cache
      await _cacheManager.invalidateCache('widget_${widgetId}_$userId');
    } catch (e) {
      throw Exception('Failed to invalidate widget cache: $e');
    }
  }

  /// Invalidate all cache
  Future<void> invalidateAllCache() async {
    try {
      // Clear all Isar cache
      await _cacheManager.clearAllCache();

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
      final stats = await _cacheManager.getCacheStatistics();

      // Add additional stats
      final enhancedStats = <String, dynamic>{
        ...stats,
        'cacheHealth': await _getCacheHealth(),
        'lastCleared': await _getLastClearTime(),
        'activeProviders': _getActiveProviderCount(),
        'cacheType': 'Isar Only',
        'timestamp': DateTime.now().toIso8601String(),
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
      // Cleanup expired entries in Isar
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
}

// =============================================================================
// CACHE REFRESH SCHEDULER (FIXED TYPE ANNOTATIONS)
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
// PROVIDER EXTENSIONS (FIXED TYPE ANNOTATIONS)
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

  /// Use Isar cache manager directly
  IsarCacheManager get isarCache {
    return read(isarCacheManagerProvider);
  }
}

// =============================================================================
// CACHE PERFORMANCE MONITOR (FIXED TYPE ANNOTATIONS)
// =============================================================================

/// Monitor cache performance and optimize automatically
@riverpod
class CachePerformanceMonitor extends _$CachePerformanceMonitor {
  @override
  FutureOr<Map<String, dynamic>> build() async {
    return await _getPerformanceMetrics();
  }

  Future<Map<String, dynamic>> _getPerformanceMetrics() async {
    try {
      final cacheManager = ref.read(cacheManagerProvider.notifier);
      final stats = await cacheManager.getCacheStats();

      return {
        'cacheHitRatio': _calculateHitRatio(stats),
        'avgResponseTime': _calculateAvgResponseTime(),
        'memoryUsage': stats['memoryUsage'] ?? {},
        'recommendations': _generateRecommendations(stats),
      };
    } catch (e) {
      return {
        'error': true,
        'message': e.toString(),
      };
    }
  }

  double _calculateHitRatio(Map<String, dynamic> stats) {
    // Implement cache hit ratio calculation based on your stats
    return 0.85; // Placeholder
  }

  double _calculateAvgResponseTime() {
    // Implement response time calculation
    return 150.0; // milliseconds placeholder
  }

  List<String> _generateRecommendations(Map<String, dynamic> stats) {
    final recommendations = <String>[];

    final cacheHealth = stats['cacheHealth'];
    if (cacheHealth != null && cacheHealth['score'] < 70) {
      recommendations.add('Consider clearing expired cache entries');
    }

    // Add more intelligent recommendations
    return recommendations;
  }

  /// Trigger performance optimization
  Future<void> optimizePerformance() async {
    final cacheManager = ref.read(cacheManagerProvider.notifier);
    await cacheManager.optimizeCache();
    ref.invalidateSelf(); // Refresh metrics
  }
}
