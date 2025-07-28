// lib/core/models/dashboard_model.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'user_model.dart';

part 'dashboard_model.freezed.dart';
part 'dashboard_model.g.dart';

@freezed
class DashboardConfig with _$DashboardConfig {
  const factory DashboardConfig({
    required String id,
    required String name,
    required String organizationId,
    required List<String> applicableRoles,
    required List<String> applicableUnits,
    required int hierarchyLevel, // 0=org, 1=division, 2=dept, 3=team
    required List<DashboardWidget> widgets,
    required Map<String, dynamic> layoutConfig,
    @Default(true) bool isActive,
    @TimestampConverter() DateTime? createdAt,
  }) = _DashboardConfig;

  factory DashboardConfig.fromJson(Map<String, dynamic> json) =>
      _$DashboardConfigFromJson(json);

  factory DashboardConfig.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return DashboardConfig.fromJson({...data, 'id': doc.id});
  }
}

@freezed
class DashboardWidget with _$DashboardWidget {
  const factory DashboardWidget({
    required String id,
    required String type, // 'chart', 'kpi', 'table', 'form', 'list'
    required String title,
    required Map<String, dynamic> config,
    required List<String> requiredPermissions,
    required GridPosition position,
    @Default(true) bool isVisible,
  }) = _DashboardWidget;

  factory DashboardWidget.fromJson(Map<String, dynamic> json) =>
      _$DashboardWidgetFromJson(json);
}

@freezed
class GridPosition with _$GridPosition {
  const factory GridPosition({
    required int x,
    required int y,
    required int width,
    required int height,
  }) = _GridPosition;

  factory GridPosition.fromJson(Map<String, dynamic> json) =>
      _$GridPositionFromJson(json);
}
