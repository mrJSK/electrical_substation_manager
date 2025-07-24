// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppUserImpl _$$AppUserImplFromJson(Map<String, dynamic> json) =>
    _$AppUserImpl(
      uid: json['uid'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      photoUrl: json['photoUrl'] as String?,
      role: DynamicRole.fromJson(json['role'] as Map<String, dynamic>),
      organizationId: json['organizationId'] as String,
      hierarchyId: json['hierarchyId'] as String?,
      permissions: (json['permissions'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      roleData: json['roleData'] as Map<String, dynamic>? ?? const {},
      isActive: json['isActive'] as bool? ?? true,
      status: json['status'] as String? ?? 'pending',
      createdAt: const TimestampConverter().fromJson(json['createdAt']),
      lastLogin: const TimestampConverter().fromJson(json['lastLogin']),
      lastSynced: const TimestampConverter().fromJson(json['lastSynced']),
      requestedAt: const TimestampConverter().fromJson(json['requestedAt']),
      approvedAt: const TimestampConverter().fromJson(json['approvedAt']),
      rejectedAt: const TimestampConverter().fromJson(json['rejectedAt']),
      suspendedAt: const TimestampConverter().fromJson(json['suspendedAt']),
      approvedBy: json['approvedBy'] as String?,
      rejectedBy: json['rejectedBy'] as String?,
      suspendedBy: json['suspendedBy'] as String?,
      rejectionReason: json['rejectionReason'] as String?,
      suspensionReason: json['suspensionReason'] as String?,
      tenantId: json['tenantId'] as String?,
      organizationSettings:
          json['organizationSettings'] as Map<String, dynamic>? ?? const {},
      passwordLastChanged:
          const TimestampConverter().fromJson(json['passwordLastChanged']),
      termsAcceptedAt:
          const TimestampConverter().fromJson(json['termsAcceptedAt']),
      preferredLanguage: json['preferredLanguage'] as String?,
      deviceTokens: (json['deviceTokens'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      isEmailVerified: json['isEmailVerified'] as bool? ?? false,
      isPhoneVerified: json['isPhoneVerified'] as bool? ?? false,
      profileCompleteness:
          (json['profileCompleteness'] as num?)?.toDouble() ?? 0.0,
      preferences: json['preferences'] as Map<String, dynamic>? ?? const {},
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$$AppUserImplToJson(_$AppUserImpl instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'email': instance.email,
      'name': instance.name,
      'photoUrl': instance.photoUrl,
      'role': instance.role,
      'organizationId': instance.organizationId,
      'hierarchyId': instance.hierarchyId,
      'permissions': instance.permissions,
      'roleData': instance.roleData,
      'isActive': instance.isActive,
      'status': instance.status,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'lastLogin': const TimestampConverter().toJson(instance.lastLogin),
      'lastSynced': const TimestampConverter().toJson(instance.lastSynced),
      'requestedAt': const TimestampConverter().toJson(instance.requestedAt),
      'approvedAt': const TimestampConverter().toJson(instance.approvedAt),
      'rejectedAt': const TimestampConverter().toJson(instance.rejectedAt),
      'suspendedAt': const TimestampConverter().toJson(instance.suspendedAt),
      'approvedBy': instance.approvedBy,
      'rejectedBy': instance.rejectedBy,
      'suspendedBy': instance.suspendedBy,
      'rejectionReason': instance.rejectionReason,
      'suspensionReason': instance.suspensionReason,
      'tenantId': instance.tenantId,
      'organizationSettings': instance.organizationSettings,
      'passwordLastChanged':
          const TimestampConverter().toJson(instance.passwordLastChanged),
      'termsAcceptedAt':
          const TimestampConverter().toJson(instance.termsAcceptedAt),
      'preferredLanguage': instance.preferredLanguage,
      'deviceTokens': instance.deviceTokens,
      'isEmailVerified': instance.isEmailVerified,
      'isPhoneVerified': instance.isPhoneVerified,
      'profileCompleteness': instance.profileCompleteness,
      'preferences': instance.preferences,
      'metadata': instance.metadata,
    };
