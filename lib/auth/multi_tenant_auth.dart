import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../admin/models/organization_config.dart';
import '../models/app_user.dart';
import '../models/dynamic_role.dart';
import '../providers/organization_provider.dart';
import 'auth_provider.dart';

part 'multi_tenant_auth.g.dart';

@riverpod
class MultiTenantAuth extends _$MultiTenantAuth {
  @override
  Stream<AuthState> build() {
    final orgConfigMap = ref.watch(organizationConfigProvider);

    // Handle empty or loading state
    if (orgConfigMap.isEmpty) {
      return Stream.value(const AuthState.loading());
    }

    // Safely extract authentication config with fallbacks
    final authConfig = orgConfigMap['authentication'] as Map<String, dynamic>?;
    if (authConfig == null) {
      return Stream.value(const AuthState.error(
          AuthError.unknown, "Authentication configuration not found"));
    }

    final authType = authConfig['type'] as String? ?? 'firebase';
    final authSettings = authConfig['config'] as Map<String, dynamic>? ?? {};

    switch (authType) {
      case 'firebase':
        return _handleFirebaseAuth(authSettings);
      case 'azure':
        return _handleAzureAuth(authSettings);
      case 'ldap':
        return _handleLDAPAuth(authSettings);
      case 'custom':
        return _handleCustomAuth(authSettings);
      default:
        return _handleGoogleAuth();
    }
  }

  Stream<AuthState> _handleFirebaseAuth(Map<String, dynamic> config) {
    return FirebaseAuth.instance
        .authStateChanges()
        .asyncMap((user) => _processUser(user, config));
  }

  Stream<AuthState> _handleAzureAuth(Map<String, dynamic> config) {
    return Stream.value(const AuthState.unauthenticated());
  }

  Stream<AuthState> _handleLDAPAuth(Map<String, dynamic> config) {
    return Stream.value(const AuthState.unauthenticated());
  }

  Stream<AuthState> _handleCustomAuth(Map<String, dynamic> config) {
    return Stream.value(const AuthState.unauthenticated());
  }

  Stream<AuthState> _handleGoogleAuth() {
    return FirebaseAuth.instance
        .authStateChanges()
        .asyncMap((user) => _processUser(user, {}));
  }

  Future<AuthState> _processUser(
      User? user, Map<String, dynamic> config) async {
    if (user == null) {
      return const AuthState.unauthenticated();
    }

    try {
      final orgConfigMap = ref.read(organizationConfigProvider);

      if (orgConfigMap.isEmpty) {
        return const AuthState.error(
            AuthError.unknown, "Organization configuration not loaded");
      }

      // Process user with organization context
      final userRepository = ref.read(userRepositoryProvider);
      final userProfile = await userRepository.getUserProfile(user.uid);

      if (userProfile != null) {
        if (!userProfile.isActive) {
          return const AuthState.error(
              AuthError.permissionDenied, "Your account has been disabled.");
        }
        return AuthState.authenticated(userProfile);
      } else {
        // Create new user with dynamic role from org config
        final defaultRole = _getDefaultRoleFromMap(orgConfigMap);
        final newUser = AppUser(
          uid: user.uid,
          email: user.email ?? '',
          name: user.displayName ?? 'New User',
          photoUrl: user.photoURL,
          role: defaultRole,
          organizationId: orgConfigMap['id'] as String? ?? 'default',
          permissions: defaultRole.permissions,
          roleData: defaultRole.config,
          lastLogin: DateTime.now(),
          isActive: true,
        );

        await userRepository.createUserProfile(newUser);
        return AuthState.authenticated(newUser);
      }
    } catch (e) {
      return AuthState.error(AuthError.unknown, e.toString());
    }
  }

  DynamicRole _getDefaultRoleFromMap(Map<String, dynamic> orgConfigMap) {
    // Safely extract roles from map
    final rolesList = orgConfigMap['roles'] as List<dynamic>? ?? [];

    if (rolesList.isEmpty) {
      // Fallback default role
      return DynamicRole(
        id: 'default_user',
        name: 'basic_user',
        displayName: 'Basic User',
        hierarchyLevel: 999,
        organizationId: orgConfigMap['id'] as String? ?? 'default',
        permissions: const ['view_own', 'basic_operations'],
        config: const {'hierarchyAccess': 'own', 'dashboardType': 'basic'},
      );
    }

    // Convert role maps to DynamicRole objects and find lowest hierarchy
    final roles = rolesList
        .cast<Map<String, dynamic>>()
        .map((roleMap) => DynamicRole(
              id: roleMap['id'] as String? ?? 'unknown',
              name: roleMap['name'] as String? ?? 'unknown',
              displayName: roleMap['displayName'] as String? ?? 'Unknown',
              hierarchyLevel: roleMap['hierarchyLevel'] as int? ?? 999,
              organizationId: orgConfigMap['id'] as String? ?? 'default',
              permissions:
                  List<String>.from(roleMap['permissions'] as List? ?? []),
              config:
                  Map<String, dynamic>.from(roleMap['config'] as Map? ?? {}),
            ))
        .toList();

    // Sort by hierarchy level (highest number = lowest hierarchy)
    roles.sort((a, b) => b.hierarchyLevel.compareTo(a.hierarchyLevel));

    return roles.first;
  }
}
