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
      inheritedRoles: (json['inheritedRoles'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      constraints: json['constraints'] as Map<String, dynamic>? ?? const {},
      isSystemRole: json['isSystemRole'] as bool? ?? false,
      isActive: json['isActive'] as bool? ?? true,
      priority: (json['priority'] as num?)?.toInt() ?? 100,
      createdBy: json['createdBy'] as String?,
      createdAt: const TimestampConverter().fromJson(json['createdAt']),
      updatedAt: const TimestampConverter().fromJson(json['updatedAt']),
    );

Map<String, dynamic> _$$RoleModelImplToJson(_$RoleModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'organizationId': instance.organizationId,
      'name': instance.name,
      'description': instance.description,
      'permissions': instance.permissions,
      'scopeLevel': instance.scopeLevel,
      'inheritedRoles': instance.inheritedRoles,
      'constraints': instance.constraints,
      'isSystemRole': instance.isSystemRole,
      'isActive': instance.isActive,
      'priority': instance.priority,
      'createdBy': instance.createdBy,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
    };

_$PermissionPolicyImpl _$$PermissionPolicyImplFromJson(
        Map<String, dynamic> json) =>
    _$PermissionPolicyImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      ruleType: json['ruleType'] as String,
      conditions: json['conditions'] as Map<String, dynamic>,
      permissions: (json['permissions'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      parameters: json['parameters'] as Map<String, dynamic>? ?? const {},
      priority: (json['priority'] as num?)?.toInt() ?? 100,
      isActive: json['isActive'] as bool? ?? true,
      createdBy: json['createdBy'] as String?,
      createdAt: const TimestampConverter().fromJson(json['createdAt']),
      updatedAt: const TimestampConverter().fromJson(json['updatedAt']),
    );

Map<String, dynamic> _$$PermissionPolicyImplToJson(
        _$PermissionPolicyImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'ruleType': instance.ruleType,
      'conditions': instance.conditions,
      'permissions': instance.permissions,
      'parameters': instance.parameters,
      'priority': instance.priority,
      'isActive': instance.isActive,
      'createdBy': instance.createdBy,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
    };

_$UserPermissionImpl _$$UserPermissionImplFromJson(Map<String, dynamic> json) =>
    _$UserPermissionImpl(
      userId: json['userId'] as String,
      permission: json['permission'] as String,
      grantedBy: json['grantedBy'] as String,
      reason: json['reason'] as String?,
      expiresAt: const TimestampConverter().fromJson(json['expiresAt']),
      grantedAt: const TimestampConverter().fromJson(json['grantedAt']),
    );

Map<String, dynamic> _$$UserPermissionImplToJson(
        _$UserPermissionImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'permission': instance.permission,
      'grantedBy': instance.grantedBy,
      'reason': instance.reason,
      'expiresAt': const TimestampConverter().toJson(instance.expiresAt),
      'grantedAt': const TimestampConverter().toJson(instance.grantedAt),
    };
