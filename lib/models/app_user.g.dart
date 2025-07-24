// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppUserImpl _$$AppUserImplFromJson(Map<String, dynamic> json) =>
    _$AppUserImpl(
      uid: json['uid'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      photoUrl: json['photoUrl'] as String?,
      role: DynamicRole.fromJson(json['role'] as Map<String, dynamic>),
      organizationId: json['organizationId'] as String,
      hierarchyId: json['hierarchyId'] as String?,
      permissions: (json['permissions'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      roleData: json['roleData'] as Map<String, dynamic>? ?? const {},
      lastLogin: json['lastLogin'] == null
          ? null
          : DateTime.parse(json['lastLogin'] as String),
      isActive: json['isActive'] as bool? ?? true,
      lastSynced: json['lastSynced'] == null
          ? null
          : DateTime.parse(json['lastSynced'] as String),
    );

Map<String, dynamic> _$$AppUserImplToJson(_$AppUserImpl instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'email': instance.email,
      'name': instance.name,
      'photoUrl': instance.photoUrl,
      'role': instance.role,
      'organizationId': instance.organizationId,
      'hierarchyId': instance.hierarchyId,
      'permissions': instance.permissions,
      'roleData': instance.roleData,
      'lastLogin': instance.lastLogin?.toIso8601String(),
      'isActive': instance.isActive,
      'lastSynced': instance.lastSynced?.toIso8601String(),
    };
