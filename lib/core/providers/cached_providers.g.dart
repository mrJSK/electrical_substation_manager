// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cached_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$cachedUserPermissionsHash() =>
    r'e37e618f44acbfc04e1e14b9030e997015350ed1';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$CachedUserPermissions
    extends BuildlessAutoDisposeAsyncNotifier<Map<String, bool>> {
  late final String userId;

  FutureOr<Map<String, bool>> build(
    String userId,
  );
}

/// Cached user permissions with enhanced error handling
/// Cached user permissions with enhanced error handling
///
/// Copied from [CachedUserPermissions].
@ProviderFor(CachedUserPermissions)
const cachedUserPermissionsProvider = CachedUserPermissionsFamily();

/// Cached user permissions with enhanced error handling
/// Cached user permissions with enhanced error handling
///
/// Copied from [CachedUserPermissions].
class CachedUserPermissionsFamily
    extends Family<AsyncValue<Map<String, bool>>> {
  /// Cached user permissions with enhanced error handling
  /// Cached user permissions with enhanced error handling
  ///
  /// Copied from [CachedUserPermissions].
  const CachedUserPermissionsFamily();

  /// Cached user permissions with enhanced error handling
  /// Cached user permissions with enhanced error handling
  ///
  /// Copied from [CachedUserPermissions].
  CachedUserPermissionsProvider call(
    String userId,
  ) {
    return CachedUserPermissionsProvider(
      userId,
    );
  }

  @override
  CachedUserPermissionsProvider getProviderOverride(
    covariant CachedUserPermissionsProvider provider,
  ) {
    return call(
      provider.userId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'cachedUserPermissionsProvider';
}

/// Cached user permissions with enhanced error handling
/// Cached user permissions with enhanced error handling
///
/// Copied from [CachedUserPermissions].
class CachedUserPermissionsProvider
    extends AutoDisposeAsyncNotifierProviderImpl<CachedUserPermissions,
        Map<String, bool>> {
  /// Cached user permissions with enhanced error handling
  /// Cached user permissions with enhanced error handling
  ///
  /// Copied from [CachedUserPermissions].
  CachedUserPermissionsProvider(
    String userId,
  ) : this._internal(
          () => CachedUserPermissions()..userId = userId,
          from: cachedUserPermissionsProvider,
          name: r'cachedUserPermissionsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$cachedUserPermissionsHash,
          dependencies: CachedUserPermissionsFamily._dependencies,
          allTransitiveDependencies:
              CachedUserPermissionsFamily._allTransitiveDependencies,
          userId: userId,
        );

  CachedUserPermissionsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userId,
  }) : super.internal();

  final String userId;

  @override
  FutureOr<Map<String, bool>> runNotifierBuild(
    covariant CachedUserPermissions notifier,
  ) {
    return notifier.build(
      userId,
    );
  }

  @override
  Override overrideWith(CachedUserPermissions Function() create) {
    return ProviderOverride(
      origin: this,
      override: CachedUserPermissionsProvider._internal(
        () => create()..userId = userId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userId: userId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<CachedUserPermissions,
      Map<String, bool>> createElement() {
    return _CachedUserPermissionsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CachedUserPermissionsProvider && other.userId == userId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin CachedUserPermissionsRef
    on AutoDisposeAsyncNotifierProviderRef<Map<String, bool>> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _CachedUserPermissionsProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<CachedUserPermissions,
        Map<String, bool>> with CachedUserPermissionsRef {
  _CachedUserPermissionsProviderElement(super.provider);

  @override
  String get userId => (origin as CachedUserPermissionsProvider).userId;
}

String _$cachedUserProfileHash() => r'a288f97f4b119e543b67adee84f333fd8648ea28';

abstract class _$CachedUserProfile
    extends BuildlessAutoDisposeAsyncNotifier<UserModel?> {
  late final String userId;

  FutureOr<UserModel?> build(
    String userId,
  );
}

/// Cached user profile with organization context
///
/// Copied from [CachedUserProfile].
@ProviderFor(CachedUserProfile)
const cachedUserProfileProvider = CachedUserProfileFamily();

/// Cached user profile with organization context
///
/// Copied from [CachedUserProfile].
class CachedUserProfileFamily extends Family<AsyncValue<UserModel?>> {
  /// Cached user profile with organization context
  ///
  /// Copied from [CachedUserProfile].
  const CachedUserProfileFamily();

  /// Cached user profile with organization context
  ///
  /// Copied from [CachedUserProfile].
  CachedUserProfileProvider call(
    String userId,
  ) {
    return CachedUserProfileProvider(
      userId,
    );
  }

  @override
  CachedUserProfileProvider getProviderOverride(
    covariant CachedUserProfileProvider provider,
  ) {
    return call(
      provider.userId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'cachedUserProfileProvider';
}

/// Cached user profile with organization context
///
/// Copied from [CachedUserProfile].
class CachedUserProfileProvider extends AutoDisposeAsyncNotifierProviderImpl<
    CachedUserProfile, UserModel?> {
  /// Cached user profile with organization context
  ///
  /// Copied from [CachedUserProfile].
  CachedUserProfileProvider(
    String userId,
  ) : this._internal(
          () => CachedUserProfile()..userId = userId,
          from: cachedUserProfileProvider,
          name: r'cachedUserProfileProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$cachedUserProfileHash,
          dependencies: CachedUserProfileFamily._dependencies,
          allTransitiveDependencies:
              CachedUserProfileFamily._allTransitiveDependencies,
          userId: userId,
        );

  CachedUserProfileProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userId,
  }) : super.internal();

  final String userId;

  @override
  FutureOr<UserModel?> runNotifierBuild(
    covariant CachedUserProfile notifier,
  ) {
    return notifier.build(
      userId,
    );
  }

  @override
  Override overrideWith(CachedUserProfile Function() create) {
    return ProviderOverride(
      origin: this,
      override: CachedUserProfileProvider._internal(
        () => create()..userId = userId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userId: userId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<CachedUserProfile, UserModel?>
      createElement() {
    return _CachedUserProfileProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CachedUserProfileProvider && other.userId == userId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin CachedUserProfileRef on AutoDisposeAsyncNotifierProviderRef<UserModel?> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _CachedUserProfileProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<CachedUserProfile,
        UserModel?> with CachedUserProfileRef {
  _CachedUserProfileProviderElement(super.provider);

  @override
  String get userId => (origin as CachedUserProfileProvider).userId;
}

String _$cachedDashboardHash() => r'bf5ae745d78e4172766be157b25f1c08d5995aab';

abstract class _$CachedDashboard
    extends BuildlessAutoDisposeAsyncNotifier<DashboardConfig?> {
  late final String userId;

  FutureOr<DashboardConfig?> build(
    String userId,
  );
}

/// Enhanced cached dashboard with organization context
///
/// Copied from [CachedDashboard].
@ProviderFor(CachedDashboard)
const cachedDashboardProvider = CachedDashboardFamily();

/// Enhanced cached dashboard with organization context
///
/// Copied from [CachedDashboard].
class CachedDashboardFamily extends Family<AsyncValue<DashboardConfig?>> {
  /// Enhanced cached dashboard with organization context
  ///
  /// Copied from [CachedDashboard].
  const CachedDashboardFamily();

  /// Enhanced cached dashboard with organization context
  ///
  /// Copied from [CachedDashboard].
  CachedDashboardProvider call(
    String userId,
  ) {
    return CachedDashboardProvider(
      userId,
    );
  }

  @override
  CachedDashboardProvider getProviderOverride(
    covariant CachedDashboardProvider provider,
  ) {
    return call(
      provider.userId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'cachedDashboardProvider';
}

/// Enhanced cached dashboard with organization context
///
/// Copied from [CachedDashboard].
class CachedDashboardProvider extends AutoDisposeAsyncNotifierProviderImpl<
    CachedDashboard, DashboardConfig?> {
  /// Enhanced cached dashboard with organization context
  ///
  /// Copied from [CachedDashboard].
  CachedDashboardProvider(
    String userId,
  ) : this._internal(
          () => CachedDashboard()..userId = userId,
          from: cachedDashboardProvider,
          name: r'cachedDashboardProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$cachedDashboardHash,
          dependencies: CachedDashboardFamily._dependencies,
          allTransitiveDependencies:
              CachedDashboardFamily._allTransitiveDependencies,
          userId: userId,
        );

  CachedDashboardProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userId,
  }) : super.internal();

  final String userId;

  @override
  FutureOr<DashboardConfig?> runNotifierBuild(
    covariant CachedDashboard notifier,
  ) {
    return notifier.build(
      userId,
    );
  }

  @override
  Override overrideWith(CachedDashboard Function() create) {
    return ProviderOverride(
      origin: this,
      override: CachedDashboardProvider._internal(
        () => create()..userId = userId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userId: userId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<CachedDashboard, DashboardConfig?>
      createElement() {
    return _CachedDashboardProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CachedDashboardProvider && other.userId == userId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin CachedDashboardRef
    on AutoDisposeAsyncNotifierProviderRef<DashboardConfig?> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _CachedDashboardProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<CachedDashboard,
        DashboardConfig?> with CachedDashboardRef {
  _CachedDashboardProviderElement(super.provider);

  @override
  String get userId => (origin as CachedDashboardProvider).userId;
}

String _$cachedWidgetDataHash() => r'07dc757d74781a8d77722734e559d1853e9cf397';

abstract class _$CachedWidgetData
    extends BuildlessAutoDisposeAsyncNotifier<Map<String, dynamic>> {
  late final String widgetId;
  late final String userId;

  FutureOr<Map<String, dynamic>> build(
    String widgetId,
    String userId,
  );
}

/// Cached widget data with enhanced error handling
///
/// Copied from [CachedWidgetData].
@ProviderFor(CachedWidgetData)
const cachedWidgetDataProvider = CachedWidgetDataFamily();

/// Cached widget data with enhanced error handling
///
/// Copied from [CachedWidgetData].
class CachedWidgetDataFamily extends Family<AsyncValue<Map<String, dynamic>>> {
  /// Cached widget data with enhanced error handling
  ///
  /// Copied from [CachedWidgetData].
  const CachedWidgetDataFamily();

  /// Cached widget data with enhanced error handling
  ///
  /// Copied from [CachedWidgetData].
  CachedWidgetDataProvider call(
    String widgetId,
    String userId,
  ) {
    return CachedWidgetDataProvider(
      widgetId,
      userId,
    );
  }

  @override
  CachedWidgetDataProvider getProviderOverride(
    covariant CachedWidgetDataProvider provider,
  ) {
    return call(
      provider.widgetId,
      provider.userId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'cachedWidgetDataProvider';
}

/// Cached widget data with enhanced error handling
///
/// Copied from [CachedWidgetData].
class CachedWidgetDataProvider extends AutoDisposeAsyncNotifierProviderImpl<
    CachedWidgetData, Map<String, dynamic>> {
  /// Cached widget data with enhanced error handling
  ///
  /// Copied from [CachedWidgetData].
  CachedWidgetDataProvider(
    String widgetId,
    String userId,
  ) : this._internal(
          () => CachedWidgetData()
            ..widgetId = widgetId
            ..userId = userId,
          from: cachedWidgetDataProvider,
          name: r'cachedWidgetDataProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$cachedWidgetDataHash,
          dependencies: CachedWidgetDataFamily._dependencies,
          allTransitiveDependencies:
              CachedWidgetDataFamily._allTransitiveDependencies,
          widgetId: widgetId,
          userId: userId,
        );

  CachedWidgetDataProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.widgetId,
    required this.userId,
  }) : super.internal();

  final String widgetId;
  final String userId;

  @override
  FutureOr<Map<String, dynamic>> runNotifierBuild(
    covariant CachedWidgetData notifier,
  ) {
    return notifier.build(
      widgetId,
      userId,
    );
  }

  @override
  Override overrideWith(CachedWidgetData Function() create) {
    return ProviderOverride(
      origin: this,
      override: CachedWidgetDataProvider._internal(
        () => create()
          ..widgetId = widgetId
          ..userId = userId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        widgetId: widgetId,
        userId: userId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<CachedWidgetData,
      Map<String, dynamic>> createElement() {
    return _CachedWidgetDataProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CachedWidgetDataProvider &&
        other.widgetId == widgetId &&
        other.userId == userId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, widgetId.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin CachedWidgetDataRef
    on AutoDisposeAsyncNotifierProviderRef<Map<String, dynamic>> {
  /// The parameter `widgetId` of this provider.
  String get widgetId;

  /// The parameter `userId` of this provider.
  String get userId;
}

class _CachedWidgetDataProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<CachedWidgetData,
        Map<String, dynamic>> with CachedWidgetDataRef {
  _CachedWidgetDataProviderElement(super.provider);

  @override
  String get widgetId => (origin as CachedWidgetDataProvider).widgetId;
  @override
  String get userId => (origin as CachedWidgetDataProvider).userId;
}

String _$cachedDynamicModelsHash() =>
    r'a6b7384bfc4642f3bf1ee24ca09857ef62b75abc';

/// Cached dynamic models for the application
///
/// Copied from [CachedDynamicModels].
@ProviderFor(CachedDynamicModels)
final cachedDynamicModelsProvider = AutoDisposeAsyncNotifierProvider<
    CachedDynamicModels, List<DynamicModel>>.internal(
  CachedDynamicModels.new,
  name: r'cachedDynamicModelsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$cachedDynamicModelsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CachedDynamicModels = AutoDisposeAsyncNotifier<List<DynamicModel>>;
String _$cachedOrgDynamicModelsHash() =>
    r'c4c6b45a6e0f645b84a60b8b355204ae9b1a0dd3';

abstract class _$CachedOrgDynamicModels
    extends BuildlessAutoDisposeAsyncNotifier<List<DynamicModel>> {
  late final String organizationId;

  FutureOr<List<DynamicModel>> build(
    String organizationId,
  );
}

/// Cached organization-specific dynamic models
///
/// Copied from [CachedOrgDynamicModels].
@ProviderFor(CachedOrgDynamicModels)
const cachedOrgDynamicModelsProvider = CachedOrgDynamicModelsFamily();

/// Cached organization-specific dynamic models
///
/// Copied from [CachedOrgDynamicModels].
class CachedOrgDynamicModelsFamily
    extends Family<AsyncValue<List<DynamicModel>>> {
  /// Cached organization-specific dynamic models
  ///
  /// Copied from [CachedOrgDynamicModels].
  const CachedOrgDynamicModelsFamily();

  /// Cached organization-specific dynamic models
  ///
  /// Copied from [CachedOrgDynamicModels].
  CachedOrgDynamicModelsProvider call(
    String organizationId,
  ) {
    return CachedOrgDynamicModelsProvider(
      organizationId,
    );
  }

  @override
  CachedOrgDynamicModelsProvider getProviderOverride(
    covariant CachedOrgDynamicModelsProvider provider,
  ) {
    return call(
      provider.organizationId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'cachedOrgDynamicModelsProvider';
}

/// Cached organization-specific dynamic models
///
/// Copied from [CachedOrgDynamicModels].
class CachedOrgDynamicModelsProvider
    extends AutoDisposeAsyncNotifierProviderImpl<CachedOrgDynamicModels,
        List<DynamicModel>> {
  /// Cached organization-specific dynamic models
  ///
  /// Copied from [CachedOrgDynamicModels].
  CachedOrgDynamicModelsProvider(
    String organizationId,
  ) : this._internal(
          () => CachedOrgDynamicModels()..organizationId = organizationId,
          from: cachedOrgDynamicModelsProvider,
          name: r'cachedOrgDynamicModelsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$cachedOrgDynamicModelsHash,
          dependencies: CachedOrgDynamicModelsFamily._dependencies,
          allTransitiveDependencies:
              CachedOrgDynamicModelsFamily._allTransitiveDependencies,
          organizationId: organizationId,
        );

  CachedOrgDynamicModelsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.organizationId,
  }) : super.internal();

  final String organizationId;

  @override
  FutureOr<List<DynamicModel>> runNotifierBuild(
    covariant CachedOrgDynamicModels notifier,
  ) {
    return notifier.build(
      organizationId,
    );
  }

  @override
  Override overrideWith(CachedOrgDynamicModels Function() create) {
    return ProviderOverride(
      origin: this,
      override: CachedOrgDynamicModelsProvider._internal(
        () => create()..organizationId = organizationId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        organizationId: organizationId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<CachedOrgDynamicModels,
      List<DynamicModel>> createElement() {
    return _CachedOrgDynamicModelsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CachedOrgDynamicModelsProvider &&
        other.organizationId == organizationId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, organizationId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin CachedOrgDynamicModelsRef
    on AutoDisposeAsyncNotifierProviderRef<List<DynamicModel>> {
  /// The parameter `organizationId` of this provider.
  String get organizationId;
}

class _CachedOrgDynamicModelsProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<CachedOrgDynamicModels,
        List<DynamicModel>> with CachedOrgDynamicModelsRef {
  _CachedOrgDynamicModelsProviderElement(super.provider);

  @override
  String get organizationId =>
      (origin as CachedOrgDynamicModelsProvider).organizationId;
}

String _$cacheManagerHash() => r'458507781dc115b550f92219cd43d4e4e004afce';

/// Enhanced cache manager with comprehensive functionality
///
/// Copied from [CacheManager].
@ProviderFor(CacheManager)
final cacheManagerProvider =
    AutoDisposeAsyncNotifierProvider<CacheManager, void>.internal(
  CacheManager.new,
  name: r'cacheManagerProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$cacheManagerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CacheManager = AutoDisposeAsyncNotifier<void>;
String _$cacheRefreshSchedulerHash() =>
    r'3be6eebafdee62486fa58ca58f437078e5a43ceb';

/// Automated cache refresh scheduler
///
/// Copied from [CacheRefreshScheduler].
@ProviderFor(CacheRefreshScheduler)
final cacheRefreshSchedulerProvider =
    AutoDisposeAsyncNotifierProvider<CacheRefreshScheduler, void>.internal(
  CacheRefreshScheduler.new,
  name: r'cacheRefreshSchedulerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$cacheRefreshSchedulerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CacheRefreshScheduler = AutoDisposeAsyncNotifier<void>;
String _$cachePerformanceMonitorHash() =>
    r'de9a5f2ffe1d70a9c5a700007388c183153e6b86';

/// Monitor cache performance and optimize automatically
///
/// Copied from [CachePerformanceMonitor].
@ProviderFor(CachePerformanceMonitor)
final cachePerformanceMonitorProvider = AutoDisposeAsyncNotifierProvider<
    CachePerformanceMonitor, Map<String, dynamic>>.internal(
  CachePerformanceMonitor.new,
  name: r'cachePerformanceMonitorProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$cachePerformanceMonitorHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CachePerformanceMonitor
    = AutoDisposeAsyncNotifier<Map<String, dynamic>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
