import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'user_model.dart';

part 'organization_model.freezed.dart';
part 'organization_model.g.dart';

@freezed
class OrganizationModel with _$OrganizationModel {
  const OrganizationModel._();

  const factory OrganizationModel({
    required String id,
    required String name,
    String? description,
    String? logoUrl,
    required String industry, // 'electrical', 'manufacturing', etc.
    String? website,
    String? email,
    String? phone,
    required OrganizationAddress address,
    required SubscriptionTier subscriptionTier,
    required Map<String, dynamic> settings,
    @Default({}) Map<String, int> limits, // user_limit, storage_limit, etc.
    @Default(true) bool isActive,
    String? ownerId,
    @TimestampConverter() DateTime? subscriptionExpiryAt,
    @TimestampConverter() DateTime? createdAt,
    @TimestampConverter() DateTime? updatedAt,
  }) = _OrganizationModel;

  factory OrganizationModel.fromJson(Map<String, dynamic> json) =>
      _$OrganizationModelFromJson(json);

  factory OrganizationModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return OrganizationModel.fromJson({...data, 'id': doc.id});
  }

  Map<String, dynamic> toFirestore() {
    final json = toJson();
    json.remove('id');
    return json;
  }

  // Helper methods
  bool get isSubscriptionActive {
    if (subscriptionExpiryAt == null) return true;
    return DateTime.now().isBefore(subscriptionExpiryAt!);
  }

  int getUserLimit() => limits['user_limit'] ?? _getDefaultUserLimit();
  int getStorageLimit() => limits['storage_limit'] ?? _getDefaultStorageLimit();

  int _getDefaultUserLimit() {
    switch (subscriptionTier) {
      case SubscriptionTier.free:
        return 5;
      case SubscriptionTier.basic:
        return 50;
      case SubscriptionTier.pro:
        return 200;
      case SubscriptionTier.enterprise:
        return 999999;
    }
  }

  int _getDefaultStorageLimit() {
    switch (subscriptionTier) {
      case SubscriptionTier.free:
        return 1024; // 1GB in MB
      case SubscriptionTier.basic:
        return 10240; // 10GB
      case SubscriptionTier.pro:
        return 102400; // 100GB
      case SubscriptionTier.enterprise:
        return 1048576; // 1TB
    }
  }
}

@freezed
class OrganizationAddress with _$OrganizationAddress {
  const OrganizationAddress._();

  const factory OrganizationAddress({
    required String street,
    required String city,
    required String state,
    required String country,
    required String pincode,
    String? landmark,
    double? latitude,
    double? longitude,
  }) = _OrganizationAddress;

  factory OrganizationAddress.fromJson(Map<String, dynamic> json) =>
      _$OrganizationAddressFromJson(json);

  // Helper methods
  String get fullAddress => '$street, $city, $state, $country - $pincode';
  bool get hasCoordinates => latitude != null && longitude != null;
}

@freezed
class Department with _$Department {
  const Department._();

  const factory Department({
    required String id,
    required String organizationId,
    required String name,
    String? description,
    String? managerId,
    String? parentDepartmentId,
    @Default([]) List<String> childDepartments,
    @Default({}) Map<String, dynamic> settings,
    @Default(true) bool isActive,
    @TimestampConverter() DateTime? createdAt,
    @TimestampConverter() DateTime? updatedAt,
  }) = _Department;

  factory Department.fromJson(Map<String, dynamic> json) =>
      _$DepartmentFromJson(json);

  factory Department.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Department.fromJson({...data, 'id': doc.id});
  }

  Map<String, dynamic> toFirestore() {
    final json = toJson();
    json.remove('id');
    return json;
  }

  // Helper methods
  bool get hasParent => parentDepartmentId != null;
  bool get hasChildren => childDepartments.isNotEmpty;
  bool get isRootDepartment => parentDepartmentId == null;
}

enum SubscriptionTier {
  @JsonValue('free')
  free,
  @JsonValue('basic')
  basic,
  @JsonValue('pro')
  pro,
  @JsonValue('enterprise')
  enterprise,
}
