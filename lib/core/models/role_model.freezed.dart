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
  List<String> get inheritedRoles => throw _privateConstructorUsedError;
  Map<String, dynamic> get constraints => throw _privateConstructorUsedError;
  bool get isSystemRole => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  int get priority =>
      throw _privateConstructorUsedError; // Higher number = higher priority
  String? get createdBy => throw _privateConstructorUsedError;
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
      List<String> inheritedRoles,
      Map<String, dynamic> constraints,
      bool isSystemRole,
      bool isActive,
      int priority,
      String? createdBy,
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
    Object? inheritedRoles = null,
    Object? constraints = null,
    Object? isSystemRole = null,
    Object? isActive = null,
    Object? priority = null,
    Object? createdBy = freezed,
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
      inheritedRoles: null == inheritedRoles
          ? _value.inheritedRoles
          : inheritedRoles // ignore: cast_nullable_to_non_nullable
              as List<String>,
      constraints: null == constraints
          ? _value.constraints
          : constraints // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      isSystemRole: null == isSystemRole
          ? _value.isSystemRole
          : isSystemRole // ignore: cast_nullable_to_non_nullable
              as bool,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as int,
      createdBy: freezed == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String?,
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
      List<String> inheritedRoles,
      Map<String, dynamic> constraints,
      bool isSystemRole,
      bool isActive,
      int priority,
      String? createdBy,
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
    Object? inheritedRoles = null,
    Object? constraints = null,
    Object? isSystemRole = null,
    Object? isActive = null,
    Object? priority = null,
    Object? createdBy = freezed,
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
      inheritedRoles: null == inheritedRoles
          ? _value._inheritedRoles
          : inheritedRoles // ignore: cast_nullable_to_non_nullable
              as List<String>,
      constraints: null == constraints
          ? _value._constraints
          : constraints // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      isSystemRole: null == isSystemRole
          ? _value.isSystemRole
          : isSystemRole // ignore: cast_nullable_to_non_nullable
              as bool,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as int,
      createdBy: freezed == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String?,
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
class _$RoleModelImpl extends _RoleModel {
  const _$RoleModelImpl(
      {required this.id,
      required this.organizationId,
      required this.name,
      this.description,
      required final List<String> permissions,
      required this.scopeLevel,
      final List<String> inheritedRoles = const [],
      final Map<String, dynamic> constraints = const {},
      this.isSystemRole = false,
      this.isActive = true,
      this.priority = 100,
      this.createdBy,
      @TimestampConverter() this.createdAt,
      @TimestampConverter() this.updatedAt})
      : _permissions = permissions,
        _inheritedRoles = inheritedRoles,
        _constraints = constraints,
        super._();

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
  final List<String> _inheritedRoles;
// 'organization', 'department', 'team', 'individual'
  @override
  @JsonKey()
  List<String> get inheritedRoles {
    if (_inheritedRoles is EqualUnmodifiableListView) return _inheritedRoles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_inheritedRoles);
  }

  final Map<String, dynamic> _constraints;
  @override
  @JsonKey()
  Map<String, dynamic> get constraints {
    if (_constraints is EqualUnmodifiableMapView) return _constraints;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_constraints);
  }

  @override
  @JsonKey()
  final bool isSystemRole;
  @override
  @JsonKey()
  final bool isActive;
  @override
  @JsonKey()
  final int priority;
// Higher number = higher priority
  @override
  final String? createdBy;
  @override
  @TimestampConverter()
  final DateTime? createdAt;
  @override
  @TimestampConverter()
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'RoleModel(id: $id, organizationId: $organizationId, name: $name, description: $description, permissions: $permissions, scopeLevel: $scopeLevel, inheritedRoles: $inheritedRoles, constraints: $constraints, isSystemRole: $isSystemRole, isActive: $isActive, priority: $priority, createdBy: $createdBy, createdAt: $createdAt, updatedAt: $updatedAt)';
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
            const DeepCollectionEquality()
                .equals(other._inheritedRoles, _inheritedRoles) &&
            const DeepCollectionEquality()
                .equals(other._constraints, _constraints) &&
            (identical(other.isSystemRole, isSystemRole) ||
                other.isSystemRole == isSystemRole) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
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
      const DeepCollectionEquality().hash(_inheritedRoles),
      const DeepCollectionEquality().hash(_constraints),
      isSystemRole,
      isActive,
      priority,
      createdBy,
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

abstract class _RoleModel extends RoleModel {
  const factory _RoleModel(
      {required final String id,
      required final String organizationId,
      required final String name,
      final String? description,
      required final List<String> permissions,
      required final String scopeLevel,
      final List<String> inheritedRoles,
      final Map<String, dynamic> constraints,
      final bool isSystemRole,
      final bool isActive,
      final int priority,
      final String? createdBy,
      @TimestampConverter() final DateTime? createdAt,
      @TimestampConverter() final DateTime? updatedAt}) = _$RoleModelImpl;
  const _RoleModel._() : super._();

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
  List<String> get inheritedRoles;
  @override
  Map<String, dynamic> get constraints;
  @override
  bool get isSystemRole;
  @override
  bool get isActive;
  @override
  int get priority;
  @override // Higher number = higher priority
  String? get createdBy;
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
  String? get description => throw _privateConstructorUsedError;
  String get ruleType =>
      throw _privateConstructorUsedError; // 'static', 'dynamic', 'contextual', 'time_based'
  Map<String, dynamic> get conditions => throw _privateConstructorUsedError;
  List<String> get permissions => throw _privateConstructorUsedError;
  Map<String, dynamic> get parameters => throw _privateConstructorUsedError;
  int get priority => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  String? get createdBy => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get updatedAt => throw _privateConstructorUsedError;

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
      String? description,
      String ruleType,
      Map<String, dynamic> conditions,
      List<String> permissions,
      Map<String, dynamic> parameters,
      int priority,
      bool isActive,
      String? createdBy,
      @TimestampConverter() DateTime? createdAt,
      @TimestampConverter() DateTime? updatedAt});
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
    Object? description = freezed,
    Object? ruleType = null,
    Object? conditions = null,
    Object? permissions = null,
    Object? parameters = null,
    Object? priority = null,
    Object? isActive = null,
    Object? createdBy = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
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
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
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
      parameters: null == parameters
          ? _value.parameters
          : parameters // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as int,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      createdBy: freezed == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String?,
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
      String? description,
      String ruleType,
      Map<String, dynamic> conditions,
      List<String> permissions,
      Map<String, dynamic> parameters,
      int priority,
      bool isActive,
      String? createdBy,
      @TimestampConverter() DateTime? createdAt,
      @TimestampConverter() DateTime? updatedAt});
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
    Object? description = freezed,
    Object? ruleType = null,
    Object? conditions = null,
    Object? permissions = null,
    Object? parameters = null,
    Object? priority = null,
    Object? isActive = null,
    Object? createdBy = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
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
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
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
      parameters: null == parameters
          ? _value._parameters
          : parameters // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as int,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      createdBy: freezed == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String?,
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
class _$PermissionPolicyImpl extends _PermissionPolicy {
  const _$PermissionPolicyImpl(
      {required this.id,
      required this.name,
      this.description,
      required this.ruleType,
      required final Map<String, dynamic> conditions,
      required final List<String> permissions,
      final Map<String, dynamic> parameters = const {},
      this.priority = 100,
      this.isActive = true,
      this.createdBy,
      @TimestampConverter() this.createdAt,
      @TimestampConverter() this.updatedAt})
      : _conditions = conditions,
        _permissions = permissions,
        _parameters = parameters,
        super._();

  factory _$PermissionPolicyImpl.fromJson(Map<String, dynamic> json) =>
      _$$PermissionPolicyImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String? description;
  @override
  final String ruleType;
// 'static', 'dynamic', 'contextual', 'time_based'
  final Map<String, dynamic> _conditions;
// 'static', 'dynamic', 'contextual', 'time_based'
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

  final Map<String, dynamic> _parameters;
  @override
  @JsonKey()
  Map<String, dynamic> get parameters {
    if (_parameters is EqualUnmodifiableMapView) return _parameters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_parameters);
  }

  @override
  @JsonKey()
  final int priority;
  @override
  @JsonKey()
  final bool isActive;
  @override
  final String? createdBy;
  @override
  @TimestampConverter()
  final DateTime? createdAt;
  @override
  @TimestampConverter()
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'PermissionPolicy(id: $id, name: $name, description: $description, ruleType: $ruleType, conditions: $conditions, permissions: $permissions, parameters: $parameters, priority: $priority, isActive: $isActive, createdBy: $createdBy, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PermissionPolicyImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.ruleType, ruleType) ||
                other.ruleType == ruleType) &&
            const DeepCollectionEquality()
                .equals(other._conditions, _conditions) &&
            const DeepCollectionEquality()
                .equals(other._permissions, _permissions) &&
            const DeepCollectionEquality()
                .equals(other._parameters, _parameters) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
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
      name,
      description,
      ruleType,
      const DeepCollectionEquality().hash(_conditions),
      const DeepCollectionEquality().hash(_permissions),
      const DeepCollectionEquality().hash(_parameters),
      priority,
      isActive,
      createdBy,
      createdAt,
      updatedAt);

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

abstract class _PermissionPolicy extends PermissionPolicy {
  const factory _PermissionPolicy(
          {required final String id,
          required final String name,
          final String? description,
          required final String ruleType,
          required final Map<String, dynamic> conditions,
          required final List<String> permissions,
          final Map<String, dynamic> parameters,
          final int priority,
          final bool isActive,
          final String? createdBy,
          @TimestampConverter() final DateTime? createdAt,
          @TimestampConverter() final DateTime? updatedAt}) =
      _$PermissionPolicyImpl;
  const _PermissionPolicy._() : super._();

  factory _PermissionPolicy.fromJson(Map<String, dynamic> json) =
      _$PermissionPolicyImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String? get description;
  @override
  String get ruleType;
  @override // 'static', 'dynamic', 'contextual', 'time_based'
  Map<String, dynamic> get conditions;
  @override
  List<String> get permissions;
  @override
  Map<String, dynamic> get parameters;
  @override
  int get priority;
  @override
  bool get isActive;
  @override
  String? get createdBy;
  @override
  @TimestampConverter()
  DateTime? get createdAt;
  @override
  @TimestampConverter()
  DateTime? get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$PermissionPolicyImplCopyWith<_$PermissionPolicyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserPermission _$UserPermissionFromJson(Map<String, dynamic> json) {
  return _UserPermission.fromJson(json);
}

/// @nodoc
mixin _$UserPermission {
  String get userId => throw _privateConstructorUsedError;
  String get permission => throw _privateConstructorUsedError;
  String get grantedBy => throw _privateConstructorUsedError;
  String? get reason => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get expiresAt => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get grantedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserPermissionCopyWith<UserPermission> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserPermissionCopyWith<$Res> {
  factory $UserPermissionCopyWith(
          UserPermission value, $Res Function(UserPermission) then) =
      _$UserPermissionCopyWithImpl<$Res, UserPermission>;
  @useResult
  $Res call(
      {String userId,
      String permission,
      String grantedBy,
      String? reason,
      @TimestampConverter() DateTime? expiresAt,
      @TimestampConverter() DateTime? grantedAt});
}

/// @nodoc
class _$UserPermissionCopyWithImpl<$Res, $Val extends UserPermission>
    implements $UserPermissionCopyWith<$Res> {
  _$UserPermissionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? permission = null,
    Object? grantedBy = null,
    Object? reason = freezed,
    Object? expiresAt = freezed,
    Object? grantedAt = freezed,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      permission: null == permission
          ? _value.permission
          : permission // ignore: cast_nullable_to_non_nullable
              as String,
      grantedBy: null == grantedBy
          ? _value.grantedBy
          : grantedBy // ignore: cast_nullable_to_non_nullable
              as String,
      reason: freezed == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String?,
      expiresAt: freezed == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      grantedAt: freezed == grantedAt
          ? _value.grantedAt
          : grantedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserPermissionImplCopyWith<$Res>
    implements $UserPermissionCopyWith<$Res> {
  factory _$$UserPermissionImplCopyWith(_$UserPermissionImpl value,
          $Res Function(_$UserPermissionImpl) then) =
      __$$UserPermissionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String userId,
      String permission,
      String grantedBy,
      String? reason,
      @TimestampConverter() DateTime? expiresAt,
      @TimestampConverter() DateTime? grantedAt});
}

/// @nodoc
class __$$UserPermissionImplCopyWithImpl<$Res>
    extends _$UserPermissionCopyWithImpl<$Res, _$UserPermissionImpl>
    implements _$$UserPermissionImplCopyWith<$Res> {
  __$$UserPermissionImplCopyWithImpl(
      _$UserPermissionImpl _value, $Res Function(_$UserPermissionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? permission = null,
    Object? grantedBy = null,
    Object? reason = freezed,
    Object? expiresAt = freezed,
    Object? grantedAt = freezed,
  }) {
    return _then(_$UserPermissionImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      permission: null == permission
          ? _value.permission
          : permission // ignore: cast_nullable_to_non_nullable
              as String,
      grantedBy: null == grantedBy
          ? _value.grantedBy
          : grantedBy // ignore: cast_nullable_to_non_nullable
              as String,
      reason: freezed == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String?,
      expiresAt: freezed == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      grantedAt: freezed == grantedAt
          ? _value.grantedAt
          : grantedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserPermissionImpl extends _UserPermission {
  const _$UserPermissionImpl(
      {required this.userId,
      required this.permission,
      required this.grantedBy,
      this.reason,
      @TimestampConverter() this.expiresAt,
      @TimestampConverter() this.grantedAt})
      : super._();

  factory _$UserPermissionImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserPermissionImplFromJson(json);

  @override
  final String userId;
  @override
  final String permission;
  @override
  final String grantedBy;
  @override
  final String? reason;
  @override
  @TimestampConverter()
  final DateTime? expiresAt;
  @override
  @TimestampConverter()
  final DateTime? grantedAt;

  @override
  String toString() {
    return 'UserPermission(userId: $userId, permission: $permission, grantedBy: $grantedBy, reason: $reason, expiresAt: $expiresAt, grantedAt: $grantedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserPermissionImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.permission, permission) ||
                other.permission == permission) &&
            (identical(other.grantedBy, grantedBy) ||
                other.grantedBy == grantedBy) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt) &&
            (identical(other.grantedAt, grantedAt) ||
                other.grantedAt == grantedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, userId, permission, grantedBy, reason, expiresAt, grantedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserPermissionImplCopyWith<_$UserPermissionImpl> get copyWith =>
      __$$UserPermissionImplCopyWithImpl<_$UserPermissionImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserPermissionImplToJson(
      this,
    );
  }
}

abstract class _UserPermission extends UserPermission {
  const factory _UserPermission(
      {required final String userId,
      required final String permission,
      required final String grantedBy,
      final String? reason,
      @TimestampConverter() final DateTime? expiresAt,
      @TimestampConverter() final DateTime? grantedAt}) = _$UserPermissionImpl;
  const _UserPermission._() : super._();

  factory _UserPermission.fromJson(Map<String, dynamic> json) =
      _$UserPermissionImpl.fromJson;

  @override
  String get userId;
  @override
  String get permission;
  @override
  String get grantedBy;
  @override
  String? get reason;
  @override
  @TimestampConverter()
  DateTime? get expiresAt;
  @override
  @TimestampConverter()
  DateTime? get grantedAt;
  @override
  @JsonKey(ignore: true)
  _$$UserPermissionImplCopyWith<_$UserPermissionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
