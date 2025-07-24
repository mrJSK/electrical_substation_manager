// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dynamic_role.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DynamicRoleImpl _$$DynamicRoleImplFromJson(Map<String, dynamic> json) =>
    _$DynamicRoleImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      displayName: json['displayName'] as String,
      hierarchyLevel: (json['hierarchyLevel'] as num).toInt(),
      organizationId: json['organizationId'] as String,
      permissions: (json['permissions'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      config: json['config'] as Map<String, dynamic>,
      parentRoleId: json['parentRoleId'] as String?,
      childRoleIds: (json['childRoleIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$DynamicRoleImplToJson(_$DynamicRoleImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'displayName': instance.displayName,
      'hierarchyLevel': instance.hierarchyLevel,
      'organizationId': instance.organizationId,
      'permissions': instance.permissions,
      'config': instance.config,
      'parentRoleId': instance.parentRoleId,
      'childRoleIds': instance.childRoleIds,
    };
