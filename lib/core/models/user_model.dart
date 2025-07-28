import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const UserModel._(); // Private constructor for custom methods

  const factory UserModel({
    required String id,
    required String email,
    required String name,
    String? photoUrl,
    required String organizationId,
    String? departmentId,
    String? managerId,
    String? phoneNumber,
    String? designation,
    required List<String> roles,
    required Map<String, dynamic> permissions,
    @Default({}) Map<String, dynamic> preferences,
    @Default(true) bool isActive,
    @Default(false) bool isEmailVerified,
    @TimestampConverter() DateTime? lastLoginAt,
    @TimestampConverter() DateTime? createdAt,
    @TimestampConverter() DateTime? updatedAt,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserModel.fromJson({...data, 'id': doc.id});
  }

  // Custom method for Firestore conversion
  Map<String, dynamic> toFirestore() {
    final json = toJson();
    json.remove('id'); // Remove ID for Firestore
    return json;
  }

  // Helper methods
  bool hasRole(String role) => roles.contains(role);
  bool hasPermission(String permission) => permissions.containsKey(permission);
  bool get isAdmin => roles.contains('admin');
  bool get isManager => roles.contains('manager');
}

@freezed
class UserProfile with _$UserProfile {
  const UserProfile._();

  const factory UserProfile({
    required String userId,
    String? bio,
    String? address,
    String? city,
    String? state,
    String? country,
    String? pincode,
    @Default({}) Map<String, String> socialLinks,
    @Default([]) List<String> skills,
    @Default([]) List<String> certifications,
    @TimestampConverter() DateTime? dateOfBirth,
    @TimestampConverter() DateTime? joiningDate,
    @TimestampConverter() DateTime? createdAt,
    @TimestampConverter() DateTime? updatedAt,
  }) = _UserProfile;

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);

  factory UserProfile.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserProfile.fromJson(data);
  }

  Map<String, dynamic> toFirestore() {
    final json = toJson();
    return json;
  }
}

// Custom converter for Firestore Timestamps
class TimestampConverter implements JsonConverter<DateTime?, Object?> {
  const TimestampConverter();

  @override
  DateTime? fromJson(Object? json) {
    if (json == null) return null;
    if (json is Timestamp) return json.toDate();
    if (json is String) return DateTime.parse(json);
    return null;
  }

  @override
  Object? toJson(DateTime? object) {
    return object?.toIso8601String();
  }
}
