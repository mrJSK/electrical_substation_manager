import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/dashboard_model.dart';
import '../models/dynamic_model.dart';
import '../models/user_model.dart';
import '../services/enhanced_isar_service.dart';
import '../services/connectivity_service.dart';
import 'global_providers.dart';
import 'cached_providers.dart';

part 'enhanced_providers.g.dart';

// =============================================================================
// ENHANCED USER DATA PROVIDERS
// =============================================================================

/// Enhanced user permissions with intelligent caching and connectivity awareness
@riverpod
class UserPermissions extends _$UserPermissions {
  @override
  Future<List<String>> build(String userId) async {
    // Enhanced cache management with connectivity awareness
    ref.cacheForWithConnectivity(const Duration(hours: 4));

    // Link to connectivity for automatic refresh
    final connectivity = ref.watch(connectivityServiceProvider);

    try {
      // Use cached provider for better performance
      return await ref.watch(cachedUserPermissionsProvider(userId).future);
    } catch (e) {
      // Enhanced error handling
      if (connectivity.status == ConnectivityStatus.offline) {
        // Try to get from local cache
        final cached =
            await EnhancedIsarService.getCachedUserPermissions(userId);
        if (cached != null) {
          return cached;
        }
      }

      // Return minimal permissions as fallback
      return ['viewer']; // Basic permission for degraded experience
    }
  }

  /// Force refresh permissions with error handling
  Future<void> forceRefresh(String userId) async {
    try {
      final permissions =
          ref.read(cachedUserPermissionsProvider(userId).notifier);
      await permissions.forceRefresh(userId);
      ref.invalidateSelf();
    } catch (e) {
      throw Exception('Failed to refresh permissions: $e');
    }
  }

  /// Check if user has specific permission
  Future<bool> hasPermission(String userId, String permission) async {
    try {
      final permissions = await future;
      return permissions.contains(permission) || permissions.contains('admin');
    } catch (e) {
      return false; // Deny access on error
    }
  }

  /// Get user role based on permissions
  Future<String> getUserRole(String userId) async {
    try {
      final permissions = await future;

      if (permissions.contains('admin')) return 'Administrator';
      if (permissions.contains('supervisor')) return 'Supervisor';
      if (permissions.contains('maintenance_tech'))
        return 'Maintenance Technician';
      if (permissions.contains('operator')) return 'Operator';
      if (permissions.contains('viewer')) return 'Viewer';

      return 'Guest';
    } catch (e) {
      return 'Guest';
    }
  }
}

/// Enhanced user profile with organization context
@riverpod
class UserProfileData extends _$UserProfileData {
  @override
  Future<UserProfile?> build(String userId) async {
    // Cache for extended period as profile data changes less frequently
    ref.cacheForWithConnectivity(const Duration(hours: 6));

    // Link to user permissions for consistency
    ref.watch(userPermissionsProvider(userId));

    try {
      return await ref.watch(cachedUserProfileProvider(userId).future);
    } catch (e) {
      // Return null on error - UI should handle gracefully
      return null;
    }
  }

  /// Update user profile
  Future<void> updateProfile(
      String userId, Map<String, dynamic> updates) async {
    try {
      // Implement profile update logic here
      // final userService = ref.read(userServiceProvider);
      // await userService.updateProfile(userId, updates);

      // Invalidate cache after update
      ref.invalidate(cachedUserProfileProvider(userId));
      ref.invalidateSelf();
    } catch (e) {
      throw Exception('Failed to update profile: $e');
    }
  }
}

// =============================================================================
// ENHANCED DASHBOARD PROVIDERS
// =============================================================================

/// Enhanced dashboard data with intelligent dependency management
@riverpod
class DashboardData extends _$DashboardData {
  @override
  Future<DashboardConfig?> build(String userId) async {
    // Cache with smart invalidation
    ref.cacheForWithConnectivity(const Duration(hours: 2));

    // Auto-invalidate when permissions change (affects widget visibility)
    ref.watch(userPermissionsProvider(userId));

    // Watch connectivity for offline behavior
    final connectivity = ref.watch(connectivityServiceProvider);

    try {
      // Use cached provider for consistency
      final dashboard = await ref.watch(cachedDashboardProvider(userId).future);

      if (dashboard != null) {
        // Filter widgets based on current permissions
        final permissions =
            await ref.watch(userPermissionsProvider(userId).future);
        final filteredWidgets = dashboard.widgets.where((widget) {
          return widget.requiredPermissions.isEmpty ||
              widget.requiredPermissions
                  .any((perm) => permissions.contains(perm));
        }).toList();

        return dashboard.copyWith(widgets: filteredWidgets);
      }

      return dashboard;
    } catch (e) {
      // Enhanced error handling with offline support
      if (connectivity.status == ConnectivityStatus.offline) {
        final cached = await EnhancedIsarService.getCachedDashboard(userId);
        return cached;
      }

      throw Exception('Failed to load dashboard: $e');
    }
  }

  /// Refresh dashboard with widget updates
  Future<void> refreshDashboard(String userId) async {
    try {
      final dashboard = ref.read(cachedDashboardProvider(userId).notifier);
      await dashboard.forceRefresh(userId);
      ref.invalidateSelf();
    } catch (e) {
      throw Exception('Failed to refresh dashboard: $e');
    }
  }

  /// Update widget configuration
  Future<void> updateWidgetConfig(
      String userId, String widgetId, Map<String, dynamic> config) async {
    try {
      // Implement widget config update
      // final dashboardService = ref.read(dashboardServiceProvider);
      // await dashboardService.updateWidgetConfig(userId, widgetId, config);

      // Invalidate related caches
      ref.invalidate(cachedDashboardProvider(userId));
      ref.invalidateSelf();
    } catch (e) {
      throw Exception('Failed to update widget config: $e');
    }
  }

  /// Get dashboard statistics
  Future<Map<String, dynamic>> getDashboardStats(String userId) async {
    try {
      final dashboard = await future;
      if (dashboard == null) return {};

      return {
        'totalWidgets': dashboard.widgets.length,
        'visibleWidgets': dashboard.widgets.where((w) => w.isVisible).length,
        'criticalWidgets':
            dashboard.widgets.where((w) => w.priority == 'high').length,
        'lastUpdated': dashboard.updatedAt?.toIso8601String(),
        'layout': dashboard.layoutConfig,
      };
    } catch (e) {
      return {'error': e.toString()};
    }
  }
}

/// Enhanced widget data cache with real-time updates
@riverpod
class WidgetDataCache extends _$WidgetDataCache {
  Timer? _refreshTimer;

  @override
  Future<Map<String, dynamic>> build(String widgetId, String userId) async {
    // Shorter cache for real-time data
    ref.cacheForWithConnectivity(const Duration(minutes: 30));

    // Auto-invalidate when user switches
    ref.watch(currentUserProvider);

    // Link to dashboard changes
    ref.watch(dashboardDataProvider(userId));

    // Setup auto-refresh for critical widgets
    _setupAutoRefresh(widgetId, userId);

    // Cleanup on dispose
    ref.onDispose(() {
      _refreshTimer?.cancel();
    });

    try {
      return await ref.watch(cachedWidgetDataProvider(widgetId, userId).future);
    } catch (e) {
      // Enhanced error handling
      final connectivity = ref.watch(connectivityServiceProvider);

      if (connectivity.status == ConnectivityStatus.offline) {
        final cached =
            await EnhancedIsarService.getCachedWidgetData(widgetId, userId);
        if (cached != null) {
          return {
            ...cached,
            'offline': true,
            'lastUpdated': DateTime.now().toIso8601String(),
          };
        }
      }

      return {
        'error': true,
        'message': 'Failed to load widget data',
        'widgetId': widgetId,
        'offline': connectivity.status == ConnectivityStatus.offline,
      };
    }
  }

  void _setupAutoRefresh(String widgetId, String userId) {
    // Auto refresh for real-time widgets every 2 minutes
    _refreshTimer = Timer.periodic(const Duration(minutes: 2), (_) async {
      try {
        final connectivity = ref.read(connectivityServiceProvider);
        if (connectivity.status == ConnectivityStatus.online) {
          final widgetData =
              ref.read(cachedWidgetDataProvider(widgetId, userId).notifier);
          await widgetData.forceRefresh(widgetId, userId);
        }
      } catch (e) {
        // Silent fail for background refresh
      }
    });
  }

  /// Force refresh widget data
  Future<void> forceRefresh(String widgetId, String userId) async {
    try {
      final widgetData =
          ref.read(cachedWidgetDataProvider(widgetId, userId).notifier);
      await widgetData.forceRefresh(widgetId, userId);
      ref.invalidateSelf();
    } catch (e) {
      throw Exception('Failed to refresh widget data: $e');
    }
  }

  /// Get widget performance metrics
  Future<Map<String, dynamic>> getWidgetMetrics(
      String widgetId, String userId) async {
    try {
      final data = await future;

      return {
        'loadTime': data['loadTime'] ?? 0,
        'dataPoints': data['data']?.length ?? 0,
        'lastUpdate': data['timestamp'] ?? DateTime.now().toIso8601String(),
        'cacheHit': data.containsKey('cached'),
        'errorRate': data.containsKey('error') ? 1.0 : 0.0,
      };
    } catch (e) {
      return {
        'error': true,
        'message': e.toString(),
      };
    }
  }
}

// =============================================================================
// DYNAMIC MODEL PROVIDERS
// =============================================================================

/// Enhanced dynamic models provider with organization context
@riverpod
class DynamicModelsData extends _$DynamicModelsData {
  @override
  Future<List<DynamicModel>> build(String? organizationId) async {
    // Cache for extended period as models change less frequently
    ref.cacheForWithConnectivity(const Duration(hours: 4));

    // Link to user permissions for model access control
    final currentUser = ref.watch(currentUserProvider);
    final userId = currentUser.value?.uid;

    if (userId != null) {
      ref.watch(userPermissionsProvider(userId));
    }

    try {
      if (organizationId != null) {
        return await ref
            .watch(cachedOrgDynamicModelsProvider(organizationId).future);
      } else {
        return await ref.watch(cachedDynamicModelsProvider.future);
      }
    } catch (e) {
      // Return empty list on error
      return <DynamicModel>[];
    }
  }

  /// Get models by category
  Future<List<DynamicModel>> getModelsByCategory(String category) async {
    try {
      final models = await future;
      return models
          .where((model) =>
              model.category?.toLowerCase() == category.toLowerCase())
          .toList();
    } catch (e) {
      return <DynamicModel>[];
    }
  }

  /// Search models
  Future<List<DynamicModel>> searchModels(String query) async {
    try {
      final models = await future;
      final searchTerm = query.toLowerCase();

      return models
          .where((model) =>
              model.modelName.toLowerCase().contains(searchTerm) ||
              model.displayName.toLowerCase().contains(searchTerm) ||
              (model.description?.toLowerCase().contains(searchTerm) ?? false))
          .toList();
    } catch (e) {
      return <DynamicModel>[];
    }
  }

  /// Get model statistics
  Future<Map<String, dynamic>> getModelsStats() async {
    try {
      final models = await future;

      final stats = <String, dynamic>{
        'totalModels': models.length,
        'activeModels': models.where((m) => m.isActive).length,
        'categories': <String, int>{},
        'avgFieldsPerModel': 0.0,
      };

      // Category distribution
      final categories = <String, int>{};
      int totalFields = 0;

      for (final model in models) {
        final category = model.category ?? 'Other';
        categories[category] = (categories[category] ?? 0) + 1;
        totalFields += model.fields.length;
      }

      stats['categories'] = categories;
      stats['avgFieldsPerModel'] =
          models.isNotEmpty ? totalFields / models.length : 0.0;

      return stats;
    } catch (e) {
      return {'error': e.toString()};
    }
  }
}

/// Specific model provider with validation
@riverpod
class DynamicModelByName extends _$DynamicModelByName {
  @override
  Future<DynamicModel?> build(String modelName, String? organizationId) async {
    // Cache for extended period
    ref.cacheForWithConnectivity(const Duration(hours: 2));

    // Link to models data
    ref.watch(dynamicModelsDataProvider(organizationId));

    try {
      final models =
          await ref.watch(dynamicModelsDataProvider(organizationId).future);
      return models.firstWhere(
        (model) => model.modelName == modelName,
        orElse: () => throw StateError('Model not found'),
      );
    } catch (e) {
      return null;
    }
  }

  /// Validate model configuration
  Future<List<String>> validateModel(
      String modelName, String? organizationId) async {
    try {
      final model = await future;
      if (model == null) {
        return ['Model not found'];
      }

      final issues = <String>[];

      // Basic validation
      if (model.fields.isEmpty) {
        issues.add('Model has no fields defined');
      }

      // Check required fields
      for (final requiredField in model.requiredFields) {
        if (!model.fields.containsKey(requiredField)) {
          issues.add(
              'Required field "$requiredField" not found in model definition');
        }
      }

      // Check selection fields have options
      for (final field in model.fields.values) {
        if (field.isSelectionField && field.options.isEmpty) {
          issues.add(
              'Selection field "${field.fieldName}" has no options defined');
        }
      }

      return issues;
    } catch (e) {
      return ['Validation error: $e'];
    }
  }

  /// Get model usage statistics
  Future<Map<String, dynamic>> getModelUsage(
      String modelName, String? organizationId) async {
    try {
      final model = await future;
      if (model == null) return {};

      // This would typically come from your analytics service
      return {
        'totalRecords': 0, // Implement based on your record counting logic
        'recentActivity': [], // Recent model usage
        'popularFields': [], // Most used fields
        'validationErrors': [], // Common validation errors
      };
    } catch (e) {
      return {'error': e.toString()};
    }
  }
}

// =============================================================================
// SYSTEM HEALTH AND MONITORING PROVIDERS
// =============================================================================

/// System health monitoring provider
@riverpod
class SystemHealth extends _$SystemHealth {
  @override
  Future<Map<String, dynamic>> build() async {
    // Refresh every 5 minutes
    ref.cacheForWithConnectivity(const Duration(minutes: 5));

    try {
      final connectivity = ref.watch(connectivityServiceProvider);
      final cacheManager = ref.read(cacheManagerProvider.notifier);

      // Get various health metrics
      final cacheStats = await cacheManager.getCacheStats();

      final health = <String, dynamic>{
        'timestamp': DateTime.now().toIso8601String(),
        'connectivity': connectivity.status.name,
        'cache': cacheStats,
        'overall_status': 'healthy', // Determine based on metrics
        'uptime': DateTime.now()
            .difference(DateTime.now())
            .inMinutes, // Implement properly
        'memory_usage': await _getMemoryUsage(),
        'error_rate': 0.0, // Implement error tracking
      };

      // Determine overall health
      health['overall_status'] = _determineOverallHealth(health);

      return health;
    } catch (e) {
      return {
        'timestamp': DateTime.now().toIso8601String(),
        'overall_status': 'error',
        'error': e.toString(),
      };
    }
  }

  String _determineOverallHealth(Map<String, dynamic> metrics) {
    // Implement health scoring logic
    final cacheHealth = metrics['cache']?['cacheHealth']?['score'] as int? ?? 0;
    final errorRate = metrics['error_rate'] as double? ?? 0.0;
    final isOnline = metrics['connectivity'] == 'online';

    if (!isOnline) return 'degraded';
    if (errorRate > 0.1) return 'unhealthy';
    if (cacheHealth < 50) return 'degraded';

    return 'healthy';
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
// ENHANCED CACHE EXTENSIONS
// =============================================================================

/// Enhanced cache extension with connectivity awareness
extension EnhancedCacheForExtension on Ref {
  /// Cache with connectivity awareness - extends cache time when offline
  void cacheForWithConnectivity(Duration duration) {
    Timer? cacheTimer;
    StreamSubscription? connectivitySub;

    void setupTimer(Duration cacheDuration) {
      cacheTimer?.cancel();
      cacheTimer = Timer(cacheDuration, () {
        invalidateSelf();
      });
    }

    // Watch connectivity and adjust cache behavior
    connectivitySub =
        watch(connectivityServiceProvider.stream).listen((connectivity) {
      if (connectivity.status == ConnectivityStatus.offline) {
        // Extend cache time when offline
        setupTimer(duration * 2);
      } else {
        // Normal cache time when online
        setupTimer(duration);
      }
    });

    // Initial setup
    setupTimer(duration);

    // Cleanup
    onDispose(() {
      cacheTimer?.cancel();
      connectivitySub?.cancel();
    });
  }

  /// Cache with custom invalidation conditions
  void cacheUntil(bool Function() condition, {Duration? maxDuration}) {
    Timer? checkTimer;
    Timer? maxTimer;

    void checkCondition() {
      if (condition()) {
        invalidateSelf();
        return;
      }

      // Check again in 30 seconds
      checkTimer = Timer(const Duration(seconds: 30), checkCondition);
    }

    // Start checking
    checkCondition();

    // Set maximum cache duration if provided
    if (maxDuration != null) {
      maxTimer = Timer(maxDuration, () {
        invalidateSelf();
      });
    }

    // Cleanup
    onDispose(() {
      checkTimer?.cancel();
      maxTimer?.cancel();
    });
  }

  /// Cache with dependencies - invalidate when any dependency changes
  void cacheWithDependencies(
      Duration duration, List<ProviderBase> dependencies) {
    Timer? cacheTimer;
    final subscriptions = <StreamSubscription>[];

    void setupCache() {
      cacheTimer?.cancel();
      cacheTimer = Timer(duration, () {
        invalidateSelf();
      });
    }

    // Watch all dependencies
    for (final dependency in dependencies) {
      try {
        // This is a simplified approach - in practice you'd need proper dependency watching
        subscriptions.add(watch(dependency.stream).listen((_) {
          invalidateSelf();
        }));
      } catch (e) {
        // Handle dependencies that don't have streams
      }
    }

    setupCache();

    // Cleanup
    onDispose(() {
      cacheTimer?.cancel();
      for (final sub in subscriptions) {
        sub.cancel();
      }
    });
  }
}

// =============================================================================
// PROVIDER UTILITIES
// =============================================================================

/// Utility class for provider management
class ProviderUtils {
  /// Warm up critical providers for better performance
  static Future<void> warmUpProviders(
      WidgetRef ref, String userId, String organizationId) async {
    final futures = <Future>[
      ref.read(userPermissionsProvider(userId).future),
      ref.read(dashboardDataProvider(userId).future),
      ref.read(dynamicModelsDataProvider(organizationId).future),
    ];

    try {
      await Future.wait(futures, eagerError: false);
    } catch (e) {
      // Non-critical operation, don't throw
    }
  }

  /// Refresh all user-related providers
  static void refreshUserProviders(WidgetRef ref, String userId) {
    ref.invalidate(userPermissionsProvider(userId));
    ref.invalidate(dashboardDataProvider(userId));
    ref.invalidate(userProfileDataProvider(userId));
  }

  /// Get provider health status
  static Future<Map<String, bool>> getProviderHealthStatus(
      WidgetRef ref) async {
    final status = <String, bool>{};

    try {
      await ref.read(systemHealthProvider.future);
      status['systemHealth'] = true;
    } catch (e) {
      status['systemHealth'] = false;
    }

    // Add more provider checks as needed

    return status;
  }
}

// =============================================================================
// EXTENSION METHODS FOR EASIER USAGE
// =============================================================================

extension EnhancedProviderExtensions on WidgetRef {
  /// Check if user has specific permission
  Future<bool> hasPermission(String userId, String permission) async {
    try {
      final permissions = read(userPermissionsProvider(userId).notifier);
      return await permissions.hasPermission(userId, permission);
    } catch (e) {
      return false;
    }
  }

  /// Get user role
  Future<String> getUserRole(String userId) async {
    try {
      final permissions = read(userPermissionsProvider(userId).notifier);
      return await permissions.getUserRole(userId);
    } catch (e) {
      return 'Guest';
    }
  }

  /// Refresh all user data
  Future<void> refreshAllUserData(String userId) async {
    ProviderUtils.refreshUserProviders(this, userId);
  }

  /// Warm up providers
  Future<void> warmUpProviders(String userId, String organizationId) async {
    await ProviderUtils.warmUpProviders(this, userId, organizationId);
  }

  /// Get system health
  Future<String> getSystemHealthStatus() async {
    try {
      final health = await read(systemHealthProvider.future);
      return health['overall_status'] as String? ?? 'unknown';
    } catch (e) {
      return 'error';
    }
  }
}
