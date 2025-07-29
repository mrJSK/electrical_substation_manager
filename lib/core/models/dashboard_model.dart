// lib/core/models/dashboard_model.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'user_model.dart';

part 'dashboard_model.freezed.dart';
part 'dashboard_model.g.dart';

@freezed
class DashboardConfig with _$DashboardConfig {
  const DashboardConfig._();

  const factory DashboardConfig({
    required String id,
    required String name,
    String? description,
    required String organizationId,
    required List<String> applicableRoles,
    required List<String> applicableUnits,
    required int hierarchyLevel, // 0=org, 1=division, 2=dept, 3=team
    required List<DashboardWidget> widgets,
    required Map<String, dynamic> layoutConfig,
    @Default({}) Map<String, dynamic> filters,
    @Default(true) bool isActive,
    @Default(false) bool isDefault,
    String? createdBy,
    @TimestampConverter() DateTime? createdAt,
    @TimestampConverter() DateTime? updatedAt,
  }) = _DashboardConfig;

  factory DashboardConfig.fromJson(Map<String, dynamic> json) =>
      _$DashboardConfigFromJson(json);

  factory DashboardConfig.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return DashboardConfig.fromJson({...data, 'id': doc.id});
  }

  Map<String, dynamic> toFirestore() {
    final json = toJson();
    json.remove('id');
    return json;
  }

  // Helper methods
  List<DashboardWidget> get activeWidgets =>
      widgets.where((w) => w.isVisible).toList();
  bool isApplicableToUser(UserModel user) {
    return applicableRoles.any((role) => user.roles.contains(role)) ||
        (user.departmentId != null &&
            applicableUnits.contains(user.departmentId));
  }
}

@freezed
class DashboardWidget with _$DashboardWidget {
  const DashboardWidget._();

  const factory DashboardWidget({
    required String id,
    required String
        type, // 'chart', 'kpi', 'table', 'form', 'list', 'gauge', 'alert'
    required String title,
    String? subtitle,
    String? description,
    required Map<String, dynamic> config,
    required List<String> requiredPermissions,
    required GridPosition position,
    @Default(true) bool isVisible,
    @Default(false) bool isResizable,
    @Default({}) Map<String, dynamic> styling,
    @Default(15) int refreshInterval, // minutes
    @Default('medium') String priority, // Added priority field
    @TimestampConverter() DateTime? lastUpdated,
  }) = _DashboardWidget;

  factory DashboardWidget.fromJson(Map<String, dynamic> json) =>
      _$DashboardWidgetFromJson(json);

  // Helper methods
  bool get needsRefresh {
    if (lastUpdated == null) return true;
    return DateTime.now().difference(lastUpdated!).inMinutes >= refreshInterval;
  }

  String get displayTitle => subtitle != null ? '$title - $subtitle' : title;
}

@freezed
class GridPosition with _$GridPosition {
  const GridPosition._();

  const factory GridPosition({
    required int x,
    required int y,
    required int width,
    required int height,
    @Default(1) int minWidth,
    @Default(1) int minHeight,
    @Default(12) int maxWidth,
    @Default(10) int maxHeight,
  }) = _GridPosition;

  factory GridPosition.fromJson(Map<String, dynamic> json) =>
      _$GridPositionFromJson(json);

  // Helper methods
  int get area => width * height;
  bool get isValidSize =>
      width >= minWidth &&
      height >= minHeight &&
      width <= maxWidth &&
      height <= maxHeight;
}

@freezed
class WidgetData with _$WidgetData {
  const WidgetData._();

  const factory WidgetData({
    required String widgetId,
    required Map<String, dynamic> data,
    @Default(false) bool hasError,
    String? errorMessage,
    @TimestampConverter() DateTime? lastFetched,
    @TimestampConverter() DateTime? nextRefresh,
  }) = _WidgetData;

  factory WidgetData.fromJson(Map<String, dynamic> json) =>
      _$WidgetDataFromJson(json);

  // Helper methods
  bool get isStale {
    if (nextRefresh == null) return false;
    return DateTime.now().isAfter(nextRefresh!);
  }

  bool get isValid => !hasError && data.isNotEmpty;
}
