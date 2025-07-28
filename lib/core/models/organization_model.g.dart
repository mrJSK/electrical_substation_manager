// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'organization_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OrganizationModelImpl _$$OrganizationModelImplFromJson(
        Map<String, dynamic> json) =>
    _$OrganizationModelImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      logoUrl: json['logoUrl'] as String?,
      industry: json['industry'] as String,
      website: json['website'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      address:
          OrganizationAddress.fromJson(json['address'] as Map<String, dynamic>),
      subscriptionTier:
          $enumDecode(_$SubscriptionTierEnumMap, json['subscriptionTier']),
      settings: json['settings'] as Map<String, dynamic>,
      limits: (json['limits'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, (e as num).toInt()),
          ) ??
          const {},
      isActive: json['isActive'] as bool? ?? true,
      ownerId: json['ownerId'] as String?,
      subscriptionExpiryAt:
          const TimestampConverter().fromJson(json['subscriptionExpiryAt']),
      createdAt: const TimestampConverter().fromJson(json['createdAt']),
      updatedAt: const TimestampConverter().fromJson(json['updatedAt']),
    );

Map<String, dynamic> _$$OrganizationModelImplToJson(
        _$OrganizationModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'logoUrl': instance.logoUrl,
      'industry': instance.industry,
      'website': instance.website,
      'email': instance.email,
      'phone': instance.phone,
      'address': instance.address,
      'subscriptionTier': _$SubscriptionTierEnumMap[instance.subscriptionTier]!,
      'settings': instance.settings,
      'limits': instance.limits,
      'isActive': instance.isActive,
      'ownerId': instance.ownerId,
      'subscriptionExpiryAt':
          const TimestampConverter().toJson(instance.subscriptionExpiryAt),
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
    };

const _$SubscriptionTierEnumMap = {
  SubscriptionTier.free: 'free',
  SubscriptionTier.basic: 'basic',
  SubscriptionTier.pro: 'pro',
  SubscriptionTier.enterprise: 'enterprise',
};

_$OrganizationAddressImpl _$$OrganizationAddressImplFromJson(
        Map<String, dynamic> json) =>
    _$OrganizationAddressImpl(
      street: json['street'] as String,
      city: json['city'] as String,
      state: json['state'] as String,
      country: json['country'] as String,
      pincode: json['pincode'] as String,
      landmark: json['landmark'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$OrganizationAddressImplToJson(
        _$OrganizationAddressImpl instance) =>
    <String, dynamic>{
      'street': instance.street,
      'city': instance.city,
      'state': instance.state,
      'country': instance.country,
      'pincode': instance.pincode,
      'landmark': instance.landmark,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };

_$DepartmentImpl _$$DepartmentImplFromJson(Map<String, dynamic> json) =>
    _$DepartmentImpl(
      id: json['id'] as String,
      organizationId: json['organizationId'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      managerId: json['managerId'] as String?,
      parentDepartmentId: json['parentDepartmentId'] as String?,
      childDepartments: (json['childDepartments'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      settings: json['settings'] as Map<String, dynamic>? ?? const {},
      isActive: json['isActive'] as bool? ?? true,
      createdAt: const TimestampConverter().fromJson(json['createdAt']),
      updatedAt: const TimestampConverter().fromJson(json['updatedAt']),
    );

Map<String, dynamic> _$$DepartmentImplToJson(_$DepartmentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'organizationId': instance.organizationId,
      'name': instance.name,
      'description': instance.description,
      'managerId': instance.managerId,
      'parentDepartmentId': instance.parentDepartmentId,
      'childDepartments': instance.childDepartments,
      'settings': instance.settings,
      'isActive': instance.isActive,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
    };
