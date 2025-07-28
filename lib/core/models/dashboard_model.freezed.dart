// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dashboard_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DashboardConfig _$DashboardConfigFromJson(Map<String, dynamic> json) {
  return _DashboardConfig.fromJson(json);
}

/// @nodoc
mixin _$DashboardConfig {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get organizationId => throw _privateConstructorUsedError;
  List<String> get applicableRoles => throw _privateConstructorUsedError;
  List<String> get applicableUnits => throw _privateConstructorUsedError;
  int get hierarchyLevel =>
      throw _privateConstructorUsedError; // 0=org, 1=division, 2=dept, 3=team
  List<DashboardWidget> get widgets => throw _privateConstructorUsedError;
  Map<String, dynamic> get layoutConfig => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DashboardConfigCopyWith<DashboardConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DashboardConfigCopyWith<$Res> {
  factory $DashboardConfigCopyWith(
          DashboardConfig value, $Res Function(DashboardConfig) then) =
      _$DashboardConfigCopyWithImpl<$Res, DashboardConfig>;
  @useResult
  $Res call(
      {String id,
      String name,
      String organizationId,
      List<String> applicableRoles,
      List<String> applicableUnits,
      int hierarchyLevel,
      List<DashboardWidget> widgets,
      Map<String, dynamic> layoutConfig,
      bool isActive,
      @TimestampConverter() DateTime? createdAt});
}

/// @nodoc
class _$DashboardConfigCopyWithImpl<$Res, $Val extends DashboardConfig>
    implements $DashboardConfigCopyWith<$Res> {
  _$DashboardConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? organizationId = null,
    Object? applicableRoles = null,
    Object? applicableUnits = null,
    Object? hierarchyLevel = null,
    Object? widgets = null,
    Object? layoutConfig = null,
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
      organizationId: null == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      applicableRoles: null == applicableRoles
          ? _value.applicableRoles
          : applicableRoles // ignore: cast_nullable_to_non_nullable
              as List<String>,
      applicableUnits: null == applicableUnits
          ? _value.applicableUnits
          : applicableUnits // ignore: cast_nullable_to_non_nullable
              as List<String>,
      hierarchyLevel: null == hierarchyLevel
          ? _value.hierarchyLevel
          : hierarchyLevel // ignore: cast_nullable_to_non_nullable
              as int,
      widgets: null == widgets
          ? _value.widgets
          : widgets // ignore: cast_nullable_to_non_nullable
              as List<DashboardWidget>,
      layoutConfig: null == layoutConfig
          ? _value.layoutConfig
          : layoutConfig // ignore: cast_nullable_to_non_nullable
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
abstract class _$$DashboardConfigImplCopyWith<$Res>
    implements $DashboardConfigCopyWith<$Res> {
  factory _$$DashboardConfigImplCopyWith(_$DashboardConfigImpl value,
          $Res Function(_$DashboardConfigImpl) then) =
      __$$DashboardConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String organizationId,
      List<String> applicableRoles,
      List<String> applicableUnits,
      int hierarchyLevel,
      List<DashboardWidget> widgets,
      Map<String, dynamic> layoutConfig,
      bool isActive,
      @TimestampConverter() DateTime? createdAt});
}

/// @nodoc
class __$$DashboardConfigImplCopyWithImpl<$Res>
    extends _$DashboardConfigCopyWithImpl<$Res, _$DashboardConfigImpl>
    implements _$$DashboardConfigImplCopyWith<$Res> {
  __$$DashboardConfigImplCopyWithImpl(
      _$DashboardConfigImpl _value, $Res Function(_$DashboardConfigImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? organizationId = null,
    Object? applicableRoles = null,
    Object? applicableUnits = null,
    Object? hierarchyLevel = null,
    Object? widgets = null,
    Object? layoutConfig = null,
    Object? isActive = null,
    Object? createdAt = freezed,
  }) {
    return _then(_$DashboardConfigImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      organizationId: null == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      applicableRoles: null == applicableRoles
          ? _value._applicableRoles
          : applicableRoles // ignore: cast_nullable_to_non_nullable
              as List<String>,
      applicableUnits: null == applicableUnits
          ? _value._applicableUnits
          : applicableUnits // ignore: cast_nullable_to_non_nullable
              as List<String>,
      hierarchyLevel: null == hierarchyLevel
          ? _value.hierarchyLevel
          : hierarchyLevel // ignore: cast_nullable_to_non_nullable
              as int,
      widgets: null == widgets
          ? _value._widgets
          : widgets // ignore: cast_nullable_to_non_nullable
              as List<DashboardWidget>,
      layoutConfig: null == layoutConfig
          ? _value._layoutConfig
          : layoutConfig // ignore: cast_nullable_to_non_nullable
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
class _$DashboardConfigImpl implements _DashboardConfig {
  const _$DashboardConfigImpl(
      {required this.id,
      required this.name,
      required this.organizationId,
      required final List<String> applicableRoles,
      required final List<String> applicableUnits,
      required this.hierarchyLevel,
      required final List<DashboardWidget> widgets,
      required final Map<String, dynamic> layoutConfig,
      this.isActive = true,
      @TimestampConverter() this.createdAt})
      : _applicableRoles = applicableRoles,
        _applicableUnits = applicableUnits,
        _widgets = widgets,
        _layoutConfig = layoutConfig;

  factory _$DashboardConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$DashboardConfigImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String organizationId;
  final List<String> _applicableRoles;
  @override
  List<String> get applicableRoles {
    if (_applicableRoles is EqualUnmodifiableListView) return _applicableRoles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_applicableRoles);
  }

  final List<String> _applicableUnits;
  @override
  List<String> get applicableUnits {
    if (_applicableUnits is EqualUnmodifiableListView) return _applicableUnits;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_applicableUnits);
  }

  @override
  final int hierarchyLevel;
// 0=org, 1=division, 2=dept, 3=team
  final List<DashboardWidget> _widgets;
// 0=org, 1=division, 2=dept, 3=team
  @override
  List<DashboardWidget> get widgets {
    if (_widgets is EqualUnmodifiableListView) return _widgets;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_widgets);
  }

  final Map<String, dynamic> _layoutConfig;
  @override
  Map<String, dynamic> get layoutConfig {
    if (_layoutConfig is EqualUnmodifiableMapView) return _layoutConfig;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_layoutConfig);
  }

  @override
  @JsonKey()
  final bool isActive;
  @override
  @TimestampConverter()
  final DateTime? createdAt;

  @override
  String toString() {
    return 'DashboardConfig(id: $id, name: $name, organizationId: $organizationId, applicableRoles: $applicableRoles, applicableUnits: $applicableUnits, hierarchyLevel: $hierarchyLevel, widgets: $widgets, layoutConfig: $layoutConfig, isActive: $isActive, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DashboardConfigImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.organizationId, organizationId) ||
                other.organizationId == organizationId) &&
            const DeepCollectionEquality()
                .equals(other._applicableRoles, _applicableRoles) &&
            const DeepCollectionEquality()
                .equals(other._applicableUnits, _applicableUnits) &&
            (identical(other.hierarchyLevel, hierarchyLevel) ||
                other.hierarchyLevel == hierarchyLevel) &&
            const DeepCollectionEquality().equals(other._widgets, _widgets) &&
            const DeepCollectionEquality()
                .equals(other._layoutConfig, _layoutConfig) &&
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
      organizationId,
      const DeepCollectionEquality().hash(_applicableRoles),
      const DeepCollectionEquality().hash(_applicableUnits),
      hierarchyLevel,
      const DeepCollectionEquality().hash(_widgets),
      const DeepCollectionEquality().hash(_layoutConfig),
      isActive,
      createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DashboardConfigImplCopyWith<_$DashboardConfigImpl> get copyWith =>
      __$$DashboardConfigImplCopyWithImpl<_$DashboardConfigImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DashboardConfigImplToJson(
      this,
    );
  }
}

abstract class _DashboardConfig implements DashboardConfig {
  const factory _DashboardConfig(
      {required final String id,
      required final String name,
      required final String organizationId,
      required final List<String> applicableRoles,
      required final List<String> applicableUnits,
      required final int hierarchyLevel,
      required final List<DashboardWidget> widgets,
      required final Map<String, dynamic> layoutConfig,
      final bool isActive,
      @TimestampConverter() final DateTime? createdAt}) = _$DashboardConfigImpl;

  factory _DashboardConfig.fromJson(Map<String, dynamic> json) =
      _$DashboardConfigImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get organizationId;
  @override
  List<String> get applicableRoles;
  @override
  List<String> get applicableUnits;
  @override
  int get hierarchyLevel;
  @override // 0=org, 1=division, 2=dept, 3=team
  List<DashboardWidget> get widgets;
  @override
  Map<String, dynamic> get layoutConfig;
  @override
  bool get isActive;
  @override
  @TimestampConverter()
  DateTime? get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$DashboardConfigImplCopyWith<_$DashboardConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DashboardWidget _$DashboardWidgetFromJson(Map<String, dynamic> json) {
  return _DashboardWidget.fromJson(json);
}

/// @nodoc
mixin _$DashboardWidget {
  String get id => throw _privateConstructorUsedError;
  String get type =>
      throw _privateConstructorUsedError; // 'chart', 'kpi', 'table', 'form', 'list'
  String get title => throw _privateConstructorUsedError;
  Map<String, dynamic> get config => throw _privateConstructorUsedError;
  List<String> get requiredPermissions => throw _privateConstructorUsedError;
  GridPosition get position => throw _privateConstructorUsedError;
  bool get isVisible => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DashboardWidgetCopyWith<DashboardWidget> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DashboardWidgetCopyWith<$Res> {
  factory $DashboardWidgetCopyWith(
          DashboardWidget value, $Res Function(DashboardWidget) then) =
      _$DashboardWidgetCopyWithImpl<$Res, DashboardWidget>;
  @useResult
  $Res call(
      {String id,
      String type,
      String title,
      Map<String, dynamic> config,
      List<String> requiredPermissions,
      GridPosition position,
      bool isVisible});

  $GridPositionCopyWith<$Res> get position;
}

/// @nodoc
class _$DashboardWidgetCopyWithImpl<$Res, $Val extends DashboardWidget>
    implements $DashboardWidgetCopyWith<$Res> {
  _$DashboardWidgetCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? title = null,
    Object? config = null,
    Object? requiredPermissions = null,
    Object? position = null,
    Object? isVisible = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      config: null == config
          ? _value.config
          : config // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      requiredPermissions: null == requiredPermissions
          ? _value.requiredPermissions
          : requiredPermissions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as GridPosition,
      isVisible: null == isVisible
          ? _value.isVisible
          : isVisible // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $GridPositionCopyWith<$Res> get position {
    return $GridPositionCopyWith<$Res>(_value.position, (value) {
      return _then(_value.copyWith(position: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DashboardWidgetImplCopyWith<$Res>
    implements $DashboardWidgetCopyWith<$Res> {
  factory _$$DashboardWidgetImplCopyWith(_$DashboardWidgetImpl value,
          $Res Function(_$DashboardWidgetImpl) then) =
      __$$DashboardWidgetImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String type,
      String title,
      Map<String, dynamic> config,
      List<String> requiredPermissions,
      GridPosition position,
      bool isVisible});

  @override
  $GridPositionCopyWith<$Res> get position;
}

/// @nodoc
class __$$DashboardWidgetImplCopyWithImpl<$Res>
    extends _$DashboardWidgetCopyWithImpl<$Res, _$DashboardWidgetImpl>
    implements _$$DashboardWidgetImplCopyWith<$Res> {
  __$$DashboardWidgetImplCopyWithImpl(
      _$DashboardWidgetImpl _value, $Res Function(_$DashboardWidgetImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? title = null,
    Object? config = null,
    Object? requiredPermissions = null,
    Object? position = null,
    Object? isVisible = null,
  }) {
    return _then(_$DashboardWidgetImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      config: null == config
          ? _value._config
          : config // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      requiredPermissions: null == requiredPermissions
          ? _value._requiredPermissions
          : requiredPermissions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as GridPosition,
      isVisible: null == isVisible
          ? _value.isVisible
          : isVisible // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DashboardWidgetImpl implements _DashboardWidget {
  const _$DashboardWidgetImpl(
      {required this.id,
      required this.type,
      required this.title,
      required final Map<String, dynamic> config,
      required final List<String> requiredPermissions,
      required this.position,
      this.isVisible = true})
      : _config = config,
        _requiredPermissions = requiredPermissions;

  factory _$DashboardWidgetImpl.fromJson(Map<String, dynamic> json) =>
      _$$DashboardWidgetImplFromJson(json);

  @override
  final String id;
  @override
  final String type;
// 'chart', 'kpi', 'table', 'form', 'list'
  @override
  final String title;
  final Map<String, dynamic> _config;
  @override
  Map<String, dynamic> get config {
    if (_config is EqualUnmodifiableMapView) return _config;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_config);
  }

  final List<String> _requiredPermissions;
  @override
  List<String> get requiredPermissions {
    if (_requiredPermissions is EqualUnmodifiableListView)
      return _requiredPermissions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_requiredPermissions);
  }

  @override
  final GridPosition position;
  @override
  @JsonKey()
  final bool isVisible;

  @override
  String toString() {
    return 'DashboardWidget(id: $id, type: $type, title: $title, config: $config, requiredPermissions: $requiredPermissions, position: $position, isVisible: $isVisible)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DashboardWidgetImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.title, title) || other.title == title) &&
            const DeepCollectionEquality().equals(other._config, _config) &&
            const DeepCollectionEquality()
                .equals(other._requiredPermissions, _requiredPermissions) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.isVisible, isVisible) ||
                other.isVisible == isVisible));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      type,
      title,
      const DeepCollectionEquality().hash(_config),
      const DeepCollectionEquality().hash(_requiredPermissions),
      position,
      isVisible);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DashboardWidgetImplCopyWith<_$DashboardWidgetImpl> get copyWith =>
      __$$DashboardWidgetImplCopyWithImpl<_$DashboardWidgetImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DashboardWidgetImplToJson(
      this,
    );
  }
}

abstract class _DashboardWidget implements DashboardWidget {
  const factory _DashboardWidget(
      {required final String id,
      required final String type,
      required final String title,
      required final Map<String, dynamic> config,
      required final List<String> requiredPermissions,
      required final GridPosition position,
      final bool isVisible}) = _$DashboardWidgetImpl;

  factory _DashboardWidget.fromJson(Map<String, dynamic> json) =
      _$DashboardWidgetImpl.fromJson;

  @override
  String get id;
  @override
  String get type;
  @override // 'chart', 'kpi', 'table', 'form', 'list'
  String get title;
  @override
  Map<String, dynamic> get config;
  @override
  List<String> get requiredPermissions;
  @override
  GridPosition get position;
  @override
  bool get isVisible;
  @override
  @JsonKey(ignore: true)
  _$$DashboardWidgetImplCopyWith<_$DashboardWidgetImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

GridPosition _$GridPositionFromJson(Map<String, dynamic> json) {
  return _GridPosition.fromJson(json);
}

/// @nodoc
mixin _$GridPosition {
  int get x => throw _privateConstructorUsedError;
  int get y => throw _privateConstructorUsedError;
  int get width => throw _privateConstructorUsedError;
  int get height => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GridPositionCopyWith<GridPosition> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GridPositionCopyWith<$Res> {
  factory $GridPositionCopyWith(
          GridPosition value, $Res Function(GridPosition) then) =
      _$GridPositionCopyWithImpl<$Res, GridPosition>;
  @useResult
  $Res call({int x, int y, int width, int height});
}

/// @nodoc
class _$GridPositionCopyWithImpl<$Res, $Val extends GridPosition>
    implements $GridPositionCopyWith<$Res> {
  _$GridPositionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? x = null,
    Object? y = null,
    Object? width = null,
    Object? height = null,
  }) {
    return _then(_value.copyWith(
      x: null == x
          ? _value.x
          : x // ignore: cast_nullable_to_non_nullable
              as int,
      y: null == y
          ? _value.y
          : y // ignore: cast_nullable_to_non_nullable
              as int,
      width: null == width
          ? _value.width
          : width // ignore: cast_nullable_to_non_nullable
              as int,
      height: null == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GridPositionImplCopyWith<$Res>
    implements $GridPositionCopyWith<$Res> {
  factory _$$GridPositionImplCopyWith(
          _$GridPositionImpl value, $Res Function(_$GridPositionImpl) then) =
      __$$GridPositionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int x, int y, int width, int height});
}

/// @nodoc
class __$$GridPositionImplCopyWithImpl<$Res>
    extends _$GridPositionCopyWithImpl<$Res, _$GridPositionImpl>
    implements _$$GridPositionImplCopyWith<$Res> {
  __$$GridPositionImplCopyWithImpl(
      _$GridPositionImpl _value, $Res Function(_$GridPositionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? x = null,
    Object? y = null,
    Object? width = null,
    Object? height = null,
  }) {
    return _then(_$GridPositionImpl(
      x: null == x
          ? _value.x
          : x // ignore: cast_nullable_to_non_nullable
              as int,
      y: null == y
          ? _value.y
          : y // ignore: cast_nullable_to_non_nullable
              as int,
      width: null == width
          ? _value.width
          : width // ignore: cast_nullable_to_non_nullable
              as int,
      height: null == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GridPositionImpl implements _GridPosition {
  const _$GridPositionImpl(
      {required this.x,
      required this.y,
      required this.width,
      required this.height});

  factory _$GridPositionImpl.fromJson(Map<String, dynamic> json) =>
      _$$GridPositionImplFromJson(json);

  @override
  final int x;
  @override
  final int y;
  @override
  final int width;
  @override
  final int height;

  @override
  String toString() {
    return 'GridPosition(x: $x, y: $y, width: $width, height: $height)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GridPositionImpl &&
            (identical(other.x, x) || other.x == x) &&
            (identical(other.y, y) || other.y == y) &&
            (identical(other.width, width) || other.width == width) &&
            (identical(other.height, height) || other.height == height));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, x, y, width, height);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GridPositionImplCopyWith<_$GridPositionImpl> get copyWith =>
      __$$GridPositionImplCopyWithImpl<_$GridPositionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GridPositionImplToJson(
      this,
    );
  }
}

abstract class _GridPosition implements GridPosition {
  const factory _GridPosition(
      {required final int x,
      required final int y,
      required final int width,
      required final int height}) = _$GridPositionImpl;

  factory _GridPosition.fromJson(Map<String, dynamic> json) =
      _$GridPositionImpl.fromJson;

  @override
  int get x;
  @override
  int get y;
  @override
  int get width;
  @override
  int get height;
  @override
  @JsonKey(ignore: true)
  _$$GridPositionImplCopyWith<_$GridPositionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
