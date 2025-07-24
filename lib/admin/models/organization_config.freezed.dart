// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'organization_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

OrganizationConfig _$OrganizationConfigFromJson(Map<String, dynamic> json) {
  return _OrganizationConfig.fromJson(json);
}

/// @nodoc
mixin _$OrganizationConfig {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get logoUrl => throw _privateConstructorUsedError;
  Map<String, String> get branding => throw _privateConstructorUsedError;
  List<HierarchyLevel> get hierarchy => throw _privateConstructorUsedError;
  Map<String, List<String>> get rolePermissions =>
      throw _privateConstructorUsedError;
  DatabaseConfig get database => throw _privateConstructorUsedError;
  AuthConfig get authentication => throw _privateConstructorUsedError;
  Map<String, dynamic> get integrations =>
      throw _privateConstructorUsedError; // Add this missing field
  bool get isActive => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OrganizationConfigCopyWith<OrganizationConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrganizationConfigCopyWith<$Res> {
  factory $OrganizationConfigCopyWith(
          OrganizationConfig value, $Res Function(OrganizationConfig) then) =
      _$OrganizationConfigCopyWithImpl<$Res, OrganizationConfig>;
  @useResult
  $Res call(
      {String id,
      String name,
      String logoUrl,
      Map<String, String> branding,
      List<HierarchyLevel> hierarchy,
      Map<String, List<String>> rolePermissions,
      DatabaseConfig database,
      AuthConfig authentication,
      Map<String, dynamic> integrations,
      bool isActive});

  $DatabaseConfigCopyWith<$Res> get database;
  $AuthConfigCopyWith<$Res> get authentication;
}

/// @nodoc
class _$OrganizationConfigCopyWithImpl<$Res, $Val extends OrganizationConfig>
    implements $OrganizationConfigCopyWith<$Res> {
  _$OrganizationConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? logoUrl = null,
    Object? branding = null,
    Object? hierarchy = null,
    Object? rolePermissions = null,
    Object? database = null,
    Object? authentication = null,
    Object? integrations = null,
    Object? isActive = null,
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
      logoUrl: null == logoUrl
          ? _value.logoUrl
          : logoUrl // ignore: cast_nullable_to_non_nullable
              as String,
      branding: null == branding
          ? _value.branding
          : branding // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      hierarchy: null == hierarchy
          ? _value.hierarchy
          : hierarchy // ignore: cast_nullable_to_non_nullable
              as List<HierarchyLevel>,
      rolePermissions: null == rolePermissions
          ? _value.rolePermissions
          : rolePermissions // ignore: cast_nullable_to_non_nullable
              as Map<String, List<String>>,
      database: null == database
          ? _value.database
          : database // ignore: cast_nullable_to_non_nullable
              as DatabaseConfig,
      authentication: null == authentication
          ? _value.authentication
          : authentication // ignore: cast_nullable_to_non_nullable
              as AuthConfig,
      integrations: null == integrations
          ? _value.integrations
          : integrations // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $DatabaseConfigCopyWith<$Res> get database {
    return $DatabaseConfigCopyWith<$Res>(_value.database, (value) {
      return _then(_value.copyWith(database: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $AuthConfigCopyWith<$Res> get authentication {
    return $AuthConfigCopyWith<$Res>(_value.authentication, (value) {
      return _then(_value.copyWith(authentication: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$OrganizationConfigImplCopyWith<$Res>
    implements $OrganizationConfigCopyWith<$Res> {
  factory _$$OrganizationConfigImplCopyWith(_$OrganizationConfigImpl value,
          $Res Function(_$OrganizationConfigImpl) then) =
      __$$OrganizationConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String logoUrl,
      Map<String, String> branding,
      List<HierarchyLevel> hierarchy,
      Map<String, List<String>> rolePermissions,
      DatabaseConfig database,
      AuthConfig authentication,
      Map<String, dynamic> integrations,
      bool isActive});

  @override
  $DatabaseConfigCopyWith<$Res> get database;
  @override
  $AuthConfigCopyWith<$Res> get authentication;
}

/// @nodoc
class __$$OrganizationConfigImplCopyWithImpl<$Res>
    extends _$OrganizationConfigCopyWithImpl<$Res, _$OrganizationConfigImpl>
    implements _$$OrganizationConfigImplCopyWith<$Res> {
  __$$OrganizationConfigImplCopyWithImpl(_$OrganizationConfigImpl _value,
      $Res Function(_$OrganizationConfigImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? logoUrl = null,
    Object? branding = null,
    Object? hierarchy = null,
    Object? rolePermissions = null,
    Object? database = null,
    Object? authentication = null,
    Object? integrations = null,
    Object? isActive = null,
  }) {
    return _then(_$OrganizationConfigImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      logoUrl: null == logoUrl
          ? _value.logoUrl
          : logoUrl // ignore: cast_nullable_to_non_nullable
              as String,
      branding: null == branding
          ? _value._branding
          : branding // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      hierarchy: null == hierarchy
          ? _value._hierarchy
          : hierarchy // ignore: cast_nullable_to_non_nullable
              as List<HierarchyLevel>,
      rolePermissions: null == rolePermissions
          ? _value._rolePermissions
          : rolePermissions // ignore: cast_nullable_to_non_nullable
              as Map<String, List<String>>,
      database: null == database
          ? _value.database
          : database // ignore: cast_nullable_to_non_nullable
              as DatabaseConfig,
      authentication: null == authentication
          ? _value.authentication
          : authentication // ignore: cast_nullable_to_non_nullable
              as AuthConfig,
      integrations: null == integrations
          ? _value._integrations
          : integrations // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OrganizationConfigImpl implements _OrganizationConfig {
  const _$OrganizationConfigImpl(
      {required this.id,
      required this.name,
      required this.logoUrl,
      required final Map<String, String> branding,
      required final List<HierarchyLevel> hierarchy,
      required final Map<String, List<String>> rolePermissions,
      required this.database,
      required this.authentication,
      required final Map<String, dynamic> integrations,
      this.isActive = true})
      : _branding = branding,
        _hierarchy = hierarchy,
        _rolePermissions = rolePermissions,
        _integrations = integrations;

  factory _$OrganizationConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrganizationConfigImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String logoUrl;
  final Map<String, String> _branding;
  @override
  Map<String, String> get branding {
    if (_branding is EqualUnmodifiableMapView) return _branding;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_branding);
  }

  final List<HierarchyLevel> _hierarchy;
  @override
  List<HierarchyLevel> get hierarchy {
    if (_hierarchy is EqualUnmodifiableListView) return _hierarchy;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_hierarchy);
  }

  final Map<String, List<String>> _rolePermissions;
  @override
  Map<String, List<String>> get rolePermissions {
    if (_rolePermissions is EqualUnmodifiableMapView) return _rolePermissions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_rolePermissions);
  }

  @override
  final DatabaseConfig database;
  @override
  final AuthConfig authentication;
  final Map<String, dynamic> _integrations;
  @override
  Map<String, dynamic> get integrations {
    if (_integrations is EqualUnmodifiableMapView) return _integrations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_integrations);
  }

// Add this missing field
  @override
  @JsonKey()
  final bool isActive;

  @override
  String toString() {
    return 'OrganizationConfig(id: $id, name: $name, logoUrl: $logoUrl, branding: $branding, hierarchy: $hierarchy, rolePermissions: $rolePermissions, database: $database, authentication: $authentication, integrations: $integrations, isActive: $isActive)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrganizationConfigImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl) &&
            const DeepCollectionEquality().equals(other._branding, _branding) &&
            const DeepCollectionEquality()
                .equals(other._hierarchy, _hierarchy) &&
            const DeepCollectionEquality()
                .equals(other._rolePermissions, _rolePermissions) &&
            (identical(other.database, database) ||
                other.database == database) &&
            (identical(other.authentication, authentication) ||
                other.authentication == authentication) &&
            const DeepCollectionEquality()
                .equals(other._integrations, _integrations) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      logoUrl,
      const DeepCollectionEquality().hash(_branding),
      const DeepCollectionEquality().hash(_hierarchy),
      const DeepCollectionEquality().hash(_rolePermissions),
      database,
      authentication,
      const DeepCollectionEquality().hash(_integrations),
      isActive);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OrganizationConfigImplCopyWith<_$OrganizationConfigImpl> get copyWith =>
      __$$OrganizationConfigImplCopyWithImpl<_$OrganizationConfigImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrganizationConfigImplToJson(
      this,
    );
  }
}

abstract class _OrganizationConfig implements OrganizationConfig {
  const factory _OrganizationConfig(
      {required final String id,
      required final String name,
      required final String logoUrl,
      required final Map<String, String> branding,
      required final List<HierarchyLevel> hierarchy,
      required final Map<String, List<String>> rolePermissions,
      required final DatabaseConfig database,
      required final AuthConfig authentication,
      required final Map<String, dynamic> integrations,
      final bool isActive}) = _$OrganizationConfigImpl;

  factory _OrganizationConfig.fromJson(Map<String, dynamic> json) =
      _$OrganizationConfigImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get logoUrl;
  @override
  Map<String, String> get branding;
  @override
  List<HierarchyLevel> get hierarchy;
  @override
  Map<String, List<String>> get rolePermissions;
  @override
  DatabaseConfig get database;
  @override
  AuthConfig get authentication;
  @override
  Map<String, dynamic> get integrations;
  @override // Add this missing field
  bool get isActive;
  @override
  @JsonKey(ignore: true)
  _$$OrganizationConfigImplCopyWith<_$OrganizationConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DatabaseConfig _$DatabaseConfigFromJson(Map<String, dynamic> json) {
  return _DatabaseConfig.fromJson(json);
}

/// @nodoc
mixin _$DatabaseConfig {
  DatabaseType get type => throw _privateConstructorUsedError;
  Map<String, dynamic> get config => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DatabaseConfigCopyWith<DatabaseConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DatabaseConfigCopyWith<$Res> {
  factory $DatabaseConfigCopyWith(
          DatabaseConfig value, $Res Function(DatabaseConfig) then) =
      _$DatabaseConfigCopyWithImpl<$Res, DatabaseConfig>;
  @useResult
  $Res call({DatabaseType type, Map<String, dynamic> config});
}

/// @nodoc
class _$DatabaseConfigCopyWithImpl<$Res, $Val extends DatabaseConfig>
    implements $DatabaseConfigCopyWith<$Res> {
  _$DatabaseConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? config = null,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as DatabaseType,
      config: null == config
          ? _value.config
          : config // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DatabaseConfigImplCopyWith<$Res>
    implements $DatabaseConfigCopyWith<$Res> {
  factory _$$DatabaseConfigImplCopyWith(_$DatabaseConfigImpl value,
          $Res Function(_$DatabaseConfigImpl) then) =
      __$$DatabaseConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DatabaseType type, Map<String, dynamic> config});
}

/// @nodoc
class __$$DatabaseConfigImplCopyWithImpl<$Res>
    extends _$DatabaseConfigCopyWithImpl<$Res, _$DatabaseConfigImpl>
    implements _$$DatabaseConfigImplCopyWith<$Res> {
  __$$DatabaseConfigImplCopyWithImpl(
      _$DatabaseConfigImpl _value, $Res Function(_$DatabaseConfigImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? config = null,
  }) {
    return _then(_$DatabaseConfigImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as DatabaseType,
      config: null == config
          ? _value._config
          : config // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DatabaseConfigImpl implements _DatabaseConfig {
  const _$DatabaseConfigImpl(
      {required this.type, required final Map<String, dynamic> config})
      : _config = config;

  factory _$DatabaseConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$DatabaseConfigImplFromJson(json);

  @override
  final DatabaseType type;
  final Map<String, dynamic> _config;
  @override
  Map<String, dynamic> get config {
    if (_config is EqualUnmodifiableMapView) return _config;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_config);
  }

  @override
  String toString() {
    return 'DatabaseConfig(type: $type, config: $config)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DatabaseConfigImpl &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(other._config, _config));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, type, const DeepCollectionEquality().hash(_config));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DatabaseConfigImplCopyWith<_$DatabaseConfigImpl> get copyWith =>
      __$$DatabaseConfigImplCopyWithImpl<_$DatabaseConfigImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DatabaseConfigImplToJson(
      this,
    );
  }
}

abstract class _DatabaseConfig implements DatabaseConfig {
  const factory _DatabaseConfig(
      {required final DatabaseType type,
      required final Map<String, dynamic> config}) = _$DatabaseConfigImpl;

  factory _DatabaseConfig.fromJson(Map<String, dynamic> json) =
      _$DatabaseConfigImpl.fromJson;

  @override
  DatabaseType get type;
  @override
  Map<String, dynamic> get config;
  @override
  @JsonKey(ignore: true)
  _$$DatabaseConfigImplCopyWith<_$DatabaseConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AuthConfig _$AuthConfigFromJson(Map<String, dynamic> json) {
  return _AuthConfig.fromJson(json);
}

/// @nodoc
mixin _$AuthConfig {
  AuthType get type => throw _privateConstructorUsedError;
  Map<String, dynamic> get config => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AuthConfigCopyWith<AuthConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthConfigCopyWith<$Res> {
  factory $AuthConfigCopyWith(
          AuthConfig value, $Res Function(AuthConfig) then) =
      _$AuthConfigCopyWithImpl<$Res, AuthConfig>;
  @useResult
  $Res call({AuthType type, Map<String, dynamic> config});
}

/// @nodoc
class _$AuthConfigCopyWithImpl<$Res, $Val extends AuthConfig>
    implements $AuthConfigCopyWith<$Res> {
  _$AuthConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? config = null,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as AuthType,
      config: null == config
          ? _value.config
          : config // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AuthConfigImplCopyWith<$Res>
    implements $AuthConfigCopyWith<$Res> {
  factory _$$AuthConfigImplCopyWith(
          _$AuthConfigImpl value, $Res Function(_$AuthConfigImpl) then) =
      __$$AuthConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({AuthType type, Map<String, dynamic> config});
}

/// @nodoc
class __$$AuthConfigImplCopyWithImpl<$Res>
    extends _$AuthConfigCopyWithImpl<$Res, _$AuthConfigImpl>
    implements _$$AuthConfigImplCopyWith<$Res> {
  __$$AuthConfigImplCopyWithImpl(
      _$AuthConfigImpl _value, $Res Function(_$AuthConfigImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? config = null,
  }) {
    return _then(_$AuthConfigImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as AuthType,
      config: null == config
          ? _value._config
          : config // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AuthConfigImpl implements _AuthConfig {
  const _$AuthConfigImpl(
      {required this.type, required final Map<String, dynamic> config})
      : _config = config;

  factory _$AuthConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$AuthConfigImplFromJson(json);

  @override
  final AuthType type;
  final Map<String, dynamic> _config;
  @override
  Map<String, dynamic> get config {
    if (_config is EqualUnmodifiableMapView) return _config;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_config);
  }

  @override
  String toString() {
    return 'AuthConfig(type: $type, config: $config)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthConfigImpl &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(other._config, _config));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, type, const DeepCollectionEquality().hash(_config));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthConfigImplCopyWith<_$AuthConfigImpl> get copyWith =>
      __$$AuthConfigImplCopyWithImpl<_$AuthConfigImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AuthConfigImplToJson(
      this,
    );
  }
}

abstract class _AuthConfig implements AuthConfig {
  const factory _AuthConfig(
      {required final AuthType type,
      required final Map<String, dynamic> config}) = _$AuthConfigImpl;

  factory _AuthConfig.fromJson(Map<String, dynamic> json) =
      _$AuthConfigImpl.fromJson;

  @override
  AuthType get type;
  @override
  Map<String, dynamic> get config;
  @override
  @JsonKey(ignore: true)
  _$$AuthConfigImplCopyWith<_$AuthConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
