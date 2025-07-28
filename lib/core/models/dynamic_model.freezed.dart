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
  Map<String, FieldConfig> get fields => throw _privateConstructorUsedError;
  List<ValidationRule> get validationRules =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> get relationships => throw _privateConstructorUsedError;
  Map<String, dynamic> get uiConfig => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
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
      Map<String, FieldConfig> fields,
      List<ValidationRule> validationRules,
      Map<String, dynamic> relationships,
      Map<String, dynamic> uiConfig,
      bool isActive,
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
    Object? fields = null,
    Object? validationRules = null,
    Object? relationships = null,
    Object? uiConfig = null,
    Object? isActive = null,
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
      fields: null == fields
          ? _value.fields
          : fields // ignore: cast_nullable_to_non_nullable
              as Map<String, FieldConfig>,
      validationRules: null == validationRules
          ? _value.validationRules
          : validationRules // ignore: cast_nullable_to_non_nullable
              as List<ValidationRule>,
      relationships: null == relationships
          ? _value.relationships
          : relationships // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      uiConfig: null == uiConfig
          ? _value.uiConfig
          : uiConfig // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
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
      Map<String, FieldConfig> fields,
      List<ValidationRule> validationRules,
      Map<String, dynamic> relationships,
      Map<String, dynamic> uiConfig,
      bool isActive,
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
    Object? fields = null,
    Object? validationRules = null,
    Object? relationships = null,
    Object? uiConfig = null,
    Object? isActive = null,
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
      fields: null == fields
          ? _value._fields
          : fields // ignore: cast_nullable_to_non_nullable
              as Map<String, FieldConfig>,
      validationRules: null == validationRules
          ? _value._validationRules
          : validationRules // ignore: cast_nullable_to_non_nullable
              as List<ValidationRule>,
      relationships: null == relationships
          ? _value._relationships
          : relationships // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      uiConfig: null == uiConfig
          ? _value._uiConfig
          : uiConfig // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
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
class _$DynamicModelImpl implements _DynamicModel {
  const _$DynamicModelImpl(
      {required this.id,
      required this.modelName,
      required this.displayName,
      this.description,
      required final Map<String, FieldConfig> fields,
      required final List<ValidationRule> validationRules,
      required final Map<String, dynamic> relationships,
      required final Map<String, dynamic> uiConfig,
      this.isActive = true,
      @TimestampConverter() this.createdAt,
      @TimestampConverter() this.updatedAt})
      : _fields = fields,
        _validationRules = validationRules,
        _relationships = relationships,
        _uiConfig = uiConfig;

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
  final Map<String, FieldConfig> _fields;
  @override
  Map<String, FieldConfig> get fields {
    if (_fields is EqualUnmodifiableMapView) return _fields;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_fields);
  }

  final List<ValidationRule> _validationRules;
  @override
  List<ValidationRule> get validationRules {
    if (_validationRules is EqualUnmodifiableListView) return _validationRules;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_validationRules);
  }

  final Map<String, dynamic> _relationships;
  @override
  Map<String, dynamic> get relationships {
    if (_relationships is EqualUnmodifiableMapView) return _relationships;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_relationships);
  }

  final Map<String, dynamic> _uiConfig;
  @override
  Map<String, dynamic> get uiConfig {
    if (_uiConfig is EqualUnmodifiableMapView) return _uiConfig;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_uiConfig);
  }

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
    return 'DynamicModel(id: $id, modelName: $modelName, displayName: $displayName, description: $description, fields: $fields, validationRules: $validationRules, relationships: $relationships, uiConfig: $uiConfig, isActive: $isActive, createdAt: $createdAt, updatedAt: $updatedAt)';
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
            const DeepCollectionEquality().equals(other._fields, _fields) &&
            const DeepCollectionEquality()
                .equals(other._validationRules, _validationRules) &&
            const DeepCollectionEquality()
                .equals(other._relationships, _relationships) &&
            const DeepCollectionEquality().equals(other._uiConfig, _uiConfig) &&
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
      modelName,
      displayName,
      description,
      const DeepCollectionEquality().hash(_fields),
      const DeepCollectionEquality().hash(_validationRules),
      const DeepCollectionEquality().hash(_relationships),
      const DeepCollectionEquality().hash(_uiConfig),
      isActive,
      createdAt,
      updatedAt);

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

abstract class _DynamicModel implements DynamicModel {
  const factory _DynamicModel(
      {required final String id,
      required final String modelName,
      required final String displayName,
      final String? description,
      required final Map<String, FieldConfig> fields,
      required final List<ValidationRule> validationRules,
      required final Map<String, dynamic> relationships,
      required final Map<String, dynamic> uiConfig,
      final bool isActive,
      @TimestampConverter() final DateTime? createdAt,
      @TimestampConverter() final DateTime? updatedAt}) = _$DynamicModelImpl;

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
  Map<String, FieldConfig> get fields;
  @override
  List<ValidationRule> get validationRules;
  @override
  Map<String, dynamic> get relationships;
  @override
  Map<String, dynamic> get uiConfig;
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
  _$$DynamicModelImplCopyWith<_$DynamicModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FieldConfig _$FieldConfigFromJson(Map<String, dynamic> json) {
  return _FieldConfig.fromJson(json);
}

/// @nodoc
mixin _$FieldConfig {
  String get fieldName => throw _privateConstructorUsedError;
  String get fieldType =>
      throw _privateConstructorUsedError; // 'string', 'number', 'boolean', 'date', 'dropdown'
  String get displayName => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  bool get isRequired => throw _privateConstructorUsedError;
  bool get isEditable => throw _privateConstructorUsedError;
  bool get isVisible => throw _privateConstructorUsedError;
  Map<String, dynamic>? get validationRules =>
      throw _privateConstructorUsedError;
  List<String>? get options =>
      throw _privateConstructorUsedError; // For dropdown fields
  String? get defaultValue => throw _privateConstructorUsedError;
  Map<String, dynamic>? get uiConfig => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FieldConfigCopyWith<FieldConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FieldConfigCopyWith<$Res> {
  factory $FieldConfigCopyWith(
          FieldConfig value, $Res Function(FieldConfig) then) =
      _$FieldConfigCopyWithImpl<$Res, FieldConfig>;
  @useResult
  $Res call(
      {String fieldName,
      String fieldType,
      String displayName,
      String? description,
      bool isRequired,
      bool isEditable,
      bool isVisible,
      Map<String, dynamic>? validationRules,
      List<String>? options,
      String? defaultValue,
      Map<String, dynamic>? uiConfig});
}

/// @nodoc
class _$FieldConfigCopyWithImpl<$Res, $Val extends FieldConfig>
    implements $FieldConfigCopyWith<$Res> {
  _$FieldConfigCopyWithImpl(this._value, this._then);

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
    Object? isRequired = null,
    Object? isEditable = null,
    Object? isVisible = null,
    Object? validationRules = freezed,
    Object? options = freezed,
    Object? defaultValue = freezed,
    Object? uiConfig = freezed,
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
      validationRules: freezed == validationRules
          ? _value.validationRules
          : validationRules // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      options: freezed == options
          ? _value.options
          : options // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      defaultValue: freezed == defaultValue
          ? _value.defaultValue
          : defaultValue // ignore: cast_nullable_to_non_nullable
              as String?,
      uiConfig: freezed == uiConfig
          ? _value.uiConfig
          : uiConfig // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FieldConfigImplCopyWith<$Res>
    implements $FieldConfigCopyWith<$Res> {
  factory _$$FieldConfigImplCopyWith(
          _$FieldConfigImpl value, $Res Function(_$FieldConfigImpl) then) =
      __$$FieldConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String fieldName,
      String fieldType,
      String displayName,
      String? description,
      bool isRequired,
      bool isEditable,
      bool isVisible,
      Map<String, dynamic>? validationRules,
      List<String>? options,
      String? defaultValue,
      Map<String, dynamic>? uiConfig});
}

/// @nodoc
class __$$FieldConfigImplCopyWithImpl<$Res>
    extends _$FieldConfigCopyWithImpl<$Res, _$FieldConfigImpl>
    implements _$$FieldConfigImplCopyWith<$Res> {
  __$$FieldConfigImplCopyWithImpl(
      _$FieldConfigImpl _value, $Res Function(_$FieldConfigImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fieldName = null,
    Object? fieldType = null,
    Object? displayName = null,
    Object? description = freezed,
    Object? isRequired = null,
    Object? isEditable = null,
    Object? isVisible = null,
    Object? validationRules = freezed,
    Object? options = freezed,
    Object? defaultValue = freezed,
    Object? uiConfig = freezed,
  }) {
    return _then(_$FieldConfigImpl(
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
      validationRules: freezed == validationRules
          ? _value._validationRules
          : validationRules // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      options: freezed == options
          ? _value._options
          : options // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      defaultValue: freezed == defaultValue
          ? _value.defaultValue
          : defaultValue // ignore: cast_nullable_to_non_nullable
              as String?,
      uiConfig: freezed == uiConfig
          ? _value._uiConfig
          : uiConfig // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FieldConfigImpl implements _FieldConfig {
  const _$FieldConfigImpl(
      {required this.fieldName,
      required this.fieldType,
      required this.displayName,
      this.description,
      this.isRequired = false,
      this.isEditable = true,
      this.isVisible = true,
      final Map<String, dynamic>? validationRules,
      final List<String>? options,
      this.defaultValue,
      final Map<String, dynamic>? uiConfig})
      : _validationRules = validationRules,
        _options = options,
        _uiConfig = uiConfig;

  factory _$FieldConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$FieldConfigImplFromJson(json);

  @override
  final String fieldName;
  @override
  final String fieldType;
// 'string', 'number', 'boolean', 'date', 'dropdown'
  @override
  final String displayName;
  @override
  final String? description;
  @override
  @JsonKey()
  final bool isRequired;
  @override
  @JsonKey()
  final bool isEditable;
  @override
  @JsonKey()
  final bool isVisible;
  final Map<String, dynamic>? _validationRules;
  @override
  Map<String, dynamic>? get validationRules {
    final value = _validationRules;
    if (value == null) return null;
    if (_validationRules is EqualUnmodifiableMapView) return _validationRules;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final List<String>? _options;
  @override
  List<String>? get options {
    final value = _options;
    if (value == null) return null;
    if (_options is EqualUnmodifiableListView) return _options;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

// For dropdown fields
  @override
  final String? defaultValue;
  final Map<String, dynamic>? _uiConfig;
  @override
  Map<String, dynamic>? get uiConfig {
    final value = _uiConfig;
    if (value == null) return null;
    if (_uiConfig is EqualUnmodifiableMapView) return _uiConfig;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'FieldConfig(fieldName: $fieldName, fieldType: $fieldType, displayName: $displayName, description: $description, isRequired: $isRequired, isEditable: $isEditable, isVisible: $isVisible, validationRules: $validationRules, options: $options, defaultValue: $defaultValue, uiConfig: $uiConfig)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FieldConfigImpl &&
            (identical(other.fieldName, fieldName) ||
                other.fieldName == fieldName) &&
            (identical(other.fieldType, fieldType) ||
                other.fieldType == fieldType) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.isRequired, isRequired) ||
                other.isRequired == isRequired) &&
            (identical(other.isEditable, isEditable) ||
                other.isEditable == isEditable) &&
            (identical(other.isVisible, isVisible) ||
                other.isVisible == isVisible) &&
            const DeepCollectionEquality()
                .equals(other._validationRules, _validationRules) &&
            const DeepCollectionEquality().equals(other._options, _options) &&
            (identical(other.defaultValue, defaultValue) ||
                other.defaultValue == defaultValue) &&
            const DeepCollectionEquality().equals(other._uiConfig, _uiConfig));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      fieldName,
      fieldType,
      displayName,
      description,
      isRequired,
      isEditable,
      isVisible,
      const DeepCollectionEquality().hash(_validationRules),
      const DeepCollectionEquality().hash(_options),
      defaultValue,
      const DeepCollectionEquality().hash(_uiConfig));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FieldConfigImplCopyWith<_$FieldConfigImpl> get copyWith =>
      __$$FieldConfigImplCopyWithImpl<_$FieldConfigImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FieldConfigImplToJson(
      this,
    );
  }
}

abstract class _FieldConfig implements FieldConfig {
  const factory _FieldConfig(
      {required final String fieldName,
      required final String fieldType,
      required final String displayName,
      final String? description,
      final bool isRequired,
      final bool isEditable,
      final bool isVisible,
      final Map<String, dynamic>? validationRules,
      final List<String>? options,
      final String? defaultValue,
      final Map<String, dynamic>? uiConfig}) = _$FieldConfigImpl;

  factory _FieldConfig.fromJson(Map<String, dynamic> json) =
      _$FieldConfigImpl.fromJson;

  @override
  String get fieldName;
  @override
  String get fieldType;
  @override // 'string', 'number', 'boolean', 'date', 'dropdown'
  String get displayName;
  @override
  String? get description;
  @override
  bool get isRequired;
  @override
  bool get isEditable;
  @override
  bool get isVisible;
  @override
  Map<String, dynamic>? get validationRules;
  @override
  List<String>? get options;
  @override // For dropdown fields
  String? get defaultValue;
  @override
  Map<String, dynamic>? get uiConfig;
  @override
  @JsonKey(ignore: true)
  _$$FieldConfigImplCopyWith<_$FieldConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ValidationRule _$ValidationRuleFromJson(Map<String, dynamic> json) {
  return _ValidationRule.fromJson(json);
}

/// @nodoc
mixin _$ValidationRule {
  String get fieldName => throw _privateConstructorUsedError;
  String get ruleType =>
      throw _privateConstructorUsedError; // 'required', 'min', 'max', 'pattern', 'custom'
  Map<String, dynamic> get ruleConfig => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ValidationRuleCopyWith<ValidationRule> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ValidationRuleCopyWith<$Res> {
  factory $ValidationRuleCopyWith(
          ValidationRule value, $Res Function(ValidationRule) then) =
      _$ValidationRuleCopyWithImpl<$Res, ValidationRule>;
  @useResult
  $Res call(
      {String fieldName,
      String ruleType,
      Map<String, dynamic> ruleConfig,
      String? errorMessage});
}

/// @nodoc
class _$ValidationRuleCopyWithImpl<$Res, $Val extends ValidationRule>
    implements $ValidationRuleCopyWith<$Res> {
  _$ValidationRuleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fieldName = null,
    Object? ruleType = null,
    Object? ruleConfig = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_value.copyWith(
      fieldName: null == fieldName
          ? _value.fieldName
          : fieldName // ignore: cast_nullable_to_non_nullable
              as String,
      ruleType: null == ruleType
          ? _value.ruleType
          : ruleType // ignore: cast_nullable_to_non_nullable
              as String,
      ruleConfig: null == ruleConfig
          ? _value.ruleConfig
          : ruleConfig // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ValidationRuleImplCopyWith<$Res>
    implements $ValidationRuleCopyWith<$Res> {
  factory _$$ValidationRuleImplCopyWith(_$ValidationRuleImpl value,
          $Res Function(_$ValidationRuleImpl) then) =
      __$$ValidationRuleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String fieldName,
      String ruleType,
      Map<String, dynamic> ruleConfig,
      String? errorMessage});
}

/// @nodoc
class __$$ValidationRuleImplCopyWithImpl<$Res>
    extends _$ValidationRuleCopyWithImpl<$Res, _$ValidationRuleImpl>
    implements _$$ValidationRuleImplCopyWith<$Res> {
  __$$ValidationRuleImplCopyWithImpl(
      _$ValidationRuleImpl _value, $Res Function(_$ValidationRuleImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fieldName = null,
    Object? ruleType = null,
    Object? ruleConfig = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_$ValidationRuleImpl(
      fieldName: null == fieldName
          ? _value.fieldName
          : fieldName // ignore: cast_nullable_to_non_nullable
              as String,
      ruleType: null == ruleType
          ? _value.ruleType
          : ruleType // ignore: cast_nullable_to_non_nullable
              as String,
      ruleConfig: null == ruleConfig
          ? _value._ruleConfig
          : ruleConfig // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ValidationRuleImpl implements _ValidationRule {
  const _$ValidationRuleImpl(
      {required this.fieldName,
      required this.ruleType,
      required final Map<String, dynamic> ruleConfig,
      this.errorMessage})
      : _ruleConfig = ruleConfig;

  factory _$ValidationRuleImpl.fromJson(Map<String, dynamic> json) =>
      _$$ValidationRuleImplFromJson(json);

  @override
  final String fieldName;
  @override
  final String ruleType;
// 'required', 'min', 'max', 'pattern', 'custom'
  final Map<String, dynamic> _ruleConfig;
// 'required', 'min', 'max', 'pattern', 'custom'
  @override
  Map<String, dynamic> get ruleConfig {
    if (_ruleConfig is EqualUnmodifiableMapView) return _ruleConfig;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_ruleConfig);
  }

  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'ValidationRule(fieldName: $fieldName, ruleType: $ruleType, ruleConfig: $ruleConfig, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ValidationRuleImpl &&
            (identical(other.fieldName, fieldName) ||
                other.fieldName == fieldName) &&
            (identical(other.ruleType, ruleType) ||
                other.ruleType == ruleType) &&
            const DeepCollectionEquality()
                .equals(other._ruleConfig, _ruleConfig) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, fieldName, ruleType,
      const DeepCollectionEquality().hash(_ruleConfig), errorMessage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ValidationRuleImplCopyWith<_$ValidationRuleImpl> get copyWith =>
      __$$ValidationRuleImplCopyWithImpl<_$ValidationRuleImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ValidationRuleImplToJson(
      this,
    );
  }
}

abstract class _ValidationRule implements ValidationRule {
  const factory _ValidationRule(
      {required final String fieldName,
      required final String ruleType,
      required final Map<String, dynamic> ruleConfig,
      final String? errorMessage}) = _$ValidationRuleImpl;

  factory _ValidationRule.fromJson(Map<String, dynamic> json) =
      _$ValidationRuleImpl.fromJson;

  @override
  String get fieldName;
  @override
  String get ruleType;
  @override // 'required', 'min', 'max', 'pattern', 'custom'
  Map<String, dynamic> get ruleConfig;
  @override
  String? get errorMessage;
  @override
  @JsonKey(ignore: true)
  _$$ValidationRuleImplCopyWith<_$ValidationRuleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
