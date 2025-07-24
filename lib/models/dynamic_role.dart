import 'package:freezed_annotation/freezed_annotation.dart';

part 'dynamic_role.freezed.dart';
part 'dynamic_role.g.dart';

@freezed
class DynamicRole with _$DynamicRole {
  const factory DynamicRole({
    required String id,
    required String name,
    required String displayName,
    required int hierarchyLevel,
    required String organizationId,
    required List<String> permissions,
    required Map<String, dynamic> config,
    String? parentRoleId,
    @Default([]) List<String> childRoleIds,
  }) = _DynamicRole;

  factory DynamicRole.fromJson(Map<String, dynamic> json) =>
      _$DynamicRoleFromJson(json);
}
