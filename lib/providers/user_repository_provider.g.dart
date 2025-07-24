// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userRepositoryHash() => r'fca2c5510d025b2df250cb61655f7a05280ff4b3';

/// Provider for UserRepository
///
/// Copied from [userRepository].
@ProviderFor(userRepository)
final userRepositoryProvider = AutoDisposeProvider<UserRepository>.internal(
  userRepository,
  name: r'userRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$userRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UserRepositoryRef = AutoDisposeProviderRef<UserRepository>;
String _$currentUserProfileHash() =>
    r'e0b004fd1dc502b3a46c24dd309f6cf23f1b6a2f';

/// Provider for watching the current user's profile
///
/// Copied from [currentUserProfile].
@ProviderFor(currentUserProfile)
final currentUserProfileProvider = AutoDisposeStreamProvider<AppUser?>.internal(
  currentUserProfile,
  name: r'currentUserProfileProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentUserProfileHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CurrentUserProfileRef = AutoDisposeStreamProviderRef<AppUser?>;
String _$usersByOrganizationHash() =>
    r'd9e87a382b194698e49c2ceb07f8964cb297650a';

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

/// Provider for getting users by organization
///
/// Copied from [usersByOrganization].
@ProviderFor(usersByOrganization)
const usersByOrganizationProvider = UsersByOrganizationFamily();

/// Provider for getting users by organization
///
/// Copied from [usersByOrganization].
class UsersByOrganizationFamily extends Family<AsyncValue<List<AppUser>>> {
  /// Provider for getting users by organization
  ///
  /// Copied from [usersByOrganization].
  const UsersByOrganizationFamily();

  /// Provider for getting users by organization
  ///
  /// Copied from [usersByOrganization].
  UsersByOrganizationProvider call(
    String organizationId,
  ) {
    return UsersByOrganizationProvider(
      organizationId,
    );
  }

  @override
  UsersByOrganizationProvider getProviderOverride(
    covariant UsersByOrganizationProvider provider,
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
  String? get name => r'usersByOrganizationProvider';
}

/// Provider for getting users by organization
///
/// Copied from [usersByOrganization].
class UsersByOrganizationProvider
    extends AutoDisposeFutureProvider<List<AppUser>> {
  /// Provider for getting users by organization
  ///
  /// Copied from [usersByOrganization].
  UsersByOrganizationProvider(
    String organizationId,
  ) : this._internal(
          (ref) => usersByOrganization(
            ref as UsersByOrganizationRef,
            organizationId,
          ),
          from: usersByOrganizationProvider,
          name: r'usersByOrganizationProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$usersByOrganizationHash,
          dependencies: UsersByOrganizationFamily._dependencies,
          allTransitiveDependencies:
              UsersByOrganizationFamily._allTransitiveDependencies,
          organizationId: organizationId,
        );

  UsersByOrganizationProvider._internal(
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
  Override overrideWith(
    FutureOr<List<AppUser>> Function(UsersByOrganizationRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UsersByOrganizationProvider._internal(
        (ref) => create(ref as UsersByOrganizationRef),
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
  AutoDisposeFutureProviderElement<List<AppUser>> createElement() {
    return _UsersByOrganizationProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UsersByOrganizationProvider &&
        other.organizationId == organizationId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, organizationId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin UsersByOrganizationRef on AutoDisposeFutureProviderRef<List<AppUser>> {
  /// The parameter `organizationId` of this provider.
  String get organizationId;
}

class _UsersByOrganizationProviderElement
    extends AutoDisposeFutureProviderElement<List<AppUser>>
    with UsersByOrganizationRef {
  _UsersByOrganizationProviderElement(super.provider);

  @override
  String get organizationId =>
      (origin as UsersByOrganizationProvider).organizationId;
}

String _$usersByStatusHash() => r'b014b8f09e64f352609d828e5b99b6574129eb81';

/// Provider for getting users by status
///
/// Copied from [usersByStatus].
@ProviderFor(usersByStatus)
const usersByStatusProvider = UsersByStatusFamily();

/// Provider for getting users by status
///
/// Copied from [usersByStatus].
class UsersByStatusFamily extends Family<AsyncValue<List<AppUser>>> {
  /// Provider for getting users by status
  ///
  /// Copied from [usersByStatus].
  const UsersByStatusFamily();

  /// Provider for getting users by status
  ///
  /// Copied from [usersByStatus].
  UsersByStatusProvider call(
    String status,
  ) {
    return UsersByStatusProvider(
      status,
    );
  }

  @override
  UsersByStatusProvider getProviderOverride(
    covariant UsersByStatusProvider provider,
  ) {
    return call(
      provider.status,
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
  String? get name => r'usersByStatusProvider';
}

/// Provider for getting users by status
///
/// Copied from [usersByStatus].
class UsersByStatusProvider extends AutoDisposeFutureProvider<List<AppUser>> {
  /// Provider for getting users by status
  ///
  /// Copied from [usersByStatus].
  UsersByStatusProvider(
    String status,
  ) : this._internal(
          (ref) => usersByStatus(
            ref as UsersByStatusRef,
            status,
          ),
          from: usersByStatusProvider,
          name: r'usersByStatusProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$usersByStatusHash,
          dependencies: UsersByStatusFamily._dependencies,
          allTransitiveDependencies:
              UsersByStatusFamily._allTransitiveDependencies,
          status: status,
        );

  UsersByStatusProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.status,
  }) : super.internal();

  final String status;

  @override
  Override overrideWith(
    FutureOr<List<AppUser>> Function(UsersByStatusRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UsersByStatusProvider._internal(
        (ref) => create(ref as UsersByStatusRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        status: status,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<AppUser>> createElement() {
    return _UsersByStatusProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UsersByStatusProvider && other.status == status;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, status.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin UsersByStatusRef on AutoDisposeFutureProviderRef<List<AppUser>> {
  /// The parameter `status` of this provider.
  String get status;
}

class _UsersByStatusProviderElement
    extends AutoDisposeFutureProviderElement<List<AppUser>>
    with UsersByStatusRef {
  _UsersByStatusProviderElement(super.provider);

  @override
  String get status => (origin as UsersByStatusProvider).status;
}

String _$pendingUsersHash() => r'133d698a4f9c43dcb58c3ad5d93c72fe3bfe8c8f';

/// Provider for getting pending users
///
/// Copied from [pendingUsers].
@ProviderFor(pendingUsers)
final pendingUsersProvider = AutoDisposeFutureProvider<List<AppUser>>.internal(
  pendingUsers,
  name: r'pendingUsersProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$pendingUsersHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef PendingUsersRef = AutoDisposeFutureProviderRef<List<AppUser>>;
String _$usersByRoleHash() => r'd217ef12854979161d1b3df494ca5dfcf7918936';

/// Provider for getting users by role
///
/// Copied from [usersByRole].
@ProviderFor(usersByRole)
const usersByRoleProvider = UsersByRoleFamily();

/// Provider for getting users by role
///
/// Copied from [usersByRole].
class UsersByRoleFamily extends Family<AsyncValue<List<AppUser>>> {
  /// Provider for getting users by role
  ///
  /// Copied from [usersByRole].
  const UsersByRoleFamily();

  /// Provider for getting users by role
  ///
  /// Copied from [usersByRole].
  UsersByRoleProvider call(
    DynamicRole role,
  ) {
    return UsersByRoleProvider(
      role,
    );
  }

  @override
  UsersByRoleProvider getProviderOverride(
    covariant UsersByRoleProvider provider,
  ) {
    return call(
      provider.role,
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
  String? get name => r'usersByRoleProvider';
}

/// Provider for getting users by role
///
/// Copied from [usersByRole].
class UsersByRoleProvider extends AutoDisposeFutureProvider<List<AppUser>> {
  /// Provider for getting users by role
  ///
  /// Copied from [usersByRole].
  UsersByRoleProvider(
    DynamicRole role,
  ) : this._internal(
          (ref) => usersByRole(
            ref as UsersByRoleRef,
            role,
          ),
          from: usersByRoleProvider,
          name: r'usersByRoleProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$usersByRoleHash,
          dependencies: UsersByRoleFamily._dependencies,
          allTransitiveDependencies:
              UsersByRoleFamily._allTransitiveDependencies,
          role: role,
        );

  UsersByRoleProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.role,
  }) : super.internal();

  final DynamicRole role;

  @override
  Override overrideWith(
    FutureOr<List<AppUser>> Function(UsersByRoleRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UsersByRoleProvider._internal(
        (ref) => create(ref as UsersByRoleRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        role: role,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<AppUser>> createElement() {
    return _UsersByRoleProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UsersByRoleProvider && other.role == role;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, role.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin UsersByRoleRef on AutoDisposeFutureProviderRef<List<AppUser>> {
  /// The parameter `role` of this provider.
  DynamicRole get role;
}

class _UsersByRoleProviderElement
    extends AutoDisposeFutureProviderElement<List<AppUser>>
    with UsersByRoleRef {
  _UsersByRoleProviderElement(super.provider);

  @override
  DynamicRole get role => (origin as UsersByRoleProvider).role;
}

String _$userApprovalNotifierHash() =>
    r'2004be7e4ebfe8d21f22dd3b1ca36471ed8f221f';

/// Provider for user approval operations
///
/// Copied from [UserApprovalNotifier].
@ProviderFor(UserApprovalNotifier)
final userApprovalNotifierProvider = AutoDisposeNotifierProvider<
    UserApprovalNotifier, AsyncValue<void>>.internal(
  UserApprovalNotifier.new,
  name: r'userApprovalNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$userApprovalNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$UserApprovalNotifier = AutoDisposeNotifier<AsyncValue<void>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
