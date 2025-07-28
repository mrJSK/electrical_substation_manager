// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enhanced_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userPermissionsHash() => r'85afc4245fd10454839919af8f1db9cf01503ae4';

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

/// Enhanced user permissions with intelligent caching and connectivity awareness
///
/// Copied from [UserPermissions].
@ProviderFor(UserPermissions)
const userPermissionsProvider = UserPermissionsFamily();

/// Enhanced user permissions with intelligent caching and connectivity awareness
///
/// Copied from [UserPermissions].
class UserPermissionsFamily extends Family<AsyncValue<List<String>>> {
  /// Enhanced user permissions with intelligent caching and connectivity awareness
  ///
  /// Copied from [UserPermissions].
  const UserPermissionsFamily();

  /// Enhanced user permissions with intelligent caching and connectivity awareness
  ///
  /// Copied from [UserPermissions].
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

/// Enhanced user permissions with intelligent caching and connectivity awareness
///
/// Copied from [UserPermissions].
class UserPermissionsProvider extends AutoDisposeAsyncNotifierProviderImpl<
    UserPermissions, List<String>> {
  /// Enhanced user permissions with intelligent caching and connectivity awareness
  ///
  /// Copied from [UserPermissions].
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

String _$userProfileDataHash() => r'4438824addcef26b315dd059080b8766c7341e68';

abstract class _$UserProfileData
    extends BuildlessAutoDisposeAsyncNotifier<UserProfile?> {
  late final String userId;

  FutureOr<UserProfile?> build(
    String userId,
  );
}

/// Enhanced user profile with organization context
///
/// Copied from [UserProfileData].
@ProviderFor(UserProfileData)
const userProfileDataProvider = UserProfileDataFamily();

/// Enhanced user profile with organization context
///
/// Copied from [UserProfileData].
class UserProfileDataFamily extends Family<AsyncValue<UserProfile?>> {
  /// Enhanced user profile with organization context
  ///
  /// Copied from [UserProfileData].
  const UserProfileDataFamily();

  /// Enhanced user profile with organization context
  ///
  /// Copied from [UserProfileData].
  UserProfileDataProvider call(
    String userId,
  ) {
    return UserProfileDataProvider(
      userId,
    );
  }

  @override
  UserProfileDataProvider getProviderOverride(
    covariant UserProfileDataProvider provider,
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
  String? get name => r'userProfileDataProvider';
}

/// Enhanced user profile with organization context
///
/// Copied from [UserProfileData].
class UserProfileDataProvider extends AutoDisposeAsyncNotifierProviderImpl<
    UserProfileData, UserProfile?> {
  /// Enhanced user profile with organization context
  ///
  /// Copied from [UserProfileData].
  UserProfileDataProvider(
    String userId,
  ) : this._internal(
          () => UserProfileData()..userId = userId,
          from: userProfileDataProvider,
          name: r'userProfileDataProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$userProfileDataHash,
          dependencies: UserProfileDataFamily._dependencies,
          allTransitiveDependencies:
              UserProfileDataFamily._allTransitiveDependencies,
          userId: userId,
        );

  UserProfileDataProvider._internal(
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
  FutureOr<UserProfile?> runNotifierBuild(
    covariant UserProfileData notifier,
  ) {
    return notifier.build(
      userId,
    );
  }

  @override
  Override overrideWith(UserProfileData Function() create) {
    return ProviderOverride(
      origin: this,
      override: UserProfileDataProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<UserProfileData, UserProfile?>
      createElement() {
    return _UserProfileDataProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UserProfileDataProvider && other.userId == userId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin UserProfileDataRef on AutoDisposeAsyncNotifierProviderRef<UserProfile?> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _UserProfileDataProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<UserProfileData,
        UserProfile?> with UserProfileDataRef {
  _UserProfileDataProviderElement(super.provider);

  @override
  String get userId => (origin as UserProfileDataProvider).userId;
}

String _$dashboardDataHash() => r'12a1653206972ded69ed47e09dd2cdd3ee6f997f';

abstract class _$DashboardData
    extends BuildlessAutoDisposeAsyncNotifier<DashboardConfig?> {
  late final String userId;

  FutureOr<DashboardConfig?> build(
    String userId,
  );
}

/// Enhanced dashboard data with intelligent dependency management
///
/// Copied from [DashboardData].
@ProviderFor(DashboardData)
const dashboardDataProvider = DashboardDataFamily();

/// Enhanced dashboard data with intelligent dependency management
///
/// Copied from [DashboardData].
class DashboardDataFamily extends Family<AsyncValue<DashboardConfig?>> {
  /// Enhanced dashboard data with intelligent dependency management
  ///
  /// Copied from [DashboardData].
  const DashboardDataFamily();

  /// Enhanced dashboard data with intelligent dependency management
  ///
  /// Copied from [DashboardData].
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

/// Enhanced dashboard data with intelligent dependency management
///
/// Copied from [DashboardData].
class DashboardDataProvider extends AutoDisposeAsyncNotifierProviderImpl<
    DashboardData, DashboardConfig?> {
  /// Enhanced dashboard data with intelligent dependency management
  ///
  /// Copied from [DashboardData].
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

String _$widgetDataCacheHash() => r'1d50a67d4377b99ce97102bc6fdbfeab19231d8b';

abstract class _$WidgetDataCache
    extends BuildlessAutoDisposeAsyncNotifier<Map<String, dynamic>> {
  late final String widgetId;
  late final String userId;

  FutureOr<Map<String, dynamic>> build(
    String widgetId,
    String userId,
  );
}

/// Enhanced widget data cache with real-time updates
///
/// Copied from [WidgetDataCache].
@ProviderFor(WidgetDataCache)
const widgetDataCacheProvider = WidgetDataCacheFamily();

/// Enhanced widget data cache with real-time updates
///
/// Copied from [WidgetDataCache].
class WidgetDataCacheFamily extends Family<AsyncValue<Map<String, dynamic>>> {
  /// Enhanced widget data cache with real-time updates
  ///
  /// Copied from [WidgetDataCache].
  const WidgetDataCacheFamily();

  /// Enhanced widget data cache with real-time updates
  ///
  /// Copied from [WidgetDataCache].
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

/// Enhanced widget data cache with real-time updates
///
/// Copied from [WidgetDataCache].
class WidgetDataCacheProvider extends AutoDisposeAsyncNotifierProviderImpl<
    WidgetDataCache, Map<String, dynamic>> {
  /// Enhanced widget data cache with real-time updates
  ///
  /// Copied from [WidgetDataCache].
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

String _$dynamicModelsDataHash() => r'25dc4547c6bb362dda80f6d00ceb947f3d2e4394';

abstract class _$DynamicModelsData
    extends BuildlessAutoDisposeAsyncNotifier<List<DynamicModel>> {
  late final String? organizationId;

  FutureOr<List<DynamicModel>> build(
    String? organizationId,
  );
}

/// Enhanced dynamic models provider with organization context
///
/// Copied from [DynamicModelsData].
@ProviderFor(DynamicModelsData)
const dynamicModelsDataProvider = DynamicModelsDataFamily();

/// Enhanced dynamic models provider with organization context
///
/// Copied from [DynamicModelsData].
class DynamicModelsDataFamily extends Family<AsyncValue<List<DynamicModel>>> {
  /// Enhanced dynamic models provider with organization context
  ///
  /// Copied from [DynamicModelsData].
  const DynamicModelsDataFamily();

  /// Enhanced dynamic models provider with organization context
  ///
  /// Copied from [DynamicModelsData].
  DynamicModelsDataProvider call(
    String? organizationId,
  ) {
    return DynamicModelsDataProvider(
      organizationId,
    );
  }

  @override
  DynamicModelsDataProvider getProviderOverride(
    covariant DynamicModelsDataProvider provider,
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
  String? get name => r'dynamicModelsDataProvider';
}

/// Enhanced dynamic models provider with organization context
///
/// Copied from [DynamicModelsData].
class DynamicModelsDataProvider extends AutoDisposeAsyncNotifierProviderImpl<
    DynamicModelsData, List<DynamicModel>> {
  /// Enhanced dynamic models provider with organization context
  ///
  /// Copied from [DynamicModelsData].
  DynamicModelsDataProvider(
    String? organizationId,
  ) : this._internal(
          () => DynamicModelsData()..organizationId = organizationId,
          from: dynamicModelsDataProvider,
          name: r'dynamicModelsDataProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$dynamicModelsDataHash,
          dependencies: DynamicModelsDataFamily._dependencies,
          allTransitiveDependencies:
              DynamicModelsDataFamily._allTransitiveDependencies,
          organizationId: organizationId,
        );

  DynamicModelsDataProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.organizationId,
  }) : super.internal();

  final String? organizationId;

  @override
  FutureOr<List<DynamicModel>> runNotifierBuild(
    covariant DynamicModelsData notifier,
  ) {
    return notifier.build(
      organizationId,
    );
  }

  @override
  Override overrideWith(DynamicModelsData Function() create) {
    return ProviderOverride(
      origin: this,
      override: DynamicModelsDataProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<DynamicModelsData, List<DynamicModel>>
      createElement() {
    return _DynamicModelsDataProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DynamicModelsDataProvider &&
        other.organizationId == organizationId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, organizationId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin DynamicModelsDataRef
    on AutoDisposeAsyncNotifierProviderRef<List<DynamicModel>> {
  /// The parameter `organizationId` of this provider.
  String? get organizationId;
}

class _DynamicModelsDataProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<DynamicModelsData,
        List<DynamicModel>> with DynamicModelsDataRef {
  _DynamicModelsDataProviderElement(super.provider);

  @override
  String? get organizationId =>
      (origin as DynamicModelsDataProvider).organizationId;
}

String _$dynamicModelByNameHash() =>
    r'8b39a04c0d722caa38e7aa9cbb0033d8da368c9d';

abstract class _$DynamicModelByName
    extends BuildlessAutoDisposeAsyncNotifier<DynamicModel?> {
  late final String modelName;
  late final String? organizationId;

  FutureOr<DynamicModel?> build(
    String modelName,
    String? organizationId,
  );
}

/// Specific model provider with validation
///
/// Copied from [DynamicModelByName].
@ProviderFor(DynamicModelByName)
const dynamicModelByNameProvider = DynamicModelByNameFamily();

/// Specific model provider with validation
///
/// Copied from [DynamicModelByName].
class DynamicModelByNameFamily extends Family<AsyncValue<DynamicModel?>> {
  /// Specific model provider with validation
  ///
  /// Copied from [DynamicModelByName].
  const DynamicModelByNameFamily();

  /// Specific model provider with validation
  ///
  /// Copied from [DynamicModelByName].
  DynamicModelByNameProvider call(
    String modelName,
    String? organizationId,
  ) {
    return DynamicModelByNameProvider(
      modelName,
      organizationId,
    );
  }

  @override
  DynamicModelByNameProvider getProviderOverride(
    covariant DynamicModelByNameProvider provider,
  ) {
    return call(
      provider.modelName,
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
  String? get name => r'dynamicModelByNameProvider';
}

/// Specific model provider with validation
///
/// Copied from [DynamicModelByName].
class DynamicModelByNameProvider extends AutoDisposeAsyncNotifierProviderImpl<
    DynamicModelByName, DynamicModel?> {
  /// Specific model provider with validation
  ///
  /// Copied from [DynamicModelByName].
  DynamicModelByNameProvider(
    String modelName,
    String? organizationId,
  ) : this._internal(
          () => DynamicModelByName()
            ..modelName = modelName
            ..organizationId = organizationId,
          from: dynamicModelByNameProvider,
          name: r'dynamicModelByNameProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$dynamicModelByNameHash,
          dependencies: DynamicModelByNameFamily._dependencies,
          allTransitiveDependencies:
              DynamicModelByNameFamily._allTransitiveDependencies,
          modelName: modelName,
          organizationId: organizationId,
        );

  DynamicModelByNameProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.modelName,
    required this.organizationId,
  }) : super.internal();

  final String modelName;
  final String? organizationId;

  @override
  FutureOr<DynamicModel?> runNotifierBuild(
    covariant DynamicModelByName notifier,
  ) {
    return notifier.build(
      modelName,
      organizationId,
    );
  }

  @override
  Override overrideWith(DynamicModelByName Function() create) {
    return ProviderOverride(
      origin: this,
      override: DynamicModelByNameProvider._internal(
        () => create()
          ..modelName = modelName
          ..organizationId = organizationId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        modelName: modelName,
        organizationId: organizationId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<DynamicModelByName, DynamicModel?>
      createElement() {
    return _DynamicModelByNameProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DynamicModelByNameProvider &&
        other.modelName == modelName &&
        other.organizationId == organizationId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, modelName.hashCode);
    hash = _SystemHash.combine(hash, organizationId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin DynamicModelByNameRef
    on AutoDisposeAsyncNotifierProviderRef<DynamicModel?> {
  /// The parameter `modelName` of this provider.
  String get modelName;

  /// The parameter `organizationId` of this provider.
  String? get organizationId;
}

class _DynamicModelByNameProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<DynamicModelByName,
        DynamicModel?> with DynamicModelByNameRef {
  _DynamicModelByNameProviderElement(super.provider);

  @override
  String get modelName => (origin as DynamicModelByNameProvider).modelName;
  @override
  String? get organizationId =>
      (origin as DynamicModelByNameProvider).organizationId;
}

String _$systemHealthHash() => r'300e82adfa6dd0846b0f6960fed802b15856d07a';

/// System health monitoring provider
///
/// Copied from [SystemHealth].
@ProviderFor(SystemHealth)
final systemHealthProvider = AutoDisposeAsyncNotifierProvider<SystemHealth,
    Map<String, dynamic>>.internal(
  SystemHealth.new,
  name: r'systemHealthProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$systemHealthHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SystemHealth = AutoDisposeAsyncNotifier<Map<String, dynamic>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
