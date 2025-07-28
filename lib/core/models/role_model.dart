import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'user_model.dart';

part 'role_model.freezed.dart';
part 'role_model.g.dart';

@freezed
class RoleModel with _$RoleModel {
  const factory RoleModel({
    required String id,
    required String organizationId,
    required String name,
    String? description,
    required List<String> permissions,
    required String
        scopeLevel, // 'organization', 'department', 'team', 'individual'
    @Default(false) bool isSystemRole,
    @Default(true) bool isActive,
    @TimestampConverter() DateTime? createdAt,
    @TimestampConverter() DateTime? updatedAt,
  }) = _RoleModel;

  factory RoleModel.fromJson(Map<String, dynamic> json) =>
      _$RoleModelFromJson(json);

  factory RoleModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return RoleModel.fromJson({...data, 'id': doc.id});
  }
}

@freezed
class PermissionPolicy with _$PermissionPolicy {
  const factory PermissionPolicy({
    required String id,
    required String name,
    required String ruleType, // 'static', 'dynamic', 'contextual'
    required Map<String, dynamic> conditions,
    required List<String> permissions,
    String? description,
    @Default(true) bool isActive,
    @TimestampConverter() DateTime? createdAt,
  }) = _PermissionPolicy;

  factory PermissionPolicy.fromJson(Map<String, dynamic> json) =>
      _$PermissionPolicyFromJson(json);

  factory PermissionPolicy.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return PermissionPolicy.fromJson({...data, 'id': doc.id});
  }
}
