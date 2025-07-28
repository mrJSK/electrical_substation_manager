// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'organization_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OrganizationModelImpl _$$OrganizationModelImplFromJson(
        Map<String, dynamic> json) =>
    _$OrganizationModelImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      type: json['type'] as String,
      settings: json['settings'] as Map<String, dynamic>,
      hierarchyLevels: (json['hierarchyLevels'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      logoUrl: json['logoUrl'] as String?,
      isActive: json['isActive'] as bool? ?? true,
      createdAt:
          const TimestampConverter().fromJson(json['createdAt'] as Timestamp?),
      updatedAt:
          const TimestampConverter().fromJson(json['updatedAt'] as Timestamp?),
    );

Map<String, dynamic> _$$OrganizationModelImplToJson(
        _$OrganizationModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'type': instance.type,
      'settings': instance.settings,
      'hierarchyLevels': instance.hierarchyLevels,
      'logoUrl': instance.logoUrl,
      'isActive': instance.isActive,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
    };

_$OrganizationalUnitImpl _$$OrganizationalUnitImplFromJson(
        Map<String, dynamic> json) =>
    _$OrganizationalUnitImpl(
      id: json['id'] as String,
      organizationId: json['organizationId'] as String,
      parentUnitId: json['parentUnitId'] as String?,
      unitType: json['unitType'] as String,
      level: (json['level'] as num).toInt(),
      name: json['name'] as String,
      description: json['description'] as String?,
      permissionsConfig: json['permissionsConfig'] as Map<String, dynamic>,
      isActive: json['isActive'] as bool? ?? true,
      createdAt:
          const TimestampConverter().fromJson(json['createdAt'] as Timestamp?),
    );

Map<String, dynamic> _$$OrganizationalUnitImplToJson(
        _$OrganizationalUnitImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'organizationId': instance.organizationId,
      'parentUnitId': instance.parentUnitId,
      'unitType': instance.unitType,
      'level': instance.level,
      'name': instance.name,
      'description': instance.description,
      'permissionsConfig': instance.permissionsConfig,
      'isActive': instance.isActive,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
    };
