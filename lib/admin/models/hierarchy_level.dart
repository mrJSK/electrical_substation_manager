import 'package:freezed_annotation/freezed_annotation.dart';

part 'hierarchy_level.freezed.dart';
part 'hierarchy_level.g.dart';

@freezed
class HierarchyLevel with _$HierarchyLevel {
  const factory HierarchyLevel({
    required String id,
    required String name,
    required String displayName,
    required int level,
    String? parentId,
    required List<String> permissions,
    required Map<String, dynamic> dashboardConfig,
  }) = _HierarchyLevel;

  factory HierarchyLevel.fromJson(Map<String, dynamic> json) =>
      _$HierarchyLevelFromJson(json);
}
