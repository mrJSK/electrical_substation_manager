// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'organization_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OrganizationConfigImpl _$$OrganizationConfigImplFromJson(
        Map<String, dynamic> json) =>
    _$OrganizationConfigImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      logoUrl: json['logoUrl'] as String,
      branding: Map<String, String>.from(json['branding'] as Map),
      hierarchy: (json['hierarchy'] as List<dynamic>)
          .map((e) => HierarchyLevel.fromJson(e as Map<String, dynamic>))
          .toList(),
      rolePermissions: (json['rolePermissions'] as Map<String, dynamic>).map(
        (k, e) =>
            MapEntry(k, (e as List<dynamic>).map((e) => e as String).toList()),
      ),
      database:
          DatabaseConfig.fromJson(json['database'] as Map<String, dynamic>),
      authentication:
          AuthConfig.fromJson(json['authentication'] as Map<String, dynamic>),
      integrations: json['integrations'] as Map<String, dynamic>,
      isActive: json['isActive'] as bool? ?? true,
    );

Map<String, dynamic> _$$OrganizationConfigImplToJson(
        _$OrganizationConfigImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'logoUrl': instance.logoUrl,
      'branding': instance.branding,
      'hierarchy': instance.hierarchy,
      'rolePermissions': instance.rolePermissions,
      'database': instance.database,
      'authentication': instance.authentication,
      'integrations': instance.integrations,
      'isActive': instance.isActive,
    };

_$DatabaseConfigImpl _$$DatabaseConfigImplFromJson(Map<String, dynamic> json) =>
    _$DatabaseConfigImpl(
      type: $enumDecode(_$DatabaseTypeEnumMap, json['type']),
      config: json['config'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$$DatabaseConfigImplToJson(
        _$DatabaseConfigImpl instance) =>
    <String, dynamic>{
      'type': _$DatabaseTypeEnumMap[instance.type]!,
      'config': instance.config,
    };

const _$DatabaseTypeEnumMap = {
  DatabaseType.firebase: 'firebase',
  DatabaseType.mysql: 'mysql',
  DatabaseType.postgresql: 'postgresql',
  DatabaseType.oracle: 'oracle',
};

_$AuthConfigImpl _$$AuthConfigImplFromJson(Map<String, dynamic> json) =>
    _$AuthConfigImpl(
      type: $enumDecode(_$AuthTypeEnumMap, json['type']),
      config: json['config'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$$AuthConfigImplToJson(_$AuthConfigImpl instance) =>
    <String, dynamic>{
      'type': _$AuthTypeEnumMap[instance.type]!,
      'config': instance.config,
    };

const _$AuthTypeEnumMap = {
  AuthType.firebase: 'firebase',
  AuthType.azure: 'azure',
  AuthType.ldap: 'ldap',
  AuthType.custom: 'custom',
};
