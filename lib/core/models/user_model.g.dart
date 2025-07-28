// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      photoUrl: json['photoUrl'] as String?,
      organizationId: json['organizationId'] as String,
      roles: (json['roles'] as List<dynamic>).map((e) => e as String).toList(),
      permissions: json['permissions'] as Map<String, dynamic>,
      departmentId: json['departmentId'] as String?,
      managerId: json['managerId'] as String?,
      isActive: json['isActive'] as bool? ?? true,
      createdAt:
          const TimestampConverter().fromJson(json['createdAt'] as Timestamp?),
      updatedAt:
          const TimestampConverter().fromJson(json['updatedAt'] as Timestamp?),
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'name': instance.name,
      'photoUrl': instance.photoUrl,
      'organizationId': instance.organizationId,
      'roles': instance.roles,
      'permissions': instance.permissions,
      'departmentId': instance.departmentId,
      'managerId': instance.managerId,
      'isActive': instance.isActive,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
    };
