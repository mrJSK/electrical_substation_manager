// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userRepositoryHash() => r'fca2c5510d025b2df250cb61655f7a05280ff4b3';

/// See also [userRepository].
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
String _$firebaseAuthStreamHash() =>
    r'3402a8644536ba266394532a28fe6303bbd63063';

/// See also [firebaseAuthStream].
@ProviderFor(firebaseAuthStream)
final firebaseAuthStreamProvider =
    AutoDisposeStreamProvider<firebase.User?>.internal(
  firebaseAuthStream,
  name: r'firebaseAuthStreamProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$firebaseAuthStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FirebaseAuthStreamRef = AutoDisposeStreamProviderRef<firebase.User?>;
String _$currentFirebaseUserHash() =>
    r'07ccd3fdf2e8f7262f921ab2f3396b90dadb8bdf';

/// See also [currentFirebaseUser].
@ProviderFor(currentFirebaseUser)
final currentFirebaseUserProvider =
    AutoDisposeProvider<firebase.User?>.internal(
  currentFirebaseUser,
  name: r'currentFirebaseUserProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentFirebaseUserHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CurrentFirebaseUserRef = AutoDisposeProviderRef<firebase.User?>;
String _$currentUserHash() => r'f9d854ca7a40ae08a4eecea34706f4bffe161971';

/// See also [currentUser].
@ProviderFor(currentUser)
final currentUserProvider = AutoDisposeProvider<AppUser?>.internal(
  currentUser,
  name: r'currentUserProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$currentUserHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CurrentUserRef = AutoDisposeProviderRef<AppUser?>;
String _$isAuthenticatedHash() => r'e9669f2e11c7c343c891eb928c5d04fd6136d22f';

/// See also [isAuthenticated].
@ProviderFor(isAuthenticated)
final isAuthenticatedProvider = AutoDisposeProvider<bool>.internal(
  isAuthenticated,
  name: r'isAuthenticatedProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$isAuthenticatedHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef IsAuthenticatedRef = AutoDisposeProviderRef<bool>;
String _$hasPermissionHash() => r'49a5f8917ca349c226e02d809fe2f9bc5156bbf7';

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

/// See also [hasPermission].
@ProviderFor(hasPermission)
const hasPermissionProvider = HasPermissionFamily();

/// See also [hasPermission].
class HasPermissionFamily extends Family<bool> {
  /// See also [hasPermission].
  const HasPermissionFamily();

  /// See also [hasPermission].
  HasPermissionProvider call(
    String permission,
  ) {
    return HasPermissionProvider(
      permission,
    );
  }

  @override
  HasPermissionProvider getProviderOverride(
    covariant HasPermissionProvider provider,
  ) {
    return call(
      provider.permission,
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
  String? get name => r'hasPermissionProvider';
}

/// See also [hasPermission].
class HasPermissionProvider extends AutoDisposeProvider<bool> {
  /// See also [hasPermission].
  HasPermissionProvider(
    String permission,
  ) : this._internal(
          (ref) => hasPermission(
            ref as HasPermissionRef,
            permission,
          ),
          from: hasPermissionProvider,
          name: r'hasPermissionProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$hasPermissionHash,
          dependencies: HasPermissionFamily._dependencies,
          allTransitiveDependencies:
              HasPermissionFamily._allTransitiveDependencies,
          permission: permission,
        );

  HasPermissionProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.permission,
  }) : super.internal();

  final String permission;

  @override
  Override overrideWith(
    bool Function(HasPermissionRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: HasPermissionProvider._internal(
        (ref) => create(ref as HasPermissionRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        permission: permission,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<bool> createElement() {
    return _HasPermissionProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is HasPermissionProvider && other.permission == permission;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, permission.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin HasPermissionRef on AutoDisposeProviderRef<bool> {
  /// The parameter `permission` of this provider.
  String get permission;
}

class _HasPermissionProviderElement extends AutoDisposeProviderElement<bool>
    with HasPermissionRef {
  _HasPermissionProviderElement(super.provider);

  @override
  String get permission => (origin as HasPermissionProvider).permission;
}

String _$accessibleScreensHash() => r'55fb829b8d2ddcf1567f12d6470f83979a115710';

/// See also [accessibleScreens].
@ProviderFor(accessibleScreens)
final accessibleScreensProvider = AutoDisposeProvider<List<String>>.internal(
  accessibleScreens,
  name: r'accessibleScreensProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$accessibleScreensHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AccessibleScreensRef = AutoDisposeProviderRef<List<String>>;
String _$canAccessHierarchyHash() =>
    r'3555242d49f2a421d7928456e87287b5c70bfbc5';

/// See also [canAccessHierarchy].
@ProviderFor(canAccessHierarchy)
const canAccessHierarchyProvider = CanAccessHierarchyFamily();

/// See also [canAccessHierarchy].
class CanAccessHierarchyFamily extends Family<bool> {
  /// See also [canAccessHierarchy].
  const CanAccessHierarchyFamily();

  /// See also [canAccessHierarchy].
  CanAccessHierarchyProvider call(
    String hierarchyId,
  ) {
    return CanAccessHierarchyProvider(
      hierarchyId,
    );
  }

  @override
  CanAccessHierarchyProvider getProviderOverride(
    covariant CanAccessHierarchyProvider provider,
  ) {
    return call(
      provider.hierarchyId,
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
  String? get name => r'canAccessHierarchyProvider';
}

/// See also [canAccessHierarchy].
class CanAccessHierarchyProvider extends AutoDisposeProvider<bool> {
  /// See also [canAccessHierarchy].
  CanAccessHierarchyProvider(
    String hierarchyId,
  ) : this._internal(
          (ref) => canAccessHierarchy(
            ref as CanAccessHierarchyRef,
            hierarchyId,
          ),
          from: canAccessHierarchyProvider,
          name: r'canAccessHierarchyProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$canAccessHierarchyHash,
          dependencies: CanAccessHierarchyFamily._dependencies,
          allTransitiveDependencies:
              CanAccessHierarchyFamily._allTransitiveDependencies,
          hierarchyId: hierarchyId,
        );

  CanAccessHierarchyProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.hierarchyId,
  }) : super.internal();

  final String hierarchyId;

  @override
  Override overrideWith(
    bool Function(CanAccessHierarchyRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CanAccessHierarchyProvider._internal(
        (ref) => create(ref as CanAccessHierarchyRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        hierarchyId: hierarchyId,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<bool> createElement() {
    return _CanAccessHierarchyProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CanAccessHierarchyProvider &&
        other.hierarchyId == hierarchyId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, hierarchyId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin CanAccessHierarchyRef on AutoDisposeProviderRef<bool> {
  /// The parameter `hierarchyId` of this provider.
  String get hierarchyId;
}

class _CanAccessHierarchyProviderElement
    extends AutoDisposeProviderElement<bool> with CanAccessHierarchyRef {
  _CanAccessHierarchyProviderElement(super.provider);

  @override
  String get hierarchyId => (origin as CanAccessHierarchyProvider).hierarchyId;
}

String _$userRoleHash() => r'1dffcb16d883c4a80a28d92e5a31020fcf6bd103';

/// See also [userRole].
@ProviderFor(userRole)
final userRoleProvider = AutoDisposeProvider<UserRole?>.internal(
  userRole,
  name: r'userRoleProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$userRoleHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UserRoleRef = AutoDisposeProviderRef<UserRole?>;
String _$hasRoleHash() => r'405cb11be59828516214806f72e75ba65098ddcc';

/// See also [hasRole].
@ProviderFor(hasRole)
const hasRoleProvider = HasRoleFamily();

/// See also [hasRole].
class HasRoleFamily extends Family<bool> {
  /// See also [hasRole].
  const HasRoleFamily();

  /// See also [hasRole].
  HasRoleProvider call(
    UserRole role,
  ) {
    return HasRoleProvider(
      role,
    );
  }

  @override
  HasRoleProvider getProviderOverride(
    covariant HasRoleProvider provider,
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
  String? get name => r'hasRoleProvider';
}

/// See also [hasRole].
class HasRoleProvider extends AutoDisposeProvider<bool> {
  /// See also [hasRole].
  HasRoleProvider(
    UserRole role,
  ) : this._internal(
          (ref) => hasRole(
            ref as HasRoleRef,
            role,
          ),
          from: hasRoleProvider,
          name: r'hasRoleProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$hasRoleHash,
          dependencies: HasRoleFamily._dependencies,
          allTransitiveDependencies: HasRoleFamily._allTransitiveDependencies,
          role: role,
        );

  HasRoleProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.role,
  }) : super.internal();

  final UserRole role;

  @override
  Override overrideWith(
    bool Function(HasRoleRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: HasRoleProvider._internal(
        (ref) => create(ref as HasRoleRef),
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
  AutoDisposeProviderElement<bool> createElement() {
    return _HasRoleProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is HasRoleProvider && other.role == role;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, role.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin HasRoleRef on AutoDisposeProviderRef<bool> {
  /// The parameter `role` of this provider.
  UserRole get role;
}

class _HasRoleProviderElement extends AutoDisposeProviderElement<bool>
    with HasRoleRef {
  _HasRoleProviderElement(super.provider);

  @override
  UserRole get role => (origin as HasRoleProvider).role;
}

String _$isAdminHash() => r'4b6f23dbdde407ce39c085c5565826baff9e6d47';

/// See also [isAdmin].
@ProviderFor(isAdmin)
final isAdminProvider = AutoDisposeProvider<bool>.internal(
  isAdmin,
  name: r'isAdminProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$isAdminHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef IsAdminRef = AutoDisposeProviderRef<bool>;
String _$isAuthLoadingHash() => r'e6512337def01934537887df175ccbb4baced9cb';

/// See also [isAuthLoading].
@ProviderFor(isAuthLoading)
final isAuthLoadingProvider = AutoDisposeProvider<bool>.internal(
  isAuthLoading,
  name: r'isAuthLoadingProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$isAuthLoadingHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef IsAuthLoadingRef = AutoDisposeProviderRef<bool>;
String _$authErrorHash() => r'9828c0f7f457551853657c01110eb896f8b2e896';

/// See also [authError].
@ProviderFor(authError)
final authErrorProvider = AutoDisposeProvider<String?>.internal(
  authError,
  name: r'authErrorProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$authErrorHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AuthErrorRef = AutoDisposeProviderRef<String?>;
String _$authStateHash() => r'878d745cae99a0fd12c7b5d76ee7b1439b9ec9f5';

/// See also [authState].
@ProviderFor(authState)
final authStateProvider = AutoDisposeProvider<AuthState>.internal(
  authState,
  name: r'authStateProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$authStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AuthStateRef = AutoDisposeProviderRef<AuthState>;
String _$connectionStatusHash() => r'105134c8caa4471a94475f1d9da5b38b079fa274';

/// See also [ConnectionStatus].
@ProviderFor(ConnectionStatus)
final connectionStatusProvider =
    AutoDisposeNotifierProvider<ConnectionStatus, bool>.internal(
  ConnectionStatus.new,
  name: r'connectionStatusProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$connectionStatusHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ConnectionStatus = AutoDisposeNotifier<bool>;
String _$authStateNotifierHash() => r'48f66fb6cd218c359507cc41f7259b407e6cbc5b';

/// See also [AuthStateNotifier].
@ProviderFor(AuthStateNotifier)
final authStateNotifierProvider =
    AutoDisposeNotifierProvider<AuthStateNotifier, AuthState>.internal(
  AuthStateNotifier.new,
  name: r'authStateNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$authStateNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AuthStateNotifier = AutoDisposeNotifier<AuthState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
