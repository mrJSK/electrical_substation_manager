// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enhanced_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userPermissionsHash() => r'1a9267c301cf49fd53e5292a2c80fd06919a1d19';

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

abstract class _$UserPermissions
    extends BuildlessAutoDisposeAsyncNotifier<List<String>> {
  late final String userId;

  FutureOr<List<String>> build(
    String userId,
  );
}

/// See also [UserPermissions].
@ProviderFor(UserPermissions)
const userPermissionsProvider = UserPermissionsFamily();

/// See also [UserPermissions].
class UserPermissionsFamily extends Family<AsyncValue<List<String>>> {
  /// See also [UserPermissions].
  const UserPermissionsFamily();

  /// See also [UserPermissions].
  UserPermissionsProvider call(
    String userId,
  ) {
    return UserPermissionsProvider(
      userId,
    );
  }

  @override
  UserPermissionsProvider getProviderOverride(
    covariant UserPermissionsProvider provider,
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
  String? get name => r'userPermissionsProvider';
}

/// See also [UserPermissions].
class UserPermissionsProvider extends AutoDisposeAsyncNotifierProviderImpl<
    UserPermissions, List<String>> {
  /// See also [UserPermissions].
  UserPermissionsProvider(
    String userId,
  ) : this._internal(
          () => UserPermissions()..userId = userId,
          from: userPermissionsProvider,
          name: r'userPermissionsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$userPermissionsHash,
          dependencies: UserPermissionsFamily._dependencies,
          allTransitiveDependencies:
              UserPermissionsFamily._allTransitiveDependencies,
          userId: userId,
        );

  UserPermissionsProvider._internal(
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
    covariant UserPermissions notifier,
  ) {
    return notifier.build(
      userId,
    );
  }

  @override
  Override overrideWith(UserPermissions Function() create) {
    return ProviderOverride(
      origin: this,
      override: UserPermissionsProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<UserPermissions, List<String>>
      createElement() {
    return _UserPermissionsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UserPermissionsProvider && other.userId == userId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin UserPermissionsRef on AutoDisposeAsyncNotifierProviderRef<List<String>> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _UserPermissionsProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<UserPermissions,
        List<String>> with UserPermissionsRef {
  _UserPermissionsProviderElement(super.provider);

  @override
  String get userId => (origin as UserPermissionsProvider).userId;
}

String _$dashboardDataHash() => r'501af5d4f2526e76636834d6375f4b44a62927fa';

abstract class _$DashboardData
    extends BuildlessAutoDisposeAsyncNotifier<DashboardConfig?> {
  late final String userId;

  FutureOr<DashboardConfig?> build(
    String userId,
  );
}

/// See also [DashboardData].
@ProviderFor(DashboardData)
const dashboardDataProvider = DashboardDataFamily();

/// See also [DashboardData].
class DashboardDataFamily extends Family<AsyncValue<DashboardConfig?>> {
  /// See also [DashboardData].
  const DashboardDataFamily();

  /// See also [DashboardData].
  DashboardDataProvider call(
    String userId,
  ) {
    return DashboardDataProvider(
      userId,
    );
  }

  @override
  DashboardDataProvider getProviderOverride(
    covariant DashboardDataProvider provider,
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
  String? get name => r'dashboardDataProvider';
}

/// See also [DashboardData].
class DashboardDataProvider extends AutoDisposeAsyncNotifierProviderImpl<
    DashboardData, DashboardConfig?> {
  /// See also [DashboardData].
  DashboardDataProvider(
    String userId,
  ) : this._internal(
          () => DashboardData()..userId = userId,
          from: dashboardDataProvider,
          name: r'dashboardDataProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$dashboardDataHash,
          dependencies: DashboardDataFamily._dependencies,
          allTransitiveDependencies:
              DashboardDataFamily._allTransitiveDependencies,
          userId: userId,
        );

  DashboardDataProvider._internal(
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
    covariant DashboardData notifier,
  ) {
    return notifier.build(
      userId,
    );
  }

  @override
  Override overrideWith(DashboardData Function() create) {
    return ProviderOverride(
      origin: this,
      override: DashboardDataProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<DashboardData, DashboardConfig?>
      createElement() {
    return _DashboardDataProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DashboardDataProvider && other.userId == userId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin DashboardDataRef
    on AutoDisposeAsyncNotifierProviderRef<DashboardConfig?> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _DashboardDataProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<DashboardData,
        DashboardConfig?> with DashboardDataRef {
  _DashboardDataProviderElement(super.provider);

  @override
  String get userId => (origin as DashboardDataProvider).userId;
}

String _$widgetDataCacheHash() => r'43a43f563120f515a19e743391ba10ed5016168f';

abstract class _$WidgetDataCache
    extends BuildlessAutoDisposeAsyncNotifier<Map<String, dynamic>> {
  late final String widgetId;
  late final String userId;

  FutureOr<Map<String, dynamic>> build(
    String widgetId,
    String userId,
  );
}

/// See also [WidgetDataCache].
@ProviderFor(WidgetDataCache)
const widgetDataCacheProvider = WidgetDataCacheFamily();

/// See also [WidgetDataCache].
class WidgetDataCacheFamily extends Family<AsyncValue<Map<String, dynamic>>> {
  /// See also [WidgetDataCache].
  const WidgetDataCacheFamily();

  /// See also [WidgetDataCache].
  WidgetDataCacheProvider call(
    String widgetId,
    String userId,
  ) {
    return WidgetDataCacheProvider(
      widgetId,
      userId,
    );
  }

  @override
  WidgetDataCacheProvider getProviderOverride(
    covariant WidgetDataCacheProvider provider,
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
  String? get name => r'widgetDataCacheProvider';
}

/// See also [WidgetDataCache].
class WidgetDataCacheProvider extends AutoDisposeAsyncNotifierProviderImpl<
    WidgetDataCache, Map<String, dynamic>> {
  /// See also [WidgetDataCache].
  WidgetDataCacheProvider(
    String widgetId,
    String userId,
  ) : this._internal(
          () => WidgetDataCache()
            ..widgetId = widgetId
            ..userId = userId,
          from: widgetDataCacheProvider,
          name: r'widgetDataCacheProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$widgetDataCacheHash,
          dependencies: WidgetDataCacheFamily._dependencies,
          allTransitiveDependencies:
              WidgetDataCacheFamily._allTransitiveDependencies,
          widgetId: widgetId,
          userId: userId,
        );

  WidgetDataCacheProvider._internal(
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
    covariant WidgetDataCache notifier,
  ) {
    return notifier.build(
      widgetId,
      userId,
    );
  }

  @override
  Override overrideWith(WidgetDataCache Function() create) {
    return ProviderOverride(
      origin: this,
      override: WidgetDataCacheProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<WidgetDataCache, Map<String, dynamic>>
      createElement() {
    return _WidgetDataCacheProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is WidgetDataCacheProvider &&
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

mixin WidgetDataCacheRef
    on AutoDisposeAsyncNotifierProviderRef<Map<String, dynamic>> {
  /// The parameter `widgetId` of this provider.
  String get widgetId;

  /// The parameter `userId` of this provider.
  String get userId;
}

class _WidgetDataCacheProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<WidgetDataCache,
        Map<String, dynamic>> with WidgetDataCacheRef {
  _WidgetDataCacheProviderElement(super.provider);

  @override
  String get widgetId => (origin as WidgetDataCacheProvider).widgetId;
  @override
  String get userId => (origin as WidgetDataCacheProvider).userId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
