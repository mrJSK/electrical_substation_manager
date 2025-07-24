// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'organizations_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$organizationsHash() => r'2b5f8937d4661b3a2ec75ce532cdb355e018dced';

/// See also [organizations].
@ProviderFor(organizations)
final organizationsProvider =
    AutoDisposeFutureProvider<List<Map<String, dynamic>>>.internal(
  organizations,
  name: r'organizationsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$organizationsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef OrganizationsRef
    = AutoDisposeFutureProviderRef<List<Map<String, dynamic>>>;
String _$organizationsNotifierHash() =>
    r'be3304ccae92e8327a2555b058fefc64cb7282e7';

/// See also [OrganizationsNotifier].
@ProviderFor(OrganizationsNotifier)
final organizationsNotifierProvider = AutoDisposeAsyncNotifierProvider<
    OrganizationsNotifier, List<Map<String, dynamic>>>.internal(
  OrganizationsNotifier.new,
  name: r'organizationsNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$organizationsNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$OrganizationsNotifier
    = AutoDisposeAsyncNotifier<List<Map<String, dynamic>>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
