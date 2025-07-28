// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DashboardConfigImpl _$$DashboardConfigImplFromJson(
        Map<String, dynamic> json) =>
    _$DashboardConfigImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      organizationId: json['organizationId'] as String,
      applicableRoles: (json['applicableRoles'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      applicableUnits: (json['applicableUnits'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      hierarchyLevel: (json['hierarchyLevel'] as num).toInt(),
      widgets: (json['widgets'] as List<dynamic>)
          .map((e) => DashboardWidget.fromJson(e as Map<String, dynamic>))
          .toList(),
      layoutConfig: json['layoutConfig'] as Map<String, dynamic>,
      isActive: json['isActive'] as bool? ?? true,
      createdAt:
          const TimestampConverter().fromJson(json['createdAt'] as Timestamp?),
    );

Map<String, dynamic> _$$DashboardConfigImplToJson(
        _$DashboardConfigImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'organizationId': instance.organizationId,
      'applicableRoles': instance.applicableRoles,
      'applicableUnits': instance.applicableUnits,
      'hierarchyLevel': instance.hierarchyLevel,
      'widgets': instance.widgets,
      'layoutConfig': instance.layoutConfig,
      'isActive': instance.isActive,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
    };

_$DashboardWidgetImpl _$$DashboardWidgetImplFromJson(
        Map<String, dynamic> json) =>
    _$DashboardWidgetImpl(
      id: json['id'] as String,
      type: json['type'] as String,
      title: json['title'] as String,
      config: json['config'] as Map<String, dynamic>,
      requiredPermissions: (json['requiredPermissions'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      position: GridPosition.fromJson(json['position'] as Map<String, dynamic>),
      isVisible: json['isVisible'] as bool? ?? true,
    );

Map<String, dynamic> _$$DashboardWidgetImplToJson(
        _$DashboardWidgetImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'title': instance.title,
      'config': instance.config,
      'requiredPermissions': instance.requiredPermissions,
      'position': instance.position,
      'isVisible': instance.isVisible,
    };

_$GridPositionImpl _$$GridPositionImplFromJson(Map<String, dynamic> json) =>
    _$GridPositionImpl(
      x: (json['x'] as num).toInt(),
      y: (json['y'] as num).toInt(),
      width: (json['width'] as num).toInt(),
      height: (json['height'] as num).toInt(),
    );

Map<String, dynamic> _$$GridPositionImplToJson(_$GridPositionImpl instance) =>
    <String, dynamic>{
      'x': instance.x,
      'y': instance.y,
      'width': instance.width,
      'height': instance.height,
    };
