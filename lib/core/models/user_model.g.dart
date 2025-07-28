// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      photoUrl: json['photoUrl'] as String?,
      organizationId: json['organizationId'] as String,
      departmentId: json['departmentId'] as String?,
      managerId: json['managerId'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      designation: json['designation'] as String?,
      roles: (json['roles'] as List<dynamic>).map((e) => e as String).toList(),
      permissions: json['permissions'] as Map<String, dynamic>,
      preferences: json['preferences'] as Map<String, dynamic>? ?? const {},
      isActive: json['isActive'] as bool? ?? true,
      isEmailVerified: json['isEmailVerified'] as bool? ?? false,
      lastLoginAt: const TimestampConverter().fromJson(json['lastLoginAt']),
      createdAt: const TimestampConverter().fromJson(json['createdAt']),
      updatedAt: const TimestampConverter().fromJson(json['updatedAt']),
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'name': instance.name,
      'photoUrl': instance.photoUrl,
      'organizationId': instance.organizationId,
      'departmentId': instance.departmentId,
      'managerId': instance.managerId,
      'phoneNumber': instance.phoneNumber,
      'designation': instance.designation,
      'roles': instance.roles,
      'permissions': instance.permissions,
      'preferences': instance.preferences,
      'isActive': instance.isActive,
      'isEmailVerified': instance.isEmailVerified,
      'lastLoginAt': const TimestampConverter().toJson(instance.lastLoginAt),
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
    };

_$UserProfileImpl _$$UserProfileImplFromJson(Map<String, dynamic> json) =>
    _$UserProfileImpl(
      userId: json['userId'] as String,
      bio: json['bio'] as String?,
      address: json['address'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      country: json['country'] as String?,
      pincode: json['pincode'] as String?,
      socialLinks: (json['socialLinks'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ) ??
          const {},
      skills: (json['skills'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      certifications: (json['certifications'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      dateOfBirth: const TimestampConverter().fromJson(json['dateOfBirth']),
      joiningDate: const TimestampConverter().fromJson(json['joiningDate']),
      createdAt: const TimestampConverter().fromJson(json['createdAt']),
      updatedAt: const TimestampConverter().fromJson(json['updatedAt']),
    );

Map<String, dynamic> _$$UserProfileImplToJson(_$UserProfileImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'bio': instance.bio,
      'address': instance.address,
      'city': instance.city,
      'state': instance.state,
      'country': instance.country,
      'pincode': instance.pincode,
      'socialLinks': instance.socialLinks,
      'skills': instance.skills,
      'certifications': instance.certifications,
      'dateOfBirth': const TimestampConverter().toJson(instance.dateOfBirth),
      'joiningDate': const TimestampConverter().toJson(instance.joiningDate),
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
    };
