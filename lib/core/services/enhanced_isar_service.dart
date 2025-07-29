// lib/core/services/enhanced_isar_service.dart
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

  late String
      dataJson; // Changed from dynamic to String to store JSON-serializable data

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

  @ignore // Added ignore annotation
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

// NEW: Organization cache collection
@collection
class CachedOrganization {
  Id id = Isar.autoIncrement;

  @Index()
  late String organizationId;

  late String organizationJson; // Serialized organization data

  @Index()
  late DateTime createdAt;

  late DateTime expiresAt;

  late String organizationType; // company, department, etc.

  late bool isActive;

  bool get isExpired => DateTime.now().isAfter(expiresAt);
}

// NEW: Generic permissions cache collection
@collection
class CachedPermissions {
  Id id = Isar.autoIncrement;

  @Index()
  late String userId;

  late String permissionsJson; // Serialized Map<String, bool>

  @Index()
  late DateTime createdAt;

  late DateTime expiresAt;

  late String? context; // dashboard, model, widget, etc.

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

  /// Get singleton instance
  static EnhancedIsarService get instance => EnhancedIsarService._();
  EnhancedIsarService._();

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
        CachedOrganizationSchema, // NEW
        CachedPermissionsSchema, // NEW
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
          ..value = '2.1.0' // Updated version
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
          ..dataJson = jsonEncode(data) // Serialize data to JSON string
          ..createdAt = DateTime.now()
          ..expiresAt = duration != null ? DateTime.now().add(duration) : null
          ..category = category ?? 'general'
          ..metadata = metadata != null ? jsonEncode(metadata) : null;

        await isar.cacheItems.put(cacheItem);
      });

      // Update memory cache with the deserialized object
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

      // Deserialize data from JSON string
      final dynamic decodedData = jsonDecode(cached.dataJson);
      // Update memory cache
      _updateMemoryCache(key, decodedData);
      return decodedData as T?;
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
  // NEW: ORGANIZATION CACHE METHODS (REQUIRED BY CACHED PROVIDERS)
  // =============================================================================

  /// Cache organization data
  static Future<void> cacheOrganization(
    String organizationId,
    dynamic organizationData,
    Duration duration, {
    String organizationType = 'company',
    bool isActive = true,
  }) async {
    try {
      final isar = await _getInstance();

      await isar.writeTxn(() async {
        // Clear existing organization cache
        await isar.cachedOrganizations
            .filter()
            .organizationIdEqualTo(organizationId)
            .deleteAll();

        // Create new cache entry
        final cached = CachedOrganization()
          ..organizationId = organizationId
          ..organizationJson = jsonEncode(organizationData)
          ..createdAt = DateTime.now()
          ..expiresAt = DateTime.now().add(duration)
          ..organizationType = organizationType
          ..isActive = isActive;

        await isar.cachedOrganizations.put(cached);
      });

      debugPrint('Cached organization: $organizationId');
    } catch (e) {
      debugPrint('Failed to cache organization $organizationId: $e');
    }
  }

  /// Get cached organization data
  static Future<dynamic> getCachedOrganization(String organizationId) async {
    try {
      final isar = await _getInstance();
      final cached = await isar.cachedOrganizations
          .filter()
          .organizationIdEqualTo(organizationId)
          .findFirst();

      if (cached == null || cached.isExpired) {
        // Clean up expired cache
        if (cached != null && cached.isExpired) {
          await isar.writeTxn(() async {
            await isar.cachedOrganizations.delete(cached.id);
          });
        }
        return null;
      }

      return jsonDecode(cached.organizationJson);
    } catch (e) {
      debugPrint('Failed to get cached organization $organizationId: $e');
      return null;
    }
  }

  // =============================================================================
  // NEW: GENERIC PERMISSIONS CACHE METHODS (REQUIRED BY CACHED PROVIDERS)
  // =============================================================================

  /// Cache permissions as Map<String, bool>
  static Future<void> cachePermissions(
    String userId,
    Map<String, bool> permissions,
    Duration duration, {
    String? context,
  }) async {
    try {
      final isar = await _getInstance();

      await isar.writeTxn(() async {
        // Clear existing permissions cache
        await isar.cachedPermissions
            .filter()
            .userIdEqualTo(userId)
            .and()
            .contextEqualTo(context)
            .deleteAll();

        // Create new cache entry
        final cached = CachedPermissions()
          ..userId = userId
          ..permissionsJson = jsonEncode(permissions)
          ..createdAt = DateTime.now()
          ..expiresAt = DateTime.now().add(duration)
          ..context = context;

        await isar.cachedPermissions.put(cached);
      });

      debugPrint('Cached permissions for user: $userId');
    } catch (e) {
      debugPrint('Failed to cache permissions for user $userId: $e');
    }
  }

  /// Get cached permissions as Map<String, bool>
  static Future<Map<String, bool>?> getCachedPermissions(
    String userId, {
    String? context,
  }) async {
    try {
      final isar = await _getInstance();
      final cached = await isar.cachedPermissions
          .filter()
          .userIdEqualTo(userId)
          .and()
          .contextEqualTo(context)
          .findFirst();

      if (cached == null || cached.isExpired) {
        // Clean up expired cache
        if (cached != null && cached.isExpired) {
          await isar.writeTxn(() async {
            await isar.cachedPermissions.delete(cached.id);
          });
        }
        return null;
      }

      final decoded = jsonDecode(cached.permissionsJson);
      return Map<String, bool>.from(decoded);
    } catch (e) {
      debugPrint('Failed to get cached permissions for user $userId: $e');
      return null;
    }
  }

  // =============================================================================
  // NEW: GENERIC DATA CACHE METHODS (REQUIRED BY CACHED PROVIDERS)
  // =============================================================================

  /// Cache generic data (for widgets, etc.)
  static Future<void> cacheGenericData(
    String key,
    Map<String, dynamic> data,
    Duration duration, {
    String? category,
  }) async {
    try {
      await cacheData(
        key,
        data,
        duration: duration,
        category: category ?? 'generic',
      );
    } catch (e) {
      debugPrint('Failed to cache generic data for key $key: $e');
    }
  }

  /// Get cached generic data
  static Future<Map<String, dynamic>?> getCachedGenericData(String key) async {
    try {
      return await getCachedData<Map<String, dynamic>>(key);
    } catch (e) {
      debugPrint('Failed to get cached generic data for key $key: $e');
      return null;
    }
  }

  // =============================================================================
  // NEW: CACHE CLEARING BY KEY AND PATTERN (REQUIRED BY CACHED PROVIDERS)
  // =============================================================================

  /// Clear cache by specific key
  static Future<void> clearCacheByKey(String key) async {
    try {
      final isar = await _getInstance();
      await isar.writeTxn(() async {
        await isar.cacheItems.filter().keyEqualTo(key).deleteAll();
      });

      // Also clear from memory cache
      _memoryCache.remove(key);

      debugPrint('Cleared cache for key: $key');
    } catch (e) {
      debugPrint('Failed to clear cache for key $key: $e');
    }
  }

  /// Clear cache by pattern (with wildcard support)
  static Future<void> clearCacheByPattern(String pattern) async {
    try {
      final isar = await _getInstance();

      await isar.writeTxn(() async {
        if (pattern.contains('*')) {
          // Handle wildcard patterns
          final regexPattern = pattern.replaceAll('*', '.*');
          final regex = RegExp(regexPattern);

          // Get all cache items
          final allItems = await isar.cacheItems.where().findAll();

          // Filter by pattern and delete
          for (final item in allItems) {
            if (regex.hasMatch(item.key)) {
              await isar.cacheItems.delete(item.id);
              _memoryCache.remove(item.key);
            }
          }
        } else {
          // Exact match
          await isar.cacheItems.filter().keyEqualTo(pattern).deleteAll();
          _memoryCache.remove(pattern);
        }
      });

      debugPrint('Cleared cache for pattern: $pattern');
    } catch (e) {
      debugPrint('Failed to clear cache for pattern $pattern: $e');
    }
  }

  // =============================================================================
  // EXISTING USER PERMISSIONS METHODS (UNCHANGED)
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
  // EXISTING DASHBOARD METHODS (UNCHANGED)
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
  // EXISTING WIDGET DATA METHODS (UNCHANGED)
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
  // EXISTING DYNAMIC MODEL METHODS (UNCHANGED)
  // =============================================================================

  /// Cache dynamic models
  static Future<void> cacheDynamicModels(
    String key, // Added key parameter for consistency
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
  // EXISTING USER PROFILE METHODS (UNCHANGED)
  // =============================================================================

  /// Cache user profile
  static Future<void> cacheUserProfile(
    String userId,
    dynamic profile, // Changed from UserProfile to dynamic for flexibility
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
          ..profileJson =
              jsonEncode(profile is Map ? profile : profile.toJson())
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
  static Future<dynamic> getCachedUserProfile(String userId) async {
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

      final json = jsonDecode(cached.profileJson);
      return json; // Return as dynamic - let the caller handle type conversion
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
  // EXISTING ORGANIZATION DATA METHODS (UNCHANGED)
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

        // Clear organization cache entries
        await isar.cachedOrganizations
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
  // EXISTING CACHE MAINTENANCE METHODS (ENHANCED)
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

        // Clean expired organizations
        final expiredOrgs = await isar.cachedOrganizations
            .filter()
            .expiresAtLessThan(now)
            .deleteAll();

        // Clean expired generic permissions
        final expiredGenericPermissions = await isar.cachedPermissions
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
            'Profiles: $expiredProfiles, '
            'Organizations: $expiredOrgs, '
            'GenericPermissions: $expiredGenericPermissions');
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
  // EXISTING CACHE EXPORT/IMPORT METHODS (ENHANCED)
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
        'organizations': <Map<String, dynamic>>[], // NEW
        'genericPermissions': <Map<String, dynamic>>[], // NEW
        'metadata': <Map<String, dynamic>>[],
      };

      // Export cache items
      final cacheItems = await isar.cacheItems.where().findAll();
      for (final item in cacheItems) {
        exportData['cacheItems'].add({
          'key': item.key,
          'dataJson': item.dataJson,
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

      // Export organizations
      final organizations = await isar.cachedOrganizations.where().findAll();
      for (final org in organizations) {
        exportData['organizations'].add({
          'organizationId': org.organizationId,
          'organizationJson': org.organizationJson,
          'organizationType': org.organizationType,
          'isActive': org.isActive,
          'createdAt': org.createdAt.toIso8601String(),
          'expiresAt': org.expiresAt.toIso8601String(),
        });
      }

      // Export generic permissions
      final genericPermissions = await isar.cachedPermissions.where().findAll();
      for (final perm in genericPermissions) {
        exportData['genericPermissions'].add({
          'userId': perm.userId,
          'permissionsJson': perm.permissionsJson,
          'context': perm.context,
          'createdAt': perm.createdAt.toIso8601String(),
          'expiresAt': perm.expiresAt.toIso8601String(),
        });
      }

      exportData['totalItems'] = cacheItems.length +
          permissions.length +
          organizations.length +
          genericPermissions.length;

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
            ..dataJson = item['dataJson'] as String
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

        // Import organizations
        final organizations =
            cacheData['organizations'] as List<dynamic>? ?? [];
        for (final orgData in organizations) {
          final org = orgData as Map<String, dynamic>;

          final expiresAt = DateTime.parse(org['expiresAt'] as String);
          if (expiresAt.isBefore(DateTime.now())) continue;

          final cached = CachedOrganization()
            ..organizationId = org['organizationId'] as String
            ..organizationJson = org['organizationJson'] as String
            ..organizationType = org['organizationType'] as String
            ..isActive = org['isActive'] as bool
            ..createdAt = DateTime.parse(org['createdAt'] as String)
            ..expiresAt = expiresAt;

          await isar.cachedOrganizations.put(cached);
        }

        // Import generic permissions
        final genericPermissions =
            cacheData['genericPermissions'] as List<dynamic>? ?? [];
        for (final permData in genericPermissions) {
          final perm = permData as Map<String, dynamic>;

          final expiresAt = DateTime.parse(perm['expiresAt'] as String);
          if (expiresAt.isBefore(DateTime.now())) continue;

          final cached = CachedPermissions()
            ..userId = perm['userId'] as String
            ..permissionsJson = perm['permissionsJson'] as String
            ..context = perm['context'] as String?
            ..createdAt = DateTime.parse(perm['createdAt'] as String)
            ..expiresAt = expiresAt;

          await isar.cachedPermissions.put(cached);
        }
      });
    } catch (e) {
      throw Exception('Failed to import cache data: $e');
    }
  }

  // =============================================================================
  // EXISTING MEMORY AND PERFORMANCE METHODS (ENHANCED)
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
      final organizationsCount = await isar.cachedOrganizations.count(); // NEW
      final genericPermissionsCount =
          await isar.cachedPermissions.count(); // NEW

      // Estimate memory usage (rough calculation)
      final totalItems = cacheItemsCount +
          permissionsCount +
          dashboardsCount +
          widgetsCount +
          modelsCount +
          profilesCount +
          organizationsCount +
          genericPermissionsCount;

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
        'organizations': organizationsCount, // NEW
        'genericPermissions': genericPermissionsCount, // NEW
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

      // Organizations stats (NEW)
      final organizations = await isar.cachedOrganizations.where().findAll();
      final expiredOrganizations =
          organizations.where((item) => item.isExpired).length;
      stats['collections']['organizations'] = {
        'total': organizations.length,
        'expired': expiredOrganizations,
        'active': organizations.length - expiredOrganizations,
      };

      // Generic permissions stats (NEW)
      final genericPermissions = await isar.cachedPermissions.where().findAll();
      final expiredGenericPermissions =
          genericPermissions.where((item) => item.isExpired).length;
      stats['collections']['genericPermissions'] = {
        'total': genericPermissions.length,
        'expired': expiredGenericPermissions,
        'active': genericPermissions.length - expiredGenericPermissions,
      };

      // Calculate overall health
      final totalItems = cacheItems.length +
          permissions.length +
          organizations.length +
          genericPermissions.length;
      final totalExpired = expiredCacheItems +
          expiredPermissions +
          expiredOrganizations +
          expiredGenericPermissions;
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
        'cacheVersion': '2.1.0', // Updated version
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
  // EXISTING BULK OPERATIONS AND UTILITIES (UNCHANGED)
  // =============================================================================

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
        'dataType': 'JSON_STRING',
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
        await isar.cachedOrganizations.clear(); // NEW
        await isar.cachedPermissions.clear(); // NEW
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
          _updateMemoryCache(key, jsonDecode(item.dataJson));
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
