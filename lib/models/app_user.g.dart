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
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      lastLogin: json['lastLogin'] == null
          ? null
          : DateTime.parse(json['lastLogin'] as String),
      lastSynced: json['lastSynced'] == null
          ? null
          : DateTime.parse(json['lastSynced'] as String),
      requestedAt: json['requestedAt'] == null
          ? null
          : DateTime.parse(json['requestedAt'] as String),
      approvedAt: json['approvedAt'] == null
          ? null
          : DateTime.parse(json['approvedAt'] as String),
      rejectedAt: json['rejectedAt'] == null
          ? null
          : DateTime.parse(json['rejectedAt'] as String),
      suspendedAt: json['suspendedAt'] == null
          ? null
          : DateTime.parse(json['suspendedAt'] as String),
      approvedBy: json['approvedBy'] as String?,
      rejectedBy: json['rejectedBy'] as String?,
      suspendedBy: json['suspendedBy'] as String?,
      rejectionReason: json['rejectionReason'] as String?,
      suspensionReason: json['suspensionReason'] as String?,
      tenantId: json['tenantId'] as String?,
      organizationSettings:
          json['organizationSettings'] as Map<String, dynamic>? ?? const {},
      passwordLastChanged: json['passwordLastChanged'] == null
          ? null
          : DateTime.parse(json['passwordLastChanged'] as String),
      termsAcceptedAt: json['termsAcceptedAt'] == null
          ? null
          : DateTime.parse(json['termsAcceptedAt'] as String),
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
      'createdAt': instance.createdAt?.toIso8601String(),
      'lastLogin': instance.lastLogin?.toIso8601String(),
      'lastSynced': instance.lastSynced?.toIso8601String(),
      'requestedAt': instance.requestedAt?.toIso8601String(),
      'approvedAt': instance.approvedAt?.toIso8601String(),
      'rejectedAt': instance.rejectedAt?.toIso8601String(),
      'suspendedAt': instance.suspendedAt?.toIso8601String(),
      'approvedBy': instance.approvedBy,
      'rejectedBy': instance.rejectedBy,
      'suspendedBy': instance.suspendedBy,
      'rejectionReason': instance.rejectionReason,
      'suspensionReason': instance.suspensionReason,
      'tenantId': instance.tenantId,
      'organizationSettings': instance.organizationSettings,
      'passwordLastChanged': instance.passwordLastChanged?.toIso8601String(),
      'termsAcceptedAt': instance.termsAcceptedAt?.toIso8601String(),
      'preferredLanguage': instance.preferredLanguage,
      'deviceTokens': instance.deviceTokens,
      'isEmailVerified': instance.isEmailVerified,
      'isPhoneVerified': instance.isPhoneVerified,
      'profileCompleteness': instance.profileCompleteness,
      'preferences': instance.preferences,
      'metadata': instance.metadata,
    };
