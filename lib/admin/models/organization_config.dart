import 'package:freezed_annotation/freezed_annotation.dart';
import 'hierarchy_level.dart';

part 'organization_config.freezed.dart';
part 'organization_config.g.dart';

@freezed
class OrganizationConfig with _$OrganizationConfig {
  const factory OrganizationConfig({
    required String id,
    required String name,
    required String logoUrl,
    required Map<String, String> branding,
    required List<HierarchyLevel> hierarchy,
    required Map<String, List<String>> rolePermissions,
    required DatabaseConfig database,
    required AuthConfig authentication,
    required Map<String, dynamic> integrations, // Add this missing field
    @Default(true) bool isActive,
  }) = _OrganizationConfig;

  factory OrganizationConfig.fromJson(Map<String, dynamic> json) =>
      _$OrganizationConfigFromJson(json);

  // Update empty constructor
  factory OrganizationConfig.empty() => const OrganizationConfig(
        id: '',
        name: '',
        logoUrl: '',
        branding: {},
        hierarchy: [],
        rolePermissions: {},
        database: DatabaseConfig(type: DatabaseType.firebase, config: {}),
        authentication: AuthConfig(type: AuthType.firebase, config: {}),
        integrations: {}, // Add this
      );
}

@freezed
class DatabaseConfig with _$DatabaseConfig {
  const factory DatabaseConfig({
    required DatabaseType type,
    required Map<String, dynamic> config,
  }) = _DatabaseConfig;

  factory DatabaseConfig.fromJson(Map<String, dynamic> json) =>
      _$DatabaseConfigFromJson(json);
}

@freezed
class AuthConfig with _$AuthConfig {
  const factory AuthConfig({
    required AuthType type,
    required Map<String, dynamic> config,
  }) = _AuthConfig;

  factory AuthConfig.fromJson(Map<String, dynamic> json) =>
      _$AuthConfigFromJson(json);
}

enum DatabaseType { firebase, mysql, postgresql, oracle }

enum AuthType { firebase, azure, ldap, custom }
