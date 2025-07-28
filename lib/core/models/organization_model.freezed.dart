// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'organization_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

OrganizationModel _$OrganizationModelFromJson(Map<String, dynamic> json) {
  return _OrganizationModel.fromJson(json);
}

/// @nodoc
mixin _$OrganizationModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String get type =>
      throw _privateConstructorUsedError; // 'enterprise', 'department', 'team'
  Map<String, dynamic> get settings => throw _privateConstructorUsedError;
  List<String> get hierarchyLevels => throw _privateConstructorUsedError;
  String? get logoUrl => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OrganizationModelCopyWith<OrganizationModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrganizationModelCopyWith<$Res> {
  factory $OrganizationModelCopyWith(
          OrganizationModel value, $Res Function(OrganizationModel) then) =
      _$OrganizationModelCopyWithImpl<$Res, OrganizationModel>;
  @useResult
  $Res call(
      {String id,
      String name,
      String? description,
      String type,
      Map<String, dynamic> settings,
      List<String> hierarchyLevels,
      String? logoUrl,
      bool isActive,
      @TimestampConverter() DateTime? createdAt,
      @TimestampConverter() DateTime? updatedAt});
}

/// @nodoc
class _$OrganizationModelCopyWithImpl<$Res, $Val extends OrganizationModel>
    implements $OrganizationModelCopyWith<$Res> {
  _$OrganizationModelCopyWithImpl(this._value, this._then);

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
    Object? type = null,
    Object? settings = null,
    Object? hierarchyLevels = null,
    Object? logoUrl = freezed,
    Object? isActive = null,
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
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      settings: null == settings
          ? _value.settings
          : settings // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      hierarchyLevels: null == hierarchyLevels
          ? _value.hierarchyLevels
          : hierarchyLevels // ignore: cast_nullable_to_non_nullable
              as List<String>,
      logoUrl: freezed == logoUrl
          ? _value.logoUrl
          : logoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
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
abstract class _$$OrganizationModelImplCopyWith<$Res>
    implements $OrganizationModelCopyWith<$Res> {
  factory _$$OrganizationModelImplCopyWith(_$OrganizationModelImpl value,
          $Res Function(_$OrganizationModelImpl) then) =
      __$$OrganizationModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String? description,
      String type,
      Map<String, dynamic> settings,
      List<String> hierarchyLevels,
      String? logoUrl,
      bool isActive,
      @TimestampConverter() DateTime? createdAt,
      @TimestampConverter() DateTime? updatedAt});
}

/// @nodoc
class __$$OrganizationModelImplCopyWithImpl<$Res>
    extends _$OrganizationModelCopyWithImpl<$Res, _$OrganizationModelImpl>
    implements _$$OrganizationModelImplCopyWith<$Res> {
  __$$OrganizationModelImplCopyWithImpl(_$OrganizationModelImpl _value,
      $Res Function(_$OrganizationModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? type = null,
    Object? settings = null,
    Object? hierarchyLevels = null,
    Object? logoUrl = freezed,
    Object? isActive = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$OrganizationModelImpl(
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
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      settings: null == settings
          ? _value._settings
          : settings // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      hierarchyLevels: null == hierarchyLevels
          ? _value._hierarchyLevels
          : hierarchyLevels // ignore: cast_nullable_to_non_nullable
              as List<String>,
      logoUrl: freezed == logoUrl
          ? _value.logoUrl
          : logoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
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
class _$OrganizationModelImpl implements _OrganizationModel {
  const _$OrganizationModelImpl(
      {required this.id,
      required this.name,
      this.description,
      required this.type,
      required final Map<String, dynamic> settings,
      required final List<String> hierarchyLevels,
      this.logoUrl,
      this.isActive = true,
      @TimestampConverter() this.createdAt,
      @TimestampConverter() this.updatedAt})
      : _settings = settings,
        _hierarchyLevels = hierarchyLevels;

  factory _$OrganizationModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrganizationModelImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String? description;
  @override
  final String type;
// 'enterprise', 'department', 'team'
  final Map<String, dynamic> _settings;
// 'enterprise', 'department', 'team'
  @override
  Map<String, dynamic> get settings {
    if (_settings is EqualUnmodifiableMapView) return _settings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_settings);
  }

  final List<String> _hierarchyLevels;
  @override
  List<String> get hierarchyLevels {
    if (_hierarchyLevels is EqualUnmodifiableListView) return _hierarchyLevels;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_hierarchyLevels);
  }

  @override
  final String? logoUrl;
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
    return 'OrganizationModel(id: $id, name: $name, description: $description, type: $type, settings: $settings, hierarchyLevels: $hierarchyLevels, logoUrl: $logoUrl, isActive: $isActive, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrganizationModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(other._settings, _settings) &&
            const DeepCollectionEquality()
                .equals(other._hierarchyLevels, _hierarchyLevels) &&
            (identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl) &&
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
      name,
      description,
      type,
      const DeepCollectionEquality().hash(_settings),
      const DeepCollectionEquality().hash(_hierarchyLevels),
      logoUrl,
      isActive,
      createdAt,
      updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OrganizationModelImplCopyWith<_$OrganizationModelImpl> get copyWith =>
      __$$OrganizationModelImplCopyWithImpl<_$OrganizationModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrganizationModelImplToJson(
      this,
    );
  }
}

abstract class _OrganizationModel implements OrganizationModel {
  const factory _OrganizationModel(
          {required final String id,
          required final String name,
          final String? description,
          required final String type,
          required final Map<String, dynamic> settings,
          required final List<String> hierarchyLevels,
          final String? logoUrl,
          final bool isActive,
          @TimestampConverter() final DateTime? createdAt,
          @TimestampConverter() final DateTime? updatedAt}) =
      _$OrganizationModelImpl;

  factory _OrganizationModel.fromJson(Map<String, dynamic> json) =
      _$OrganizationModelImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String? get description;
  @override
  String get type;
  @override // 'enterprise', 'department', 'team'
  Map<String, dynamic> get settings;
  @override
  List<String> get hierarchyLevels;
  @override
  String? get logoUrl;
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
  _$$OrganizationModelImplCopyWith<_$OrganizationModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OrganizationalUnit _$OrganizationalUnitFromJson(Map<String, dynamic> json) {
  return _OrganizationalUnit.fromJson(json);
}

/// @nodoc
mixin _$OrganizationalUnit {
  String get id => throw _privateConstructorUsedError;
  String get organizationId => throw _privateConstructorUsedError;
  String? get parentUnitId => throw _privateConstructorUsedError;
  String get unitType => throw _privateConstructorUsedError;
  int get level => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  Map<String, dynamic> get permissionsConfig =>
      throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OrganizationalUnitCopyWith<OrganizationalUnit> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrganizationalUnitCopyWith<$Res> {
  factory $OrganizationalUnitCopyWith(
          OrganizationalUnit value, $Res Function(OrganizationalUnit) then) =
      _$OrganizationalUnitCopyWithImpl<$Res, OrganizationalUnit>;
  @useResult
  $Res call(
      {String id,
      String organizationId,
      String? parentUnitId,
      String unitType,
      int level,
      String name,
      String? description,
      Map<String, dynamic> permissionsConfig,
      bool isActive,
      @TimestampConverter() DateTime? createdAt});
}

/// @nodoc
class _$OrganizationalUnitCopyWithImpl<$Res, $Val extends OrganizationalUnit>
    implements $OrganizationalUnitCopyWith<$Res> {
  _$OrganizationalUnitCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? organizationId = null,
    Object? parentUnitId = freezed,
    Object? unitType = null,
    Object? level = null,
    Object? name = null,
    Object? description = freezed,
    Object? permissionsConfig = null,
    Object? isActive = null,
    Object? createdAt = freezed,
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
      parentUnitId: freezed == parentUnitId
          ? _value.parentUnitId
          : parentUnitId // ignore: cast_nullable_to_non_nullable
              as String?,
      unitType: null == unitType
          ? _value.unitType
          : unitType // ignore: cast_nullable_to_non_nullable
              as String,
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      permissionsConfig: null == permissionsConfig
          ? _value.permissionsConfig
          : permissionsConfig // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
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
abstract class _$$OrganizationalUnitImplCopyWith<$Res>
    implements $OrganizationalUnitCopyWith<$Res> {
  factory _$$OrganizationalUnitImplCopyWith(_$OrganizationalUnitImpl value,
          $Res Function(_$OrganizationalUnitImpl) then) =
      __$$OrganizationalUnitImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String organizationId,
      String? parentUnitId,
      String unitType,
      int level,
      String name,
      String? description,
      Map<String, dynamic> permissionsConfig,
      bool isActive,
      @TimestampConverter() DateTime? createdAt});
}

/// @nodoc
class __$$OrganizationalUnitImplCopyWithImpl<$Res>
    extends _$OrganizationalUnitCopyWithImpl<$Res, _$OrganizationalUnitImpl>
    implements _$$OrganizationalUnitImplCopyWith<$Res> {
  __$$OrganizationalUnitImplCopyWithImpl(_$OrganizationalUnitImpl _value,
      $Res Function(_$OrganizationalUnitImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? organizationId = null,
    Object? parentUnitId = freezed,
    Object? unitType = null,
    Object? level = null,
    Object? name = null,
    Object? description = freezed,
    Object? permissionsConfig = null,
    Object? isActive = null,
    Object? createdAt = freezed,
  }) {
    return _then(_$OrganizationalUnitImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      organizationId: null == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      parentUnitId: freezed == parentUnitId
          ? _value.parentUnitId
          : parentUnitId // ignore: cast_nullable_to_non_nullable
              as String?,
      unitType: null == unitType
          ? _value.unitType
          : unitType // ignore: cast_nullable_to_non_nullable
              as String,
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      permissionsConfig: null == permissionsConfig
          ? _value._permissionsConfig
          : permissionsConfig // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
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
class _$OrganizationalUnitImpl implements _OrganizationalUnit {
  const _$OrganizationalUnitImpl(
      {required this.id,
      required this.organizationId,
      this.parentUnitId,
      required this.unitType,
      required this.level,
      required this.name,
      this.description,
      required final Map<String, dynamic> permissionsConfig,
      this.isActive = true,
      @TimestampConverter() this.createdAt})
      : _permissionsConfig = permissionsConfig;

  factory _$OrganizationalUnitImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrganizationalUnitImplFromJson(json);

  @override
  final String id;
  @override
  final String organizationId;
  @override
  final String? parentUnitId;
  @override
  final String unitType;
  @override
  final int level;
  @override
  final String name;
  @override
  final String? description;
  final Map<String, dynamic> _permissionsConfig;
  @override
  Map<String, dynamic> get permissionsConfig {
    if (_permissionsConfig is EqualUnmodifiableMapView)
      return _permissionsConfig;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_permissionsConfig);
  }

  @override
  @JsonKey()
  final bool isActive;
  @override
  @TimestampConverter()
  final DateTime? createdAt;

  @override
  String toString() {
    return 'OrganizationalUnit(id: $id, organizationId: $organizationId, parentUnitId: $parentUnitId, unitType: $unitType, level: $level, name: $name, description: $description, permissionsConfig: $permissionsConfig, isActive: $isActive, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrganizationalUnitImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.organizationId, organizationId) ||
                other.organizationId == organizationId) &&
            (identical(other.parentUnitId, parentUnitId) ||
                other.parentUnitId == parentUnitId) &&
            (identical(other.unitType, unitType) ||
                other.unitType == unitType) &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality()
                .equals(other._permissionsConfig, _permissionsConfig) &&
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
      organizationId,
      parentUnitId,
      unitType,
      level,
      name,
      description,
      const DeepCollectionEquality().hash(_permissionsConfig),
      isActive,
      createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OrganizationalUnitImplCopyWith<_$OrganizationalUnitImpl> get copyWith =>
      __$$OrganizationalUnitImplCopyWithImpl<_$OrganizationalUnitImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrganizationalUnitImplToJson(
      this,
    );
  }
}

abstract class _OrganizationalUnit implements OrganizationalUnit {
  const factory _OrganizationalUnit(
          {required final String id,
          required final String organizationId,
          final String? parentUnitId,
          required final String unitType,
          required final int level,
          required final String name,
          final String? description,
          required final Map<String, dynamic> permissionsConfig,
          final bool isActive,
          @TimestampConverter() final DateTime? createdAt}) =
      _$OrganizationalUnitImpl;

  factory _OrganizationalUnit.fromJson(Map<String, dynamic> json) =
      _$OrganizationalUnitImpl.fromJson;

  @override
  String get id;
  @override
  String get organizationId;
  @override
  String? get parentUnitId;
  @override
  String get unitType;
  @override
  int get level;
  @override
  String get name;
  @override
  String? get description;
  @override
  Map<String, dynamic> get permissionsConfig;
  @override
  bool get isActive;
  @override
  @TimestampConverter()
  DateTime? get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$OrganizationalUnitImplCopyWith<_$OrganizationalUnitImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
