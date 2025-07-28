import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'dart:async';
import '../models/dashboard_model.dart';
import '../models/dynamic_model.dart';
import '../models/user_model.dart';

part 'enhanced_isar_service.g.dart';

// =============================================================================
// ISAR COLLECTION MODELS
// =============================================================================

@collection
class CacheItem {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String key;

  late dynamic data; // Can store any JSON-serializable data

  @Index()
  late DateTime createdAt;

  late DateTime? expiresAt;

  @Index()
  late String category; // For better organization

  late String? metadata; // Additional metadata as JSON string

  bool get isExpired {
    if (expiresAt == null) return false;
    return DateTime.now().isAfter(expiresAt!);
  }

  bool get isNearExpiration {
    if (expiresAt == null) return false;
    return DateTime.now().add(const Duration(hours: 1)).isAfter(expiresAt!);
  }

  Duration? get timeUntilExpiration {
    if (expiresAt == null) return null;
    final now = DateTime.now();
    if (now.isAfter(expiresAt!)) return Duration.zero;
    return expiresAt!.difference(now);
  }
}

@collection
class CachedUserPermissions {
  Id id = Isar.autoIncrement;

  @Index()
  late String userId;

  late List<String> permissions;

  @Index()
  late DateTime createdAt;

  late DateTime expiresAt;

  late String? organizationId; // For multi-tenant support

  late String? roleLevel; // admin, supervisor, technician, etc.

  bool get isExpired => DateTime.now().isAfter(expiresAt);
}

@collection
class CachedDashboard {
  Id id = Isar.autoIncrement;

  @Index()
  late String userId;

  late String dashboardJson; // Serialized dashboard config

  @Index()
  late DateTime createdAt;

  late DateTime expiresAt;

  late String? organizationId;

  late String? dashboardVersion; // For version compatibility

  late bool isCustomized; // User customized vs default

  bool get isExpired => DateTime.now().isAfter(expiresAt);
}

@collection
class CachedWidgetData {
  Id id = Isar.autoIncrement;

  @Index()
  late String widgetId;

  @Index()
  late String userId;

  late String dataJson; // Serialized widget data

  @Index()
  late DateTime createdAt;

  late DateTime expiresAt;

  late String widgetType; // For analytics

  late bool isRealTime; // Needs frequent updates

  late String? equipmentId; // For electrical equipment widgets

  bool get isExpired => DateTime.now().isAfter(expiresAt);
}

@collection
class CachedDynamicModel {
  Id id = Isar.autoIncrement;

  @Index()
  late String modelId;

  @Index()
  late String modelName;

  late String modelJson; // Serialized dynamic model

  @Index()
  late DateTime createdAt;

  late DateTime expiresAt;

  late String? organizationId;

  late String category; // equipment, maintenance, inspection, etc.

  late String version;

  late bool isSystemModel;

  bool get isExpired => DateTime.now().isAfter(expiresAt);
}

@collection
class CachedUserProfile {
  Id id = Isar.autoIncrement;

  @Index()
  late String userId;

  late String profileJson; // Serialized user profile

  @Index()
  late DateTime createdAt;

  late DateTime expiresAt;

  late String? organizationId;

  late String? department; // Engineering, Operations, Maintenance

  late String? specialization; // HV, LV, Protection, etc.

  bool get isExpired => DateTime.now().isAfter(expiresAt);
}

@collection
class SystemMetadata {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String key;

  late String value;

  late DateTime updatedAt;

  late String? description;
}

// =============================================================================
// ENHANCED ISAR SERVICE CLASS
// =============================================================================

class EnhancedIsarService {
  static Isar? _isar;
  static Timer? _cleanupTimer;
  static Timer? _analyticsTimer;
  static final Map<String, dynamic> _memoryCache = {};
  static const int _memoryCacheLimit = 100;

  /// Initialize Isar database with all collections
  static Future<Isar> initialize() async {
    if (_isar != null) return _isar!;

    final dir = await getApplicationDocumentsDirectory();

    _isar = await Isar.open(
      [
        CacheItemSchema,
        CachedUserPermissionsSchema,
        CachedDashboardSchema,
        CachedWidgetDataSchema,
        CachedDynamicModelSchema,
        CachedUserProfileSchema,
        SystemMetadataSchema,
      ],
      directory: dir.path,
      name: 'electrical_erp_cache',
      maxSizeMiB: 512, // 512MB max size
    );

    // Initialize system
    await _initializeSystem();

    // Start background tasks
    _startCleanupTimer();
    _startAnalyticsTimer();

    debugPrint('Enhanced Isar cache initialized successfully');
    return _isar!;
  }

  /// Get singleton Isar instance
  static Future<Isar> _getInstance() async {
    return await initialize();
  }

  /// Initialize system metadata
  static Future<void> _initializeSystem() async {
    try {
      final isar = await _getInstance();
      await isar.writeTxn(() async {
        // Set initialization timestamp
        await isar.systemMetadatas.put(SystemMetadata()
          ..key = 'initialized_at'
          ..value = DateTime.now().toIso8601String()
          ..updatedAt = DateTime.now()
          ..description = 'Cache system initialization time');

        // Set version
        await isar.systemMetadatas.put(SystemMetadata()
          ..key = 'cache_version'
          ..value = '2.0.0'
          ..updatedAt = DateTime.now()
          ..description = 'Enhanced cache system version');
      });
    } catch (e) {
      debugPrint('Failed to initialize system metadata: $e');
    }
  }

  /// Start cleanup timer for expired data
  static void _startCleanupTimer() {
    _cleanupTimer?.cancel();
    _cleanupTimer = Timer.periodic(const Duration(hours: 2), (timer) async {
      await cleanupExpiredCache();
    });
  }

  /// Start analytics collection timer
  static void _startAnalyticsTimer() {
    _analyticsTimer?.cancel();
    _analyticsTimer = Timer.periodic(const Duration(hours: 6), (timer) async {
      await _collectAnalytics();
    });
  }

  /// Collect usage analytics
  static Future<void> _collectAnalytics() async {
    try {
      final stats = await getCacheStats();
      final isar = await _getInstance();

      await isar.writeTxn(() async {
        await isar.systemMetadatas.put(SystemMetadata()
          ..key = 'last_analytics'
          ..value = jsonEncode(stats)
          ..updatedAt = DateTime.now()
          ..description = 'Last collected analytics data');
      });
    } catch (e) {
      debugPrint('Failed to collect analytics: $e');
    }
  }

  // =============================================================================
  // GENERIC CACHE METHODS (using CacheItem)
  // =============================================================================

  /// Cache any data with generic key
  static Future<void> cacheData<T>(
    String key,
    T data, {
    Duration? duration,
    String? category,
    Map<String, dynamic>? metadata,
  }) async {
    try {
      final isar = await _getInstance();

      await isar.writeTxn(() async {
        // Clear existing cache with same key
        await isar.cacheItems.filter().keyEqualTo(key).deleteAll();

        // Create new cache item
        final cacheItem = CacheItem()
          ..key = key
          ..data = data
          ..createdAt = DateTime.now()
          ..expiresAt = duration != null ? DateTime.now().add(duration) : null
          ..category = category ?? 'general'
          ..metadata = metadata != null ? jsonEncode(metadata) : null;

        await isar.cacheItems.put(cacheItem);
      });

      // Update memory cache
      _updateMemoryCache(key, data);
    } catch (e) {
      debugPrint('Failed to cache data for key $key: $e');
    }
  }

  /// Get cached data by key
  static Future<T?> getCachedData<T>(String key) async {
    try {
      // Check memory cache first
      if (_memoryCache.containsKey(key)) {
        return _memoryCache[key] as T?;
      }

      final isar = await _getInstance();
      final cached = await isar.cacheItems.filter().keyEqualTo(key).findFirst();

      if (cached == null || cached.isExpired) {
        // Clean up expired cache
        if (cached != null && cached.isExpired) {
          await isar.writeTxn(() async {
            await isar.cacheItems.delete(cached.id);
          });
        }
        return null;
      }

      // Update memory cache
      _updateMemoryCache(key, cached.data);

      return cached.data as T?;
    } catch (e) {
      debugPrint('Failed to get cached data for key $key: $e');
      return null;
    }
  }

  /// Update memory cache with LRU eviction
  static void _updateMemoryCache(String key, dynamic data) {
    if (_memoryCache.length >= _memoryCacheLimit) {
      // Remove oldest entry (simple LRU approximation)
      final firstKey = _memoryCache.keys.first;
      _memoryCache.remove(firstKey);
    }
    _memoryCache[key] = data;
  }

  // =============================================================================
  // USER PERMISSIONS METHODS
  // =============================================================================

  /// Cache user permissions
  static Future<void> cacheUserPermissions(
    String userId,
    List<String> permissions,
    Duration cacheDuration, {
    String? organizationId,
    String? roleLevel,
  }) async {
    try {
      final isar = await _getInstance();

      await isar.writeTxn(() async {
        // Remove existing cache
        await isar.cachedUserPermissions
            .filter()
            .userIdEqualTo(userId)
            .deleteAll();

        // Add new cache
        final cached = CachedUserPermissions()
          ..userId = userId
          ..permissions = permissions
          ..createdAt = DateTime.now()
          ..expiresAt = DateTime.now().add(cacheDuration)
          ..organizationId = organizationId
          ..roleLevel = roleLevel;

        await isar.cachedUserPermissions.put(cached);
      });

      debugPrint('Cached permissions for user: $userId');
    } catch (e) {
      debugPrint('Failed to cache permissions for user $userId: $e');
    }
  }

  /// Get cached user permissions
  static Future<List<String>?> getCachedUserPermissions(String userId) async {
    try {
      final isar = await _getInstance();

      final cached = await isar.cachedUserPermissions
          .filter()
          .userIdEqualTo(userId)
          .findFirst();

      if (cached != null && !cached.isExpired) {
        return cached.permissions;
      }

      // Clean up expired cache
      if (cached != null && cached.isExpired) {
        await isar.writeTxn(() async {
          await isar.cachedUserPermissions.delete(cached.id);
        });
      }

      return null;
    } catch (e) {
      debugPrint('Failed to get cached permissions for user $userId: $e');
      return null;
    }
  }

  /// Clear user permissions cache
  static Future<void> clearUserPermissions(String userId) async {
    try {
      final isar = await _getInstance();
      await isar.writeTxn(() async {
        await isar.cachedUserPermissions
            .filter()
            .userIdEqualTo(userId)
            .deleteAll();
      });
    } catch (e) {
      debugPrint('Failed to clear permissions cache for user $userId: $e');
    }
  }

  // =============================================================================
  // DASHBOARD METHODS
  // =============================================================================

  /// Cache dashboard configuration
  static Future<void> cacheDashboard(
    String userId,
    DashboardConfig dashboard,
    Duration cacheDuration, {
    String? organizationId,
    bool isCustomized = false,
  }) async {
    try {
      final isar = await _getInstance();

      await isar.writeTxn(() async {
        await isar.cachedDashboards.filter().userIdEqualTo(userId).deleteAll();

        final cached = CachedDashboard()
          ..userId = userId
          ..dashboardJson = jsonEncode(dashboard.toJson())
          ..createdAt = DateTime.now()
          ..expiresAt = DateTime.now().add(cacheDuration)
          ..organizationId = organizationId
          ..dashboardVersion = '1.0'
          ..isCustomized = isCustomized;

        await isar.cachedDashboards.put(cached);
      });

      debugPrint('Cached dashboard for user: $userId');
    } catch (e) {
      debugPrint('Failed to cache dashboard for user $userId: $e');
    }
  }

  /// Get cached dashboard
  static Future<DashboardConfig?> getCachedDashboard(String userId) async {
    try {
      final isar = await _getInstance();

      final cached = await isar.cachedDashboards
          .filter()
          .userIdEqualTo(userId)
          .findFirst();

      if (cached != null && !cached.isExpired) {
        final json = jsonDecode(cached.dashboardJson);
        return DashboardConfig.fromJson(json);
      }

      return null;
    } catch (e) {
      debugPrint('Failed to get cached dashboard for user $userId: $e');
      return null;
    }
  }

  /// Clear user dashboard cache
  static Future<void> clearUserDashboard(String userId) async {
    try {
      final isar = await _getInstance();
      await isar.writeTxn(() async {
        await isar.cachedDashboards.filter().userIdEqualTo(userId).deleteAll();
      });
    } catch (e) {
      debugPrint('Failed to clear dashboard cache for user $userId: $e');
    }
  }

  // =============================================================================
  // WIDGET DATA METHODS
  // =============================================================================

  /// Cache widget data
  static Future<void> cacheWidgetData(
    String widgetId,
    String userId,
    Map<String, dynamic> data,
    Duration cacheDuration, {
    String? widgetType,
    bool isRealTime = false,
    String? equipmentId,
  }) async {
    try {
      final isar = await _getInstance();

      await isar.writeTxn(() async {
        await isar.cachedWidgetDatas
            .filter()
            .widgetIdEqualTo(widgetId)
            .and()
            .userIdEqualTo(userId)
            .deleteAll();

        final cached = CachedWidgetData()
          ..widgetId = widgetId
          ..userId = userId
          ..dataJson = jsonEncode(data)
          ..createdAt = DateTime.now()
          ..expiresAt = DateTime.now().add(cacheDuration)
          ..widgetType = widgetType ?? 'unknown'
          ..isRealTime = isRealTime
          ..equipmentId = equipmentId;

        await isar.cachedWidgetDatas.put(cached);
      });
    } catch (e) {
      debugPrint('Failed to cache widget data for $widgetId: $e');
    }
  }

  /// Get cached widget data
  static Future<Map<String, dynamic>?> getCachedWidgetData(
    String widgetId,
    String userId,
  ) async {
    try {
      final isar = await _getInstance();

      final cached = await isar.cachedWidgetDatas
          .filter()
          .widgetIdEqualTo(widgetId)
          .and()
          .userIdEqualTo(userId)
          .findFirst();

      if (cached != null && !cached.isExpired) {
        return Map<String, dynamic>.from(jsonDecode(cached.dataJson));
      }

      return null;
    } catch (e) {
      debugPrint('Failed to get cached widget data for $widgetId: $e');
      return null;
    }
  }

  /// Clear widget data
  static Future<void> clearWidgetData(String widgetId, String userId) async {
    try {
      final isar = await _getInstance();
      await isar.writeTxn(() async {
        await isar.cachedWidgetDatas
            .filter()
            .widgetIdEqualTo(widgetId)
            .and()
            .userIdEqualTo(userId)
            .deleteAll();
      });
    } catch (e) {
      debugPrint('Failed to clear widget data for $widgetId: $e');
    }
  }

  /// Clear all widget data for a user
  static Future<void> clearUserWidgetData(String userId) async {
    try {
      final isar = await _getInstance();
      await isar.writeTxn(() async {
        await isar.cachedWidgetDatas.filter().userIdEqualTo(userId).deleteAll();
      });
    } catch (e) {
      debugPrint('Failed to clear user widget data for $userId: $e');
    }
  }

  // =============================================================================
  // DYNAMIC MODEL METHODS
  // =============================================================================

  /// Cache dynamic models
  static Future<void> cacheDynamicModels(
    List<DynamicModel> models,
    Duration duration,
  ) async {
    try {
      final isar = await _getInstance();

      await isar.writeTxn(() async {
        // Clear existing models
        await isar.cachedDynamicModels.clear();

        // Cache new models
        for (final model in models) {
          final cached = CachedDynamicModel()
            ..modelId = model.id
            ..modelName = model.modelName
            ..modelJson = jsonEncode(model.toJson())
            ..createdAt = DateTime.now()
            ..expiresAt = DateTime.now().add(duration)
            ..organizationId = model.organizationId
            ..category = model.category ?? 'general'
            ..version = model.version ?? '1.0'
            ..isSystemModel = model.isSystemModel;

          await isar.cachedDynamicModels.put(cached);
        }
      });
    } catch (e) {
      debugPrint('Failed to cache dynamic models: $e');
    }
  }

  /// Get cached dynamic models
  static Future<List<DynamicModel>?> getCachedDynamicModels() async {
    try {
      final isar = await _getInstance();
      final cached = await isar.cachedDynamicModels.where().findAll();

      if (cached.isEmpty) return null;

      // Check if any are expired
      final now = DateTime.now();
      final validCached = cached.where((item) => !item.isExpired).toList();

      if (validCached.isEmpty) {
        // Clear expired cache
        await isar.writeTxn(() async {
          await isar.cachedDynamicModels.clear();
        });
        return null;
      }

      // Convert to models
      final models = <DynamicModel>[];
      for (final item in validCached) {
        try {
          final json = jsonDecode(item.modelJson) as Map<String, dynamic>;
          models.add(DynamicModel.fromJson(json));
        } catch (e) {
          debugPrint('Failed to parse cached model ${item.modelName}: $e');
        }
      }

      return models;
    } catch (e) {
      debugPrint('Failed to get cached dynamic models: $e');
      return null;
    }
  }

  /// Cache organization models
  static Future<void> cacheOrgModels(
    String organizationId,
    List<DynamicModel> models,
    Duration duration,
  ) async {
    try {
      await cacheData(
        'org_models_$organizationId',
        models.map((m) => m.toJson()).toList(),
        duration: duration,
        category: 'organization_models',
        metadata: {'organizationId': organizationId},
      );
    } catch (e) {
      debugPrint('Failed to cache org models for $organizationId: $e');
    }
  }

  /// Get cached organization models
  static Future<List<DynamicModel>?> getCachedOrgModels(
      String organizationId) async {
    try {
      final cached =
          await getCachedData<List<dynamic>>('org_models_$organizationId');
      if (cached == null) return null;

      return cached
          .map((json) => DynamicModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      debugPrint('Failed to get cached org models for $organizationId: $e');
      return null;
    }
  }

  /// Cache model by ID
  static Future<void> cacheModelById(
    String modelId,
    DynamicModel model,
    Duration duration,
  ) async {
    try {
      await cacheData(
        'model_$modelId',
        model.toJson(),
        duration: duration,
        category: 'dynamic_model',
        metadata: {'modelId': modelId},
      );
    } catch (e) {
      debugPrint('Failed to cache model $modelId: $e');
    }
  }

  /// Get cached model by ID
  static Future<DynamicModel?> getCachedModelById(String modelId) async {
    try {
      final cached =
          await getCachedData<Map<String, dynamic>>('model_$modelId');
      if (cached == null) return null;

      return DynamicModel.fromJson(cached);
    } catch (e) {
      debugPrint('Failed to get cached model $modelId: $e');
      return null;
    }
  }

  /// Clear organization models
  static Future<void> clearOrgModels(String organizationId) async {
    try {
      final isar = await _getInstance();
      await isar.writeTxn(() async {
        await isar.cacheItems
            .filter()
            .keyEqualTo('org_models_$organizationId')
            .deleteAll();
      });
    } catch (e) {
      debugPrint('Failed to clear org models for $organizationId: $e');
    }
  }

  // =============================================================================
  // USER PROFILE METHODS
  // =============================================================================

  /// Cache user profile
  static Future<void> cacheUserProfile(
    String userId,
    UserProfile profile,
    Duration duration, {
    String? organizationId,
    String? department,
    String? specialization,
  }) async {
    try {
      final isar = await _getInstance();

      await isar.writeTxn(() async {
        // Clear existing profile
        await isar.cachedUserProfiles
            .filter()
            .userIdEqualTo(userId)
            .deleteAll();

        // Cache new profile
        final cached = CachedUserProfile()
          ..userId = userId
          ..profileJson = jsonEncode(profile.toJson())
          ..createdAt = DateTime.now()
          ..expiresAt = DateTime.now().add(duration)
          ..organizationId = organizationId
          ..department = department
          ..specialization = specialization;

        await isar.cachedUserProfiles.put(cached);
      });
    } catch (e) {
      debugPrint('Failed to cache user profile for $userId: $e');
    }
  }

  /// Get cached user profile
  static Future<UserProfile?> getCachedUserProfile(String userId) async {
    try {
      final isar = await _getInstance();
      final cached = await isar.cachedUserProfiles
          .filter()
          .userIdEqualTo(userId)
          .findFirst();

      if (cached == null || cached.isExpired) {
        // Clean up expired cache
        if (cached != null && cached.isExpired) {
          await isar.writeTxn(() async {
            await isar.cachedUserProfiles.delete(cached.id);
          });
        }
        return null;
      }

      final json = jsonDecode(cached.profileJson) as Map<String, dynamic>;
      return UserProfile.fromJson(json);
    } catch (e) {
      debugPrint('Failed to get cached user profile for $userId: $e');
      return null;
    }
  }

  /// Clear user profile cache
  static Future<void> clearUserProfile(String userId) async {
    try {
      final isar = await _getInstance();
      await isar.writeTxn(() async {
        await isar.cachedUserProfiles
            .filter()
            .userIdEqualTo(userId)
            .deleteAll();
      });
    } catch (e) {
      debugPrint('Failed to clear user profile for $userId: $e');
    }
  }

  // =============================================================================
  // ORGANIZATION DATA METHODS
  // =============================================================================

  /// Clear all organization data
  static Future<void> clearOrgData(String organizationId) async {
    try {
      final isar = await _getInstance();
      await isar.writeTxn(() async {
        // Clear organization models
        await isar.cachedDynamicModels
            .filter()
            .organizationIdEqualTo(organizationId)
            .deleteAll();

        // Clear organization dashboards
        await isar.cachedDashboards
            .filter()
            .organizationIdEqualTo(organizationId)
            .deleteAll();

        // Clear organization profiles
        await isar.cachedUserProfiles
            .filter()
            .organizationIdEqualTo(organizationId)
            .deleteAll();

        // Clear generic organization cache items
        final patterns = [
          'org_models_$organizationId',
          'org_settings_$organizationId',
          'org_users_$organizationId',
          'org_equipment_$organizationId',
        ];

        for (final pattern in patterns) {
          await isar.cacheItems.filter().keyEqualTo(pattern).deleteAll();
        }
      });
    } catch (e) {
      debugPrint('Failed to clear org data for $organizationId: $e');
    }
  }

  // =============================================================================
  // CACHE MAINTENANCE METHODS
  // =============================================================================

  /// Clean up expired cache entries
  static Future<void> cleanupExpiredCache() async {
    try {
      final isar = await _getInstance();
      final now = DateTime.now();

      await isar.writeTxn(() async {
        // Clean expired cache items
        final expiredItems =
            await isar.cacheItems.filter().expiresAtLessThan(now).deleteAll();

        // Clean expired permissions
        final expiredPermissions = await isar.cachedUserPermissions
            .filter()
            .expiresAtLessThan(now)
            .deleteAll();

        // Clean expired dashboards
        final expiredDashboards = await isar.cachedDashboards
            .filter()
            .expiresAtLessThan(now)
            .deleteAll();

        // Clean expired widget data
        final expiredWidgets = await isar.cachedWidgetDatas
            .filter()
            .expiresAtLessThan(now)
            .deleteAll();

        // Clean expired models
        final expiredModels = await isar.cachedDynamicModels
            .filter()
            .expiresAtLessThan(now)
            .deleteAll();

        // Clean expired profiles
        final expiredProfiles = await isar.cachedUserProfiles
            .filter()
            .expiresAtLessThan(now)
            .deleteAll();

        // Update last cleanup time
        await _updateLastClearTime();

        debugPrint('Cache cleanup completed: '
            'Items: $expiredItems, '
            'Permissions: $expiredPermissions, '
            'Dashboards: $expiredDashboards, '
            'Widgets: $expiredWidgets, '
            'Models: $expiredModels, '
            'Profiles: $expiredProfiles');
      });

      // Clear memory cache of expired items
      _memoryCache.clear();
    } catch (e) {
      debugPrint('Cache cleanup failed: $e');
    }
  }

  /// Update last cache clear time
  static Future<void> _updateLastClearTime() async {
    try {
      final isar = await _getInstance();
      await isar.systemMetadatas.put(SystemMetadata()
        ..key = 'last_cleanup'
        ..value = DateTime.now().toIso8601String()
        ..updatedAt = DateTime.now()
        ..description = 'Last cache cleanup time');
    } catch (e) {
      debugPrint('Failed to update last clear time: $e');
    }
  }

  /// Get last cache clear time
  static Future<DateTime?> getLastClearTime() async {
    try {
      final isar = await _getInstance();
      final metadata = await isar.systemMetadatas
          .filter()
          .keyEqualTo('last_cleanup')
          .findFirst();

      if (metadata != null) {
        return DateTime.parse(metadata.value);
      }
      return null;
    } catch (e) {
      debugPrint('Failed to get last clear time: $e');
      return null;
    }
  }

  // =============================================================================
  // CACHE EXPORT/IMPORT METHODS
  // =============================================================================

  /// Export all cache data for debugging/backup
  static Future<Map<String, dynamic>> exportCacheData() async {
    try {
      final isar = await _getInstance();

      final exportData = <String, dynamic>{
        'exportedAt': DateTime.now().toIso8601String(),
        'cacheItems': <Map<String, dynamic>>[],
        'permissions': <Map<String, dynamic>>[],
        'dashboards': <Map<String, dynamic>>[],
        'widgets': <Map<String, dynamic>>[],
        'models': <Map<String, dynamic>>[],
        'profiles': <Map<String, dynamic>>[],
        'metadata': <Map<String, dynamic>>[],
      };

      // Export cache items
      final cacheItems = await isar.cacheItems.where().findAll();
      for (final item in cacheItems) {
        exportData['cacheItems'].add({
          'key': item.key,
          'data': item.data,
          'category': item.category,
          'createdAt': item.createdAt.toIso8601String(),
          'expiresAt': item.expiresAt?.toIso8601String(),
          'metadata': item.metadata,
        });
      }

      // Export permissions
      final permissions = await isar.cachedUserPermissions.where().findAll();
      for (final perm in permissions) {
        exportData['permissions'].add({
          'userId': perm.userId,
          'permissions': perm.permissions,
          'organizationId': perm.organizationId,
          'roleLevel': perm.roleLevel,
          'createdAt': perm.createdAt.toIso8601String(),
          'expiresAt': perm.expiresAt.toIso8601String(),
        });
      }

      // Export other collections similarly...
      exportData['totalItems'] = cacheItems.length + permissions.length;

      return exportData;
    } catch (e) {
      return {
        'error': true,
        'message': e.toString(),
        'exportedAt': DateTime.now().toIso8601String(),
      };
    }
  }

  /// Import cache data from backup
  static Future<void> importCacheData(Map<String, dynamic> cacheData) async {
    try {
      final isar = await _getInstance();

      // Clear existing cache first
      await clearAllCache();

      await isar.writeTxn(() async {
        // Import cache items
        final items = cacheData['cacheItems'] as List<dynamic>? ?? [];
        for (final itemData in items) {
          final item = itemData as Map<String, dynamic>;

          // Skip expired items during import
          final expiresAtString = item['expiresAt'] as String?;
          if (expiresAtString != null) {
            final expiresAt = DateTime.parse(expiresAtString);
            if (expiresAt.isBefore(DateTime.now())) {
              continue;
            }
          }

          final cacheItem = CacheItem()
            ..key = item['key'] as String
            ..data = item['data']
            ..category = item['category'] as String
            ..createdAt = DateTime.parse(item['createdAt'] as String)
            ..expiresAt =
                expiresAtString != null ? DateTime.parse(expiresAtString) : null
            ..metadata = item['metadata'] as String?;

          await isar.cacheItems.put(cacheItem);
        }

        // Import permissions
        final permissions = cacheData['permissions'] as List<dynamic>? ?? [];
        for (final permData in permissions) {
          final perm = permData as Map<String, dynamic>;

          final expiresAt = DateTime.parse(perm['expiresAt'] as String);
          if (expiresAt.isBefore(DateTime.now())) continue;

          final cached = CachedUserPermissions()
            ..userId = perm['userId'] as String
            ..permissions = (perm['permissions'] as List).cast<String>()
            ..organizationId = perm['organizationId'] as String?
            ..roleLevel = perm['roleLevel'] as String?
            ..createdAt = DateTime.parse(perm['createdAt'] as String)
            ..expiresAt = expiresAt;

          await isar.cachedUserPermissions.put(cached);
        }

        // Import other collections similarly...
      });
    } catch (e) {
      throw Exception('Failed to import cache data: $e');
    }
  }

  // =============================================================================
  // MEMORY AND PERFORMANCE METHODS
  // =============================================================================

  /// Get memory usage statistics
  static Future<Map<String, dynamic>> getMemoryUsage() async {
    try {
      final isar = await _getInstance();

      // Get collection counts
      final cacheItemsCount = await isar.cacheItems.count();
      final permissionsCount = await isar.cachedUserPermissions.count();
      final dashboardsCount = await isar.cachedDashboards.count();
      final widgetsCount = await isar.cachedWidgetDatas.count();
      final modelsCount = await isar.cachedDynamicModels.count();
      final profilesCount = await isar.cachedUserProfiles.count();

      // Estimate memory usage (rough calculation)
      final totalItems = cacheItemsCount +
          permissionsCount +
          dashboardsCount +
          widgetsCount +
          modelsCount +
          profilesCount;

      // Memory cache size
      final memoryCacheSize = _memoryCache.length;

      return {
        'totalItems': totalItems,
        'cacheItems': cacheItemsCount,
        'permissions': permissionsCount,
        'dashboards': dashboardsCount,
        'widgets': widgetsCount,
        'models': modelsCount,
        'profiles': profilesCount,
        'memoryCacheSize': memoryCacheSize,
        'memoryCacheLimit': _memoryCacheLimit,
        'estimatedMB': (totalItems * 1024 / (1024 * 1024)).toStringAsFixed(2),
        'measuredAt': DateTime.now().toIso8601String(),
      };
    } catch (e) {
      return {
        'error': true,
        'message': e.toString(),
      };
    }
  }

  /// Get comprehensive cache statistics
  static Future<Map<String, dynamic>> getCacheStats() async {
    try {
      final isar = await _getInstance();
      final now = DateTime.now();

      // Get all collection counts and expired counts
      final stats = <String, dynamic>{
        'timestamp': now.toIso8601String(),
        'collections': <String, dynamic>{},
        'health': <String, dynamic>{},
        'memory': await getMemoryUsage(),
        'system': <String, dynamic>{},
      };

      // Cache items stats
      final cacheItems = await isar.cacheItems.where().findAll();
      final expiredCacheItems =
          cacheItems.where((item) => item.isExpired).length;
      stats['collections']['cacheItems'] = {
        'total': cacheItems.length,
        'expired': expiredCacheItems,
        'active': cacheItems.length - expiredCacheItems,
      };

      // Permissions stats
      final permissions = await isar.cachedUserPermissions.where().findAll();
      final expiredPermissions =
          permissions.where((item) => item.isExpired).length;
      stats['collections']['permissions'] = {
        'total': permissions.length,
        'expired': expiredPermissions,
        'active': permissions.length - expiredPermissions,
      };

      // Calculate overall health
      final totalItems = cacheItems.length + permissions.length;
      final totalExpired = expiredCacheItems + expiredPermissions;
      final healthScore = totalItems > 0
          ? ((totalItems - totalExpired) / totalItems * 100).round()
          : 100;

      stats['health'] = {
        'score': healthScore,
        'status': _getHealthStatus(healthScore),
        'totalItems': totalItems,
        'expiredItems': totalExpired,
        'activeItems': totalItems - totalExpired,
      };

      // System info
      final lastCleanup = await getLastClearTime();
      stats['system'] = {
        'lastCleanup': lastCleanup?.toIso8601String(),
        'cacheVersion': '2.0.0',
        'memoryCache': {
          'size': _memoryCache.length,
          'limit': _memoryCacheLimit,
          'usage':
              '${(_memoryCache.length / _memoryCacheLimit * 100).round()}%',
        },
      };

      return stats;
    } catch (e) {
      return {
        'error': true,
        'message': e.toString(),
        'timestamp': DateTime.now().toIso8601String(),
      };
    }
  }

  /// Get health status based on score
  static String _getHealthStatus(int score) {
    if (score >= 90) return 'excellent';
    if (score >= 80) return 'good';
    if (score >= 60) return 'fair';
    if (score >= 40) return 'poor';
    return 'critical';
  }

  // =============================================================================
  // BULK OPERATIONS AND UTILITIES
  // =============================================================================

  /// Clear cache by pattern
  static Future<void> clearCacheByPattern(String pattern) async {
    try {
      final isar = await _getInstance();
      await isar.writeTxn(() async {
        await isar.cacheItems.filter().keyStartsWith(pattern).deleteAll();
      });
    } catch (e) {
      debugPrint('Failed to clear cache by pattern $pattern: $e');
    }
  }

  /// Refresh cache item expiration
  static Future<void> refreshCacheExpiration(
      String key, Duration newDuration) async {
    try {
      final isar = await _getInstance();
      await isar.writeTxn(() async {
        final item = await isar.cacheItems.filter().keyEqualTo(key).findFirst();
        if (item != null) {
          item.expiresAt = DateTime.now().add(newDuration);
          await isar.cacheItems.put(item);
        }
      });
    } catch (e) {
      debugPrint('Failed to refresh cache expiration for $key: $e');
    }
  }

  /// Get cache item info without loading data
  static Future<Map<String, dynamic>?> getCacheItemInfo(String key) async {
    try {
      final isar = await _getInstance();
      final item = await isar.cacheItems.filter().keyEqualTo(key).findFirst();

      if (item == null) return null;

      return {
        'key': item.key,
        'category': item.category,
        'createdAt': item.createdAt.toIso8601String(),
        'expiresAt': item.expiresAt?.toIso8601String(),
        'isExpired': item.isExpired,
        'timeUntilExpiration': item.timeUntilExpiration?.inMinutes,
        'dataType': item.data.runtimeType.toString(),
      };
    } catch (e) {
      debugPrint('Failed to get cache item info for $key: $e');
      return null;
    }
  }

  /// Clear all cache
  static Future<void> clearAllCache() async {
    try {
      final isar = await _getInstance();
      await isar.writeTxn(() async {
        await isar.cacheItems.clear();
        await isar.cachedUserPermissions.clear();
        await isar.cachedDashboards.clear();
        await isar.cachedWidgetDatas.clear();
        await isar.cachedDynamicModels.clear();
        await isar.cachedUserProfiles.clear();
      });

      // Clear memory cache
      _memoryCache.clear();

      debugPrint('All Isar cache cleared');
    } catch (e) {
      debugPrint('Failed to clear all cache: $e');
    }
  }

  /// Optimize cache performance
  static Future<Map<String, dynamic>> optimizeCache() async {
    try {
      final startTime = DateTime.now();
      final initialStats = await getCacheStats();

      // Clean up expired items
      await cleanupExpiredCache();

      // Compact database if supported
      // Note: Uncomment if your Isar version supports compaction
      // await _isar?.compact();

      final endTime = DateTime.now();
      final finalStats = await getCacheStats();

      return {
        'optimizationComplete': true,
        'duration': endTime.difference(startTime).inMilliseconds,
        'initialItems': initialStats['health']['totalItems'],
        'finalItems': finalStats['health']['totalItems'],
        'itemsRemoved': (initialStats['health']['expiredItems'] as int? ?? 0),
        'timestamp': DateTime.now().toIso8601String(),
      };
    } catch (e) {
      return {
        'optimizationComplete': false,
        'error': e.toString(),
        'timestamp': DateTime.now().toIso8601String(),
      };
    }
  }

  /// Preload cache for better performance
  static Future<void> preloadCache(List<String> keys) async {
    try {
      final isar = await _getInstance();

      for (final key in keys) {
        final item = await isar.cacheItems.filter().keyEqualTo(key).findFirst();
        if (item != null && !item.isExpired) {
          _updateMemoryCache(key, item.data);
        }
      }
    } catch (e) {
      debugPrint('Failed to preload cache: $e');
    }
  }

  /// Dispose and cleanup
  static Future<void> dispose() async {
    _cleanupTimer?.cancel();
    _analyticsTimer?.cancel();
    _memoryCache.clear();
    await _isar?.close();
    _isar = null;
    debugPrint('Enhanced Isar service disposed');
  }
}
