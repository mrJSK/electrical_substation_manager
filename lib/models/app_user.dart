import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dynamic_role.dart';

part 'app_user.freezed.dart';
part 'app_user.g.dart';

@freezed
class AppUser with _$AppUser {
  const factory AppUser({
    // Core user information
    required String uid,
    required String email,
    required String name,
    String? photoUrl,

    // Role and organization
    required DynamicRole role,
    required String organizationId,
    String? hierarchyId,

    // Permissions and role data
    @Default([]) List<String> permissions,
    @Default({}) Map<String, dynamic> roleData,

    // User status and lifecycle
    @Default(true) bool isActive,
    @Default('pending') String status, // pending, approved, rejected, suspended

    // Timestamps for audit trail - Using TimestampConverter for Firestore compatibility
    @TimestampConverter() DateTime? createdAt,
    @TimestampConverter() DateTime? lastLogin,
    @TimestampConverter() DateTime? lastSynced,
    @TimestampConverter()
    DateTime? requestedAt, // When user registration was requested
    @TimestampConverter() DateTime? approvedAt, // When user was approved
    @TimestampConverter() DateTime? rejectedAt, // When user was rejected
    @TimestampConverter() DateTime? suspendedAt, // When user was suspended

    // Approval workflow fields
    String? approvedBy, // UID of user who approved
    String? rejectedBy, // UID of user who rejected
    String? suspendedBy, // UID of user who suspended
    String? rejectionReason, // Reason for rejection
    String? suspensionReason, // Reason for suspension

    // Multi-tenant specific fields
    String? tenantId, // Additional tenant identifier if needed
    @Default({})
    Map<String, dynamic> organizationSettings, // Org-specific user settings

    // Security and compliance
    @TimestampConverter() DateTime? passwordLastChanged,
    @TimestampConverter() DateTime? termsAcceptedAt,
    String? preferredLanguage,
    @Default([]) List<String> deviceTokens, // For push notifications

    // Profile completeness and verification
    @Default(false) bool isEmailVerified,
    @Default(false) bool isPhoneVerified,
    @Default(0.0) double profileCompleteness, // 0.0 to 1.0

    // User preferences
    @Default({}) Map<String, dynamic> preferences,
    @Default({})
    Map<String, dynamic> metadata, // Extensible field for future use
  }) = _AppUser;

  factory AppUser.fromJson(Map<String, dynamic> json) =>
      _$AppUserFromJson(json);

  // Private constructor for extension methods
  const AppUser._();

  // Permission checking methods
  bool hasPermission(String permission) =>
      permissions.contains(permission) ||
      role.permissions.contains(permission) ||
      permissions.contains('*') ||
      role.permissions.contains('*');

  bool hasAnyPermission(List<String> permissionList) =>
      permissionList.any((permission) => hasPermission(permission));

  bool hasAllPermissions(List<String> permissionList) =>
      permissionList.every((permission) => hasPermission(permission));

  // Hierarchy access methods
  bool canAccessHierarchy(String hierarchyId) {
    final accessConfig = role.config['hierarchyAccess'];
    if (accessConfig == 'all') return true;
    if (accessConfig == 'own') return this.hierarchyId == hierarchyId;

    // Check if user can access based on hierarchy level
    return role.config['accessibleHierarchies']?.contains(hierarchyId) ?? false;
  }

  bool canManageHierarchy(String hierarchyId) {
    return hasPermission('manage_hierarchy') && canAccessHierarchy(hierarchyId);
  }

  // Status checking methods
  bool get isPending => status == 'pending';
  bool get isApproved => status == 'approved';
  bool get isRejected => status == 'rejected';
  bool get isSuspended => status == 'suspended';
  bool get canLogin => isActive && isApproved && !isSuspended;

  // Role and hierarchy getters
  String get roleDisplayName => role.displayName;
  int get hierarchyLevel => role.hierarchyLevel;
  String get roleName => role.name;

  // Profile completeness methods
  bool get isProfileComplete => profileCompleteness >= 1.0;
  bool get needsProfileUpdate => profileCompleteness < 0.7;

  // Verification status
  bool get isFullyVerified => isEmailVerified && isPhoneVerified;

  // Organization methods
  bool belongsToOrganization(String orgId) => organizationId == orgId;

  T? getOrganizationSetting<T>(String key, {T? defaultValue}) {
    return organizationSettings[key] as T? ?? defaultValue;
  }

  T? getPreference<T>(String key, {T? defaultValue}) {
    return preferences[key] as T? ?? defaultValue;
  }

  T? getMetadata<T>(String key, {T? defaultValue}) {
    return metadata[key] as T? ?? defaultValue;
  }

  // Security methods
  bool get needsPasswordChange {
    if (passwordLastChanged == null) return true;
    final daysSinceChange =
        DateTime.now().difference(passwordLastChanged!).inDays;
    return daysSinceChange > 90; // Password expires after 90 days
  }

  bool get hasAcceptedLatestTerms {
    if (termsAcceptedAt == null) return false;
    // Add logic to check against latest terms version
    return true;
  }

  // Audit trail methods
  String get statusDisplayName {
    switch (status) {
      case 'pending':
        return 'Pending Approval';
      case 'approved':
        return 'Active';
      case 'rejected':
        return 'Rejected';
      case 'suspended':
        return 'Suspended';
      default:
        return status.toUpperCase();
    }
  }

  Duration? get timeSinceLastLogin {
    if (lastLogin == null) return null;
    return DateTime.now().difference(lastLogin!);
  }

  // Factory constructors for common use cases
  factory AppUser.createPendingUser({
    required String uid,
    required String email,
    required String name,
    String? photoUrl,
    required DynamicRole role,
    required String organizationId,
    String? hierarchyId,
  }) {
    return AppUser(
      uid: uid,
      email: email,
      name: name,
      photoUrl: photoUrl,
      role: role,
      organizationId: organizationId,
      hierarchyId: hierarchyId,
      status: 'pending',
      isActive: false,
      permissions: [], // No permissions until approved
      createdAt: DateTime.now(),
      requestedAt: DateTime.now(),
      profileCompleteness: _calculateInitialProfileCompleteness(
        name: name,
        email: email,
        photoUrl: photoUrl,
      ),
    );
  }

  // Utility method for calculating profile completeness
  static double _calculateInitialProfileCompleteness({
    required String name,
    required String email,
    String? photoUrl,
    String? hierarchyId,
  }) {
    double completeness = 0.0;

    if (name.isNotEmpty) completeness += 0.3;
    if (email.isNotEmpty) completeness += 0.3;
    if (photoUrl != null && photoUrl.isNotEmpty) completeness += 0.2;
    if (hierarchyId != null) completeness += 0.2;

    return completeness;
  }

  // Copy with additional helper for common updates
  AppUser approve({
    required String approvedByUid,
    List<String>? newPermissions,
    DynamicRole? newRole,
  }) {
    return copyWith(
      status: 'approved',
      isActive: true,
      approvedAt: DateTime.now(),
      approvedBy: approvedByUid,
      permissions: newPermissions ?? permissions,
      role: newRole ?? role,
    );
  }

  AppUser reject({
    required String rejectedByUid,
    String? reason,
  }) {
    return copyWith(
      status: 'rejected',
      isActive: false,
      rejectedAt: DateTime.now(),
      rejectedBy: rejectedByUid,
      rejectionReason: reason,
    );
  }

  AppUser suspend({
    required String suspendedByUid,
    String? reason,
  }) {
    return copyWith(
      status: 'suspended',
      isActive: false,
      suspendedAt: DateTime.now(),
      suspendedBy: suspendedByUid,
      suspensionReason: reason,
    );
  }

  // Validation methods
  List<String> get validationErrors {
    final errors = <String>[];

    if (email.isEmpty) errors.add('Email is required');
    if (name.isEmpty) errors.add('Name is required');
    if (organizationId.isEmpty) errors.add('Organization is required');
    if (!isEmailVerified) errors.add('Email verification required');
    if (!hasAcceptedLatestTerms) errors.add('Terms acceptance required');

    return errors;
  }

  bool get isValid => validationErrors.isEmpty;
}

// Timestamp Converter Class for handling Firestore Timestamps
class TimestampConverter implements JsonConverter<DateTime?, Object?> {
  const TimestampConverter();

  @override
  DateTime? fromJson(Object? json) {
    if (json == null) return null;

    // Handle Firestore Timestamp objects
    if (json is Timestamp) {
      return json.toDate();
    }

    // Handle String timestamps (ISO format)
    if (json is String) {
      try {
        return DateTime.parse(json);
      } catch (e) {
        print('Error parsing timestamp string: $json - $e');
        return null;
      }
    }

    // Handle int/double (milliseconds since epoch)
    if (json is int) {
      return DateTime.fromMillisecondsSinceEpoch(json);
    }

    if (json is double) {
      return DateTime.fromMillisecondsSinceEpoch(json.toInt());
    }

    print('Unknown timestamp format: ${json.runtimeType} - $json');
    return null;
  }

  @override
  Object? toJson(DateTime? dateTime) {
    if (dateTime == null) return null;
    // Return as ISO string for JSON serialization
    return dateTime.toIso8601String();
  }
}
