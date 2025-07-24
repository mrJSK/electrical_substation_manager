// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hierarchy_level.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HierarchyLevelImpl _$$HierarchyLevelImplFromJson(Map<String, dynamic> json) =>
    _$HierarchyLevelImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      displayName: json['displayName'] as String,
      level: (json['level'] as num).toInt(),
      parentId: json['parentId'] as String?,
      permissions: (json['permissions'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      dashboardConfig: json['dashboardConfig'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$$HierarchyLevelImplToJson(
        _$HierarchyLevelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'displayName': instance.displayName,
      'level': instance.level,
      'parentId': instance.parentId,
      'permissions': instance.permissions,
      'dashboardConfig': instance.dashboardConfig,
    };
