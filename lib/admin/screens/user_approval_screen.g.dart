// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_approval_screen.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$filteredApprovalRequestsHash() =>
    r'dda8dde960764eb91b2b4b0c3abc8783114c5a28';

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

/// See also [filteredApprovalRequests].
@ProviderFor(filteredApprovalRequests)
const filteredApprovalRequestsProvider = FilteredApprovalRequestsFamily();

/// See also [filteredApprovalRequests].
class FilteredApprovalRequestsFamily
    extends Family<AsyncValue<List<Map<String, dynamic>>>> {
  /// See also [filteredApprovalRequests].
  const FilteredApprovalRequestsFamily();

  /// See also [filteredApprovalRequests].
  FilteredApprovalRequestsProvider call(
    String status,
  ) {
    return FilteredApprovalRequestsProvider(
      status,
    );
  }

  @override
  FilteredApprovalRequestsProvider getProviderOverride(
    covariant FilteredApprovalRequestsProvider provider,
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
  String? get name => r'filteredApprovalRequestsProvider';
}

/// See also [filteredApprovalRequests].
class FilteredApprovalRequestsProvider
    extends AutoDisposeStreamProvider<List<Map<String, dynamic>>> {
  /// See also [filteredApprovalRequests].
  FilteredApprovalRequestsProvider(
    String status,
  ) : this._internal(
          (ref) => filteredApprovalRequests(
            ref as FilteredApprovalRequestsRef,
            status,
          ),
          from: filteredApprovalRequestsProvider,
          name: r'filteredApprovalRequestsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$filteredApprovalRequestsHash,
          dependencies: FilteredApprovalRequestsFamily._dependencies,
          allTransitiveDependencies:
              FilteredApprovalRequestsFamily._allTransitiveDependencies,
          status: status,
        );

  FilteredApprovalRequestsProvider._internal(
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
    Stream<List<Map<String, dynamic>>> Function(
            FilteredApprovalRequestsRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FilteredApprovalRequestsProvider._internal(
        (ref) => create(ref as FilteredApprovalRequestsRef),
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
  AutoDisposeStreamProviderElement<List<Map<String, dynamic>>> createElement() {
    return _FilteredApprovalRequestsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FilteredApprovalRequestsProvider && other.status == status;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, status.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin FilteredApprovalRequestsRef
    on AutoDisposeStreamProviderRef<List<Map<String, dynamic>>> {
  /// The parameter `status` of this provider.
  String get status;
}

class _FilteredApprovalRequestsProviderElement
    extends AutoDisposeStreamProviderElement<List<Map<String, dynamic>>>
    with FilteredApprovalRequestsRef {
  _FilteredApprovalRequestsProviderElement(super.provider);

  @override
  String get status => (origin as FilteredApprovalRequestsProvider).status;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
