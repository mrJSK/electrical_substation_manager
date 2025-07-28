// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cached_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$cachedUserPermissionsHash() =>
    r'bbdd15ea5ca7f09312c8af3ff0e971a76458ac09';

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
    extends BuildlessAutoDisposeAsyncNotifier<List<String>> {
  late final String userId;

  FutureOr<List<String>> build(
    String userId,
  );
}

/// See also [CachedUserPermissions].
@ProviderFor(CachedUserPermissions)
const cachedUserPermissionsProvider = CachedUserPermissionsFamily();

/// See also [CachedUserPermissions].
class CachedUserPermissionsFamily extends Family<AsyncValue<List<String>>> {
  /// See also [CachedUserPermissions].
  const CachedUserPermissionsFamily();

  /// See also [CachedUserPermissions].
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

/// See also [CachedUserPermissions].
class CachedUserPermissionsProvider
    extends AutoDisposeAsyncNotifierProviderImpl<CachedUserPermissions,
        List<String>> {
  /// See also [CachedUserPermissions].
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
  FutureOr<List<String>> runNotifierBuild(
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
  AutoDisposeAsyncNotifierProviderElement<CachedUserPermissions, List<String>>
      createElement() {
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
    on AutoDisposeAsyncNotifierProviderRef<List<String>> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _CachedUserPermissionsProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<CachedUserPermissions,
        List<String>> with CachedUserPermissionsRef {
  _CachedUserPermissionsProviderElement(super.provider);

  @override
  String get userId => (origin as CachedUserPermissionsProvider).userId;
}

String _$cachedDashboardHash() => r'cd1cba64a2b39241b70fed6e4225d3c41cda1b6b';

abstract class _$CachedDashboard
    extends BuildlessAutoDisposeAsyncNotifier<DashboardConfig?> {
  late final String userId;

  FutureOr<DashboardConfig?> build(
    String userId,
  );
}

/// See also [CachedDashboard].
@ProviderFor(CachedDashboard)
const cachedDashboardProvider = CachedDashboardFamily();

/// See also [CachedDashboard].
class CachedDashboardFamily extends Family<AsyncValue<DashboardConfig?>> {
  /// See also [CachedDashboard].
  const CachedDashboardFamily();

  /// See also [CachedDashboard].
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

/// See also [CachedDashboard].
class CachedDashboardProvider extends AutoDisposeAsyncNotifierProviderImpl<
    CachedDashboard, DashboardConfig?> {
  /// See also [CachedDashboard].
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

String _$cachedWidgetDataHash() => r'b587ba81f4bdccd72ecb4b8f1fe6d8cbfb4e7633';

abstract class _$CachedWidgetData
    extends BuildlessAutoDisposeAsyncNotifier<Map<String, dynamic>> {
  late final String widgetId;
  late final String userId;

  FutureOr<Map<String, dynamic>> build(
    String widgetId,
    String userId,
  );
}

/// See also [CachedWidgetData].
@ProviderFor(CachedWidgetData)
const cachedWidgetDataProvider = CachedWidgetDataFamily();

/// See also [CachedWidgetData].
class CachedWidgetDataFamily extends Family<AsyncValue<Map<String, dynamic>>> {
  /// See also [CachedWidgetData].
  const CachedWidgetDataFamily();

  /// See also [CachedWidgetData].
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

/// See also [CachedWidgetData].
class CachedWidgetDataProvider extends AutoDisposeAsyncNotifierProviderImpl<
    CachedWidgetData, Map<String, dynamic>> {
  /// See also [CachedWidgetData].
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

String _$cacheManagerHash() => r'72945464e6efb8527db6d4faef19be6053e8b688';

/// See also [CacheManager].
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
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
