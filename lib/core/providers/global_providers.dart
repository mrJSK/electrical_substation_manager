import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/dashboard_model.dart';
import '../models/user_model.dart';
import '../models/organization_model.dart';
import '../models/notification_model.dart';
import '../services/auth_service.dart';
import '../services/notification_service.dart';
import '../services/permission_service.dart';
import '../services/dashboard_service.dart';
import '../services/connectivity_service.dart';
import '../services/enhanced_isar_service.dart';
import 'cached_providers.dart';

// =============================================================================
// CORE SERVICE PROVIDERS (FIXED TYPE ANNOTATIONS)
// =============================================================================

/// Authentication service provider
final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});

/// Permission service provider
final permissionServiceProvider = Provider<PermissionService>((ref) {
  return PermissionService();
});

/// Dashboard service provider
final dashboardServiceProvider = Provider<DashboardService>((ref) {
  return DashboardService();
});

/// Connectivity service provider with proper lifecycle management
final connectivityServiceProvider = Provider<ConnectivityService>((ref) {
  final service = ConnectivityService();

  // Initialize the service
  service.initialize();

  // Dispose service when provider is disposed
  ref.onDispose(() {
    service.dispose();
  });

  return service;
});

/// Enhanced Isar database service provider
final isarServiceProvider = Provider<EnhancedIsarService>((ref) {
  return EnhancedIsarService.instance; // Use singleton instance
});

/// Notification service provider
final notificationServiceProvider = Provider<NotificationService>((ref) {
  final auth = ref.watch(authServiceProvider);
  return NotificationService(auth);
});

// =============================================================================
// AUTHENTICATION & USER PROVIDERS (FIXED TYPE ANNOTATIONS)
// =============================================================================

/// Current authenticated user stream provider
final currentUserProvider = StreamProvider<User?>((ref) {
  final auth = ref.watch(authServiceProvider);
  return auth.authStateChanges;
});

/// Authentication state provider (simplified boolean)
final isAuthenticatedProvider = Provider<bool>((ref) {
  final userAsync = ref.watch(currentUserProvider);
  return userAsync.when(
    data: (user) => user != null,
    loading: () => false,
    error: (_, __) => false,
  );
});

/// Current user ID provider
final currentUserIdProvider = Provider<String?>((ref) {
  final userAsync = ref.watch(currentUserProvider);
  return userAsync.when(
    data: (user) => user?.uid,
    loading: () => null,
    error: (_, __) => null,
  );
});

/// User profile provider with caching
final userProfileProvider =
    FutureProvider.family<UserModel?, String>((ref, userId) async {
  final auth = ref.watch(authServiceProvider);
  final cacheManager = ref.watch(cacheManagerProvider.notifier);

  try {
    // Try to get from cache first
    final cachedProfile =
        await cacheManager.getCachedData<UserModel>('user_profile_$userId');
    if (cachedProfile != null) {
      return cachedProfile;
    }

    // Fetch from service
    final profile = await auth.getUserProfile(userId);

    // Cache the result
    if (profile != null) {
      await cacheManager.cacheData('user_profile_$userId', profile);
    }

    return profile;
  } catch (e) {
    // Try to return cached data on error
    final cached =
        await cacheManager.getCachedData<UserModel>('user_profile_$userId');
    return cached;
  }
});

/// Current user profile provider
final currentUserProfileProvider = FutureProvider<UserModel?>((ref) async {
  final userId = ref.watch(currentUserIdProvider);
  if (userId == null) return null;

  final profileAsync = ref.watch(userProfileProvider(userId));
  return profileAsync.when(
    data: (profile) => profile,
    loading: () => null,
    error: (_, __) => null,
  );
});

/// User organization provider
final userOrganizationProvider =
    FutureProvider.family<OrganizationModel?, String>(
        (ref, organizationId) async {
  final auth = ref.watch(authServiceProvider);
  final cacheManager = ref.watch(cacheManagerProvider.notifier);

  try {
    // Try cache first
    final cachedOrg = await cacheManager
        .getCachedData<OrganizationModel>('organization_$organizationId');
    if (cachedOrg != null) {
      return cachedOrg;
    }

    // Fetch from service
    final organization = await auth.getOrganization(organizationId);

    // Cache the result
    if (organization != null) {
      await cacheManager.cacheData(
          'organization_$organizationId', organization);
    }

    return organization;
  } catch (e) {
    final cached = await cacheManager
        .getCachedData<OrganizationModel>('organization_$organizationId');
    return cached;
  }
});

// =============================================================================
// PERMISSION PROVIDERS (FIXED TYPE ANNOTATIONS)
// =============================================================================

/// User permissions provider with caching
final userPermissionsProvider =
    FutureProvider.family<Map<String, bool>, String>((ref, userId) async {
  final permissionService = ref.watch(permissionServiceProvider);
  final cacheManager = ref.watch(cacheManagerProvider.notifier);

  try {
    // Try cache first
    final cachedPermissions = await cacheManager
        .getCachedData<Map<String, bool>>('permissions_$userId');
    if (cachedPermissions != null) {
      return cachedPermissions;
    }

    // Fetch from service
    final permissions = await permissionService.getUserPermissions(userId);

    // Cache the result
    await cacheManager.cacheData('permissions_$userId', permissions);

    return permissions;
  } catch (e) {
    // Return cached data on error or empty map
    final cached = await cacheManager
        .getCachedData<Map<String, bool>>('permissions_$userId');
    return cached ?? <String, bool>{};
  }
});

/// Specific permission checker provider
final hasPermissionProvider =
    FutureProvider.family<bool, ({String userId, String permission})>(
        (ref, params) async {
  final permissionService = ref.watch(permissionServiceProvider);

  try {
    return await permissionService.hasPermission(
        params.userId, params.permission);
  } catch (e) {
    // Fail closed for security (deny access if permission check fails)
    return false;
  }
});

/// Current user permissions provider
final currentUserPermissionsProvider =
    FutureProvider<Map<String, bool>>((ref) async {
  final userId = ref.watch(currentUserIdProvider);
  if (userId == null) return <String, bool>{};

  final permissionsAsync = ref.watch(userPermissionsProvider(userId));
  return permissionsAsync.when(
    data: (permissions) => permissions,
    loading: () => <String, bool>{},
    error: (_, __) => <String, bool>{},
  );
});

// =============================================================================
// CONNECTIVITY PROVIDERS (FIXED TYPE ANNOTATIONS)
// =============================================================================

/// Connectivity status stream provider
final connectivityStatusProvider = StreamProvider<ConnectivityStatus>((ref) {
  final connectivity = ref.watch(connectivityServiceProvider);
  return connectivity.statusStream;
});

/// Simple boolean connectivity provider
final isOnlineProvider = Provider<bool>((ref) {
  final statusAsync = ref.watch(connectivityStatusProvider);
  return statusAsync.when(
    data: (status) => status == ConnectivityStatus.online,
    loading: () => false,
    error: (_, __) => false,
  );
});

/// Network type provider (WiFi, Mobile, etc.)
final networkTypeProvider = Provider<String>((ref) {
  final connectivity = ref.watch(connectivityServiceProvider);
  return connectivity.connectionType;
});

// =============================================================================
// NOTIFICATION PROVIDERS (FIXED TYPE ANNOTATIONS)
// =============================================================================

/// User notifications provider
final userNotificationsProvider =
    StreamProvider.family<List<NotificationModel>, String>((ref, userId) {
  final notificationService = ref.watch(notificationServiceProvider);
  return notificationService.getUserNotifications(userId);
});

/// Unread notifications count provider
final unreadNotificationsCountProvider =
    Provider.family<int, String>((ref, userId) {
  final notificationsAsync = ref.watch(userNotificationsProvider(userId));
  return notificationsAsync.when(
    data: (notifications) => notifications.where((n) => !n.isRead).length,
    loading: () => 0,
    error: (_, __) => 0,
  );
});

/// Current user notifications provider
final currentUserNotificationsProvider =
    StreamProvider<List<NotificationModel>>((ref) {
  final userId = ref.watch(currentUserIdProvider);
  if (userId == null) return Stream.value(<NotificationModel>[]);

  final notificationsAsync = ref.watch(userNotificationsProvider(userId));
  return notificationsAsync.when(
    data: (notifications) => Stream.value(notifications),
    loading: () => Stream.value(<NotificationModel>[]),
    error: (_, __) => Stream.value(<NotificationModel>[]),
  );
});

// =============================================================================
// APPLICATION STATE PROVIDERS (FIXED TYPE ANNOTATIONS)
// =============================================================================

/// App initialization provider
final appInitializationProvider = FutureProvider<bool>((ref) async {
  try {
    // Initialize core services
    final connectivity = ref.watch(connectivityServiceProvider);
    final isar = ref.watch(isarServiceProvider);

    // Wait for connectivity service to initialize
    await connectivity.initialize();

    // Initialize database
    await EnhancedIsarService.initialize(); // Use static method

    return true;
  } catch (e) {
    return false;
  }
});

/// App theme mode provider (for future theme switching)
final themeModeProvider = StateProvider<ThemeMode>((ref) {
  return ThemeMode.system;
});

/// Selected organization provider (for multi-org users)
final selectedOrganizationProvider = StateProvider<String?>((ref) {
  return null;
});

// =============================================================================
// DASHBOARD PROVIDERS (FIXED TYPE ANNOTATIONS)
// =============================================================================

/// Dashboard configuration provider
final dashboardConfigProvider =
    FutureProvider.family<DashboardConfig?, String>((ref, userId) async {
  final dashboardService = ref.watch(dashboardServiceProvider);
  final cacheManager = ref.watch(cacheManagerProvider.notifier);

  try {
    // Try cache first
    final cachedDashboard =
        await cacheManager.getCachedData<DashboardConfig>('dashboard_$userId');
    if (cachedDashboard != null) {
      return cachedDashboard;
    }

    // Fetch from service
    final dashboard = await dashboardService.getUserDashboard(userId);

    // Cache the result
    if (dashboard != null) {
      await cacheManager.cacheData('dashboard_$userId', dashboard);
    }

    return dashboard;
  } catch (e) {
    final cached =
        await cacheManager.getCachedData<DashboardConfig>('dashboard_$userId');
    return cached;
  }
});

/// Widget data provider
final widgetDataProvider = FutureProvider.family<Map<String, dynamic>,
    ({String widgetId, String userId})>((ref, params) async {
  final dashboardService = ref.watch(dashboardServiceProvider);
  final cacheManager = ref.watch(cacheManagerProvider.notifier);

  try {
    // Get widget configuration first
    final dashboard =
        await ref.read(dashboardConfigProvider(params.userId).future);
    final widget = dashboard?.widgets.firstWhere(
      (w) => w.id == params.widgetId,
      orElse: () => throw Exception('Widget not found'),
    );

    if (widget == null) {
      throw Exception('Widget configuration not found');
    }

    // Try cache first
    final cacheKey = 'widget_${params.widgetId}_${params.userId}';
    final cachedData =
        await cacheManager.getCachedData<Map<String, dynamic>>(cacheKey);
    if (cachedData != null && !widget.needsRefresh) {
      return cachedData;
    }

    // Fetch fresh data
    final data = await dashboardService.getWidgetData(
      params.widgetId,
      params.userId,
      widget.config,
    );

    // Cache the result
    await cacheManager.cacheData(cacheKey, data);

    return data;
  } catch (e) {
    // Return cached data on error or empty data
    final cacheKey = 'widget_${params.widgetId}_${params.userId}';
    final cached =
        await cacheManager.getCachedData<Map<String, dynamic>>(cacheKey);
    return cached ??
        {
          'error': true,
          'message': e.toString(),
          'timestamp': DateTime.now().toIso8601String(),
        };
  }
});

// =============================================================================
// UTILITY PROVIDERS (FIXED TYPE ANNOTATIONS)
// =============================================================================

/// Current timestamp provider (useful for refresh triggers)
final currentTimestampProvider = StateProvider<DateTime>((ref) {
  return DateTime.now();
});

/// App version provider
final appVersionProvider = Provider<String>((ref) {
  return '1.0.0'; // You can get this from package_info_plus
});

/// Debug mode provider
final isDebugModeProvider = Provider<bool>((ref) {
  return false; // Set based on kDebugMode or environment
});

// =============================================================================
// COMPUTED PROVIDERS (Combinations of multiple providers) - FIXED TYPE ANNOTATIONS
// =============================================================================

/// User context provider (combines user info, permissions, and organization)
final userContextProvider = FutureProvider<UserContext?>((ref) async {
  final userId = ref.watch(currentUserIdProvider);
  if (userId == null) return null;

  final profile = await ref.read(userProfileProvider(userId).future);
  if (profile == null) return null;

  final permissions = await ref.read(userPermissionsProvider(userId).future);
  final organization = profile.organizationId.isNotEmpty
      ? await ref.read(userOrganizationProvider(profile.organizationId).future)
      : null;

  return UserContext(
    user: profile,
    permissions: permissions,
    organization: organization,
  );
});

/// System status provider (combines connectivity, auth, and initialization)
final systemStatusProvider = Provider<SystemStatus>((ref) {
  final isInitialized = ref.watch(appInitializationProvider).when(
        data: (initialized) => initialized,
        loading: () => false,
        error: (_, __) => false,
      );

  final isAuthenticated = ref.watch(isAuthenticatedProvider);
  final isOnline = ref.watch(isOnlineProvider);

  return SystemStatus(
    isInitialized: isInitialized,
    isAuthenticated: isAuthenticated,
    isOnline: isOnline,
  );
});

// =============================================================================
// HELPER CLASSES (FIXED TYPE ANNOTATIONS)
// =============================================================================

/// User context data class
class UserContext {
  final UserModel user;
  final Map<String, bool> permissions;
  final OrganizationModel? organization;

  const UserContext({
    required this.user,
    required this.permissions,
    this.organization,
  });

  bool hasPermission(String permission) {
    return permissions[permission] ?? false;
  }

  bool get isAdmin => user.roles.contains('admin');
  bool get isManager => user.roles.contains('manager');
}

/// System status data class
class SystemStatus {
  final bool isInitialized;
  final bool isAuthenticated;
  final bool isOnline;

  const SystemStatus({
    required this.isInitialized,
    required this.isAuthenticated,
    required this.isOnline,
  });

  bool get isReady => isInitialized && isAuthenticated;
  bool get isFullyOperational => isInitialized && isAuthenticated && isOnline;
}

// =============================================================================
// PROVIDER REFRESH HELPERS (FIXED TYPE ANNOTATIONS)
// =============================================================================

/// Extension to make provider refreshing easier
extension ProviderRefreshExtensions on WidgetRef {
  /// Refresh user data
  void refreshUserData(String userId) {
    refresh(userProfileProvider(userId));
    refresh(userPermissionsProvider(userId));
  }

  /// Refresh dashboard data
  void refreshDashboard(String userId) {
    refresh(dashboardConfigProvider(userId));
    // Refresh all widget data for this user
    read(cacheManagerProvider.notifier).invalidatePattern('widget_*_$userId');
  }

  /// Refresh all user-related data
  void refreshAllUserData(String userId) {
    refreshUserData(userId);
    refreshDashboard(userId);
    refresh(userNotificationsProvider(userId));
  }

  /// Force refresh connectivity
  void refreshConnectivity() {
    read(connectivityServiceProvider).checkConnectivity();
  }
}

// =============================================================================
// PROVIDER OBSERVERS (for debugging) - FIXED TYPE ANNOTATIONS
// =============================================================================

class ProviderLogger extends ProviderObserver {
  @override
  void didUpdateProvider(
    ProviderBase provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    if (newValue is AsyncError) {
      print(
          '[PROVIDER ERROR] ${provider.name ?? provider.runtimeType}: ${newValue.error}');
    }
  }

  @override
  void didDisposeProvider(ProviderBase provider, ProviderContainer container) {
    print('[PROVIDER DISPOSED] ${provider.name ?? provider.runtimeType}');
  }
}
