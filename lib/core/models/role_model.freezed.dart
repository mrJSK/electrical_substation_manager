// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'role_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RoleModel _$RoleModelFromJson(Map<String, dynamic> json) {
  return _RoleModel.fromJson(json);
}

/// @nodoc
mixin _$RoleModel {
  String get id => throw _privateConstructorUsedError;
  String get organizationId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  List<String> get permissions => throw _privateConstructorUsedError;
  String get scopeLevel =>
      throw _privateConstructorUsedError; // 'organization', 'department', 'team', 'individual'
  bool get isSystemRole => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RoleModelCopyWith<RoleModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RoleModelCopyWith<$Res> {
  factory $RoleModelCopyWith(RoleModel value, $Res Function(RoleModel) then) =
      _$RoleModelCopyWithImpl<$Res, RoleModel>;
  @useResult
  $Res call(
      {String id,
      String organizationId,
      String name,
      String? description,
      List<String> permissions,
      String scopeLevel,
      bool isSystemRole,
      bool isActive,
      @TimestampConverter() DateTime? createdAt,
      @TimestampConverter() DateTime? updatedAt});
}

/// @nodoc
class _$RoleModelCopyWithImpl<$Res, $Val extends RoleModel>
    implements $RoleModelCopyWith<$Res> {
  _$RoleModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? organizationId = null,
    Object? name = null,
    Object? description = freezed,
    Object? permissions = null,
    Object? scopeLevel = null,
    Object? isSystemRole = null,
    Object? isActive = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      organizationId: null == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      permissions: null == permissions
          ? _value.permissions
          : permissions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      scopeLevel: null == scopeLevel
          ? _value.scopeLevel
          : scopeLevel // ignore: cast_nullable_to_non_nullable
              as String,
      isSystemRole: null == isSystemRole
          ? _value.isSystemRole
          : isSystemRole // ignore: cast_nullable_to_non_nullable
              as bool,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RoleModelImplCopyWith<$Res>
    implements $RoleModelCopyWith<$Res> {
  factory _$$RoleModelImplCopyWith(
          _$RoleModelImpl value, $Res Function(_$RoleModelImpl) then) =
      __$$RoleModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String organizationId,
      String name,
      String? description,
      List<String> permissions,
      String scopeLevel,
      bool isSystemRole,
      bool isActive,
      @TimestampConverter() DateTime? createdAt,
      @TimestampConverter() DateTime? updatedAt});
}

/// @nodoc
class __$$RoleModelImplCopyWithImpl<$Res>
    extends _$RoleModelCopyWithImpl<$Res, _$RoleModelImpl>
    implements _$$RoleModelImplCopyWith<$Res> {
  __$$RoleModelImplCopyWithImpl(
      _$RoleModelImpl _value, $Res Function(_$RoleModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? organizationId = null,
    Object? name = null,
    Object? description = freezed,
    Object? permissions = null,
    Object? scopeLevel = null,
    Object? isSystemRole = null,
    Object? isActive = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$RoleModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      organizationId: null == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      permissions: null == permissions
          ? _value._permissions
          : permissions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      scopeLevel: null == scopeLevel
          ? _value.scopeLevel
          : scopeLevel // ignore: cast_nullable_to_non_nullable
              as String,
      isSystemRole: null == isSystemRole
          ? _value.isSystemRole
          : isSystemRole // ignore: cast_nullable_to_non_nullable
              as bool,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RoleModelImpl implements _RoleModel {
  const _$RoleModelImpl(
      {required this.id,
      required this.organizationId,
      required this.name,
      this.description,
      required final List<String> permissions,
      required this.scopeLevel,
      this.isSystemRole = false,
      this.isActive = true,
      @TimestampConverter() this.createdAt,
      @TimestampConverter() this.updatedAt})
      : _permissions = permissions;

  factory _$RoleModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$RoleModelImplFromJson(json);

  @override
  final String id;
  @override
  final String organizationId;
  @override
  final String name;
  @override
  final String? description;
  final List<String> _permissions;
  @override
  List<String> get permissions {
    if (_permissions is EqualUnmodifiableListView) return _permissions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_permissions);
  }

  @override
  final String scopeLevel;
// 'organization', 'department', 'team', 'individual'
  @override
  @JsonKey()
  final bool isSystemRole;
  @override
  @JsonKey()
  final bool isActive;
  @override
  @TimestampConverter()
  final DateTime? createdAt;
  @override
  @TimestampConverter()
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'RoleModel(id: $id, organizationId: $organizationId, name: $name, description: $description, permissions: $permissions, scopeLevel: $scopeLevel, isSystemRole: $isSystemRole, isActive: $isActive, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RoleModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.organizationId, organizationId) ||
                other.organizationId == organizationId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality()
                .equals(other._permissions, _permissions) &&
            (identical(other.scopeLevel, scopeLevel) ||
                other.scopeLevel == scopeLevel) &&
            (identical(other.isSystemRole, isSystemRole) ||
                other.isSystemRole == isSystemRole) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      organizationId,
      name,
      description,
      const DeepCollectionEquality().hash(_permissions),
      scopeLevel,
      isSystemRole,
      isActive,
      createdAt,
      updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RoleModelImplCopyWith<_$RoleModelImpl> get copyWith =>
      __$$RoleModelImplCopyWithImpl<_$RoleModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RoleModelImplToJson(
      this,
    );
  }
}

abstract class _RoleModel implements RoleModel {
  const factory _RoleModel(
      {required final String id,
      required final String organizationId,
      required final String name,
      final String? description,
      required final List<String> permissions,
      required final String scopeLevel,
      final bool isSystemRole,
      final bool isActive,
      @TimestampConverter() final DateTime? createdAt,
      @TimestampConverter() final DateTime? updatedAt}) = _$RoleModelImpl;

  factory _RoleModel.fromJson(Map<String, dynamic> json) =
      _$RoleModelImpl.fromJson;

  @override
  String get id;
  @override
  String get organizationId;
  @override
  String get name;
  @override
  String? get description;
  @override
  List<String> get permissions;
  @override
  String get scopeLevel;
  @override // 'organization', 'department', 'team', 'individual'
  bool get isSystemRole;
  @override
  bool get isActive;
  @override
  @TimestampConverter()
  DateTime? get createdAt;
  @override
  @TimestampConverter()
  DateTime? get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$RoleModelImplCopyWith<_$RoleModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PermissionPolicy _$PermissionPolicyFromJson(Map<String, dynamic> json) {
  return _PermissionPolicy.fromJson(json);
}

/// @nodoc
mixin _$PermissionPolicy {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get ruleType =>
      throw _privateConstructorUsedError; // 'static', 'dynamic', 'contextual'
  Map<String, dynamic> get conditions => throw _privateConstructorUsedError;
  List<String> get permissions => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PermissionPolicyCopyWith<PermissionPolicy> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PermissionPolicyCopyWith<$Res> {
  factory $PermissionPolicyCopyWith(
          PermissionPolicy value, $Res Function(PermissionPolicy) then) =
      _$PermissionPolicyCopyWithImpl<$Res, PermissionPolicy>;
  @useResult
  $Res call(
      {String id,
      String name,
      String ruleType,
      Map<String, dynamic> conditions,
      List<String> permissions,
      String? description,
      bool isActive,
      @TimestampConverter() DateTime? createdAt});
}

/// @nodoc
class _$PermissionPolicyCopyWithImpl<$Res, $Val extends PermissionPolicy>
    implements $PermissionPolicyCopyWith<$Res> {
  _$PermissionPolicyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? ruleType = null,
    Object? conditions = null,
    Object? permissions = null,
    Object? description = freezed,
    Object? isActive = null,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      ruleType: null == ruleType
          ? _value.ruleType
          : ruleType // ignore: cast_nullable_to_non_nullable
              as String,
      conditions: null == conditions
          ? _value.conditions
          : conditions // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      permissions: null == permissions
          ? _value.permissions
          : permissions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PermissionPolicyImplCopyWith<$Res>
    implements $PermissionPolicyCopyWith<$Res> {
  factory _$$PermissionPolicyImplCopyWith(_$PermissionPolicyImpl value,
          $Res Function(_$PermissionPolicyImpl) then) =
      __$$PermissionPolicyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String ruleType,
      Map<String, dynamic> conditions,
      List<String> permissions,
      String? description,
      bool isActive,
      @TimestampConverter() DateTime? createdAt});
}

/// @nodoc
class __$$PermissionPolicyImplCopyWithImpl<$Res>
    extends _$PermissionPolicyCopyWithImpl<$Res, _$PermissionPolicyImpl>
    implements _$$PermissionPolicyImplCopyWith<$Res> {
  __$$PermissionPolicyImplCopyWithImpl(_$PermissionPolicyImpl _value,
      $Res Function(_$PermissionPolicyImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? ruleType = null,
    Object? conditions = null,
    Object? permissions = null,
    Object? description = freezed,
    Object? isActive = null,
    Object? createdAt = freezed,
  }) {
    return _then(_$PermissionPolicyImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      ruleType: null == ruleType
          ? _value.ruleType
          : ruleType // ignore: cast_nullable_to_non_nullable
              as String,
      conditions: null == conditions
          ? _value._conditions
          : conditions // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      permissions: null == permissions
          ? _value._permissions
          : permissions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PermissionPolicyImpl implements _PermissionPolicy {
  const _$PermissionPolicyImpl(
      {required this.id,
      required this.name,
      required this.ruleType,
      required final Map<String, dynamic> conditions,
      required final List<String> permissions,
      this.description,
      this.isActive = true,
      @TimestampConverter() this.createdAt})
      : _conditions = conditions,
        _permissions = permissions;

  factory _$PermissionPolicyImpl.fromJson(Map<String, dynamic> json) =>
      _$$PermissionPolicyImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String ruleType;
// 'static', 'dynamic', 'contextual'
  final Map<String, dynamic> _conditions;
// 'static', 'dynamic', 'contextual'
  @override
  Map<String, dynamic> get conditions {
    if (_conditions is EqualUnmodifiableMapView) return _conditions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_conditions);
  }

  final List<String> _permissions;
  @override
  List<String> get permissions {
    if (_permissions is EqualUnmodifiableListView) return _permissions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_permissions);
  }

  @override
  final String? description;
  @override
  @JsonKey()
  final bool isActive;
  @override
  @TimestampConverter()
  final DateTime? createdAt;

  @override
  String toString() {
    return 'PermissionPolicy(id: $id, name: $name, ruleType: $ruleType, conditions: $conditions, permissions: $permissions, description: $description, isActive: $isActive, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PermissionPolicyImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.ruleType, ruleType) ||
                other.ruleType == ruleType) &&
            const DeepCollectionEquality()
                .equals(other._conditions, _conditions) &&
            const DeepCollectionEquality()
                .equals(other._permissions, _permissions) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      ruleType,
      const DeepCollectionEquality().hash(_conditions),
      const DeepCollectionEquality().hash(_permissions),
      description,
      isActive,
      createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PermissionPolicyImplCopyWith<_$PermissionPolicyImpl> get copyWith =>
      __$$PermissionPolicyImplCopyWithImpl<_$PermissionPolicyImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PermissionPolicyImplToJson(
      this,
    );
  }
}

abstract class _PermissionPolicy implements PermissionPolicy {
  const factory _PermissionPolicy(
          {required final String id,
          required final String name,
          required final String ruleType,
          required final Map<String, dynamic> conditions,
          required final List<String> permissions,
          final String? description,
          final bool isActive,
          @TimestampConverter() final DateTime? createdAt}) =
      _$PermissionPolicyImpl;

  factory _PermissionPolicy.fromJson(Map<String, dynamic> json) =
      _$PermissionPolicyImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get ruleType;
  @override // 'static', 'dynamic', 'contextual'
  Map<String, dynamic> get conditions;
  @override
  List<String> get permissions;
  @override
  String? get description;
  @override
  bool get isActive;
  @override
  @TimestampConverter()
  DateTime? get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$PermissionPolicyImplCopyWith<_$PermissionPolicyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
