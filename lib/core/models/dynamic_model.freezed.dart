// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dynamic_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DynamicModel _$DynamicModelFromJson(Map<String, dynamic> json) {
  return _DynamicModel.fromJson(json);
}

/// @nodoc
mixin _$DynamicModel {
  String get id => throw _privateConstructorUsedError;
  String get modelName => throw _privateConstructorUsedError;
  String get displayName => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get icon => throw _privateConstructorUsedError;
  String? get category =>
      throw _privateConstructorUsedError; // Equipment, Maintenance, Inspection, Report, etc.
  String? get version =>
      throw _privateConstructorUsedError; // Model version for compatibility
  String get organizationId => throw _privateConstructorUsedError;
  Map<String, DynamicField> get fields => throw _privateConstructorUsedError;
  Map<String, dynamic> get validationRules =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> get relationships => throw _privateConstructorUsedError;
  Map<String, dynamic> get uiConfig => throw _privateConstructorUsedError;
  Map<String, dynamic> get permissions => throw _privateConstructorUsedError;
  Map<String, String> get sections =>
      throw _privateConstructorUsedError; // Field grouping
  List<String> get requiredFields => throw _privateConstructorUsedError;
  List<String> get searchableFields =>
      throw _privateConstructorUsedError; // For search functionality
  List<String> get listViewFields =>
      throw _privateConstructorUsedError; // Fields to show in list views
  Map<String, dynamic> get layoutConfig =>
      throw _privateConstructorUsedError; // Form layout configuration
  bool get isActive => throw _privateConstructorUsedError;
  bool get isSystemModel => throw _privateConstructorUsedError;
  bool get allowDuplicates => throw _privateConstructorUsedError;
  bool get enableAuditLog => throw _privateConstructorUsedError;
  bool get enableVersioning => throw _privateConstructorUsedError;
  String? get createdBy => throw _privateConstructorUsedError;
  String? get updatedBy => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DynamicModelCopyWith<DynamicModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DynamicModelCopyWith<$Res> {
  factory $DynamicModelCopyWith(
          DynamicModel value, $Res Function(DynamicModel) then) =
      _$DynamicModelCopyWithImpl<$Res, DynamicModel>;
  @useResult
  $Res call(
      {String id,
      String modelName,
      String displayName,
      String? description,
      String? icon,
      String? category,
      String? version,
      String organizationId,
      Map<String, DynamicField> fields,
      Map<String, dynamic> validationRules,
      Map<String, dynamic> relationships,
      Map<String, dynamic> uiConfig,
      Map<String, dynamic> permissions,
      Map<String, String> sections,
      List<String> requiredFields,
      List<String> searchableFields,
      List<String> listViewFields,
      Map<String, dynamic> layoutConfig,
      bool isActive,
      bool isSystemModel,
      bool allowDuplicates,
      bool enableAuditLog,
      bool enableVersioning,
      String? createdBy,
      String? updatedBy,
      @TimestampConverter() DateTime? createdAt,
      @TimestampConverter() DateTime? updatedAt});
}

/// @nodoc
class _$DynamicModelCopyWithImpl<$Res, $Val extends DynamicModel>
    implements $DynamicModelCopyWith<$Res> {
  _$DynamicModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? modelName = null,
    Object? displayName = null,
    Object? description = freezed,
    Object? icon = freezed,
    Object? category = freezed,
    Object? version = freezed,
    Object? organizationId = null,
    Object? fields = null,
    Object? validationRules = null,
    Object? relationships = null,
    Object? uiConfig = null,
    Object? permissions = null,
    Object? sections = null,
    Object? requiredFields = null,
    Object? searchableFields = null,
    Object? listViewFields = null,
    Object? layoutConfig = null,
    Object? isActive = null,
    Object? isSystemModel = null,
    Object? allowDuplicates = null,
    Object? enableAuditLog = null,
    Object? enableVersioning = null,
    Object? createdBy = freezed,
    Object? updatedBy = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      modelName: null == modelName
          ? _value.modelName
          : modelName // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      icon: freezed == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      version: freezed == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String?,
      organizationId: null == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      fields: null == fields
          ? _value.fields
          : fields // ignore: cast_nullable_to_non_nullable
              as Map<String, DynamicField>,
      validationRules: null == validationRules
          ? _value.validationRules
          : validationRules // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      relationships: null == relationships
          ? _value.relationships
          : relationships // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      uiConfig: null == uiConfig
          ? _value.uiConfig
          : uiConfig // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      permissions: null == permissions
          ? _value.permissions
          : permissions // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      sections: null == sections
          ? _value.sections
          : sections // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      requiredFields: null == requiredFields
          ? _value.requiredFields
          : requiredFields // ignore: cast_nullable_to_non_nullable
              as List<String>,
      searchableFields: null == searchableFields
          ? _value.searchableFields
          : searchableFields // ignore: cast_nullable_to_non_nullable
              as List<String>,
      listViewFields: null == listViewFields
          ? _value.listViewFields
          : listViewFields // ignore: cast_nullable_to_non_nullable
              as List<String>,
      layoutConfig: null == layoutConfig
          ? _value.layoutConfig
          : layoutConfig // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      isSystemModel: null == isSystemModel
          ? _value.isSystemModel
          : isSystemModel // ignore: cast_nullable_to_non_nullable
              as bool,
      allowDuplicates: null == allowDuplicates
          ? _value.allowDuplicates
          : allowDuplicates // ignore: cast_nullable_to_non_nullable
              as bool,
      enableAuditLog: null == enableAuditLog
          ? _value.enableAuditLog
          : enableAuditLog // ignore: cast_nullable_to_non_nullable
              as bool,
      enableVersioning: null == enableVersioning
          ? _value.enableVersioning
          : enableVersioning // ignore: cast_nullable_to_non_nullable
              as bool,
      createdBy: freezed == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedBy: freezed == updatedBy
          ? _value.updatedBy
          : updatedBy // ignore: cast_nullable_to_non_nullable
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
abstract class _$$DynamicModelImplCopyWith<$Res>
    implements $DynamicModelCopyWith<$Res> {
  factory _$$DynamicModelImplCopyWith(
          _$DynamicModelImpl value, $Res Function(_$DynamicModelImpl) then) =
      __$$DynamicModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String modelName,
      String displayName,
      String? description,
      String? icon,
      String? category,
      String? version,
      String organizationId,
      Map<String, DynamicField> fields,
      Map<String, dynamic> validationRules,
      Map<String, dynamic> relationships,
      Map<String, dynamic> uiConfig,
      Map<String, dynamic> permissions,
      Map<String, String> sections,
      List<String> requiredFields,
      List<String> searchableFields,
      List<String> listViewFields,
      Map<String, dynamic> layoutConfig,
      bool isActive,
      bool isSystemModel,
      bool allowDuplicates,
      bool enableAuditLog,
      bool enableVersioning,
      String? createdBy,
      String? updatedBy,
      @TimestampConverter() DateTime? createdAt,
      @TimestampConverter() DateTime? updatedAt});
}

/// @nodoc
class __$$DynamicModelImplCopyWithImpl<$Res>
    extends _$DynamicModelCopyWithImpl<$Res, _$DynamicModelImpl>
    implements _$$DynamicModelImplCopyWith<$Res> {
  __$$DynamicModelImplCopyWithImpl(
      _$DynamicModelImpl _value, $Res Function(_$DynamicModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? modelName = null,
    Object? displayName = null,
    Object? description = freezed,
    Object? icon = freezed,
    Object? category = freezed,
    Object? version = freezed,
    Object? organizationId = null,
    Object? fields = null,
    Object? validationRules = null,
    Object? relationships = null,
    Object? uiConfig = null,
    Object? permissions = null,
    Object? sections = null,
    Object? requiredFields = null,
    Object? searchableFields = null,
    Object? listViewFields = null,
    Object? layoutConfig = null,
    Object? isActive = null,
    Object? isSystemModel = null,
    Object? allowDuplicates = null,
    Object? enableAuditLog = null,
    Object? enableVersioning = null,
    Object? createdBy = freezed,
    Object? updatedBy = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$DynamicModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      modelName: null == modelName
          ? _value.modelName
          : modelName // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      icon: freezed == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      version: freezed == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String?,
      organizationId: null == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      fields: null == fields
          ? _value._fields
          : fields // ignore: cast_nullable_to_non_nullable
              as Map<String, DynamicField>,
      validationRules: null == validationRules
          ? _value._validationRules
          : validationRules // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      relationships: null == relationships
          ? _value._relationships
          : relationships // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      uiConfig: null == uiConfig
          ? _value._uiConfig
          : uiConfig // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      permissions: null == permissions
          ? _value._permissions
          : permissions // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      sections: null == sections
          ? _value._sections
          : sections // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      requiredFields: null == requiredFields
          ? _value._requiredFields
          : requiredFields // ignore: cast_nullable_to_non_nullable
              as List<String>,
      searchableFields: null == searchableFields
          ? _value._searchableFields
          : searchableFields // ignore: cast_nullable_to_non_nullable
              as List<String>,
      listViewFields: null == listViewFields
          ? _value._listViewFields
          : listViewFields // ignore: cast_nullable_to_non_nullable
              as List<String>,
      layoutConfig: null == layoutConfig
          ? _value._layoutConfig
          : layoutConfig // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      isSystemModel: null == isSystemModel
          ? _value.isSystemModel
          : isSystemModel // ignore: cast_nullable_to_non_nullable
              as bool,
      allowDuplicates: null == allowDuplicates
          ? _value.allowDuplicates
          : allowDuplicates // ignore: cast_nullable_to_non_nullable
              as bool,
      enableAuditLog: null == enableAuditLog
          ? _value.enableAuditLog
          : enableAuditLog // ignore: cast_nullable_to_non_nullable
              as bool,
      enableVersioning: null == enableVersioning
          ? _value.enableVersioning
          : enableVersioning // ignore: cast_nullable_to_non_nullable
              as bool,
      createdBy: freezed == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedBy: freezed == updatedBy
          ? _value.updatedBy
          : updatedBy // ignore: cast_nullable_to_non_nullable
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
class _$DynamicModelImpl extends _DynamicModel {
  const _$DynamicModelImpl(
      {required this.id,
      required this.modelName,
      required this.displayName,
      this.description,
      this.icon,
      this.category,
      this.version,
      required this.organizationId,
      required final Map<String, DynamicField> fields,
      final Map<String, dynamic> validationRules = const {},
      final Map<String, dynamic> relationships = const {},
      final Map<String, dynamic> uiConfig = const {},
      final Map<String, dynamic> permissions = const {},
      final Map<String, String> sections = const {},
      final List<String> requiredFields = const [],
      final List<String> searchableFields = const [],
      final List<String> listViewFields = const [],
      final Map<String, dynamic> layoutConfig = const {},
      this.isActive = true,
      this.isSystemModel = false,
      this.allowDuplicates = false,
      this.enableAuditLog = false,
      this.enableVersioning = false,
      this.createdBy,
      this.updatedBy,
      @TimestampConverter() this.createdAt,
      @TimestampConverter() this.updatedAt})
      : _fields = fields,
        _validationRules = validationRules,
        _relationships = relationships,
        _uiConfig = uiConfig,
        _permissions = permissions,
        _sections = sections,
        _requiredFields = requiredFields,
        _searchableFields = searchableFields,
        _listViewFields = listViewFields,
        _layoutConfig = layoutConfig,
        super._();

  factory _$DynamicModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DynamicModelImplFromJson(json);

  @override
  final String id;
  @override
  final String modelName;
  @override
  final String displayName;
  @override
  final String? description;
  @override
  final String? icon;
  @override
  final String? category;
// Equipment, Maintenance, Inspection, Report, etc.
  @override
  final String? version;
// Model version for compatibility
  @override
  final String organizationId;
  final Map<String, DynamicField> _fields;
  @override
  Map<String, DynamicField> get fields {
    if (_fields is EqualUnmodifiableMapView) return _fields;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_fields);
  }

  final Map<String, dynamic> _validationRules;
  @override
  @JsonKey()
  Map<String, dynamic> get validationRules {
    if (_validationRules is EqualUnmodifiableMapView) return _validationRules;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_validationRules);
  }

  final Map<String, dynamic> _relationships;
  @override
  @JsonKey()
  Map<String, dynamic> get relationships {
    if (_relationships is EqualUnmodifiableMapView) return _relationships;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_relationships);
  }

  final Map<String, dynamic> _uiConfig;
  @override
  @JsonKey()
  Map<String, dynamic> get uiConfig {
    if (_uiConfig is EqualUnmodifiableMapView) return _uiConfig;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_uiConfig);
  }

  final Map<String, dynamic> _permissions;
  @override
  @JsonKey()
  Map<String, dynamic> get permissions {
    if (_permissions is EqualUnmodifiableMapView) return _permissions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_permissions);
  }

  final Map<String, String> _sections;
  @override
  @JsonKey()
  Map<String, String> get sections {
    if (_sections is EqualUnmodifiableMapView) return _sections;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_sections);
  }

// Field grouping
  final List<String> _requiredFields;
// Field grouping
  @override
  @JsonKey()
  List<String> get requiredFields {
    if (_requiredFields is EqualUnmodifiableListView) return _requiredFields;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_requiredFields);
  }

  final List<String> _searchableFields;
  @override
  @JsonKey()
  List<String> get searchableFields {
    if (_searchableFields is EqualUnmodifiableListView)
      return _searchableFields;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_searchableFields);
  }

// For search functionality
  final List<String> _listViewFields;
// For search functionality
  @override
  @JsonKey()
  List<String> get listViewFields {
    if (_listViewFields is EqualUnmodifiableListView) return _listViewFields;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_listViewFields);
  }

// Fields to show in list views
  final Map<String, dynamic> _layoutConfig;
// Fields to show in list views
  @override
  @JsonKey()
  Map<String, dynamic> get layoutConfig {
    if (_layoutConfig is EqualUnmodifiableMapView) return _layoutConfig;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_layoutConfig);
  }

// Form layout configuration
  @override
  @JsonKey()
  final bool isActive;
  @override
  @JsonKey()
  final bool isSystemModel;
  @override
  @JsonKey()
  final bool allowDuplicates;
  @override
  @JsonKey()
  final bool enableAuditLog;
  @override
  @JsonKey()
  final bool enableVersioning;
  @override
  final String? createdBy;
  @override
  final String? updatedBy;
  @override
  @TimestampConverter()
  final DateTime? createdAt;
  @override
  @TimestampConverter()
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'DynamicModel(id: $id, modelName: $modelName, displayName: $displayName, description: $description, icon: $icon, category: $category, version: $version, organizationId: $organizationId, fields: $fields, validationRules: $validationRules, relationships: $relationships, uiConfig: $uiConfig, permissions: $permissions, sections: $sections, requiredFields: $requiredFields, searchableFields: $searchableFields, listViewFields: $listViewFields, layoutConfig: $layoutConfig, isActive: $isActive, isSystemModel: $isSystemModel, allowDuplicates: $allowDuplicates, enableAuditLog: $enableAuditLog, enableVersioning: $enableVersioning, createdBy: $createdBy, updatedBy: $updatedBy, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DynamicModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.modelName, modelName) ||
                other.modelName == modelName) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.organizationId, organizationId) ||
                other.organizationId == organizationId) &&
            const DeepCollectionEquality().equals(other._fields, _fields) &&
            const DeepCollectionEquality()
                .equals(other._validationRules, _validationRules) &&
            const DeepCollectionEquality()
                .equals(other._relationships, _relationships) &&
            const DeepCollectionEquality().equals(other._uiConfig, _uiConfig) &&
            const DeepCollectionEquality()
                .equals(other._permissions, _permissions) &&
            const DeepCollectionEquality().equals(other._sections, _sections) &&
            const DeepCollectionEquality()
                .equals(other._requiredFields, _requiredFields) &&
            const DeepCollectionEquality()
                .equals(other._searchableFields, _searchableFields) &&
            const DeepCollectionEquality()
                .equals(other._listViewFields, _listViewFields) &&
            const DeepCollectionEquality()
                .equals(other._layoutConfig, _layoutConfig) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.isSystemModel, isSystemModel) ||
                other.isSystemModel == isSystemModel) &&
            (identical(other.allowDuplicates, allowDuplicates) ||
                other.allowDuplicates == allowDuplicates) &&
            (identical(other.enableAuditLog, enableAuditLog) ||
                other.enableAuditLog == enableAuditLog) &&
            (identical(other.enableVersioning, enableVersioning) ||
                other.enableVersioning == enableVersioning) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.updatedBy, updatedBy) ||
                other.updatedBy == updatedBy) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        modelName,
        displayName,
        description,
        icon,
        category,
        version,
        organizationId,
        const DeepCollectionEquality().hash(_fields),
        const DeepCollectionEquality().hash(_validationRules),
        const DeepCollectionEquality().hash(_relationships),
        const DeepCollectionEquality().hash(_uiConfig),
        const DeepCollectionEquality().hash(_permissions),
        const DeepCollectionEquality().hash(_sections),
        const DeepCollectionEquality().hash(_requiredFields),
        const DeepCollectionEquality().hash(_searchableFields),
        const DeepCollectionEquality().hash(_listViewFields),
        const DeepCollectionEquality().hash(_layoutConfig),
        isActive,
        isSystemModel,
        allowDuplicates,
        enableAuditLog,
        enableVersioning,
        createdBy,
        updatedBy,
        createdAt,
        updatedAt
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DynamicModelImplCopyWith<_$DynamicModelImpl> get copyWith =>
      __$$DynamicModelImplCopyWithImpl<_$DynamicModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DynamicModelImplToJson(
      this,
    );
  }
}

abstract class _DynamicModel extends DynamicModel {
  const factory _DynamicModel(
      {required final String id,
      required final String modelName,
      required final String displayName,
      final String? description,
      final String? icon,
      final String? category,
      final String? version,
      required final String organizationId,
      required final Map<String, DynamicField> fields,
      final Map<String, dynamic> validationRules,
      final Map<String, dynamic> relationships,
      final Map<String, dynamic> uiConfig,
      final Map<String, dynamic> permissions,
      final Map<String, String> sections,
      final List<String> requiredFields,
      final List<String> searchableFields,
      final List<String> listViewFields,
      final Map<String, dynamic> layoutConfig,
      final bool isActive,
      final bool isSystemModel,
      final bool allowDuplicates,
      final bool enableAuditLog,
      final bool enableVersioning,
      final String? createdBy,
      final String? updatedBy,
      @TimestampConverter() final DateTime? createdAt,
      @TimestampConverter() final DateTime? updatedAt}) = _$DynamicModelImpl;
  const _DynamicModel._() : super._();

  factory _DynamicModel.fromJson(Map<String, dynamic> json) =
      _$DynamicModelImpl.fromJson;

  @override
  String get id;
  @override
  String get modelName;
  @override
  String get displayName;
  @override
  String? get description;
  @override
  String? get icon;
  @override
  String? get category;
  @override // Equipment, Maintenance, Inspection, Report, etc.
  String? get version;
  @override // Model version for compatibility
  String get organizationId;
  @override
  Map<String, DynamicField> get fields;
  @override
  Map<String, dynamic> get validationRules;
  @override
  Map<String, dynamic> get relationships;
  @override
  Map<String, dynamic> get uiConfig;
  @override
  Map<String, dynamic> get permissions;
  @override
  Map<String, String> get sections;
  @override // Field grouping
  List<String> get requiredFields;
  @override
  List<String> get searchableFields;
  @override // For search functionality
  List<String> get listViewFields;
  @override // Fields to show in list views
  Map<String, dynamic> get layoutConfig;
  @override // Form layout configuration
  bool get isActive;
  @override
  bool get isSystemModel;
  @override
  bool get allowDuplicates;
  @override
  bool get enableAuditLog;
  @override
  bool get enableVersioning;
  @override
  String? get createdBy;
  @override
  String? get updatedBy;
  @override
  @TimestampConverter()
  DateTime? get createdAt;
  @override
  @TimestampConverter()
  DateTime? get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$DynamicModelImplCopyWith<_$DynamicModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DynamicField _$DynamicFieldFromJson(Map<String, dynamic> json) {
  return _DynamicField.fromJson(json);
}

/// @nodoc
mixin _$DynamicField {
  String get fieldName => throw _privateConstructorUsedError;
  String get fieldType =>
      throw _privateConstructorUsedError; // Use FieldType enum values as strings
  String get displayName => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get helpText =>
      throw _privateConstructorUsedError; // Additional help text for users
  String? get placeholder => throw _privateConstructorUsedError;
  String? get section =>
      throw _privateConstructorUsedError; // Group fields in sections
  String? get prefix =>
      throw _privateConstructorUsedError; // Input prefix (e.g., "$", "₹")
  String? get suffix =>
      throw _privateConstructorUsedError; // Input suffix (e.g., "kV", "MW")
  bool get isRequired => throw _privateConstructorUsedError;
  bool get isEditable => throw _privateConstructorUsedError;
  bool get isVisible => throw _privateConstructorUsedError;
  bool get isUnique => throw _privateConstructorUsedError;
  bool get showInCreate =>
      throw _privateConstructorUsedError; // Show in create forms
  bool get showInEdit =>
      throw _privateConstructorUsedError; // Show in edit forms
  bool get showInView =>
      throw _privateConstructorUsedError; // Show in view/detail screens
  bool get showInList =>
      throw _privateConstructorUsedError; // Show in list views
  bool get isSearchable =>
      throw _privateConstructorUsedError; // Include in search
  List<String> get options =>
      throw _privateConstructorUsedError; // For selection fields
  Map<String, dynamic> get validationRules =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> get uiConfig => throw _privateConstructorUsedError;
  dynamic get defaultValue => throw _privateConstructorUsedError;
  String? get referenceModel =>
      throw _privateConstructorUsedError; // For reference fields
  String? get referenceField =>
      throw _privateConstructorUsedError; // Field to display from referenced model
  int get order =>
      throw _privateConstructorUsedError; // Additional validation properties
  int? get minLength => throw _privateConstructorUsedError;
  int? get maxLength => throw _privateConstructorUsedError;
  int? get maxLines =>
      throw _privateConstructorUsedError; // For textarea fields
  double? get minValue => throw _privateConstructorUsedError;
  double? get maxValue => throw _privateConstructorUsedError;
  String? get pattern =>
      throw _privateConstructorUsedError; // Regex pattern for validation
  String? get textCapitalization =>
      throw _privateConstructorUsedError; // none, words, sentences, characters
  DateTime? get minDate => throw _privateConstructorUsedError;
  DateTime? get maxDate => throw _privateConstructorUsedError;
  int? get divisions => throw _privateConstructorUsedError; // For slider fields
// UI enhancement properties
  String? get iconName =>
      throw _privateConstructorUsedError; // Icon to show with field
  String? get colorScheme =>
      throw _privateConstructorUsedError; // Color scheme for field
  bool get isReadOnly =>
      throw _privateConstructorUsedError; // Read-only in all contexts
  bool get isHidden =>
      throw _privateConstructorUsedError; // Hidden but present in data
  String? get conditionalLogic =>
      throw _privateConstructorUsedError; // Show/hide based on other field values
// File field properties
  List<String> get allowedFileTypes =>
      throw _privateConstructorUsedError; // For file fields
  int? get maxFileSize => throw _privateConstructorUsedError; // In bytes
  bool get allowMultiple =>
      throw _privateConstructorUsedError; // Allow multiple file selection
// Relationship properties
  String? get lookupFilter =>
      throw _privateConstructorUsedError; // Filter for lookup fields
  bool get cascadeDelete =>
      throw _privateConstructorUsedError; // Cascade delete for references
// Electrical industry specific
  String? get unitOfMeasure =>
      throw _privateConstructorUsedError; // kV, MW, A, etc.
  String? get equipmentCategory =>
      throw _privateConstructorUsedError; // For equipment-related fields
  bool get isCriticalField => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DynamicFieldCopyWith<DynamicField> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DynamicFieldCopyWith<$Res> {
  factory $DynamicFieldCopyWith(
          DynamicField value, $Res Function(DynamicField) then) =
      _$DynamicFieldCopyWithImpl<$Res, DynamicField>;
  @useResult
  $Res call(
      {String fieldName,
      String fieldType,
      String displayName,
      String? description,
      String? helpText,
      String? placeholder,
      String? section,
      String? prefix,
      String? suffix,
      bool isRequired,
      bool isEditable,
      bool isVisible,
      bool isUnique,
      bool showInCreate,
      bool showInEdit,
      bool showInView,
      bool showInList,
      bool isSearchable,
      List<String> options,
      Map<String, dynamic> validationRules,
      Map<String, dynamic> uiConfig,
      dynamic defaultValue,
      String? referenceModel,
      String? referenceField,
      int order,
      int? minLength,
      int? maxLength,
      int? maxLines,
      double? minValue,
      double? maxValue,
      String? pattern,
      String? textCapitalization,
      DateTime? minDate,
      DateTime? maxDate,
      int? divisions,
      String? iconName,
      String? colorScheme,
      bool isReadOnly,
      bool isHidden,
      String? conditionalLogic,
      List<String> allowedFileTypes,
      int? maxFileSize,
      bool allowMultiple,
      String? lookupFilter,
      bool cascadeDelete,
      String? unitOfMeasure,
      String? equipmentCategory,
      bool isCriticalField});
}

/// @nodoc
class _$DynamicFieldCopyWithImpl<$Res, $Val extends DynamicField>
    implements $DynamicFieldCopyWith<$Res> {
  _$DynamicFieldCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fieldName = null,
    Object? fieldType = null,
    Object? displayName = null,
    Object? description = freezed,
    Object? helpText = freezed,
    Object? placeholder = freezed,
    Object? section = freezed,
    Object? prefix = freezed,
    Object? suffix = freezed,
    Object? isRequired = null,
    Object? isEditable = null,
    Object? isVisible = null,
    Object? isUnique = null,
    Object? showInCreate = null,
    Object? showInEdit = null,
    Object? showInView = null,
    Object? showInList = null,
    Object? isSearchable = null,
    Object? options = null,
    Object? validationRules = null,
    Object? uiConfig = null,
    Object? defaultValue = freezed,
    Object? referenceModel = freezed,
    Object? referenceField = freezed,
    Object? order = null,
    Object? minLength = freezed,
    Object? maxLength = freezed,
    Object? maxLines = freezed,
    Object? minValue = freezed,
    Object? maxValue = freezed,
    Object? pattern = freezed,
    Object? textCapitalization = freezed,
    Object? minDate = freezed,
    Object? maxDate = freezed,
    Object? divisions = freezed,
    Object? iconName = freezed,
    Object? colorScheme = freezed,
    Object? isReadOnly = null,
    Object? isHidden = null,
    Object? conditionalLogic = freezed,
    Object? allowedFileTypes = null,
    Object? maxFileSize = freezed,
    Object? allowMultiple = null,
    Object? lookupFilter = freezed,
    Object? cascadeDelete = null,
    Object? unitOfMeasure = freezed,
    Object? equipmentCategory = freezed,
    Object? isCriticalField = null,
  }) {
    return _then(_value.copyWith(
      fieldName: null == fieldName
          ? _value.fieldName
          : fieldName // ignore: cast_nullable_to_non_nullable
              as String,
      fieldType: null == fieldType
          ? _value.fieldType
          : fieldType // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      helpText: freezed == helpText
          ? _value.helpText
          : helpText // ignore: cast_nullable_to_non_nullable
              as String?,
      placeholder: freezed == placeholder
          ? _value.placeholder
          : placeholder // ignore: cast_nullable_to_non_nullable
              as String?,
      section: freezed == section
          ? _value.section
          : section // ignore: cast_nullable_to_non_nullable
              as String?,
      prefix: freezed == prefix
          ? _value.prefix
          : prefix // ignore: cast_nullable_to_non_nullable
              as String?,
      suffix: freezed == suffix
          ? _value.suffix
          : suffix // ignore: cast_nullable_to_non_nullable
              as String?,
      isRequired: null == isRequired
          ? _value.isRequired
          : isRequired // ignore: cast_nullable_to_non_nullable
              as bool,
      isEditable: null == isEditable
          ? _value.isEditable
          : isEditable // ignore: cast_nullable_to_non_nullable
              as bool,
      isVisible: null == isVisible
          ? _value.isVisible
          : isVisible // ignore: cast_nullable_to_non_nullable
              as bool,
      isUnique: null == isUnique
          ? _value.isUnique
          : isUnique // ignore: cast_nullable_to_non_nullable
              as bool,
      showInCreate: null == showInCreate
          ? _value.showInCreate
          : showInCreate // ignore: cast_nullable_to_non_nullable
              as bool,
      showInEdit: null == showInEdit
          ? _value.showInEdit
          : showInEdit // ignore: cast_nullable_to_non_nullable
              as bool,
      showInView: null == showInView
          ? _value.showInView
          : showInView // ignore: cast_nullable_to_non_nullable
              as bool,
      showInList: null == showInList
          ? _value.showInList
          : showInList // ignore: cast_nullable_to_non_nullable
              as bool,
      isSearchable: null == isSearchable
          ? _value.isSearchable
          : isSearchable // ignore: cast_nullable_to_non_nullable
              as bool,
      options: null == options
          ? _value.options
          : options // ignore: cast_nullable_to_non_nullable
              as List<String>,
      validationRules: null == validationRules
          ? _value.validationRules
          : validationRules // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      uiConfig: null == uiConfig
          ? _value.uiConfig
          : uiConfig // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      defaultValue: freezed == defaultValue
          ? _value.defaultValue
          : defaultValue // ignore: cast_nullable_to_non_nullable
              as dynamic,
      referenceModel: freezed == referenceModel
          ? _value.referenceModel
          : referenceModel // ignore: cast_nullable_to_non_nullable
              as String?,
      referenceField: freezed == referenceField
          ? _value.referenceField
          : referenceField // ignore: cast_nullable_to_non_nullable
              as String?,
      order: null == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as int,
      minLength: freezed == minLength
          ? _value.minLength
          : minLength // ignore: cast_nullable_to_non_nullable
              as int?,
      maxLength: freezed == maxLength
          ? _value.maxLength
          : maxLength // ignore: cast_nullable_to_non_nullable
              as int?,
      maxLines: freezed == maxLines
          ? _value.maxLines
          : maxLines // ignore: cast_nullable_to_non_nullable
              as int?,
      minValue: freezed == minValue
          ? _value.minValue
          : minValue // ignore: cast_nullable_to_non_nullable
              as double?,
      maxValue: freezed == maxValue
          ? _value.maxValue
          : maxValue // ignore: cast_nullable_to_non_nullable
              as double?,
      pattern: freezed == pattern
          ? _value.pattern
          : pattern // ignore: cast_nullable_to_non_nullable
              as String?,
      textCapitalization: freezed == textCapitalization
          ? _value.textCapitalization
          : textCapitalization // ignore: cast_nullable_to_non_nullable
              as String?,
      minDate: freezed == minDate
          ? _value.minDate
          : minDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      maxDate: freezed == maxDate
          ? _value.maxDate
          : maxDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      divisions: freezed == divisions
          ? _value.divisions
          : divisions // ignore: cast_nullable_to_non_nullable
              as int?,
      iconName: freezed == iconName
          ? _value.iconName
          : iconName // ignore: cast_nullable_to_non_nullable
              as String?,
      colorScheme: freezed == colorScheme
          ? _value.colorScheme
          : colorScheme // ignore: cast_nullable_to_non_nullable
              as String?,
      isReadOnly: null == isReadOnly
          ? _value.isReadOnly
          : isReadOnly // ignore: cast_nullable_to_non_nullable
              as bool,
      isHidden: null == isHidden
          ? _value.isHidden
          : isHidden // ignore: cast_nullable_to_non_nullable
              as bool,
      conditionalLogic: freezed == conditionalLogic
          ? _value.conditionalLogic
          : conditionalLogic // ignore: cast_nullable_to_non_nullable
              as String?,
      allowedFileTypes: null == allowedFileTypes
          ? _value.allowedFileTypes
          : allowedFileTypes // ignore: cast_nullable_to_non_nullable
              as List<String>,
      maxFileSize: freezed == maxFileSize
          ? _value.maxFileSize
          : maxFileSize // ignore: cast_nullable_to_non_nullable
              as int?,
      allowMultiple: null == allowMultiple
          ? _value.allowMultiple
          : allowMultiple // ignore: cast_nullable_to_non_nullable
              as bool,
      lookupFilter: freezed == lookupFilter
          ? _value.lookupFilter
          : lookupFilter // ignore: cast_nullable_to_non_nullable
              as String?,
      cascadeDelete: null == cascadeDelete
          ? _value.cascadeDelete
          : cascadeDelete // ignore: cast_nullable_to_non_nullable
              as bool,
      unitOfMeasure: freezed == unitOfMeasure
          ? _value.unitOfMeasure
          : unitOfMeasure // ignore: cast_nullable_to_non_nullable
              as String?,
      equipmentCategory: freezed == equipmentCategory
          ? _value.equipmentCategory
          : equipmentCategory // ignore: cast_nullable_to_non_nullable
              as String?,
      isCriticalField: null == isCriticalField
          ? _value.isCriticalField
          : isCriticalField // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DynamicFieldImplCopyWith<$Res>
    implements $DynamicFieldCopyWith<$Res> {
  factory _$$DynamicFieldImplCopyWith(
          _$DynamicFieldImpl value, $Res Function(_$DynamicFieldImpl) then) =
      __$$DynamicFieldImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String fieldName,
      String fieldType,
      String displayName,
      String? description,
      String? helpText,
      String? placeholder,
      String? section,
      String? prefix,
      String? suffix,
      bool isRequired,
      bool isEditable,
      bool isVisible,
      bool isUnique,
      bool showInCreate,
      bool showInEdit,
      bool showInView,
      bool showInList,
      bool isSearchable,
      List<String> options,
      Map<String, dynamic> validationRules,
      Map<String, dynamic> uiConfig,
      dynamic defaultValue,
      String? referenceModel,
      String? referenceField,
      int order,
      int? minLength,
      int? maxLength,
      int? maxLines,
      double? minValue,
      double? maxValue,
      String? pattern,
      String? textCapitalization,
      DateTime? minDate,
      DateTime? maxDate,
      int? divisions,
      String? iconName,
      String? colorScheme,
      bool isReadOnly,
      bool isHidden,
      String? conditionalLogic,
      List<String> allowedFileTypes,
      int? maxFileSize,
      bool allowMultiple,
      String? lookupFilter,
      bool cascadeDelete,
      String? unitOfMeasure,
      String? equipmentCategory,
      bool isCriticalField});
}

/// @nodoc
class __$$DynamicFieldImplCopyWithImpl<$Res>
    extends _$DynamicFieldCopyWithImpl<$Res, _$DynamicFieldImpl>
    implements _$$DynamicFieldImplCopyWith<$Res> {
  __$$DynamicFieldImplCopyWithImpl(
      _$DynamicFieldImpl _value, $Res Function(_$DynamicFieldImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fieldName = null,
    Object? fieldType = null,
    Object? displayName = null,
    Object? description = freezed,
    Object? helpText = freezed,
    Object? placeholder = freezed,
    Object? section = freezed,
    Object? prefix = freezed,
    Object? suffix = freezed,
    Object? isRequired = null,
    Object? isEditable = null,
    Object? isVisible = null,
    Object? isUnique = null,
    Object? showInCreate = null,
    Object? showInEdit = null,
    Object? showInView = null,
    Object? showInList = null,
    Object? isSearchable = null,
    Object? options = null,
    Object? validationRules = null,
    Object? uiConfig = null,
    Object? defaultValue = freezed,
    Object? referenceModel = freezed,
    Object? referenceField = freezed,
    Object? order = null,
    Object? minLength = freezed,
    Object? maxLength = freezed,
    Object? maxLines = freezed,
    Object? minValue = freezed,
    Object? maxValue = freezed,
    Object? pattern = freezed,
    Object? textCapitalization = freezed,
    Object? minDate = freezed,
    Object? maxDate = freezed,
    Object? divisions = freezed,
    Object? iconName = freezed,
    Object? colorScheme = freezed,
    Object? isReadOnly = null,
    Object? isHidden = null,
    Object? conditionalLogic = freezed,
    Object? allowedFileTypes = null,
    Object? maxFileSize = freezed,
    Object? allowMultiple = null,
    Object? lookupFilter = freezed,
    Object? cascadeDelete = null,
    Object? unitOfMeasure = freezed,
    Object? equipmentCategory = freezed,
    Object? isCriticalField = null,
  }) {
    return _then(_$DynamicFieldImpl(
      fieldName: null == fieldName
          ? _value.fieldName
          : fieldName // ignore: cast_nullable_to_non_nullable
              as String,
      fieldType: null == fieldType
          ? _value.fieldType
          : fieldType // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      helpText: freezed == helpText
          ? _value.helpText
          : helpText // ignore: cast_nullable_to_non_nullable
              as String?,
      placeholder: freezed == placeholder
          ? _value.placeholder
          : placeholder // ignore: cast_nullable_to_non_nullable
              as String?,
      section: freezed == section
          ? _value.section
          : section // ignore: cast_nullable_to_non_nullable
              as String?,
      prefix: freezed == prefix
          ? _value.prefix
          : prefix // ignore: cast_nullable_to_non_nullable
              as String?,
      suffix: freezed == suffix
          ? _value.suffix
          : suffix // ignore: cast_nullable_to_non_nullable
              as String?,
      isRequired: null == isRequired
          ? _value.isRequired
          : isRequired // ignore: cast_nullable_to_non_nullable
              as bool,
      isEditable: null == isEditable
          ? _value.isEditable
          : isEditable // ignore: cast_nullable_to_non_nullable
              as bool,
      isVisible: null == isVisible
          ? _value.isVisible
          : isVisible // ignore: cast_nullable_to_non_nullable
              as bool,
      isUnique: null == isUnique
          ? _value.isUnique
          : isUnique // ignore: cast_nullable_to_non_nullable
              as bool,
      showInCreate: null == showInCreate
          ? _value.showInCreate
          : showInCreate // ignore: cast_nullable_to_non_nullable
              as bool,
      showInEdit: null == showInEdit
          ? _value.showInEdit
          : showInEdit // ignore: cast_nullable_to_non_nullable
              as bool,
      showInView: null == showInView
          ? _value.showInView
          : showInView // ignore: cast_nullable_to_non_nullable
              as bool,
      showInList: null == showInList
          ? _value.showInList
          : showInList // ignore: cast_nullable_to_non_nullable
              as bool,
      isSearchable: null == isSearchable
          ? _value.isSearchable
          : isSearchable // ignore: cast_nullable_to_non_nullable
              as bool,
      options: null == options
          ? _value._options
          : options // ignore: cast_nullable_to_non_nullable
              as List<String>,
      validationRules: null == validationRules
          ? _value._validationRules
          : validationRules // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      uiConfig: null == uiConfig
          ? _value._uiConfig
          : uiConfig // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      defaultValue: freezed == defaultValue
          ? _value.defaultValue
          : defaultValue // ignore: cast_nullable_to_non_nullable
              as dynamic,
      referenceModel: freezed == referenceModel
          ? _value.referenceModel
          : referenceModel // ignore: cast_nullable_to_non_nullable
              as String?,
      referenceField: freezed == referenceField
          ? _value.referenceField
          : referenceField // ignore: cast_nullable_to_non_nullable
              as String?,
      order: null == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as int,
      minLength: freezed == minLength
          ? _value.minLength
          : minLength // ignore: cast_nullable_to_non_nullable
              as int?,
      maxLength: freezed == maxLength
          ? _value.maxLength
          : maxLength // ignore: cast_nullable_to_non_nullable
              as int?,
      maxLines: freezed == maxLines
          ? _value.maxLines
          : maxLines // ignore: cast_nullable_to_non_nullable
              as int?,
      minValue: freezed == minValue
          ? _value.minValue
          : minValue // ignore: cast_nullable_to_non_nullable
              as double?,
      maxValue: freezed == maxValue
          ? _value.maxValue
          : maxValue // ignore: cast_nullable_to_non_nullable
              as double?,
      pattern: freezed == pattern
          ? _value.pattern
          : pattern // ignore: cast_nullable_to_non_nullable
              as String?,
      textCapitalization: freezed == textCapitalization
          ? _value.textCapitalization
          : textCapitalization // ignore: cast_nullable_to_non_nullable
              as String?,
      minDate: freezed == minDate
          ? _value.minDate
          : minDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      maxDate: freezed == maxDate
          ? _value.maxDate
          : maxDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      divisions: freezed == divisions
          ? _value.divisions
          : divisions // ignore: cast_nullable_to_non_nullable
              as int?,
      iconName: freezed == iconName
          ? _value.iconName
          : iconName // ignore: cast_nullable_to_non_nullable
              as String?,
      colorScheme: freezed == colorScheme
          ? _value.colorScheme
          : colorScheme // ignore: cast_nullable_to_non_nullable
              as String?,
      isReadOnly: null == isReadOnly
          ? _value.isReadOnly
          : isReadOnly // ignore: cast_nullable_to_non_nullable
              as bool,
      isHidden: null == isHidden
          ? _value.isHidden
          : isHidden // ignore: cast_nullable_to_non_nullable
              as bool,
      conditionalLogic: freezed == conditionalLogic
          ? _value.conditionalLogic
          : conditionalLogic // ignore: cast_nullable_to_non_nullable
              as String?,
      allowedFileTypes: null == allowedFileTypes
          ? _value._allowedFileTypes
          : allowedFileTypes // ignore: cast_nullable_to_non_nullable
              as List<String>,
      maxFileSize: freezed == maxFileSize
          ? _value.maxFileSize
          : maxFileSize // ignore: cast_nullable_to_non_nullable
              as int?,
      allowMultiple: null == allowMultiple
          ? _value.allowMultiple
          : allowMultiple // ignore: cast_nullable_to_non_nullable
              as bool,
      lookupFilter: freezed == lookupFilter
          ? _value.lookupFilter
          : lookupFilter // ignore: cast_nullable_to_non_nullable
              as String?,
      cascadeDelete: null == cascadeDelete
          ? _value.cascadeDelete
          : cascadeDelete // ignore: cast_nullable_to_non_nullable
              as bool,
      unitOfMeasure: freezed == unitOfMeasure
          ? _value.unitOfMeasure
          : unitOfMeasure // ignore: cast_nullable_to_non_nullable
              as String?,
      equipmentCategory: freezed == equipmentCategory
          ? _value.equipmentCategory
          : equipmentCategory // ignore: cast_nullable_to_non_nullable
              as String?,
      isCriticalField: null == isCriticalField
          ? _value.isCriticalField
          : isCriticalField // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DynamicFieldImpl extends _DynamicField {
  const _$DynamicFieldImpl(
      {required this.fieldName,
      required this.fieldType,
      required this.displayName,
      this.description,
      this.helpText,
      this.placeholder,
      this.section,
      this.prefix,
      this.suffix,
      this.isRequired = false,
      this.isEditable = true,
      this.isVisible = true,
      this.isUnique = false,
      this.showInCreate = true,
      this.showInEdit = true,
      this.showInView = true,
      this.showInList = false,
      this.isSearchable = false,
      final List<String> options = const [],
      final Map<String, dynamic> validationRules = const {},
      final Map<String, dynamic> uiConfig = const {},
      this.defaultValue,
      this.referenceModel,
      this.referenceField,
      this.order = 0,
      this.minLength,
      this.maxLength,
      this.maxLines,
      this.minValue,
      this.maxValue,
      this.pattern,
      this.textCapitalization,
      this.minDate,
      this.maxDate,
      this.divisions,
      this.iconName,
      this.colorScheme,
      this.isReadOnly = false,
      this.isHidden = false,
      this.conditionalLogic,
      final List<String> allowedFileTypes = const [],
      this.maxFileSize,
      this.allowMultiple = false,
      this.lookupFilter,
      this.cascadeDelete = false,
      this.unitOfMeasure,
      this.equipmentCategory,
      this.isCriticalField = false})
      : _options = options,
        _validationRules = validationRules,
        _uiConfig = uiConfig,
        _allowedFileTypes = allowedFileTypes,
        super._();

  factory _$DynamicFieldImpl.fromJson(Map<String, dynamic> json) =>
      _$$DynamicFieldImplFromJson(json);

  @override
  final String fieldName;
  @override
  final String fieldType;
// Use FieldType enum values as strings
  @override
  final String displayName;
  @override
  final String? description;
  @override
  final String? helpText;
// Additional help text for users
  @override
  final String? placeholder;
  @override
  final String? section;
// Group fields in sections
  @override
  final String? prefix;
// Input prefix (e.g., "$", "₹")
  @override
  final String? suffix;
// Input suffix (e.g., "kV", "MW")
  @override
  @JsonKey()
  final bool isRequired;
  @override
  @JsonKey()
  final bool isEditable;
  @override
  @JsonKey()
  final bool isVisible;
  @override
  @JsonKey()
  final bool isUnique;
  @override
  @JsonKey()
  final bool showInCreate;
// Show in create forms
  @override
  @JsonKey()
  final bool showInEdit;
// Show in edit forms
  @override
  @JsonKey()
  final bool showInView;
// Show in view/detail screens
  @override
  @JsonKey()
  final bool showInList;
// Show in list views
  @override
  @JsonKey()
  final bool isSearchable;
// Include in search
  final List<String> _options;
// Include in search
  @override
  @JsonKey()
  List<String> get options {
    if (_options is EqualUnmodifiableListView) return _options;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_options);
  }

// For selection fields
  final Map<String, dynamic> _validationRules;
// For selection fields
  @override
  @JsonKey()
  Map<String, dynamic> get validationRules {
    if (_validationRules is EqualUnmodifiableMapView) return _validationRules;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_validationRules);
  }

  final Map<String, dynamic> _uiConfig;
  @override
  @JsonKey()
  Map<String, dynamic> get uiConfig {
    if (_uiConfig is EqualUnmodifiableMapView) return _uiConfig;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_uiConfig);
  }

  @override
  final dynamic defaultValue;
  @override
  final String? referenceModel;
// For reference fields
  @override
  final String? referenceField;
// Field to display from referenced model
  @override
  @JsonKey()
  final int order;
// Additional validation properties
  @override
  final int? minLength;
  @override
  final int? maxLength;
  @override
  final int? maxLines;
// For textarea fields
  @override
  final double? minValue;
  @override
  final double? maxValue;
  @override
  final String? pattern;
// Regex pattern for validation
  @override
  final String? textCapitalization;
// none, words, sentences, characters
  @override
  final DateTime? minDate;
  @override
  final DateTime? maxDate;
  @override
  final int? divisions;
// For slider fields
// UI enhancement properties
  @override
  final String? iconName;
// Icon to show with field
  @override
  final String? colorScheme;
// Color scheme for field
  @override
  @JsonKey()
  final bool isReadOnly;
// Read-only in all contexts
  @override
  @JsonKey()
  final bool isHidden;
// Hidden but present in data
  @override
  final String? conditionalLogic;
// Show/hide based on other field values
// File field properties
  final List<String> _allowedFileTypes;
// Show/hide based on other field values
// File field properties
  @override
  @JsonKey()
  List<String> get allowedFileTypes {
    if (_allowedFileTypes is EqualUnmodifiableListView)
      return _allowedFileTypes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allowedFileTypes);
  }

// For file fields
  @override
  final int? maxFileSize;
// In bytes
  @override
  @JsonKey()
  final bool allowMultiple;
// Allow multiple file selection
// Relationship properties
  @override
  final String? lookupFilter;
// Filter for lookup fields
  @override
  @JsonKey()
  final bool cascadeDelete;
// Cascade delete for references
// Electrical industry specific
  @override
  final String? unitOfMeasure;
// kV, MW, A, etc.
  @override
  final String? equipmentCategory;
// For equipment-related fields
  @override
  @JsonKey()
  final bool isCriticalField;

  @override
  String toString() {
    return 'DynamicField(fieldName: $fieldName, fieldType: $fieldType, displayName: $displayName, description: $description, helpText: $helpText, placeholder: $placeholder, section: $section, prefix: $prefix, suffix: $suffix, isRequired: $isRequired, isEditable: $isEditable, isVisible: $isVisible, isUnique: $isUnique, showInCreate: $showInCreate, showInEdit: $showInEdit, showInView: $showInView, showInList: $showInList, isSearchable: $isSearchable, options: $options, validationRules: $validationRules, uiConfig: $uiConfig, defaultValue: $defaultValue, referenceModel: $referenceModel, referenceField: $referenceField, order: $order, minLength: $minLength, maxLength: $maxLength, maxLines: $maxLines, minValue: $minValue, maxValue: $maxValue, pattern: $pattern, textCapitalization: $textCapitalization, minDate: $minDate, maxDate: $maxDate, divisions: $divisions, iconName: $iconName, colorScheme: $colorScheme, isReadOnly: $isReadOnly, isHidden: $isHidden, conditionalLogic: $conditionalLogic, allowedFileTypes: $allowedFileTypes, maxFileSize: $maxFileSize, allowMultiple: $allowMultiple, lookupFilter: $lookupFilter, cascadeDelete: $cascadeDelete, unitOfMeasure: $unitOfMeasure, equipmentCategory: $equipmentCategory, isCriticalField: $isCriticalField)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DynamicFieldImpl &&
            (identical(other.fieldName, fieldName) ||
                other.fieldName == fieldName) &&
            (identical(other.fieldType, fieldType) ||
                other.fieldType == fieldType) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.helpText, helpText) ||
                other.helpText == helpText) &&
            (identical(other.placeholder, placeholder) ||
                other.placeholder == placeholder) &&
            (identical(other.section, section) || other.section == section) &&
            (identical(other.prefix, prefix) || other.prefix == prefix) &&
            (identical(other.suffix, suffix) || other.suffix == suffix) &&
            (identical(other.isRequired, isRequired) ||
                other.isRequired == isRequired) &&
            (identical(other.isEditable, isEditable) ||
                other.isEditable == isEditable) &&
            (identical(other.isVisible, isVisible) ||
                other.isVisible == isVisible) &&
            (identical(other.isUnique, isUnique) ||
                other.isUnique == isUnique) &&
            (identical(other.showInCreate, showInCreate) ||
                other.showInCreate == showInCreate) &&
            (identical(other.showInEdit, showInEdit) ||
                other.showInEdit == showInEdit) &&
            (identical(other.showInView, showInView) ||
                other.showInView == showInView) &&
            (identical(other.showInList, showInList) ||
                other.showInList == showInList) &&
            (identical(other.isSearchable, isSearchable) ||
                other.isSearchable == isSearchable) &&
            const DeepCollectionEquality().equals(other._options, _options) &&
            const DeepCollectionEquality()
                .equals(other._validationRules, _validationRules) &&
            const DeepCollectionEquality().equals(other._uiConfig, _uiConfig) &&
            const DeepCollectionEquality()
                .equals(other.defaultValue, defaultValue) &&
            (identical(other.referenceModel, referenceModel) ||
                other.referenceModel == referenceModel) &&
            (identical(other.referenceField, referenceField) ||
                other.referenceField == referenceField) &&
            (identical(other.order, order) || other.order == order) &&
            (identical(other.minLength, minLength) ||
                other.minLength == minLength) &&
            (identical(other.maxLength, maxLength) ||
                other.maxLength == maxLength) &&
            (identical(other.maxLines, maxLines) ||
                other.maxLines == maxLines) &&
            (identical(other.minValue, minValue) ||
                other.minValue == minValue) &&
            (identical(other.maxValue, maxValue) ||
                other.maxValue == maxValue) &&
            (identical(other.pattern, pattern) || other.pattern == pattern) &&
            (identical(other.textCapitalization, textCapitalization) ||
                other.textCapitalization == textCapitalization) &&
            (identical(other.minDate, minDate) || other.minDate == minDate) &&
            (identical(other.maxDate, maxDate) || other.maxDate == maxDate) &&
            (identical(other.divisions, divisions) ||
                other.divisions == divisions) &&
            (identical(other.iconName, iconName) ||
                other.iconName == iconName) &&
            (identical(other.colorScheme, colorScheme) ||
                other.colorScheme == colorScheme) &&
            (identical(other.isReadOnly, isReadOnly) ||
                other.isReadOnly == isReadOnly) &&
            (identical(other.isHidden, isHidden) ||
                other.isHidden == isHidden) &&
            (identical(other.conditionalLogic, conditionalLogic) ||
                other.conditionalLogic == conditionalLogic) &&
            const DeepCollectionEquality()
                .equals(other._allowedFileTypes, _allowedFileTypes) &&
            (identical(other.maxFileSize, maxFileSize) ||
                other.maxFileSize == maxFileSize) &&
            (identical(other.allowMultiple, allowMultiple) ||
                other.allowMultiple == allowMultiple) &&
            (identical(other.lookupFilter, lookupFilter) ||
                other.lookupFilter == lookupFilter) &&
            (identical(other.cascadeDelete, cascadeDelete) ||
                other.cascadeDelete == cascadeDelete) &&
            (identical(other.unitOfMeasure, unitOfMeasure) ||
                other.unitOfMeasure == unitOfMeasure) &&
            (identical(other.equipmentCategory, equipmentCategory) ||
                other.equipmentCategory == equipmentCategory) &&
            (identical(other.isCriticalField, isCriticalField) ||
                other.isCriticalField == isCriticalField));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        fieldName,
        fieldType,
        displayName,
        description,
        helpText,
        placeholder,
        section,
        prefix,
        suffix,
        isRequired,
        isEditable,
        isVisible,
        isUnique,
        showInCreate,
        showInEdit,
        showInView,
        showInList,
        isSearchable,
        const DeepCollectionEquality().hash(_options),
        const DeepCollectionEquality().hash(_validationRules),
        const DeepCollectionEquality().hash(_uiConfig),
        const DeepCollectionEquality().hash(defaultValue),
        referenceModel,
        referenceField,
        order,
        minLength,
        maxLength,
        maxLines,
        minValue,
        maxValue,
        pattern,
        textCapitalization,
        minDate,
        maxDate,
        divisions,
        iconName,
        colorScheme,
        isReadOnly,
        isHidden,
        conditionalLogic,
        const DeepCollectionEquality().hash(_allowedFileTypes),
        maxFileSize,
        allowMultiple,
        lookupFilter,
        cascadeDelete,
        unitOfMeasure,
        equipmentCategory,
        isCriticalField
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DynamicFieldImplCopyWith<_$DynamicFieldImpl> get copyWith =>
      __$$DynamicFieldImplCopyWithImpl<_$DynamicFieldImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DynamicFieldImplToJson(
      this,
    );
  }
}

abstract class _DynamicField extends DynamicField {
  const factory _DynamicField(
      {required final String fieldName,
      required final String fieldType,
      required final String displayName,
      final String? description,
      final String? helpText,
      final String? placeholder,
      final String? section,
      final String? prefix,
      final String? suffix,
      final bool isRequired,
      final bool isEditable,
      final bool isVisible,
      final bool isUnique,
      final bool showInCreate,
      final bool showInEdit,
      final bool showInView,
      final bool showInList,
      final bool isSearchable,
      final List<String> options,
      final Map<String, dynamic> validationRules,
      final Map<String, dynamic> uiConfig,
      final dynamic defaultValue,
      final String? referenceModel,
      final String? referenceField,
      final int order,
      final int? minLength,
      final int? maxLength,
      final int? maxLines,
      final double? minValue,
      final double? maxValue,
      final String? pattern,
      final String? textCapitalization,
      final DateTime? minDate,
      final DateTime? maxDate,
      final int? divisions,
      final String? iconName,
      final String? colorScheme,
      final bool isReadOnly,
      final bool isHidden,
      final String? conditionalLogic,
      final List<String> allowedFileTypes,
      final int? maxFileSize,
      final bool allowMultiple,
      final String? lookupFilter,
      final bool cascadeDelete,
      final String? unitOfMeasure,
      final String? equipmentCategory,
      final bool isCriticalField}) = _$DynamicFieldImpl;
  const _DynamicField._() : super._();

  factory _DynamicField.fromJson(Map<String, dynamic> json) =
      _$DynamicFieldImpl.fromJson;

  @override
  String get fieldName;
  @override
  String get fieldType;
  @override // Use FieldType enum values as strings
  String get displayName;
  @override
  String? get description;
  @override
  String? get helpText;
  @override // Additional help text for users
  String? get placeholder;
  @override
  String? get section;
  @override // Group fields in sections
  String? get prefix;
  @override // Input prefix (e.g., "$", "₹")
  String? get suffix;
  @override // Input suffix (e.g., "kV", "MW")
  bool get isRequired;
  @override
  bool get isEditable;
  @override
  bool get isVisible;
  @override
  bool get isUnique;
  @override
  bool get showInCreate;
  @override // Show in create forms
  bool get showInEdit;
  @override // Show in edit forms
  bool get showInView;
  @override // Show in view/detail screens
  bool get showInList;
  @override // Show in list views
  bool get isSearchable;
  @override // Include in search
  List<String> get options;
  @override // For selection fields
  Map<String, dynamic> get validationRules;
  @override
  Map<String, dynamic> get uiConfig;
  @override
  dynamic get defaultValue;
  @override
  String? get referenceModel;
  @override // For reference fields
  String? get referenceField;
  @override // Field to display from referenced model
  int get order;
  @override // Additional validation properties
  int? get minLength;
  @override
  int? get maxLength;
  @override
  int? get maxLines;
  @override // For textarea fields
  double? get minValue;
  @override
  double? get maxValue;
  @override
  String? get pattern;
  @override // Regex pattern for validation
  String? get textCapitalization;
  @override // none, words, sentences, characters
  DateTime? get minDate;
  @override
  DateTime? get maxDate;
  @override
  int? get divisions;
  @override // For slider fields
// UI enhancement properties
  String? get iconName;
  @override // Icon to show with field
  String? get colorScheme;
  @override // Color scheme for field
  bool get isReadOnly;
  @override // Read-only in all contexts
  bool get isHidden;
  @override // Hidden but present in data
  String? get conditionalLogic;
  @override // Show/hide based on other field values
// File field properties
  List<String> get allowedFileTypes;
  @override // For file fields
  int? get maxFileSize;
  @override // In bytes
  bool get allowMultiple;
  @override // Allow multiple file selection
// Relationship properties
  String? get lookupFilter;
  @override // Filter for lookup fields
  bool get cascadeDelete;
  @override // Cascade delete for references
// Electrical industry specific
  String? get unitOfMeasure;
  @override // kV, MW, A, etc.
  String? get equipmentCategory;
  @override // For equipment-related fields
  bool get isCriticalField;
  @override
  @JsonKey(ignore: true)
  _$$DynamicFieldImplCopyWith<_$DynamicFieldImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DynamicRecord _$DynamicRecordFromJson(Map<String, dynamic> json) {
  return _DynamicRecord.fromJson(json);
}

/// @nodoc
mixin _$DynamicRecord {
  String get id => throw _privateConstructorUsedError;
  String get modelId => throw _privateConstructorUsedError;
  String get organizationId => throw _privateConstructorUsedError;
  Map<String, dynamic> get data => throw _privateConstructorUsedError;
  Map<String, dynamic> get metadata => throw _privateConstructorUsedError;
  Map<String, dynamic> get computedFields =>
      throw _privateConstructorUsedError; // Calculated fields
  Map<String, dynamic> get auditLog =>
      throw _privateConstructorUsedError; // Change history
  String get status =>
      throw _privateConstructorUsedError; // draft, active, archived, deleted
  int get version =>
      throw _privateConstructorUsedError; // Record version for optimistic locking
  String? get createdBy => throw _privateConstructorUsedError;
  String? get updatedBy => throw _privateConstructorUsedError;
  String? get assignedTo =>
      throw _privateConstructorUsedError; // For workflow management
  bool get isActive => throw _privateConstructorUsedError;
  bool get isLocked => throw _privateConstructorUsedError; // Prevent editing
  @TimestampConverter()
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get lastAccessedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DynamicRecordCopyWith<DynamicRecord> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DynamicRecordCopyWith<$Res> {
  factory $DynamicRecordCopyWith(
          DynamicRecord value, $Res Function(DynamicRecord) then) =
      _$DynamicRecordCopyWithImpl<$Res, DynamicRecord>;
  @useResult
  $Res call(
      {String id,
      String modelId,
      String organizationId,
      Map<String, dynamic> data,
      Map<String, dynamic> metadata,
      Map<String, dynamic> computedFields,
      Map<String, dynamic> auditLog,
      String status,
      int version,
      String? createdBy,
      String? updatedBy,
      String? assignedTo,
      bool isActive,
      bool isLocked,
      @TimestampConverter() DateTime? createdAt,
      @TimestampConverter() DateTime? updatedAt,
      @TimestampConverter() DateTime? lastAccessedAt});
}

/// @nodoc
class _$DynamicRecordCopyWithImpl<$Res, $Val extends DynamicRecord>
    implements $DynamicRecordCopyWith<$Res> {
  _$DynamicRecordCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? modelId = null,
    Object? organizationId = null,
    Object? data = null,
    Object? metadata = null,
    Object? computedFields = null,
    Object? auditLog = null,
    Object? status = null,
    Object? version = null,
    Object? createdBy = freezed,
    Object? updatedBy = freezed,
    Object? assignedTo = freezed,
    Object? isActive = null,
    Object? isLocked = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? lastAccessedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      modelId: null == modelId
          ? _value.modelId
          : modelId // ignore: cast_nullable_to_non_nullable
              as String,
      organizationId: null == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      metadata: null == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      computedFields: null == computedFields
          ? _value.computedFields
          : computedFields // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      auditLog: null == auditLog
          ? _value.auditLog
          : auditLog // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as int,
      createdBy: freezed == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedBy: freezed == updatedBy
          ? _value.updatedBy
          : updatedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      assignedTo: freezed == assignedTo
          ? _value.assignedTo
          : assignedTo // ignore: cast_nullable_to_non_nullable
              as String?,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      isLocked: null == isLocked
          ? _value.isLocked
          : isLocked // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastAccessedAt: freezed == lastAccessedAt
          ? _value.lastAccessedAt
          : lastAccessedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DynamicRecordImplCopyWith<$Res>
    implements $DynamicRecordCopyWith<$Res> {
  factory _$$DynamicRecordImplCopyWith(
          _$DynamicRecordImpl value, $Res Function(_$DynamicRecordImpl) then) =
      __$$DynamicRecordImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String modelId,
      String organizationId,
      Map<String, dynamic> data,
      Map<String, dynamic> metadata,
      Map<String, dynamic> computedFields,
      Map<String, dynamic> auditLog,
      String status,
      int version,
      String? createdBy,
      String? updatedBy,
      String? assignedTo,
      bool isActive,
      bool isLocked,
      @TimestampConverter() DateTime? createdAt,
      @TimestampConverter() DateTime? updatedAt,
      @TimestampConverter() DateTime? lastAccessedAt});
}

/// @nodoc
class __$$DynamicRecordImplCopyWithImpl<$Res>
    extends _$DynamicRecordCopyWithImpl<$Res, _$DynamicRecordImpl>
    implements _$$DynamicRecordImplCopyWith<$Res> {
  __$$DynamicRecordImplCopyWithImpl(
      _$DynamicRecordImpl _value, $Res Function(_$DynamicRecordImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? modelId = null,
    Object? organizationId = null,
    Object? data = null,
    Object? metadata = null,
    Object? computedFields = null,
    Object? auditLog = null,
    Object? status = null,
    Object? version = null,
    Object? createdBy = freezed,
    Object? updatedBy = freezed,
    Object? assignedTo = freezed,
    Object? isActive = null,
    Object? isLocked = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? lastAccessedAt = freezed,
  }) {
    return _then(_$DynamicRecordImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      modelId: null == modelId
          ? _value.modelId
          : modelId // ignore: cast_nullable_to_non_nullable
              as String,
      organizationId: null == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      metadata: null == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      computedFields: null == computedFields
          ? _value._computedFields
          : computedFields // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      auditLog: null == auditLog
          ? _value._auditLog
          : auditLog // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as int,
      createdBy: freezed == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedBy: freezed == updatedBy
          ? _value.updatedBy
          : updatedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      assignedTo: freezed == assignedTo
          ? _value.assignedTo
          : assignedTo // ignore: cast_nullable_to_non_nullable
              as String?,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      isLocked: null == isLocked
          ? _value.isLocked
          : isLocked // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastAccessedAt: freezed == lastAccessedAt
          ? _value.lastAccessedAt
          : lastAccessedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DynamicRecordImpl extends _DynamicRecord {
  const _$DynamicRecordImpl(
      {required this.id,
      required this.modelId,
      required this.organizationId,
      required final Map<String, dynamic> data,
      final Map<String, dynamic> metadata = const {},
      final Map<String, dynamic> computedFields = const {},
      final Map<String, dynamic> auditLog = const {},
      this.status = 'draft',
      this.version = 1,
      this.createdBy,
      this.updatedBy,
      this.assignedTo,
      this.isActive = true,
      this.isLocked = false,
      @TimestampConverter() this.createdAt,
      @TimestampConverter() this.updatedAt,
      @TimestampConverter() this.lastAccessedAt})
      : _data = data,
        _metadata = metadata,
        _computedFields = computedFields,
        _auditLog = auditLog,
        super._();

  factory _$DynamicRecordImpl.fromJson(Map<String, dynamic> json) =>
      _$$DynamicRecordImplFromJson(json);

  @override
  final String id;
  @override
  final String modelId;
  @override
  final String organizationId;
  final Map<String, dynamic> _data;
  @override
  Map<String, dynamic> get data {
    if (_data is EqualUnmodifiableMapView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_data);
  }

  final Map<String, dynamic> _metadata;
  @override
  @JsonKey()
  Map<String, dynamic> get metadata {
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_metadata);
  }

  final Map<String, dynamic> _computedFields;
  @override
  @JsonKey()
  Map<String, dynamic> get computedFields {
    if (_computedFields is EqualUnmodifiableMapView) return _computedFields;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_computedFields);
  }

// Calculated fields
  final Map<String, dynamic> _auditLog;
// Calculated fields
  @override
  @JsonKey()
  Map<String, dynamic> get auditLog {
    if (_auditLog is EqualUnmodifiableMapView) return _auditLog;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_auditLog);
  }

// Change history
  @override
  @JsonKey()
  final String status;
// draft, active, archived, deleted
  @override
  @JsonKey()
  final int version;
// Record version for optimistic locking
  @override
  final String? createdBy;
  @override
  final String? updatedBy;
  @override
  final String? assignedTo;
// For workflow management
  @override
  @JsonKey()
  final bool isActive;
  @override
  @JsonKey()
  final bool isLocked;
// Prevent editing
  @override
  @TimestampConverter()
  final DateTime? createdAt;
  @override
  @TimestampConverter()
  final DateTime? updatedAt;
  @override
  @TimestampConverter()
  final DateTime? lastAccessedAt;

  @override
  String toString() {
    return 'DynamicRecord(id: $id, modelId: $modelId, organizationId: $organizationId, data: $data, metadata: $metadata, computedFields: $computedFields, auditLog: $auditLog, status: $status, version: $version, createdBy: $createdBy, updatedBy: $updatedBy, assignedTo: $assignedTo, isActive: $isActive, isLocked: $isLocked, createdAt: $createdAt, updatedAt: $updatedAt, lastAccessedAt: $lastAccessedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DynamicRecordImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.modelId, modelId) || other.modelId == modelId) &&
            (identical(other.organizationId, organizationId) ||
                other.organizationId == organizationId) &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata) &&
            const DeepCollectionEquality()
                .equals(other._computedFields, _computedFields) &&
            const DeepCollectionEquality().equals(other._auditLog, _auditLog) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.updatedBy, updatedBy) ||
                other.updatedBy == updatedBy) &&
            (identical(other.assignedTo, assignedTo) ||
                other.assignedTo == assignedTo) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.isLocked, isLocked) ||
                other.isLocked == isLocked) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.lastAccessedAt, lastAccessedAt) ||
                other.lastAccessedAt == lastAccessedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      modelId,
      organizationId,
      const DeepCollectionEquality().hash(_data),
      const DeepCollectionEquality().hash(_metadata),
      const DeepCollectionEquality().hash(_computedFields),
      const DeepCollectionEquality().hash(_auditLog),
      status,
      version,
      createdBy,
      updatedBy,
      assignedTo,
      isActive,
      isLocked,
      createdAt,
      updatedAt,
      lastAccessedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DynamicRecordImplCopyWith<_$DynamicRecordImpl> get copyWith =>
      __$$DynamicRecordImplCopyWithImpl<_$DynamicRecordImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DynamicRecordImplToJson(
      this,
    );
  }
}

abstract class _DynamicRecord extends DynamicRecord {
  const factory _DynamicRecord(
          {required final String id,
          required final String modelId,
          required final String organizationId,
          required final Map<String, dynamic> data,
          final Map<String, dynamic> metadata,
          final Map<String, dynamic> computedFields,
          final Map<String, dynamic> auditLog,
          final String status,
          final int version,
          final String? createdBy,
          final String? updatedBy,
          final String? assignedTo,
          final bool isActive,
          final bool isLocked,
          @TimestampConverter() final DateTime? createdAt,
          @TimestampConverter() final DateTime? updatedAt,
          @TimestampConverter() final DateTime? lastAccessedAt}) =
      _$DynamicRecordImpl;
  const _DynamicRecord._() : super._();

  factory _DynamicRecord.fromJson(Map<String, dynamic> json) =
      _$DynamicRecordImpl.fromJson;

  @override
  String get id;
  @override
  String get modelId;
  @override
  String get organizationId;
  @override
  Map<String, dynamic> get data;
  @override
  Map<String, dynamic> get metadata;
  @override
  Map<String, dynamic> get computedFields;
  @override // Calculated fields
  Map<String, dynamic> get auditLog;
  @override // Change history
  String get status;
  @override // draft, active, archived, deleted
  int get version;
  @override // Record version for optimistic locking
  String? get createdBy;
  @override
  String? get updatedBy;
  @override
  String? get assignedTo;
  @override // For workflow management
  bool get isActive;
  @override
  bool get isLocked;
  @override // Prevent editing
  @TimestampConverter()
  DateTime? get createdAt;
  @override
  @TimestampConverter()
  DateTime? get updatedAt;
  @override
  @TimestampConverter()
  DateTime? get lastAccessedAt;
  @override
  @JsonKey(ignore: true)
  _$$DynamicRecordImplCopyWith<_$DynamicRecordImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
