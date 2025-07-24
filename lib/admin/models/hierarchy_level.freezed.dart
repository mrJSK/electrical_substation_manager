// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hierarchy_level.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

HierarchyLevel _$HierarchyLevelFromJson(Map<String, dynamic> json) {
  return _HierarchyLevel.fromJson(json);
}

/// @nodoc
mixin _$HierarchyLevel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get displayName => throw _privateConstructorUsedError;
  int get level => throw _privateConstructorUsedError;
  String? get parentId => throw _privateConstructorUsedError;
  List<String> get permissions => throw _privateConstructorUsedError;
  Map<String, dynamic> get dashboardConfig =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $HierarchyLevelCopyWith<HierarchyLevel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HierarchyLevelCopyWith<$Res> {
  factory $HierarchyLevelCopyWith(
          HierarchyLevel value, $Res Function(HierarchyLevel) then) =
      _$HierarchyLevelCopyWithImpl<$Res, HierarchyLevel>;
  @useResult
  $Res call(
      {String id,
      String name,
      String displayName,
      int level,
      String? parentId,
      List<String> permissions,
      Map<String, dynamic> dashboardConfig});
}

/// @nodoc
class _$HierarchyLevelCopyWithImpl<$Res, $Val extends HierarchyLevel>
    implements $HierarchyLevelCopyWith<$Res> {
  _$HierarchyLevelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? displayName = null,
    Object? level = null,
    Object? parentId = freezed,
    Object? permissions = null,
    Object? dashboardConfig = null,
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
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as int,
      parentId: freezed == parentId
          ? _value.parentId
          : parentId // ignore: cast_nullable_to_non_nullable
              as String?,
      permissions: null == permissions
          ? _value.permissions
          : permissions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      dashboardConfig: null == dashboardConfig
          ? _value.dashboardConfig
          : dashboardConfig // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HierarchyLevelImplCopyWith<$Res>
    implements $HierarchyLevelCopyWith<$Res> {
  factory _$$HierarchyLevelImplCopyWith(_$HierarchyLevelImpl value,
          $Res Function(_$HierarchyLevelImpl) then) =
      __$$HierarchyLevelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String displayName,
      int level,
      String? parentId,
      List<String> permissions,
      Map<String, dynamic> dashboardConfig});
}

/// @nodoc
class __$$HierarchyLevelImplCopyWithImpl<$Res>
    extends _$HierarchyLevelCopyWithImpl<$Res, _$HierarchyLevelImpl>
    implements _$$HierarchyLevelImplCopyWith<$Res> {
  __$$HierarchyLevelImplCopyWithImpl(
      _$HierarchyLevelImpl _value, $Res Function(_$HierarchyLevelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? displayName = null,
    Object? level = null,
    Object? parentId = freezed,
    Object? permissions = null,
    Object? dashboardConfig = null,
  }) {
    return _then(_$HierarchyLevelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as int,
      parentId: freezed == parentId
          ? _value.parentId
          : parentId // ignore: cast_nullable_to_non_nullable
              as String?,
      permissions: null == permissions
          ? _value._permissions
          : permissions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      dashboardConfig: null == dashboardConfig
          ? _value._dashboardConfig
          : dashboardConfig // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HierarchyLevelImpl implements _HierarchyLevel {
  const _$HierarchyLevelImpl(
      {required this.id,
      required this.name,
      required this.displayName,
      required this.level,
      this.parentId,
      required final List<String> permissions,
      required final Map<String, dynamic> dashboardConfig})
      : _permissions = permissions,
        _dashboardConfig = dashboardConfig;

  factory _$HierarchyLevelImpl.fromJson(Map<String, dynamic> json) =>
      _$$HierarchyLevelImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String displayName;
  @override
  final int level;
  @override
  final String? parentId;
  final List<String> _permissions;
  @override
  List<String> get permissions {
    if (_permissions is EqualUnmodifiableListView) return _permissions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_permissions);
  }

  final Map<String, dynamic> _dashboardConfig;
  @override
  Map<String, dynamic> get dashboardConfig {
    if (_dashboardConfig is EqualUnmodifiableMapView) return _dashboardConfig;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_dashboardConfig);
  }

  @override
  String toString() {
    return 'HierarchyLevel(id: $id, name: $name, displayName: $displayName, level: $level, parentId: $parentId, permissions: $permissions, dashboardConfig: $dashboardConfig)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HierarchyLevelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.parentId, parentId) ||
                other.parentId == parentId) &&
            const DeepCollectionEquality()
                .equals(other._permissions, _permissions) &&
            const DeepCollectionEquality()
                .equals(other._dashboardConfig, _dashboardConfig));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      displayName,
      level,
      parentId,
      const DeepCollectionEquality().hash(_permissions),
      const DeepCollectionEquality().hash(_dashboardConfig));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HierarchyLevelImplCopyWith<_$HierarchyLevelImpl> get copyWith =>
      __$$HierarchyLevelImplCopyWithImpl<_$HierarchyLevelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HierarchyLevelImplToJson(
      this,
    );
  }
}

abstract class _HierarchyLevel implements HierarchyLevel {
  const factory _HierarchyLevel(
          {required final String id,
          required final String name,
          required final String displayName,
          required final int level,
          final String? parentId,
          required final List<String> permissions,
          required final Map<String, dynamic> dashboardConfig}) =
      _$HierarchyLevelImpl;

  factory _HierarchyLevel.fromJson(Map<String, dynamic> json) =
      _$HierarchyLevelImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get displayName;
  @override
  int get level;
  @override
  String? get parentId;
  @override
  List<String> get permissions;
  @override
  Map<String, dynamic> get dashboardConfig;
  @override
  @JsonKey(ignore: true)
  _$$HierarchyLevelImplCopyWith<_$HierarchyLevelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
