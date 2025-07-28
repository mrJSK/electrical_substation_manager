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
  String? get description => throw _privateConstructorUsedError;
  String get organizationId => throw _privateConstructorUsedError;
  List<String> get applicableRoles => throw _privateConstructorUsedError;
  List<String> get applicableUnits => throw _privateConstructorUsedError;
  int get hierarchyLevel =>
      throw _privateConstructorUsedError; // 0=org, 1=division, 2=dept, 3=team
  List<DashboardWidget> get widgets => throw _privateConstructorUsedError;
  Map<String, dynamic> get layoutConfig => throw _privateConstructorUsedError;
  Map<String, dynamic> get filters => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  bool get isDefault => throw _privateConstructorUsedError;
  String? get createdBy => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get updatedAt => throw _privateConstructorUsedError;

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
      String? description,
      String organizationId,
      List<String> applicableRoles,
      List<String> applicableUnits,
      int hierarchyLevel,
      List<DashboardWidget> widgets,
      Map<String, dynamic> layoutConfig,
      Map<String, dynamic> filters,
      bool isActive,
      bool isDefault,
      String? createdBy,
      @TimestampConverter() DateTime? createdAt,
      @TimestampConverter() DateTime? updatedAt});
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
    Object? description = freezed,
    Object? organizationId = null,
    Object? applicableRoles = null,
    Object? applicableUnits = null,
    Object? hierarchyLevel = null,
    Object? widgets = null,
    Object? layoutConfig = null,
    Object? filters = null,
    Object? isActive = null,
    Object? isDefault = null,
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
      filters: null == filters
          ? _value.filters
          : filters // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      isDefault: null == isDefault
          ? _value.isDefault
          : isDefault // ignore: cast_nullable_to_non_nullable
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
      String? description,
      String organizationId,
      List<String> applicableRoles,
      List<String> applicableUnits,
      int hierarchyLevel,
      List<DashboardWidget> widgets,
      Map<String, dynamic> layoutConfig,
      Map<String, dynamic> filters,
      bool isActive,
      bool isDefault,
      String? createdBy,
      @TimestampConverter() DateTime? createdAt,
      @TimestampConverter() DateTime? updatedAt});
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
    Object? description = freezed,
    Object? organizationId = null,
    Object? applicableRoles = null,
    Object? applicableUnits = null,
    Object? hierarchyLevel = null,
    Object? widgets = null,
    Object? layoutConfig = null,
    Object? filters = null,
    Object? isActive = null,
    Object? isDefault = null,
    Object? createdBy = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
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
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
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
      filters: null == filters
          ? _value._filters
          : filters // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      isDefault: null == isDefault
          ? _value.isDefault
          : isDefault // ignore: cast_nullable_to_non_nullable
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
class _$DashboardConfigImpl extends _DashboardConfig {
  const _$DashboardConfigImpl(
      {required this.id,
      required this.name,
      this.description,
      required this.organizationId,
      required final List<String> applicableRoles,
      required final List<String> applicableUnits,
      required this.hierarchyLevel,
      required final List<DashboardWidget> widgets,
      required final Map<String, dynamic> layoutConfig,
      final Map<String, dynamic> filters = const {},
      this.isActive = true,
      this.isDefault = false,
      this.createdBy,
      @TimestampConverter() this.createdAt,
      @TimestampConverter() this.updatedAt})
      : _applicableRoles = applicableRoles,
        _applicableUnits = applicableUnits,
        _widgets = widgets,
        _layoutConfig = layoutConfig,
        _filters = filters,
        super._();

  factory _$DashboardConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$DashboardConfigImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String? description;
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

  final Map<String, dynamic> _filters;
  @override
  @JsonKey()
  Map<String, dynamic> get filters {
    if (_filters is EqualUnmodifiableMapView) return _filters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_filters);
  }

  @override
  @JsonKey()
  final bool isActive;
  @override
  @JsonKey()
  final bool isDefault;
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
    return 'DashboardConfig(id: $id, name: $name, description: $description, organizationId: $organizationId, applicableRoles: $applicableRoles, applicableUnits: $applicableUnits, hierarchyLevel: $hierarchyLevel, widgets: $widgets, layoutConfig: $layoutConfig, filters: $filters, isActive: $isActive, isDefault: $isDefault, createdBy: $createdBy, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DashboardConfigImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
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
            const DeepCollectionEquality().equals(other._filters, _filters) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.isDefault, isDefault) ||
                other.isDefault == isDefault) &&
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
      organizationId,
      const DeepCollectionEquality().hash(_applicableRoles),
      const DeepCollectionEquality().hash(_applicableUnits),
      hierarchyLevel,
      const DeepCollectionEquality().hash(_widgets),
      const DeepCollectionEquality().hash(_layoutConfig),
      const DeepCollectionEquality().hash(_filters),
      isActive,
      isDefault,
      createdBy,
      createdAt,
      updatedAt);

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

abstract class _DashboardConfig extends DashboardConfig {
  const factory _DashboardConfig(
      {required final String id,
      required final String name,
      final String? description,
      required final String organizationId,
      required final List<String> applicableRoles,
      required final List<String> applicableUnits,
      required final int hierarchyLevel,
      required final List<DashboardWidget> widgets,
      required final Map<String, dynamic> layoutConfig,
      final Map<String, dynamic> filters,
      final bool isActive,
      final bool isDefault,
      final String? createdBy,
      @TimestampConverter() final DateTime? createdAt,
      @TimestampConverter() final DateTime? updatedAt}) = _$DashboardConfigImpl;
  const _DashboardConfig._() : super._();

  factory _DashboardConfig.fromJson(Map<String, dynamic> json) =
      _$DashboardConfigImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String? get description;
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
  Map<String, dynamic> get filters;
  @override
  bool get isActive;
  @override
  bool get isDefault;
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
      throw _privateConstructorUsedError; // 'chart', 'kpi', 'table', 'form', 'list', 'gauge', 'alert'
  String get title => throw _privateConstructorUsedError;
  String? get subtitle => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  Map<String, dynamic> get config => throw _privateConstructorUsedError;
  List<String> get requiredPermissions => throw _privateConstructorUsedError;
  GridPosition get position => throw _privateConstructorUsedError;
  bool get isVisible => throw _privateConstructorUsedError;
  bool get isResizable => throw _privateConstructorUsedError;
  Map<String, dynamic> get styling => throw _privateConstructorUsedError;
  int get refreshInterval => throw _privateConstructorUsedError; // minutes
  @TimestampConverter()
  DateTime? get lastUpdated => throw _privateConstructorUsedError;

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
      String? subtitle,
      String? description,
      Map<String, dynamic> config,
      List<String> requiredPermissions,
      GridPosition position,
      bool isVisible,
      bool isResizable,
      Map<String, dynamic> styling,
      int refreshInterval,
      @TimestampConverter() DateTime? lastUpdated});

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
    Object? subtitle = freezed,
    Object? description = freezed,
    Object? config = null,
    Object? requiredPermissions = null,
    Object? position = null,
    Object? isVisible = null,
    Object? isResizable = null,
    Object? styling = null,
    Object? refreshInterval = null,
    Object? lastUpdated = freezed,
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
      subtitle: freezed == subtitle
          ? _value.subtitle
          : subtitle // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
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
      isResizable: null == isResizable
          ? _value.isResizable
          : isResizable // ignore: cast_nullable_to_non_nullable
              as bool,
      styling: null == styling
          ? _value.styling
          : styling // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      refreshInterval: null == refreshInterval
          ? _value.refreshInterval
          : refreshInterval // ignore: cast_nullable_to_non_nullable
              as int,
      lastUpdated: freezed == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime?,
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
      String? subtitle,
      String? description,
      Map<String, dynamic> config,
      List<String> requiredPermissions,
      GridPosition position,
      bool isVisible,
      bool isResizable,
      Map<String, dynamic> styling,
      int refreshInterval,
      @TimestampConverter() DateTime? lastUpdated});

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
    Object? subtitle = freezed,
    Object? description = freezed,
    Object? config = null,
    Object? requiredPermissions = null,
    Object? position = null,
    Object? isVisible = null,
    Object? isResizable = null,
    Object? styling = null,
    Object? refreshInterval = null,
    Object? lastUpdated = freezed,
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
      subtitle: freezed == subtitle
          ? _value.subtitle
          : subtitle // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
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
      isResizable: null == isResizable
          ? _value.isResizable
          : isResizable // ignore: cast_nullable_to_non_nullable
              as bool,
      styling: null == styling
          ? _value._styling
          : styling // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      refreshInterval: null == refreshInterval
          ? _value.refreshInterval
          : refreshInterval // ignore: cast_nullable_to_non_nullable
              as int,
      lastUpdated: freezed == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DashboardWidgetImpl extends _DashboardWidget {
  const _$DashboardWidgetImpl(
      {required this.id,
      required this.type,
      required this.title,
      this.subtitle,
      this.description,
      required final Map<String, dynamic> config,
      required final List<String> requiredPermissions,
      required this.position,
      this.isVisible = true,
      this.isResizable = false,
      final Map<String, dynamic> styling = const {},
      this.refreshInterval = 15,
      @TimestampConverter() this.lastUpdated})
      : _config = config,
        _requiredPermissions = requiredPermissions,
        _styling = styling,
        super._();

  factory _$DashboardWidgetImpl.fromJson(Map<String, dynamic> json) =>
      _$$DashboardWidgetImplFromJson(json);

  @override
  final String id;
  @override
  final String type;
// 'chart', 'kpi', 'table', 'form', 'list', 'gauge', 'alert'
  @override
  final String title;
  @override
  final String? subtitle;
  @override
  final String? description;
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
  @JsonKey()
  final bool isResizable;
  final Map<String, dynamic> _styling;
  @override
  @JsonKey()
  Map<String, dynamic> get styling {
    if (_styling is EqualUnmodifiableMapView) return _styling;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_styling);
  }

  @override
  @JsonKey()
  final int refreshInterval;
// minutes
  @override
  @TimestampConverter()
  final DateTime? lastUpdated;

  @override
  String toString() {
    return 'DashboardWidget(id: $id, type: $type, title: $title, subtitle: $subtitle, description: $description, config: $config, requiredPermissions: $requiredPermissions, position: $position, isVisible: $isVisible, isResizable: $isResizable, styling: $styling, refreshInterval: $refreshInterval, lastUpdated: $lastUpdated)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DashboardWidgetImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.subtitle, subtitle) ||
                other.subtitle == subtitle) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other._config, _config) &&
            const DeepCollectionEquality()
                .equals(other._requiredPermissions, _requiredPermissions) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.isVisible, isVisible) ||
                other.isVisible == isVisible) &&
            (identical(other.isResizable, isResizable) ||
                other.isResizable == isResizable) &&
            const DeepCollectionEquality().equals(other._styling, _styling) &&
            (identical(other.refreshInterval, refreshInterval) ||
                other.refreshInterval == refreshInterval) &&
            (identical(other.lastUpdated, lastUpdated) ||
                other.lastUpdated == lastUpdated));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      type,
      title,
      subtitle,
      description,
      const DeepCollectionEquality().hash(_config),
      const DeepCollectionEquality().hash(_requiredPermissions),
      position,
      isVisible,
      isResizable,
      const DeepCollectionEquality().hash(_styling),
      refreshInterval,
      lastUpdated);

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

abstract class _DashboardWidget extends DashboardWidget {
  const factory _DashboardWidget(
          {required final String id,
          required final String type,
          required final String title,
          final String? subtitle,
          final String? description,
          required final Map<String, dynamic> config,
          required final List<String> requiredPermissions,
          required final GridPosition position,
          final bool isVisible,
          final bool isResizable,
          final Map<String, dynamic> styling,
          final int refreshInterval,
          @TimestampConverter() final DateTime? lastUpdated}) =
      _$DashboardWidgetImpl;
  const _DashboardWidget._() : super._();

  factory _DashboardWidget.fromJson(Map<String, dynamic> json) =
      _$DashboardWidgetImpl.fromJson;

  @override
  String get id;
  @override
  String get type;
  @override // 'chart', 'kpi', 'table', 'form', 'list', 'gauge', 'alert'
  String get title;
  @override
  String? get subtitle;
  @override
  String? get description;
  @override
  Map<String, dynamic> get config;
  @override
  List<String> get requiredPermissions;
  @override
  GridPosition get position;
  @override
  bool get isVisible;
  @override
  bool get isResizable;
  @override
  Map<String, dynamic> get styling;
  @override
  int get refreshInterval;
  @override // minutes
  @TimestampConverter()
  DateTime? get lastUpdated;
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
  int get minWidth => throw _privateConstructorUsedError;
  int get minHeight => throw _privateConstructorUsedError;
  int get maxWidth => throw _privateConstructorUsedError;
  int get maxHeight => throw _privateConstructorUsedError;

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
  $Res call(
      {int x,
      int y,
      int width,
      int height,
      int minWidth,
      int minHeight,
      int maxWidth,
      int maxHeight});
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
    Object? minWidth = null,
    Object? minHeight = null,
    Object? maxWidth = null,
    Object? maxHeight = null,
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
      minWidth: null == minWidth
          ? _value.minWidth
          : minWidth // ignore: cast_nullable_to_non_nullable
              as int,
      minHeight: null == minHeight
          ? _value.minHeight
          : minHeight // ignore: cast_nullable_to_non_nullable
              as int,
      maxWidth: null == maxWidth
          ? _value.maxWidth
          : maxWidth // ignore: cast_nullable_to_non_nullable
              as int,
      maxHeight: null == maxHeight
          ? _value.maxHeight
          : maxHeight // ignore: cast_nullable_to_non_nullable
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
  $Res call(
      {int x,
      int y,
      int width,
      int height,
      int minWidth,
      int minHeight,
      int maxWidth,
      int maxHeight});
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
    Object? minWidth = null,
    Object? minHeight = null,
    Object? maxWidth = null,
    Object? maxHeight = null,
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
      minWidth: null == minWidth
          ? _value.minWidth
          : minWidth // ignore: cast_nullable_to_non_nullable
              as int,
      minHeight: null == minHeight
          ? _value.minHeight
          : minHeight // ignore: cast_nullable_to_non_nullable
              as int,
      maxWidth: null == maxWidth
          ? _value.maxWidth
          : maxWidth // ignore: cast_nullable_to_non_nullable
              as int,
      maxHeight: null == maxHeight
          ? _value.maxHeight
          : maxHeight // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GridPositionImpl extends _GridPosition {
  const _$GridPositionImpl(
      {required this.x,
      required this.y,
      required this.width,
      required this.height,
      this.minWidth = 1,
      this.minHeight = 1,
      this.maxWidth = 12,
      this.maxHeight = 10})
      : super._();

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
  @JsonKey()
  final int minWidth;
  @override
  @JsonKey()
  final int minHeight;
  @override
  @JsonKey()
  final int maxWidth;
  @override
  @JsonKey()
  final int maxHeight;

  @override
  String toString() {
    return 'GridPosition(x: $x, y: $y, width: $width, height: $height, minWidth: $minWidth, minHeight: $minHeight, maxWidth: $maxWidth, maxHeight: $maxHeight)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GridPositionImpl &&
            (identical(other.x, x) || other.x == x) &&
            (identical(other.y, y) || other.y == y) &&
            (identical(other.width, width) || other.width == width) &&
            (identical(other.height, height) || other.height == height) &&
            (identical(other.minWidth, minWidth) ||
                other.minWidth == minWidth) &&
            (identical(other.minHeight, minHeight) ||
                other.minHeight == minHeight) &&
            (identical(other.maxWidth, maxWidth) ||
                other.maxWidth == maxWidth) &&
            (identical(other.maxHeight, maxHeight) ||
                other.maxHeight == maxHeight));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, x, y, width, height, minWidth,
      minHeight, maxWidth, maxHeight);

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

abstract class _GridPosition extends GridPosition {
  const factory _GridPosition(
      {required final int x,
      required final int y,
      required final int width,
      required final int height,
      final int minWidth,
      final int minHeight,
      final int maxWidth,
      final int maxHeight}) = _$GridPositionImpl;
  const _GridPosition._() : super._();

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
  int get minWidth;
  @override
  int get minHeight;
  @override
  int get maxWidth;
  @override
  int get maxHeight;
  @override
  @JsonKey(ignore: true)
  _$$GridPositionImplCopyWith<_$GridPositionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

WidgetData _$WidgetDataFromJson(Map<String, dynamic> json) {
  return _WidgetData.fromJson(json);
}

/// @nodoc
mixin _$WidgetData {
  String get widgetId => throw _privateConstructorUsedError;
  Map<String, dynamic> get data => throw _privateConstructorUsedError;
  bool get hasError => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get lastFetched => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get nextRefresh => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WidgetDataCopyWith<WidgetData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WidgetDataCopyWith<$Res> {
  factory $WidgetDataCopyWith(
          WidgetData value, $Res Function(WidgetData) then) =
      _$WidgetDataCopyWithImpl<$Res, WidgetData>;
  @useResult
  $Res call(
      {String widgetId,
      Map<String, dynamic> data,
      bool hasError,
      String? errorMessage,
      @TimestampConverter() DateTime? lastFetched,
      @TimestampConverter() DateTime? nextRefresh});
}

/// @nodoc
class _$WidgetDataCopyWithImpl<$Res, $Val extends WidgetData>
    implements $WidgetDataCopyWith<$Res> {
  _$WidgetDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? widgetId = null,
    Object? data = null,
    Object? hasError = null,
    Object? errorMessage = freezed,
    Object? lastFetched = freezed,
    Object? nextRefresh = freezed,
  }) {
    return _then(_value.copyWith(
      widgetId: null == widgetId
          ? _value.widgetId
          : widgetId // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      hasError: null == hasError
          ? _value.hasError
          : hasError // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      lastFetched: freezed == lastFetched
          ? _value.lastFetched
          : lastFetched // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      nextRefresh: freezed == nextRefresh
          ? _value.nextRefresh
          : nextRefresh // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WidgetDataImplCopyWith<$Res>
    implements $WidgetDataCopyWith<$Res> {
  factory _$$WidgetDataImplCopyWith(
          _$WidgetDataImpl value, $Res Function(_$WidgetDataImpl) then) =
      __$$WidgetDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String widgetId,
      Map<String, dynamic> data,
      bool hasError,
      String? errorMessage,
      @TimestampConverter() DateTime? lastFetched,
      @TimestampConverter() DateTime? nextRefresh});
}

/// @nodoc
class __$$WidgetDataImplCopyWithImpl<$Res>
    extends _$WidgetDataCopyWithImpl<$Res, _$WidgetDataImpl>
    implements _$$WidgetDataImplCopyWith<$Res> {
  __$$WidgetDataImplCopyWithImpl(
      _$WidgetDataImpl _value, $Res Function(_$WidgetDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? widgetId = null,
    Object? data = null,
    Object? hasError = null,
    Object? errorMessage = freezed,
    Object? lastFetched = freezed,
    Object? nextRefresh = freezed,
  }) {
    return _then(_$WidgetDataImpl(
      widgetId: null == widgetId
          ? _value.widgetId
          : widgetId // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      hasError: null == hasError
          ? _value.hasError
          : hasError // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      lastFetched: freezed == lastFetched
          ? _value.lastFetched
          : lastFetched // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      nextRefresh: freezed == nextRefresh
          ? _value.nextRefresh
          : nextRefresh // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WidgetDataImpl extends _WidgetData {
  const _$WidgetDataImpl(
      {required this.widgetId,
      required final Map<String, dynamic> data,
      this.hasError = false,
      this.errorMessage,
      @TimestampConverter() this.lastFetched,
      @TimestampConverter() this.nextRefresh})
      : _data = data,
        super._();

  factory _$WidgetDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$WidgetDataImplFromJson(json);

  @override
  final String widgetId;
  final Map<String, dynamic> _data;
  @override
  Map<String, dynamic> get data {
    if (_data is EqualUnmodifiableMapView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_data);
  }

  @override
  @JsonKey()
  final bool hasError;
  @override
  final String? errorMessage;
  @override
  @TimestampConverter()
  final DateTime? lastFetched;
  @override
  @TimestampConverter()
  final DateTime? nextRefresh;

  @override
  String toString() {
    return 'WidgetData(widgetId: $widgetId, data: $data, hasError: $hasError, errorMessage: $errorMessage, lastFetched: $lastFetched, nextRefresh: $nextRefresh)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WidgetDataImpl &&
            (identical(other.widgetId, widgetId) ||
                other.widgetId == widgetId) &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.hasError, hasError) ||
                other.hasError == hasError) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.lastFetched, lastFetched) ||
                other.lastFetched == lastFetched) &&
            (identical(other.nextRefresh, nextRefresh) ||
                other.nextRefresh == nextRefresh));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      widgetId,
      const DeepCollectionEquality().hash(_data),
      hasError,
      errorMessage,
      lastFetched,
      nextRefresh);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WidgetDataImplCopyWith<_$WidgetDataImpl> get copyWith =>
      __$$WidgetDataImplCopyWithImpl<_$WidgetDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WidgetDataImplToJson(
      this,
    );
  }
}

abstract class _WidgetData extends WidgetData {
  const factory _WidgetData(
      {required final String widgetId,
      required final Map<String, dynamic> data,
      final bool hasError,
      final String? errorMessage,
      @TimestampConverter() final DateTime? lastFetched,
      @TimestampConverter() final DateTime? nextRefresh}) = _$WidgetDataImpl;
  const _WidgetData._() : super._();

  factory _WidgetData.fromJson(Map<String, dynamic> json) =
      _$WidgetDataImpl.fromJson;

  @override
  String get widgetId;
  @override
  Map<String, dynamic> get data;
  @override
  bool get hasError;
  @override
  String? get errorMessage;
  @override
  @TimestampConverter()
  DateTime? get lastFetched;
  @override
  @TimestampConverter()
  DateTime? get nextRefresh;
  @override
  @JsonKey(ignore: true)
  _$$WidgetDataImplCopyWith<_$WidgetDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
