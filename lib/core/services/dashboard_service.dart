import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../models/dashboard_model.dart';
import '../models/user_model.dart';
import '../constants/app_constants.dart';
import 'permission_service.dart';
import 'network_aware_service.dart';

class DashboardService with NetworkAwareService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final PermissionService _permissionService = PermissionService();

  // Multi-level caching for optimal performance
  final Map<String, DashboardConfig> _dashboardCache = {};
  final Map<String, DateTime> _dashboardCacheTimestamps = {};
  final Map<String, Map<String, dynamic>> _widgetDataCache = {};
  final Map<String, DateTime> _widgetCacheTimestamps = {};

  static const Duration _dashboardCacheTimeout = Duration(hours: 1);
  static const Duration _widgetCacheTimeout = Duration(minutes: 15);
  static const int _maxCacheSize = 500; // Prevent memory bloat

  // Optimized user dashboard retrieval with comprehensive caching
  Future<DashboardConfig?> getUserDashboard(String userId) async {
    final cacheKey = 'dashboard_$userId';

    // Check cache first
    if (_isDashboardCacheValid(cacheKey)) {
      debugPrint('Dashboard cache HIT: $userId');
      return _dashboardCache[cacheKey];
    }

    return executeOnlineOperation(
      () async {
        debugPrint('Dashboard cache MISS: $userId - Fetching from network');

        try {
          // Direct Firestore queries (since we removed Cloud Functions)
          return await _fetchUserDashboardFallback(userId);
        } catch (e) {
          debugPrint('Dashboard fetch failed: $e');
          return await _getDefaultDashboard(userId);
        }
      },
      operationName: 'Fetch User Dashboard',
      fallback: await _getDefaultDashboard(userId),
    );
  }

  // Fallback method using optimized Firestore queries
  Future<DashboardConfig?> _fetchUserDashboardFallback(String userId) async {
    try {
      // Get user profile efficiently
      final user = await _fetchUserProfile(userId);
      if (user == null) return null;

      // Find applicable dashboards with optimized query
      final dashboards = await _getApplicableDashboardsOptimized(user);

      if (dashboards.isEmpty) {
        return await _createDefaultDashboard(user);
      }

      // Select most specific dashboard (highest hierarchy level)
      dashboards.sort((a, b) => b.hierarchyLevel.compareTo(a.hierarchyLevel));
      final selectedDashboard = dashboards.first;

      // Filter widgets based on permissions using batch checking
      final filteredWidgets = await _filterWidgetsByPermissionsBatch(
          selectedDashboard.widgets, userId);

      final finalDashboard =
          selectedDashboard.copyWith(widgets: filteredWidgets);

      // Cache the result
      _cacheDashboard('dashboard_$userId', finalDashboard);

      return finalDashboard;
    } catch (e) {
      debugPrint('Error in dashboard fallback for user $userId: $e');
      throw Exception('Failed to get user dashboard: $e');
    }
  }

  Future<UserModel?> _fetchUserProfile(String userId) async {
    final doc = await _firestore
        .collection(AppConstants.usersCollection)
        .doc(userId)
        .get();

    return doc.exists ? UserModel.fromFirestore(doc) : null;
  }

  // Optimized dashboard query using composite indexes
  Future<List<DashboardConfig>> _getApplicableDashboardsOptimized(
      UserModel user) async {
    try {
      // Use composite query for better performance
      final query = _firestore
          .collection(AppConstants.dashboardConfigsCollection)
          .where('organizationId', isEqualTo: user.organizationId)
          .where('isActive', isEqualTo: true);

      final snapshot = await query.get();
      final dashboards = <DashboardConfig>[];

      for (final doc in snapshot.docs) {
        final dashboard = DashboardConfig.fromFirestore(doc);

        // Check applicability in memory (faster than multiple queries)
        final hasMatchingRole = user.roles.any((role) =>
            dashboard.applicableRoles.contains(role) ||
            dashboard.applicableRoles.isEmpty);

        final hasMatchingUnit = user.departmentId != null &&
            dashboard.applicableUnits.contains(user.departmentId);

        // Include dashboard if it matches roles, units, or is universal
        if (hasMatchingRole ||
            hasMatchingUnit ||
            dashboard.applicableRoles.isEmpty) {
          dashboards.add(dashboard);
        }
      }

      return dashboards;
    } catch (e) {
      debugPrint('Error fetching applicable dashboards: $e');
      return [];
    }
  }

  // Efficient batch permission checking for widgets
  Future<List<DashboardWidget>> _filterWidgetsByPermissionsBatch(
      List<DashboardWidget> widgets, String userId) async {
    if (widgets.isEmpty) return widgets;

    try {
      // Collect all unique permissions required
      final allPermissions = <String>{};
      for (final widget in widgets) {
        allPermissions.addAll(widget.requiredPermissions);
      }

      // Batch check all permissions at once (much faster)
      final permissionResults = await _permissionService
          .checkMultiplePermissions(userId, allPermissions.toList());

      // Filter widgets based on permission results
      final filteredWidgets = <DashboardWidget>[];
      for (final widget in widgets) {
        final canView = widget.requiredPermissions
            .every((permission) => permissionResults[permission] ?? false);

        if (canView) {
          filteredWidgets.add(widget);
        }
      }

      return filteredWidgets;
    } catch (e) {
      debugPrint('Error filtering widgets by permissions: $e');
      return widgets; // Return all widgets if permission check fails
    }
  }

  // Enhanced widget data retrieval with intelligent caching
  Future<Map<String, dynamic>> getWidgetData(
      String widgetId, String userId, Map<String, dynamic> config) async {
    final cacheKey = '${widgetId}_$userId';

    // Check cache first
    if (_isWidgetCacheValid(cacheKey)) {
      debugPrint('Widget data cache HIT: $cacheKey');
      return _widgetDataCache[cacheKey]!;
    }

    return executeOnlineOperation(
      () async {
        debugPrint('Widget data cache MISS: $cacheKey - Fetching from network');

        Map<String, dynamic> data;

        try {
          switch (config['dataSource']) {
            case 'firestore_query':
              data = await _executeFirestoreQueryOptimized(
                  config['query'] ?? {}, userId);
              break;
            case 'aggregation':
              data = await _executeAggregationOptimized(
                  config['aggregation'] ?? {}, userId);
              break;
            case 'real_time_stream':
              data = await _getRealTimeDataOptimized(
                  config['collection'] ?? 'data', userId);
              break;
            default:
              data = config['staticData'] ?? {};
          }

          // Cache the successful result
          _cacheWidgetData(cacheKey, data);
          return data;
        } catch (e) {
          debugPrint('Error getting widget data for $widgetId: $e');
          return {
            'error': 'Failed to load data',
            'widgetId': widgetId,
            'timestamp': DateTime.now().toIso8601String(),
          };
        }
      },
      operationName: 'Fetch Widget Data',
      fallback: _getOfflineWidgetData(widgetId, config),
    );
  }

  // Optimized Firestore queries with proper security and indexing
  Future<Map<String, dynamic>> _executeFirestoreQueryOptimized(
      Map<String, dynamic> queryConfig, String userId) async {
    final collection = queryConfig['collection'] as String? ?? 'data';
    Query query = _firestore.collection(collection);

    // Get user context for security filtering
    final user = await _fetchUserProfile(userId);
    if (user == null) {
      return {'data': [], 'count': 0, 'error': 'User not found'};
    }

    // Apply mandatory security filters
    query = query.where('organizationId', isEqualTo: user.organizationId);

    // Apply department filter for non-admin users
    if (user.departmentId != null && !user.roles.contains('admin')) {
      query = query.where('departmentId', isEqualTo: user.departmentId);
    }

    // Apply additional filters from config
    if (queryConfig.containsKey('filters')) {
      final filters = queryConfig['filters'] as List;
      for (final filter in filters) {
        final field = filter['field'] as String;
        final operator = filter['operator'] as String? ?? '==';
        final value = filter['value'];

        switch (operator) {
          case '==':
            query = query.where(field, isEqualTo: value);
            break;
          case '!=':
            query = query.where(field, isNotEqualTo: value);
            break;
          case '>':
            query = query.where(field, isGreaterThan: value);
            break;
          case '>=':
            query = query.where(field, isGreaterThanOrEqualTo: value);
            break;
          case '<':
            query = query.where(field, isLessThan: value);
            break;
          case '<=':
            query = query.where(field, isLessThanOrEqualTo: value);
            break;
          case 'array-contains':
            query = query.where(field, arrayContains: value);
            break;
          case 'in':
            query = query.where(field, whereIn: value);
            break;
        }
      }
    }

    // Apply ordering with fallback
    if (queryConfig.containsKey('orderBy')) {
      final orderBy = queryConfig['orderBy'] as Map<String, dynamic>;
      final field = orderBy['field'] as String;
      final descending = orderBy['descending'] as bool? ?? false;
      query = query.orderBy(field, descending: descending);
    } else {
      // Default ordering for consistent results
      query = query.orderBy(FieldPath.documentId);
    }

    // Apply reasonable limit to prevent excessive reads
    final limit = (queryConfig['limit'] as int?)?.clamp(1, 1000) ?? 100;
    query = query.limit(limit);

    final result = await query.get();

    return {
      'data': result.docs
          .map((doc) => {...doc.data() as Map<String, dynamic>, 'id': doc.id})
          .toList(),
      'count': result.docs.length,
      'hasMore': result.docs.length == limit,
      'lastDocumentId': result.docs.isNotEmpty ? result.docs.last.id : null,
      'timestamp': DateTime.now().toIso8601String(),
    };
  }

  // Simple aggregation implementation
  Future<Map<String, dynamic>> _executeAggregationOptimized(
      Map<String, dynamic> config, String userId) async {
    final collection = config['collection'] as String? ?? 'data';
    final operation = config['operation'] as String? ?? 'count';

    final user = await _fetchUserProfile(userId);
    if (user == null) return {'total': 0, 'error': 'User not found'};

    final snapshot = await _firestore
        .collection(collection)
        .where('organizationId', isEqualTo: user.organizationId)
        .limit(1000) // Prevent excessive reads
        .get();

    switch (operation) {
      case 'count':
        return {
          'total': snapshot.docs.length,
          'timestamp': DateTime.now().toIso8601String(),
        };
      case 'sum':
        final field = config['field'] as String;
        final sum = snapshot.docs.fold<double>(0, (sum, doc) {
          final value = doc.data()[field];
          return sum + (value is num ? value.toDouble() : 0);
        });
        return {
          'total': sum,
          'field': field,
          'timestamp': DateTime.now().toIso8601String(),
        };
      case 'average':
        final field = config['field'] as String;
        if (snapshot.docs.isEmpty) return {'average': 0, 'count': 0};

        final sum = snapshot.docs.fold<double>(0, (sum, doc) {
          final value = doc.data()[field];
          return sum + (value is num ? value.toDouble() : 0);
        });
        return {
          'average': sum / snapshot.docs.length,
          'count': snapshot.docs.length,
          'timestamp': DateTime.now().toIso8601String(),
        };
      default:
        return {
          'total': snapshot.docs.length,
          'operation': operation,
          'timestamp': DateTime.now().toIso8601String(),
        };
    }
  }

  // Real-time data with proper error handling
  Future<Map<String, dynamic>> _getRealTimeDataOptimized(
      String collection, String userId) async {
    final user = await _fetchUserProfile(userId);
    if (user == null) {
      return {
        'latest_data': [],
        'error': 'User not found',
        'timestamp': DateTime.now().toIso8601String(),
      };
    }

    final snapshot = await _firestore
        .collection(collection)
        .where('organizationId', isEqualTo: user.organizationId)
        .orderBy('timestamp', descending: true)
        .limit(20)
        .get();

    return {
      'latest_data': snapshot.docs
          .map((doc) => {
                ...doc.data(),
                'id': doc.id,
              })
          .toList(),
      'count': snapshot.docs.length,
      'last_updated': DateTime.now().toIso8601String(),
      'collection': collection,
    };
  }

  // Offline fallback data
  Map<String, dynamic> _getOfflineWidgetData(
      String widgetId, Map<String, dynamic> config) {
    return {
      'offline': true,
      'message': 'Data unavailable offline',
      'cached_at': DateTime.now().toIso8601String(),
      'widget_id': widgetId,
      'fallback_data': config['offlineFallback'] ?? {},
    };
  }

  // Default dashboard creation with role-based widgets
  Future<DashboardConfig> _createDefaultDashboard(UserModel user) async {
    final isAdmin = user.roles.contains('admin');
    final isManager = user.roles.contains('manager');

    final defaultWidgets = <DashboardWidget>[
      const DashboardWidget(
        id: 'welcome',
        type: 'kpi',
        title: 'Welcome',
        config: {
          'staticData': {'message': 'Welcome to your dashboard!'}
        },
        requiredPermissions: ['view_dashboard'],
        position: GridPosition(x: 0, y: 0, width: 2, height: 1),
      ),
      const DashboardWidget(
        id: 'system_status',
        type: 'kpi',
        title: 'System Status',
        config: {
          'staticData': {'status': 'Online', 'color': 'green'}
        },
        requiredPermissions: ['view_dashboard'],
        position: GridPosition(x: 2, y: 0, width: 2, height: 1),
      ),
    ];

    // Add role-specific widgets
    if (isManager || isAdmin) {
      defaultWidgets.add(
        const DashboardWidget(
          id: 'team_overview',
          type: 'chart',
          title: 'Team Overview',
          config: {
            'dataSource': 'aggregation',
            'aggregation': {'collection': 'users', 'operation': 'count'}
          },
          requiredPermissions: ['view_reports'],
          position: GridPosition(x: 0, y: 1, width: 4, height: 2),
        ),
      );
    }

    if (isAdmin) {
      defaultWidgets.add(
        const DashboardWidget(
          id: 'admin_analytics',
          type: 'chart',
          title: 'System Analytics',
          config: {
            'dataSource': 'aggregation',
            'aggregation': {'collection': 'organizations', 'operation': 'count'}
          },
          requiredPermissions: ['admin_access'],
          position: GridPosition(x: 0, y: 3, width: 4, height: 2),
        ),
      );
    }

    final dashboard = DashboardConfig(
      id: 'default_${user.id}',
      name: '${user.name}\'s Dashboard',
      organizationId: user.organizationId,
      applicableRoles: user.roles,
      applicableUnits: user.departmentId != null ? [user.departmentId!] : [],
      hierarchyLevel: 0,
      widgets: defaultWidgets,
      layoutConfig: {
        'columns': 4,
        'rowHeight': 150,
        'responsive': true,
      },
      createdAt: DateTime.now(),
    );

    // Cache the default dashboard
    _cacheDashboard('dashboard_${user.id}', dashboard);

    return dashboard;
  }

  Future<DashboardConfig?> _getDefaultDashboard(String userId) async {
    final user = await _fetchUserProfile(userId);
    return user != null ? await _createDefaultDashboard(user) : null;
  }

  // Cache management methods
  void _cacheDashboard(String key, DashboardConfig dashboard) {
    _evictOldCacheIfNeeded();
    _dashboardCache[key] = dashboard;
    _dashboardCacheTimestamps[key] = DateTime.now();
  }

  void _cacheWidgetData(String key, Map<String, dynamic> data) {
    _evictOldCacheIfNeeded();
    _widgetDataCache[key] = data;
    _widgetCacheTimestamps[key] = DateTime.now();
  }

  void _evictOldCacheIfNeeded() {
    if (_dashboardCache.length + _widgetDataCache.length > _maxCacheSize) {
      // Remove oldest entries
      final oldestDashboard = _getOldestCacheKey(_dashboardCacheTimestamps);
      final oldestWidget = _getOldestCacheKey(_widgetCacheTimestamps);

      if (oldestDashboard != null) {
        _dashboardCache.remove(oldestDashboard);
        _dashboardCacheTimestamps.remove(oldestDashboard);
      }

      if (oldestWidget != null) {
        _widgetDataCache.remove(oldestWidget);
        _widgetCacheTimestamps.remove(oldestWidget);
      }
    }
  }

  String? _getOldestCacheKey(Map<String, DateTime> timestamps) {
    if (timestamps.isEmpty) return null;

    DateTime oldest = DateTime.now();
    String? oldestKey;

    for (final entry in timestamps.entries) {
      if (entry.value.isBefore(oldest)) {
        oldest = entry.value;
        oldestKey = entry.key;
      }
    }

    return oldestKey;
  }

  bool _isDashboardCacheValid(String key) {
    if (!_dashboardCache.containsKey(key) ||
        !_dashboardCacheTimestamps.containsKey(key)) {
      return false;
    }

    final cacheTime = _dashboardCacheTimestamps[key]!;
    return DateTime.now().difference(cacheTime) < _dashboardCacheTimeout;
  }

  bool _isWidgetCacheValid(String key) {
    if (!_widgetDataCache.containsKey(key) ||
        !_widgetCacheTimestamps.containsKey(key)) {
      return false;
    }

    final cacheTime = _widgetCacheTimestamps[key]!;
    return DateTime.now().difference(cacheTime) < _widgetCacheTimeout;
  }

  // Public cache management methods
  Future<void> invalidateUserDashboard(String userId) async {
    final cacheKey = 'dashboard_$userId';
    _dashboardCache.remove(cacheKey);
    _dashboardCacheTimestamps.remove(cacheKey);

    // Also remove related widget caches
    final keysToRemove =
        _widgetDataCache.keys.where((key) => key.contains(userId)).toList();

    for (final key in keysToRemove) {
      _widgetDataCache.remove(key);
      _widgetCacheTimestamps.remove(key);
    }

    debugPrint('Invalidated dashboard cache for user: $userId');
  }

  Future<void> refreshDashboard(String userId) async {
    await invalidateUserDashboard(userId);
    // Pre-warm cache
    await getUserDashboard(userId);
  }

  void clearAllCache() {
    _dashboardCache.clear();
    _dashboardCacheTimestamps.clear();
    _widgetDataCache.clear();
    _widgetCacheTimestamps.clear();
    debugPrint('All dashboard cache cleared');
  }

  // Analytics and monitoring
  Map<String, dynamic> getDashboardStats() {
    return {
      'cached_dashboards': _dashboardCache.length,
      'cached_widgets': _widgetDataCache.length,
      'total_cache_size': _dashboardCache.length + _widgetDataCache.length,
      'max_cache_size': _maxCacheSize,
      'dashboard_cache_timeout_hours': _dashboardCacheTimeout.inHours,
      'widget_cache_timeout_minutes': _widgetCacheTimeout.inMinutes,
      'memory_usage_percent':
          ((_dashboardCache.length + _widgetDataCache.length) /
                      _maxCacheSize *
                      100)
                  .toStringAsFixed(1) +
              '%',
      'last_activity': DateTime.now().toIso8601String(),
    };
  }
}
