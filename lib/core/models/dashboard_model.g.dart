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
      description: json['description'] as String?,
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
      filters: json['filters'] as Map<String, dynamic>? ?? const {},
      isActive: json['isActive'] as bool? ?? true,
      isDefault: json['isDefault'] as bool? ?? false,
      createdBy: json['createdBy'] as String?,
      createdAt: const TimestampConverter().fromJson(json['createdAt']),
      updatedAt: const TimestampConverter().fromJson(json['updatedAt']),
    );

Map<String, dynamic> _$$DashboardConfigImplToJson(
        _$DashboardConfigImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'organizationId': instance.organizationId,
      'applicableRoles': instance.applicableRoles,
      'applicableUnits': instance.applicableUnits,
      'hierarchyLevel': instance.hierarchyLevel,
      'widgets': instance.widgets,
      'layoutConfig': instance.layoutConfig,
      'filters': instance.filters,
      'isActive': instance.isActive,
      'isDefault': instance.isDefault,
      'createdBy': instance.createdBy,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
    };

_$DashboardWidgetImpl _$$DashboardWidgetImplFromJson(
        Map<String, dynamic> json) =>
    _$DashboardWidgetImpl(
      id: json['id'] as String,
      type: json['type'] as String,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String?,
      description: json['description'] as String?,
      config: json['config'] as Map<String, dynamic>,
      requiredPermissions: (json['requiredPermissions'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      position: GridPosition.fromJson(json['position'] as Map<String, dynamic>),
      isVisible: json['isVisible'] as bool? ?? true,
      isResizable: json['isResizable'] as bool? ?? false,
      styling: json['styling'] as Map<String, dynamic>? ?? const {},
      refreshInterval: (json['refreshInterval'] as num?)?.toInt() ?? 15,
      lastUpdated: const TimestampConverter().fromJson(json['lastUpdated']),
    );

Map<String, dynamic> _$$DashboardWidgetImplToJson(
        _$DashboardWidgetImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'description': instance.description,
      'config': instance.config,
      'requiredPermissions': instance.requiredPermissions,
      'position': instance.position,
      'isVisible': instance.isVisible,
      'isResizable': instance.isResizable,
      'styling': instance.styling,
      'refreshInterval': instance.refreshInterval,
      'lastUpdated': const TimestampConverter().toJson(instance.lastUpdated),
    };

_$GridPositionImpl _$$GridPositionImplFromJson(Map<String, dynamic> json) =>
    _$GridPositionImpl(
      x: (json['x'] as num).toInt(),
      y: (json['y'] as num).toInt(),
      width: (json['width'] as num).toInt(),
      height: (json['height'] as num).toInt(),
      minWidth: (json['minWidth'] as num?)?.toInt() ?? 1,
      minHeight: (json['minHeight'] as num?)?.toInt() ?? 1,
      maxWidth: (json['maxWidth'] as num?)?.toInt() ?? 12,
      maxHeight: (json['maxHeight'] as num?)?.toInt() ?? 10,
    );

Map<String, dynamic> _$$GridPositionImplToJson(_$GridPositionImpl instance) =>
    <String, dynamic>{
      'x': instance.x,
      'y': instance.y,
      'width': instance.width,
      'height': instance.height,
      'minWidth': instance.minWidth,
      'minHeight': instance.minHeight,
      'maxWidth': instance.maxWidth,
      'maxHeight': instance.maxHeight,
    };

_$WidgetDataImpl _$$WidgetDataImplFromJson(Map<String, dynamic> json) =>
    _$WidgetDataImpl(
      widgetId: json['widgetId'] as String,
      data: json['data'] as Map<String, dynamic>,
      hasError: json['hasError'] as bool? ?? false,
      errorMessage: json['errorMessage'] as String?,
      lastFetched: const TimestampConverter().fromJson(json['lastFetched']),
      nextRefresh: const TimestampConverter().fromJson(json['nextRefresh']),
    );

Map<String, dynamic> _$$WidgetDataImplToJson(_$WidgetDataImpl instance) =>
    <String, dynamic>{
      'widgetId': instance.widgetId,
      'data': instance.data,
      'hasError': instance.hasError,
      'errorMessage': instance.errorMessage,
      'lastFetched': const TimestampConverter().toJson(instance.lastFetched),
      'nextRefresh': const TimestampConverter().toJson(instance.nextRefresh),
    };
