import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'user_model.dart';

part 'role_model.freezed.dart';
part 'role_model.g.dart';

@freezed
class RoleModel with _$RoleModel {
  const RoleModel._();

  const factory RoleModel({
    required String id,
    required String organizationId,
    required String name,
    String? description,
    required List<String> permissions,
    required String
        scopeLevel, // 'organization', 'department', 'team', 'individual'
    @Default([]) List<String> inheritedRoles,
    @Default({}) Map<String, dynamic> constraints,
    @Default(false) bool isSystemRole,
    @Default(true) bool isActive,
    @Default(100) int priority, // Higher number = higher priority
    String? createdBy,
    @TimestampConverter() DateTime? createdAt,
    @TimestampConverter() DateTime? updatedAt,
  }) = _RoleModel;

  factory RoleModel.fromJson(Map<String, dynamic> json) =>
      _$RoleModelFromJson(json);

  factory RoleModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return RoleModel.fromJson({...data, 'id': doc.id});
  }

  Map<String, dynamic> toFirestore() {
    final json = toJson();
    json.remove('id');
    return json;
  }

  // Helper methods
  bool hasPermission(String permission) => permissions.contains(permission);
  List<String> get allPermissions {
    final allPerms = <String>{...permissions};
    // Add inherited permissions logic here if needed
    return allPerms.toList();
  }
}

@freezed
class PermissionPolicy with _$PermissionPolicy {
  const PermissionPolicy._();

  const factory PermissionPolicy({
    required String id,
    required String name,
    String? description,
    required String ruleType, // 'static', 'dynamic', 'contextual', 'time_based'
    required Map<String, dynamic> conditions,
    required List<String> permissions,
    @Default({}) Map<String, dynamic> parameters,
    @Default(100) int priority,
    @Default(true) bool isActive,
    String? createdBy,
    @TimestampConverter() DateTime? createdAt,
    @TimestampConverter() DateTime? updatedAt,
  }) = _PermissionPolicy;

  factory PermissionPolicy.fromJson(Map<String, dynamic> json) =>
      _$PermissionPolicyFromJson(json);

  factory PermissionPolicy.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return PermissionPolicy.fromJson({...data, 'id': doc.id});
  }

  Map<String, dynamic> toFirestore() {
    final json = toJson();
    json.remove('id');
    return json;
  }

  // Helper methods
  bool isApplicable(Map<String, dynamic> context) {
    // Implement policy evaluation logic
    return isActive;
  }
}

@freezed
class UserPermission with _$UserPermission {
  const UserPermission._();

  const factory UserPermission({
    required String userId,
    required String permission,
    required String grantedBy,
    String? reason,
    @TimestampConverter() DateTime? expiresAt,
    @TimestampConverter() DateTime? grantedAt,
  }) = _UserPermission;

  factory UserPermission.fromJson(Map<String, dynamic> json) =>
      _$UserPermissionFromJson(json);

  // Helper methods
  bool get isExpired {
    if (expiresAt == null) return false;
    return DateTime.now().isAfter(expiresAt!);
  }

  bool get isValid => !isExpired;
}
