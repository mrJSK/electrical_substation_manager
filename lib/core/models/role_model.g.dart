// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'role_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RoleModelImpl _$$RoleModelImplFromJson(Map<String, dynamic> json) =>
    _$RoleModelImpl(
      id: json['id'] as String,
      organizationId: json['organizationId'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      permissions: (json['permissions'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      scopeLevel: json['scopeLevel'] as String,
      isSystemRole: json['isSystemRole'] as bool? ?? false,
      isActive: json['isActive'] as bool? ?? true,
      createdAt:
          const TimestampConverter().fromJson(json['createdAt'] as Timestamp?),
      updatedAt:
          const TimestampConverter().fromJson(json['updatedAt'] as Timestamp?),
    );

Map<String, dynamic> _$$RoleModelImplToJson(_$RoleModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'organizationId': instance.organizationId,
      'name': instance.name,
      'description': instance.description,
      'permissions': instance.permissions,
      'scopeLevel': instance.scopeLevel,
      'isSystemRole': instance.isSystemRole,
      'isActive': instance.isActive,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
    };

_$PermissionPolicyImpl _$$PermissionPolicyImplFromJson(
        Map<String, dynamic> json) =>
    _$PermissionPolicyImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      ruleType: json['ruleType'] as String,
      conditions: json['conditions'] as Map<String, dynamic>,
      permissions: (json['permissions'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      description: json['description'] as String?,
      isActive: json['isActive'] as bool? ?? true,
      createdAt:
          const TimestampConverter().fromJson(json['createdAt'] as Timestamp?),
    );

Map<String, dynamic> _$$PermissionPolicyImplToJson(
        _$PermissionPolicyImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'ruleType': instance.ruleType,
      'conditions': instance.conditions,
      'permissions': instance.permissions,
      'description': instance.description,
      'isActive': instance.isActive,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
    };
