import 'package:freezed_annotation/freezed_annotation.dart';
import 'dynamic_role.dart';

part 'app_user.freezed.dart';
part 'app_user.g.dart';

@freezed
class AppUser with _$AppUser {
  const factory AppUser({
    required String uid,
    required String email,
    required String name,
    String? photoUrl,

    // Replace hardcoded role with dynamic role
    required DynamicRole role,
    required String organizationId,
    String? hierarchyId,
    @Default([]) List<String> permissions, // ← Fix generic type
    @Default({}) Map<String, dynamic> roleData, // ← Fix generic type
    DateTime? lastLogin,
    @Default(true) bool isActive,
    DateTime? lastSynced,
  }) = _AppUser;

  factory AppUser.fromJson(Map<String, dynamic> json) => // ← Fix generic type
      _$AppUserFromJson(json);

  const AppUser._();

  bool hasPermission(String permission) =>
      permissions.contains(permission) || role.permissions.contains(permission);

  bool canAccessHierarchy(String hierarchyId) {
    // Dynamic hierarchy access based on role configuration
    final accessConfig = role.config['hierarchyAccess'];
    if (accessConfig == 'all') return true;
    if (accessConfig == 'own') return this.hierarchyId == hierarchyId;

    // Check if user can access based on hierarchy level
    return role.config['accessibleHierarchies']?.contains(hierarchyId) ?? false;
  }

  String get roleDisplayName => role.displayName;
  int get hierarchyLevel => role.hierarchyLevel;
}
