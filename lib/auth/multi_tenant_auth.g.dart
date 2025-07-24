// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'multi_tenant_auth.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$pendingApprovalRequestsHash() =>
    r'00fc6fac9bbf1c695528438b281e4aa9cc9a198f';

/// See also [pendingApprovalRequests].
@ProviderFor(pendingApprovalRequests)
final pendingApprovalRequestsProvider =
    AutoDisposeStreamProvider<List<Map<String, dynamic>>>.internal(
  pendingApprovalRequests,
  name: r'pendingApprovalRequestsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$pendingApprovalRequestsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef PendingApprovalRequestsRef
    = AutoDisposeStreamProviderRef<List<Map<String, dynamic>>>;
String _$userApprovalServiceHash() =>
    r'17f69f7f2f4db29df2040976dbfd5f85c5c5e720';

/// See also [userApprovalService].
@ProviderFor(userApprovalService)
final userApprovalServiceProvider =
    AutoDisposeProvider<UserApprovalService>.internal(
  userApprovalService,
  name: r'userApprovalServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$userApprovalServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UserApprovalServiceRef = AutoDisposeProviderRef<UserApprovalService>;
String _$multiTenantAuthHash() => r'c37d867858b6c8470313bc3578dfb09b009c549c';

/// See also [MultiTenantAuth].
@ProviderFor(MultiTenantAuth)
final multiTenantAuthProvider =
    AutoDisposeStreamNotifierProvider<MultiTenantAuth, AuthState>.internal(
  MultiTenantAuth.new,
  name: r'multiTenantAuthProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$multiTenantAuthHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$MultiTenantAuth = AutoDisposeStreamNotifier<AuthState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
