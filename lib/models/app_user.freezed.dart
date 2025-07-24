// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AppUser _$AppUserFromJson(Map<String, dynamic> json) {
  return _AppUser.fromJson(json);
}

/// @nodoc
mixin _$AppUser {
// Core user information
  String get uid => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get photoUrl =>
      throw _privateConstructorUsedError; // Role and organization
  DynamicRole get role => throw _privateConstructorUsedError;
  String get organizationId => throw _privateConstructorUsedError;
  String? get hierarchyId =>
      throw _privateConstructorUsedError; // Permissions and role data
  List<String> get permissions => throw _privateConstructorUsedError;
  Map<String, dynamic> get roleData =>
      throw _privateConstructorUsedError; // User status and lifecycle
  bool get isActive => throw _privateConstructorUsedError;
  String get status =>
      throw _privateConstructorUsedError; // pending, approved, rejected, suspended
// Timestamps for audit trail - Using TimestampConverter for Firestore compatibility
  @TimestampConverter()
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get lastLogin => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get lastSynced => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get requestedAt =>
      throw _privateConstructorUsedError; // When user registration was requested
  @TimestampConverter()
  DateTime? get approvedAt =>
      throw _privateConstructorUsedError; // When user was approved
  @TimestampConverter()
  DateTime? get rejectedAt =>
      throw _privateConstructorUsedError; // When user was rejected
  @TimestampConverter()
  DateTime? get suspendedAt =>
      throw _privateConstructorUsedError; // When user was suspended
// Approval workflow fields
  String? get approvedBy =>
      throw _privateConstructorUsedError; // UID of user who approved
  String? get rejectedBy =>
      throw _privateConstructorUsedError; // UID of user who rejected
  String? get suspendedBy =>
      throw _privateConstructorUsedError; // UID of user who suspended
  String? get rejectionReason =>
      throw _privateConstructorUsedError; // Reason for rejection
  String? get suspensionReason =>
      throw _privateConstructorUsedError; // Reason for suspension
// Multi-tenant specific fields
  String? get tenantId =>
      throw _privateConstructorUsedError; // Additional tenant identifier if needed
  Map<String, dynamic> get organizationSettings =>
      throw _privateConstructorUsedError; // Org-specific user settings
// Security and compliance
  @TimestampConverter()
  DateTime? get passwordLastChanged => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get termsAcceptedAt => throw _privateConstructorUsedError;
  String? get preferredLanguage => throw _privateConstructorUsedError;
  List<String> get deviceTokens =>
      throw _privateConstructorUsedError; // For push notifications
// Profile completeness and verification
  bool get isEmailVerified => throw _privateConstructorUsedError;
  bool get isPhoneVerified => throw _privateConstructorUsedError;
  double get profileCompleteness =>
      throw _privateConstructorUsedError; // 0.0 to 1.0
// User preferences
  Map<String, dynamic> get preferences => throw _privateConstructorUsedError;
  Map<String, dynamic> get metadata => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AppUserCopyWith<AppUser> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppUserCopyWith<$Res> {
  factory $AppUserCopyWith(AppUser value, $Res Function(AppUser) then) =
      _$AppUserCopyWithImpl<$Res, AppUser>;
  @useResult
  $Res call(
      {String uid,
      String email,
      String name,
      String? photoUrl,
      DynamicRole role,
      String organizationId,
      String? hierarchyId,
      List<String> permissions,
      Map<String, dynamic> roleData,
      bool isActive,
      String status,
      @TimestampConverter() DateTime? createdAt,
      @TimestampConverter() DateTime? lastLogin,
      @TimestampConverter() DateTime? lastSynced,
      @TimestampConverter() DateTime? requestedAt,
      @TimestampConverter() DateTime? approvedAt,
      @TimestampConverter() DateTime? rejectedAt,
      @TimestampConverter() DateTime? suspendedAt,
      String? approvedBy,
      String? rejectedBy,
      String? suspendedBy,
      String? rejectionReason,
      String? suspensionReason,
      String? tenantId,
      Map<String, dynamic> organizationSettings,
      @TimestampConverter() DateTime? passwordLastChanged,
      @TimestampConverter() DateTime? termsAcceptedAt,
      String? preferredLanguage,
      List<String> deviceTokens,
      bool isEmailVerified,
      bool isPhoneVerified,
      double profileCompleteness,
      Map<String, dynamic> preferences,
      Map<String, dynamic> metadata});

  $DynamicRoleCopyWith<$Res> get role;
}

/// @nodoc
class _$AppUserCopyWithImpl<$Res, $Val extends AppUser>
    implements $AppUserCopyWith<$Res> {
  _$AppUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? email = null,
    Object? name = null,
    Object? photoUrl = freezed,
    Object? role = null,
    Object? organizationId = null,
    Object? hierarchyId = freezed,
    Object? permissions = null,
    Object? roleData = null,
    Object? isActive = null,
    Object? status = null,
    Object? createdAt = freezed,
    Object? lastLogin = freezed,
    Object? lastSynced = freezed,
    Object? requestedAt = freezed,
    Object? approvedAt = freezed,
    Object? rejectedAt = freezed,
    Object? suspendedAt = freezed,
    Object? approvedBy = freezed,
    Object? rejectedBy = freezed,
    Object? suspendedBy = freezed,
    Object? rejectionReason = freezed,
    Object? suspensionReason = freezed,
    Object? tenantId = freezed,
    Object? organizationSettings = null,
    Object? passwordLastChanged = freezed,
    Object? termsAcceptedAt = freezed,
    Object? preferredLanguage = freezed,
    Object? deviceTokens = null,
    Object? isEmailVerified = null,
    Object? isPhoneVerified = null,
    Object? profileCompleteness = null,
    Object? preferences = null,
    Object? metadata = null,
  }) {
    return _then(_value.copyWith(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      photoUrl: freezed == photoUrl
          ? _value.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as DynamicRole,
      organizationId: null == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      hierarchyId: freezed == hierarchyId
          ? _value.hierarchyId
          : hierarchyId // ignore: cast_nullable_to_non_nullable
              as String?,
      permissions: null == permissions
          ? _value.permissions
          : permissions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      roleData: null == roleData
          ? _value.roleData
          : roleData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastLogin: freezed == lastLogin
          ? _value.lastLogin
          : lastLogin // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastSynced: freezed == lastSynced
          ? _value.lastSynced
          : lastSynced // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      requestedAt: freezed == requestedAt
          ? _value.requestedAt
          : requestedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      approvedAt: freezed == approvedAt
          ? _value.approvedAt
          : approvedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      rejectedAt: freezed == rejectedAt
          ? _value.rejectedAt
          : rejectedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      suspendedAt: freezed == suspendedAt
          ? _value.suspendedAt
          : suspendedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      approvedBy: freezed == approvedBy
          ? _value.approvedBy
          : approvedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      rejectedBy: freezed == rejectedBy
          ? _value.rejectedBy
          : rejectedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      suspendedBy: freezed == suspendedBy
          ? _value.suspendedBy
          : suspendedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      rejectionReason: freezed == rejectionReason
          ? _value.rejectionReason
          : rejectionReason // ignore: cast_nullable_to_non_nullable
              as String?,
      suspensionReason: freezed == suspensionReason
          ? _value.suspensionReason
          : suspensionReason // ignore: cast_nullable_to_non_nullable
              as String?,
      tenantId: freezed == tenantId
          ? _value.tenantId
          : tenantId // ignore: cast_nullable_to_non_nullable
              as String?,
      organizationSettings: null == organizationSettings
          ? _value.organizationSettings
          : organizationSettings // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      passwordLastChanged: freezed == passwordLastChanged
          ? _value.passwordLastChanged
          : passwordLastChanged // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      termsAcceptedAt: freezed == termsAcceptedAt
          ? _value.termsAcceptedAt
          : termsAcceptedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      preferredLanguage: freezed == preferredLanguage
          ? _value.preferredLanguage
          : preferredLanguage // ignore: cast_nullable_to_non_nullable
              as String?,
      deviceTokens: null == deviceTokens
          ? _value.deviceTokens
          : deviceTokens // ignore: cast_nullable_to_non_nullable
              as List<String>,
      isEmailVerified: null == isEmailVerified
          ? _value.isEmailVerified
          : isEmailVerified // ignore: cast_nullable_to_non_nullable
              as bool,
      isPhoneVerified: null == isPhoneVerified
          ? _value.isPhoneVerified
          : isPhoneVerified // ignore: cast_nullable_to_non_nullable
              as bool,
      profileCompleteness: null == profileCompleteness
          ? _value.profileCompleteness
          : profileCompleteness // ignore: cast_nullable_to_non_nullable
              as double,
      preferences: null == preferences
          ? _value.preferences
          : preferences // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      metadata: null == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $DynamicRoleCopyWith<$Res> get role {
    return $DynamicRoleCopyWith<$Res>(_value.role, (value) {
      return _then(_value.copyWith(role: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AppUserImplCopyWith<$Res> implements $AppUserCopyWith<$Res> {
  factory _$$AppUserImplCopyWith(
          _$AppUserImpl value, $Res Function(_$AppUserImpl) then) =
      __$$AppUserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String uid,
      String email,
      String name,
      String? photoUrl,
      DynamicRole role,
      String organizationId,
      String? hierarchyId,
      List<String> permissions,
      Map<String, dynamic> roleData,
      bool isActive,
      String status,
      @TimestampConverter() DateTime? createdAt,
      @TimestampConverter() DateTime? lastLogin,
      @TimestampConverter() DateTime? lastSynced,
      @TimestampConverter() DateTime? requestedAt,
      @TimestampConverter() DateTime? approvedAt,
      @TimestampConverter() DateTime? rejectedAt,
      @TimestampConverter() DateTime? suspendedAt,
      String? approvedBy,
      String? rejectedBy,
      String? suspendedBy,
      String? rejectionReason,
      String? suspensionReason,
      String? tenantId,
      Map<String, dynamic> organizationSettings,
      @TimestampConverter() DateTime? passwordLastChanged,
      @TimestampConverter() DateTime? termsAcceptedAt,
      String? preferredLanguage,
      List<String> deviceTokens,
      bool isEmailVerified,
      bool isPhoneVerified,
      double profileCompleteness,
      Map<String, dynamic> preferences,
      Map<String, dynamic> metadata});

  @override
  $DynamicRoleCopyWith<$Res> get role;
}

/// @nodoc
class __$$AppUserImplCopyWithImpl<$Res>
    extends _$AppUserCopyWithImpl<$Res, _$AppUserImpl>
    implements _$$AppUserImplCopyWith<$Res> {
  __$$AppUserImplCopyWithImpl(
      _$AppUserImpl _value, $Res Function(_$AppUserImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? email = null,
    Object? name = null,
    Object? photoUrl = freezed,
    Object? role = null,
    Object? organizationId = null,
    Object? hierarchyId = freezed,
    Object? permissions = null,
    Object? roleData = null,
    Object? isActive = null,
    Object? status = null,
    Object? createdAt = freezed,
    Object? lastLogin = freezed,
    Object? lastSynced = freezed,
    Object? requestedAt = freezed,
    Object? approvedAt = freezed,
    Object? rejectedAt = freezed,
    Object? suspendedAt = freezed,
    Object? approvedBy = freezed,
    Object? rejectedBy = freezed,
    Object? suspendedBy = freezed,
    Object? rejectionReason = freezed,
    Object? suspensionReason = freezed,
    Object? tenantId = freezed,
    Object? organizationSettings = null,
    Object? passwordLastChanged = freezed,
    Object? termsAcceptedAt = freezed,
    Object? preferredLanguage = freezed,
    Object? deviceTokens = null,
    Object? isEmailVerified = null,
    Object? isPhoneVerified = null,
    Object? profileCompleteness = null,
    Object? preferences = null,
    Object? metadata = null,
  }) {
    return _then(_$AppUserImpl(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      photoUrl: freezed == photoUrl
          ? _value.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as DynamicRole,
      organizationId: null == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      hierarchyId: freezed == hierarchyId
          ? _value.hierarchyId
          : hierarchyId // ignore: cast_nullable_to_non_nullable
              as String?,
      permissions: null == permissions
          ? _value._permissions
          : permissions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      roleData: null == roleData
          ? _value._roleData
          : roleData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastLogin: freezed == lastLogin
          ? _value.lastLogin
          : lastLogin // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastSynced: freezed == lastSynced
          ? _value.lastSynced
          : lastSynced // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      requestedAt: freezed == requestedAt
          ? _value.requestedAt
          : requestedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      approvedAt: freezed == approvedAt
          ? _value.approvedAt
          : approvedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      rejectedAt: freezed == rejectedAt
          ? _value.rejectedAt
          : rejectedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      suspendedAt: freezed == suspendedAt
          ? _value.suspendedAt
          : suspendedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      approvedBy: freezed == approvedBy
          ? _value.approvedBy
          : approvedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      rejectedBy: freezed == rejectedBy
          ? _value.rejectedBy
          : rejectedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      suspendedBy: freezed == suspendedBy
          ? _value.suspendedBy
          : suspendedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      rejectionReason: freezed == rejectionReason
          ? _value.rejectionReason
          : rejectionReason // ignore: cast_nullable_to_non_nullable
              as String?,
      suspensionReason: freezed == suspensionReason
          ? _value.suspensionReason
          : suspensionReason // ignore: cast_nullable_to_non_nullable
              as String?,
      tenantId: freezed == tenantId
          ? _value.tenantId
          : tenantId // ignore: cast_nullable_to_non_nullable
              as String?,
      organizationSettings: null == organizationSettings
          ? _value._organizationSettings
          : organizationSettings // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      passwordLastChanged: freezed == passwordLastChanged
          ? _value.passwordLastChanged
          : passwordLastChanged // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      termsAcceptedAt: freezed == termsAcceptedAt
          ? _value.termsAcceptedAt
          : termsAcceptedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      preferredLanguage: freezed == preferredLanguage
          ? _value.preferredLanguage
          : preferredLanguage // ignore: cast_nullable_to_non_nullable
              as String?,
      deviceTokens: null == deviceTokens
          ? _value._deviceTokens
          : deviceTokens // ignore: cast_nullable_to_non_nullable
              as List<String>,
      isEmailVerified: null == isEmailVerified
          ? _value.isEmailVerified
          : isEmailVerified // ignore: cast_nullable_to_non_nullable
              as bool,
      isPhoneVerified: null == isPhoneVerified
          ? _value.isPhoneVerified
          : isPhoneVerified // ignore: cast_nullable_to_non_nullable
              as bool,
      profileCompleteness: null == profileCompleteness
          ? _value.profileCompleteness
          : profileCompleteness // ignore: cast_nullable_to_non_nullable
              as double,
      preferences: null == preferences
          ? _value._preferences
          : preferences // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      metadata: null == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AppUserImpl extends _AppUser {
  const _$AppUserImpl(
      {required this.uid,
      required this.email,
      required this.name,
      this.photoUrl,
      required this.role,
      required this.organizationId,
      this.hierarchyId,
      final List<String> permissions = const [],
      final Map<String, dynamic> roleData = const {},
      this.isActive = true,
      this.status = 'pending',
      @TimestampConverter() this.createdAt,
      @TimestampConverter() this.lastLogin,
      @TimestampConverter() this.lastSynced,
      @TimestampConverter() this.requestedAt,
      @TimestampConverter() this.approvedAt,
      @TimestampConverter() this.rejectedAt,
      @TimestampConverter() this.suspendedAt,
      this.approvedBy,
      this.rejectedBy,
      this.suspendedBy,
      this.rejectionReason,
      this.suspensionReason,
      this.tenantId,
      final Map<String, dynamic> organizationSettings = const {},
      @TimestampConverter() this.passwordLastChanged,
      @TimestampConverter() this.termsAcceptedAt,
      this.preferredLanguage,
      final List<String> deviceTokens = const [],
      this.isEmailVerified = false,
      this.isPhoneVerified = false,
      this.profileCompleteness = 0.0,
      final Map<String, dynamic> preferences = const {},
      final Map<String, dynamic> metadata = const {}})
      : _permissions = permissions,
        _roleData = roleData,
        _organizationSettings = organizationSettings,
        _deviceTokens = deviceTokens,
        _preferences = preferences,
        _metadata = metadata,
        super._();

  factory _$AppUserImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppUserImplFromJson(json);

// Core user information
  @override
  final String uid;
  @override
  final String email;
  @override
  final String name;
  @override
  final String? photoUrl;
// Role and organization
  @override
  final DynamicRole role;
  @override
  final String organizationId;
  @override
  final String? hierarchyId;
// Permissions and role data
  final List<String> _permissions;
// Permissions and role data
  @override
  @JsonKey()
  List<String> get permissions {
    if (_permissions is EqualUnmodifiableListView) return _permissions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_permissions);
  }

  final Map<String, dynamic> _roleData;
  @override
  @JsonKey()
  Map<String, dynamic> get roleData {
    if (_roleData is EqualUnmodifiableMapView) return _roleData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_roleData);
  }

// User status and lifecycle
  @override
  @JsonKey()
  final bool isActive;
  @override
  @JsonKey()
  final String status;
// pending, approved, rejected, suspended
// Timestamps for audit trail - Using TimestampConverter for Firestore compatibility
  @override
  @TimestampConverter()
  final DateTime? createdAt;
  @override
  @TimestampConverter()
  final DateTime? lastLogin;
  @override
  @TimestampConverter()
  final DateTime? lastSynced;
  @override
  @TimestampConverter()
  final DateTime? requestedAt;
// When user registration was requested
  @override
  @TimestampConverter()
  final DateTime? approvedAt;
// When user was approved
  @override
  @TimestampConverter()
  final DateTime? rejectedAt;
// When user was rejected
  @override
  @TimestampConverter()
  final DateTime? suspendedAt;
// When user was suspended
// Approval workflow fields
  @override
  final String? approvedBy;
// UID of user who approved
  @override
  final String? rejectedBy;
// UID of user who rejected
  @override
  final String? suspendedBy;
// UID of user who suspended
  @override
  final String? rejectionReason;
// Reason for rejection
  @override
  final String? suspensionReason;
// Reason for suspension
// Multi-tenant specific fields
  @override
  final String? tenantId;
// Additional tenant identifier if needed
  final Map<String, dynamic> _organizationSettings;
// Additional tenant identifier if needed
  @override
  @JsonKey()
  Map<String, dynamic> get organizationSettings {
    if (_organizationSettings is EqualUnmodifiableMapView)
      return _organizationSettings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_organizationSettings);
  }

// Org-specific user settings
// Security and compliance
  @override
  @TimestampConverter()
  final DateTime? passwordLastChanged;
  @override
  @TimestampConverter()
  final DateTime? termsAcceptedAt;
  @override
  final String? preferredLanguage;
  final List<String> _deviceTokens;
  @override
  @JsonKey()
  List<String> get deviceTokens {
    if (_deviceTokens is EqualUnmodifiableListView) return _deviceTokens;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_deviceTokens);
  }

// For push notifications
// Profile completeness and verification
  @override
  @JsonKey()
  final bool isEmailVerified;
  @override
  @JsonKey()
  final bool isPhoneVerified;
  @override
  @JsonKey()
  final double profileCompleteness;
// 0.0 to 1.0
// User preferences
  final Map<String, dynamic> _preferences;
// 0.0 to 1.0
// User preferences
  @override
  @JsonKey()
  Map<String, dynamic> get preferences {
    if (_preferences is EqualUnmodifiableMapView) return _preferences;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_preferences);
  }

  final Map<String, dynamic> _metadata;
  @override
  @JsonKey()
  Map<String, dynamic> get metadata {
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_metadata);
  }

  @override
  String toString() {
    return 'AppUser(uid: $uid, email: $email, name: $name, photoUrl: $photoUrl, role: $role, organizationId: $organizationId, hierarchyId: $hierarchyId, permissions: $permissions, roleData: $roleData, isActive: $isActive, status: $status, createdAt: $createdAt, lastLogin: $lastLogin, lastSynced: $lastSynced, requestedAt: $requestedAt, approvedAt: $approvedAt, rejectedAt: $rejectedAt, suspendedAt: $suspendedAt, approvedBy: $approvedBy, rejectedBy: $rejectedBy, suspendedBy: $suspendedBy, rejectionReason: $rejectionReason, suspensionReason: $suspensionReason, tenantId: $tenantId, organizationSettings: $organizationSettings, passwordLastChanged: $passwordLastChanged, termsAcceptedAt: $termsAcceptedAt, preferredLanguage: $preferredLanguage, deviceTokens: $deviceTokens, isEmailVerified: $isEmailVerified, isPhoneVerified: $isPhoneVerified, profileCompleteness: $profileCompleteness, preferences: $preferences, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppUserImpl &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.photoUrl, photoUrl) ||
                other.photoUrl == photoUrl) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.organizationId, organizationId) ||
                other.organizationId == organizationId) &&
            (identical(other.hierarchyId, hierarchyId) ||
                other.hierarchyId == hierarchyId) &&
            const DeepCollectionEquality()
                .equals(other._permissions, _permissions) &&
            const DeepCollectionEquality().equals(other._roleData, _roleData) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.lastLogin, lastLogin) ||
                other.lastLogin == lastLogin) &&
            (identical(other.lastSynced, lastSynced) ||
                other.lastSynced == lastSynced) &&
            (identical(other.requestedAt, requestedAt) ||
                other.requestedAt == requestedAt) &&
            (identical(other.approvedAt, approvedAt) ||
                other.approvedAt == approvedAt) &&
            (identical(other.rejectedAt, rejectedAt) ||
                other.rejectedAt == rejectedAt) &&
            (identical(other.suspendedAt, suspendedAt) ||
                other.suspendedAt == suspendedAt) &&
            (identical(other.approvedBy, approvedBy) ||
                other.approvedBy == approvedBy) &&
            (identical(other.rejectedBy, rejectedBy) ||
                other.rejectedBy == rejectedBy) &&
            (identical(other.suspendedBy, suspendedBy) ||
                other.suspendedBy == suspendedBy) &&
            (identical(other.rejectionReason, rejectionReason) ||
                other.rejectionReason == rejectionReason) &&
            (identical(other.suspensionReason, suspensionReason) ||
                other.suspensionReason == suspensionReason) &&
            (identical(other.tenantId, tenantId) ||
                other.tenantId == tenantId) &&
            const DeepCollectionEquality()
                .equals(other._organizationSettings, _organizationSettings) &&
            (identical(other.passwordLastChanged, passwordLastChanged) ||
                other.passwordLastChanged == passwordLastChanged) &&
            (identical(other.termsAcceptedAt, termsAcceptedAt) ||
                other.termsAcceptedAt == termsAcceptedAt) &&
            (identical(other.preferredLanguage, preferredLanguage) ||
                other.preferredLanguage == preferredLanguage) &&
            const DeepCollectionEquality()
                .equals(other._deviceTokens, _deviceTokens) &&
            (identical(other.isEmailVerified, isEmailVerified) ||
                other.isEmailVerified == isEmailVerified) &&
            (identical(other.isPhoneVerified, isPhoneVerified) ||
                other.isPhoneVerified == isPhoneVerified) &&
            (identical(other.profileCompleteness, profileCompleteness) ||
                other.profileCompleteness == profileCompleteness) &&
            const DeepCollectionEquality()
                .equals(other._preferences, _preferences) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        uid,
        email,
        name,
        photoUrl,
        role,
        organizationId,
        hierarchyId,
        const DeepCollectionEquality().hash(_permissions),
        const DeepCollectionEquality().hash(_roleData),
        isActive,
        status,
        createdAt,
        lastLogin,
        lastSynced,
        requestedAt,
        approvedAt,
        rejectedAt,
        suspendedAt,
        approvedBy,
        rejectedBy,
        suspendedBy,
        rejectionReason,
        suspensionReason,
        tenantId,
        const DeepCollectionEquality().hash(_organizationSettings),
        passwordLastChanged,
        termsAcceptedAt,
        preferredLanguage,
        const DeepCollectionEquality().hash(_deviceTokens),
        isEmailVerified,
        isPhoneVerified,
        profileCompleteness,
        const DeepCollectionEquality().hash(_preferences),
        const DeepCollectionEquality().hash(_metadata)
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AppUserImplCopyWith<_$AppUserImpl> get copyWith =>
      __$$AppUserImplCopyWithImpl<_$AppUserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AppUserImplToJson(
      this,
    );
  }
}

abstract class _AppUser extends AppUser {
  const factory _AppUser(
      {required final String uid,
      required final String email,
      required final String name,
      final String? photoUrl,
      required final DynamicRole role,
      required final String organizationId,
      final String? hierarchyId,
      final List<String> permissions,
      final Map<String, dynamic> roleData,
      final bool isActive,
      final String status,
      @TimestampConverter() final DateTime? createdAt,
      @TimestampConverter() final DateTime? lastLogin,
      @TimestampConverter() final DateTime? lastSynced,
      @TimestampConverter() final DateTime? requestedAt,
      @TimestampConverter() final DateTime? approvedAt,
      @TimestampConverter() final DateTime? rejectedAt,
      @TimestampConverter() final DateTime? suspendedAt,
      final String? approvedBy,
      final String? rejectedBy,
      final String? suspendedBy,
      final String? rejectionReason,
      final String? suspensionReason,
      final String? tenantId,
      final Map<String, dynamic> organizationSettings,
      @TimestampConverter() final DateTime? passwordLastChanged,
      @TimestampConverter() final DateTime? termsAcceptedAt,
      final String? preferredLanguage,
      final List<String> deviceTokens,
      final bool isEmailVerified,
      final bool isPhoneVerified,
      final double profileCompleteness,
      final Map<String, dynamic> preferences,
      final Map<String, dynamic> metadata}) = _$AppUserImpl;
  const _AppUser._() : super._();

  factory _AppUser.fromJson(Map<String, dynamic> json) = _$AppUserImpl.fromJson;

  @override // Core user information
  String get uid;
  @override
  String get email;
  @override
  String get name;
  @override
  String? get photoUrl;
  @override // Role and organization
  DynamicRole get role;
  @override
  String get organizationId;
  @override
  String? get hierarchyId;
  @override // Permissions and role data
  List<String> get permissions;
  @override
  Map<String, dynamic> get roleData;
  @override // User status and lifecycle
  bool get isActive;
  @override
  String get status;
  @override // pending, approved, rejected, suspended
// Timestamps for audit trail - Using TimestampConverter for Firestore compatibility
  @TimestampConverter()
  DateTime? get createdAt;
  @override
  @TimestampConverter()
  DateTime? get lastLogin;
  @override
  @TimestampConverter()
  DateTime? get lastSynced;
  @override
  @TimestampConverter()
  DateTime? get requestedAt;
  @override // When user registration was requested
  @TimestampConverter()
  DateTime? get approvedAt;
  @override // When user was approved
  @TimestampConverter()
  DateTime? get rejectedAt;
  @override // When user was rejected
  @TimestampConverter()
  DateTime? get suspendedAt;
  @override // When user was suspended
// Approval workflow fields
  String? get approvedBy;
  @override // UID of user who approved
  String? get rejectedBy;
  @override // UID of user who rejected
  String? get suspendedBy;
  @override // UID of user who suspended
  String? get rejectionReason;
  @override // Reason for rejection
  String? get suspensionReason;
  @override // Reason for suspension
// Multi-tenant specific fields
  String? get tenantId;
  @override // Additional tenant identifier if needed
  Map<String, dynamic> get organizationSettings;
  @override // Org-specific user settings
// Security and compliance
  @TimestampConverter()
  DateTime? get passwordLastChanged;
  @override
  @TimestampConverter()
  DateTime? get termsAcceptedAt;
  @override
  String? get preferredLanguage;
  @override
  List<String> get deviceTokens;
  @override // For push notifications
// Profile completeness and verification
  bool get isEmailVerified;
  @override
  bool get isPhoneVerified;
  @override
  double get profileCompleteness;
  @override // 0.0 to 1.0
// User preferences
  Map<String, dynamic> get preferences;
  @override
  Map<String, dynamic> get metadata;
  @override
  @JsonKey(ignore: true)
  _$$AppUserImplCopyWith<_$AppUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
