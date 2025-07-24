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
  String get uid => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get photoUrl =>
      throw _privateConstructorUsedError; // Replace hardcoded role with dynamic role
  DynamicRole get role => throw _privateConstructorUsedError;
  String get organizationId => throw _privateConstructorUsedError;
  String? get hierarchyId => throw _privateConstructorUsedError;
  List<String> get permissions =>
      throw _privateConstructorUsedError; // ← Fix generic type
  Map<String, dynamic> get roleData =>
      throw _privateConstructorUsedError; // ← Fix generic type
  DateTime? get lastLogin => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  DateTime? get lastSynced => throw _privateConstructorUsedError;

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
      DateTime? lastLogin,
      bool isActive,
      DateTime? lastSynced});

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
    Object? lastLogin = freezed,
    Object? isActive = null,
    Object? lastSynced = freezed,
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
      lastLogin: freezed == lastLogin
          ? _value.lastLogin
          : lastLogin // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      lastSynced: freezed == lastSynced
          ? _value.lastSynced
          : lastSynced // ignore: cast_nullable_to_non_nullable
              as DateTime?,
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
      DateTime? lastLogin,
      bool isActive,
      DateTime? lastSynced});

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
    Object? lastLogin = freezed,
    Object? isActive = null,
    Object? lastSynced = freezed,
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
      lastLogin: freezed == lastLogin
          ? _value.lastLogin
          : lastLogin // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      lastSynced: freezed == lastSynced
          ? _value.lastSynced
          : lastSynced // ignore: cast_nullable_to_non_nullable
              as DateTime?,
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
      this.lastLogin,
      this.isActive = true,
      this.lastSynced})
      : _permissions = permissions,
        _roleData = roleData,
        super._();

  factory _$AppUserImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppUserImplFromJson(json);

  @override
  final String uid;
  @override
  final String email;
  @override
  final String name;
  @override
  final String? photoUrl;
// Replace hardcoded role with dynamic role
  @override
  final DynamicRole role;
  @override
  final String organizationId;
  @override
  final String? hierarchyId;
  final List<String> _permissions;
  @override
  @JsonKey()
  List<String> get permissions {
    if (_permissions is EqualUnmodifiableListView) return _permissions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_permissions);
  }

// ← Fix generic type
  final Map<String, dynamic> _roleData;
// ← Fix generic type
  @override
  @JsonKey()
  Map<String, dynamic> get roleData {
    if (_roleData is EqualUnmodifiableMapView) return _roleData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_roleData);
  }

// ← Fix generic type
  @override
  final DateTime? lastLogin;
  @override
  @JsonKey()
  final bool isActive;
  @override
  final DateTime? lastSynced;

  @override
  String toString() {
    return 'AppUser(uid: $uid, email: $email, name: $name, photoUrl: $photoUrl, role: $role, organizationId: $organizationId, hierarchyId: $hierarchyId, permissions: $permissions, roleData: $roleData, lastLogin: $lastLogin, isActive: $isActive, lastSynced: $lastSynced)';
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
            (identical(other.lastLogin, lastLogin) ||
                other.lastLogin == lastLogin) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.lastSynced, lastSynced) ||
                other.lastSynced == lastSynced));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
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
      lastLogin,
      isActive,
      lastSynced);

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
      final DateTime? lastLogin,
      final bool isActive,
      final DateTime? lastSynced}) = _$AppUserImpl;
  const _AppUser._() : super._();

  factory _AppUser.fromJson(Map<String, dynamic> json) = _$AppUserImpl.fromJson;

  @override
  String get uid;
  @override
  String get email;
  @override
  String get name;
  @override
  String? get photoUrl;
  @override // Replace hardcoded role with dynamic role
  DynamicRole get role;
  @override
  String get organizationId;
  @override
  String? get hierarchyId;
  @override
  List<String> get permissions;
  @override // ← Fix generic type
  Map<String, dynamic> get roleData;
  @override // ← Fix generic type
  DateTime? get lastLogin;
  @override
  bool get isActive;
  @override
  DateTime? get lastSynced;
  @override
  @JsonKey(ignore: true)
  _$$AppUserImplCopyWith<_$AppUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
