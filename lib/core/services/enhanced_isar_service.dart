import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'dart:async';
import '../models/dashboard_model.dart';

part 'enhanced_isar_service.g.dart';

@collection
class CachedUserPermissions {
  Id id = Isar.autoIncrement;

  @Index()
  late String userId;

  late List<String> permissions;

  @Index()
  late DateTime createdAt;

  late DateTime expiresAt;

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

  bool get isExpired => DateTime.now().isAfter(expiresAt);
}

class EnhancedIsarService {
  static Isar? _isar;
  static Timer? _cleanupTimer;

  static Future<Isar> initialize() async {
    if (_isar != null) return _isar!;

    final dir = await getApplicationDocumentsDirectory();

    _isar = await Isar.open(
      [
        CachedUserPermissionsSchema,
        CachedDashboardSchema,
        CachedWidgetDataSchema,
      ],
      directory: dir.path,
      name: 'erp_cache',
    );

    // Start cleanup timer
    _startCleanupTimer();

    debugPrint('Isar cache initialized successfully');
    return _isar!;
  }

  static void _startCleanupTimer() {
    _cleanupTimer?.cancel();
    _cleanupTimer = Timer.periodic(const Duration(hours: 1), (timer) async {
      await _cleanupExpiredData();
    });
  }

  static Future<void> _cleanupExpiredData() async {
    try {
      final isar = await initialize();

      await isar.writeTxn(() async {
        final now = DateTime.now();

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

        debugPrint(
            'Isar cleanup: Removed $expiredPermissions permissions, $expiredDashboards dashboards, $expiredWidgets widgets');
      });
    } catch (e) {
      debugPrint('Isar cleanup failed: $e');
    }
  }

  // Permissions caching
  static Future<void> cacheUserPermissions(
    String userId,
    List<String> permissions,
    Duration cacheDuration,
  ) async {
    try {
      final isar = await initialize();

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
          ..expiresAt = DateTime.now().add(cacheDuration);

        await isar.cachedUserPermissions.put(cached);
      });

      debugPrint('Cached permissions for user: $userId');
    } catch (e) {
      debugPrint('Failed to cache permissions for user $userId: $e');
    }
  }

  static Future<List<String>?> getCachedUserPermissions(String userId) async {
    try {
      final isar = await initialize();

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

  // Dashboard caching
  static Future<void> cacheDashboard(
    String userId,
    DashboardConfig dashboard,
    Duration cacheDuration,
  ) async {
    try {
      final isar = await initialize();

      await isar.writeTxn(() async {
        await isar.cachedDashboards.filter().userIdEqualTo(userId).deleteAll();

        final cached = CachedDashboard()
          ..userId = userId
          ..dashboardJson = jsonEncode(dashboard.toJson())
          ..createdAt = DateTime.now()
          ..expiresAt = DateTime.now().add(cacheDuration);

        await isar.cachedDashboards.put(cached);
      });

      debugPrint('Cached dashboard for user: $userId');
    } catch (e) {
      debugPrint('Failed to cache dashboard for user $userId: $e');
    }
  }

  static Future<DashboardConfig?> getCachedDashboard(String userId) async {
    try {
      final isar = await initialize();

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

  // Widget data caching
  static Future<void> cacheWidgetData(
    String widgetId,
    String userId,
    Map<String, dynamic> data,
    Duration cacheDuration,
  ) async {
    try {
      final isar = await initialize();

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
          ..expiresAt = DateTime.now().add(cacheDuration);

        await isar.cachedWidgetDatas.put(cached);
      });
    } catch (e) {
      debugPrint('Failed to cache widget data for $widgetId: $e');
    }
  }

  static Future<Map<String, dynamic>?> getCachedWidgetData(
    String widgetId,
    String userId,
  ) async {
    try {
      final isar = await initialize();

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

  // Cache clearing methods
  static Future<void> clearUserPermissions(String userId) async {
    try {
      final isar = await initialize();
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

  static Future<void> clearUserDashboard(String userId) async {
    try {
      final isar = await initialize();
      await isar.writeTxn(() async {
        await isar.cachedDashboards.filter().userIdEqualTo(userId).deleteAll();
      });
    } catch (e) {
      debugPrint('Failed to clear dashboard cache for user $userId: $e');
    }
  }

  static Future<void> clearAllCache() async {
    try {
      final isar = await initialize();
      await isar.writeTxn(() async {
        await isar.cachedUserPermissions.clear();
        await isar.cachedDashboards.clear();
        await isar.cachedWidgetDatas.clear();
      });
      debugPrint('All Isar cache cleared');
    } catch (e) {
      debugPrint('Failed to clear all cache: $e');
    }
  }

  // Analytics
  static Future<Map<String, dynamic>> getCacheStats() async {
    try {
      final isar = await initialize();

      final permissionsCount = await isar.cachedUserPermissions.count();
      final dashboardsCount = await isar.cachedDashboards.count();
      final widgetDataCount = await isar.cachedWidgetDatas.count();

      return {
        'permissions_cached': permissionsCount,
        'dashboards_cached': dashboardsCount,
        'widget_data_cached': widgetDataCount,
        'total_cache_size':
            permissionsCount + dashboardsCount + widgetDataCount,
        'last_cleanup': DateTime.now().toIso8601String(),
      };
    } catch (e) {
      debugPrint('Failed to get cache stats: $e');
      return {};
    }
  }

  static Future<void> dispose() async {
    _cleanupTimer?.cancel();
    await _isar?.close();
    _isar = null;
  }
}
