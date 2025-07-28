// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'substation_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SubstationModel _$SubstationModelFromJson(Map<String, dynamic> json) {
  return _SubstationModel.fromJson(json);
}

/// @nodoc
mixin _$SubstationModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get code => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String get organizationId => throw _privateConstructorUsedError;
  SubstationLocation get location => throw _privateConstructorUsedError;
  String get voltageLevel =>
      throw _privateConstructorUsedError; // '132KV', '220KV', '400KV', etc.
  SubstationType get type => throw _privateConstructorUsedError;
  SubstationStatus get status => throw _privateConstructorUsedError;
  List<String> get equipmentIds => throw _privateConstructorUsedError;
  Map<String, dynamic> get technicalSpecs => throw _privateConstructorUsedError;
  String? get operatorId => throw _privateConstructorUsedError;
  String? get maintenanceSchedule => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get lastMaintenanceDate => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get nextMaintenanceDate => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get commissioningDate => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SubstationModelCopyWith<SubstationModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubstationModelCopyWith<$Res> {
  factory $SubstationModelCopyWith(
          SubstationModel value, $Res Function(SubstationModel) then) =
      _$SubstationModelCopyWithImpl<$Res, SubstationModel>;
  @useResult
  $Res call(
      {String id,
      String name,
      String code,
      String? description,
      String organizationId,
      SubstationLocation location,
      String voltageLevel,
      SubstationType type,
      SubstationStatus status,
      List<String> equipmentIds,
      Map<String, dynamic> technicalSpecs,
      String? operatorId,
      String? maintenanceSchedule,
      @TimestampConverter() DateTime? lastMaintenanceDate,
      @TimestampConverter() DateTime? nextMaintenanceDate,
      @TimestampConverter() DateTime? commissioningDate,
      @TimestampConverter() DateTime? createdAt,
      @TimestampConverter() DateTime? updatedAt});

  $SubstationLocationCopyWith<$Res> get location;
}

/// @nodoc
class _$SubstationModelCopyWithImpl<$Res, $Val extends SubstationModel>
    implements $SubstationModelCopyWith<$Res> {
  _$SubstationModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? code = null,
    Object? description = freezed,
    Object? organizationId = null,
    Object? location = null,
    Object? voltageLevel = null,
    Object? type = null,
    Object? status = null,
    Object? equipmentIds = null,
    Object? technicalSpecs = null,
    Object? operatorId = freezed,
    Object? maintenanceSchedule = freezed,
    Object? lastMaintenanceDate = freezed,
    Object? nextMaintenanceDate = freezed,
    Object? commissioningDate = freezed,
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
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      organizationId: null == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as SubstationLocation,
      voltageLevel: null == voltageLevel
          ? _value.voltageLevel
          : voltageLevel // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as SubstationType,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as SubstationStatus,
      equipmentIds: null == equipmentIds
          ? _value.equipmentIds
          : equipmentIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      technicalSpecs: null == technicalSpecs
          ? _value.technicalSpecs
          : technicalSpecs // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      operatorId: freezed == operatorId
          ? _value.operatorId
          : operatorId // ignore: cast_nullable_to_non_nullable
              as String?,
      maintenanceSchedule: freezed == maintenanceSchedule
          ? _value.maintenanceSchedule
          : maintenanceSchedule // ignore: cast_nullable_to_non_nullable
              as String?,
      lastMaintenanceDate: freezed == lastMaintenanceDate
          ? _value.lastMaintenanceDate
          : lastMaintenanceDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      nextMaintenanceDate: freezed == nextMaintenanceDate
          ? _value.nextMaintenanceDate
          : nextMaintenanceDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      commissioningDate: freezed == commissioningDate
          ? _value.commissioningDate
          : commissioningDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
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

  @override
  @pragma('vm:prefer-inline')
  $SubstationLocationCopyWith<$Res> get location {
    return $SubstationLocationCopyWith<$Res>(_value.location, (value) {
      return _then(_value.copyWith(location: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SubstationModelImplCopyWith<$Res>
    implements $SubstationModelCopyWith<$Res> {
  factory _$$SubstationModelImplCopyWith(_$SubstationModelImpl value,
          $Res Function(_$SubstationModelImpl) then) =
      __$$SubstationModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String code,
      String? description,
      String organizationId,
      SubstationLocation location,
      String voltageLevel,
      SubstationType type,
      SubstationStatus status,
      List<String> equipmentIds,
      Map<String, dynamic> technicalSpecs,
      String? operatorId,
      String? maintenanceSchedule,
      @TimestampConverter() DateTime? lastMaintenanceDate,
      @TimestampConverter() DateTime? nextMaintenanceDate,
      @TimestampConverter() DateTime? commissioningDate,
      @TimestampConverter() DateTime? createdAt,
      @TimestampConverter() DateTime? updatedAt});

  @override
  $SubstationLocationCopyWith<$Res> get location;
}

/// @nodoc
class __$$SubstationModelImplCopyWithImpl<$Res>
    extends _$SubstationModelCopyWithImpl<$Res, _$SubstationModelImpl>
    implements _$$SubstationModelImplCopyWith<$Res> {
  __$$SubstationModelImplCopyWithImpl(
      _$SubstationModelImpl _value, $Res Function(_$SubstationModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? code = null,
    Object? description = freezed,
    Object? organizationId = null,
    Object? location = null,
    Object? voltageLevel = null,
    Object? type = null,
    Object? status = null,
    Object? equipmentIds = null,
    Object? technicalSpecs = null,
    Object? operatorId = freezed,
    Object? maintenanceSchedule = freezed,
    Object? lastMaintenanceDate = freezed,
    Object? nextMaintenanceDate = freezed,
    Object? commissioningDate = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$SubstationModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      organizationId: null == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as SubstationLocation,
      voltageLevel: null == voltageLevel
          ? _value.voltageLevel
          : voltageLevel // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as SubstationType,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as SubstationStatus,
      equipmentIds: null == equipmentIds
          ? _value._equipmentIds
          : equipmentIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      technicalSpecs: null == technicalSpecs
          ? _value._technicalSpecs
          : technicalSpecs // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      operatorId: freezed == operatorId
          ? _value.operatorId
          : operatorId // ignore: cast_nullable_to_non_nullable
              as String?,
      maintenanceSchedule: freezed == maintenanceSchedule
          ? _value.maintenanceSchedule
          : maintenanceSchedule // ignore: cast_nullable_to_non_nullable
              as String?,
      lastMaintenanceDate: freezed == lastMaintenanceDate
          ? _value.lastMaintenanceDate
          : lastMaintenanceDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      nextMaintenanceDate: freezed == nextMaintenanceDate
          ? _value.nextMaintenanceDate
          : nextMaintenanceDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      commissioningDate: freezed == commissioningDate
          ? _value.commissioningDate
          : commissioningDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
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
class _$SubstationModelImpl extends _SubstationModel {
  const _$SubstationModelImpl(
      {required this.id,
      required this.name,
      required this.code,
      this.description,
      required this.organizationId,
      required this.location,
      required this.voltageLevel,
      required this.type,
      required this.status,
      final List<String> equipmentIds = const [],
      final Map<String, dynamic> technicalSpecs = const {},
      this.operatorId,
      this.maintenanceSchedule,
      @TimestampConverter() this.lastMaintenanceDate,
      @TimestampConverter() this.nextMaintenanceDate,
      @TimestampConverter() this.commissioningDate,
      @TimestampConverter() this.createdAt,
      @TimestampConverter() this.updatedAt})
      : _equipmentIds = equipmentIds,
        _technicalSpecs = technicalSpecs,
        super._();

  factory _$SubstationModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SubstationModelImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String code;
  @override
  final String? description;
  @override
  final String organizationId;
  @override
  final SubstationLocation location;
  @override
  final String voltageLevel;
// '132KV', '220KV', '400KV', etc.
  @override
  final SubstationType type;
  @override
  final SubstationStatus status;
  final List<String> _equipmentIds;
  @override
  @JsonKey()
  List<String> get equipmentIds {
    if (_equipmentIds is EqualUnmodifiableListView) return _equipmentIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_equipmentIds);
  }

  final Map<String, dynamic> _technicalSpecs;
  @override
  @JsonKey()
  Map<String, dynamic> get technicalSpecs {
    if (_technicalSpecs is EqualUnmodifiableMapView) return _technicalSpecs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_technicalSpecs);
  }

  @override
  final String? operatorId;
  @override
  final String? maintenanceSchedule;
  @override
  @TimestampConverter()
  final DateTime? lastMaintenanceDate;
  @override
  @TimestampConverter()
  final DateTime? nextMaintenanceDate;
  @override
  @TimestampConverter()
  final DateTime? commissioningDate;
  @override
  @TimestampConverter()
  final DateTime? createdAt;
  @override
  @TimestampConverter()
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'SubstationModel(id: $id, name: $name, code: $code, description: $description, organizationId: $organizationId, location: $location, voltageLevel: $voltageLevel, type: $type, status: $status, equipmentIds: $equipmentIds, technicalSpecs: $technicalSpecs, operatorId: $operatorId, maintenanceSchedule: $maintenanceSchedule, lastMaintenanceDate: $lastMaintenanceDate, nextMaintenanceDate: $nextMaintenanceDate, commissioningDate: $commissioningDate, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubstationModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.organizationId, organizationId) ||
                other.organizationId == organizationId) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.voltageLevel, voltageLevel) ||
                other.voltageLevel == voltageLevel) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality()
                .equals(other._equipmentIds, _equipmentIds) &&
            const DeepCollectionEquality()
                .equals(other._technicalSpecs, _technicalSpecs) &&
            (identical(other.operatorId, operatorId) ||
                other.operatorId == operatorId) &&
            (identical(other.maintenanceSchedule, maintenanceSchedule) ||
                other.maintenanceSchedule == maintenanceSchedule) &&
            (identical(other.lastMaintenanceDate, lastMaintenanceDate) ||
                other.lastMaintenanceDate == lastMaintenanceDate) &&
            (identical(other.nextMaintenanceDate, nextMaintenanceDate) ||
                other.nextMaintenanceDate == nextMaintenanceDate) &&
            (identical(other.commissioningDate, commissioningDate) ||
                other.commissioningDate == commissioningDate) &&
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
      code,
      description,
      organizationId,
      location,
      voltageLevel,
      type,
      status,
      const DeepCollectionEquality().hash(_equipmentIds),
      const DeepCollectionEquality().hash(_technicalSpecs),
      operatorId,
      maintenanceSchedule,
      lastMaintenanceDate,
      nextMaintenanceDate,
      commissioningDate,
      createdAt,
      updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SubstationModelImplCopyWith<_$SubstationModelImpl> get copyWith =>
      __$$SubstationModelImplCopyWithImpl<_$SubstationModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SubstationModelImplToJson(
      this,
    );
  }
}

abstract class _SubstationModel extends SubstationModel {
  const factory _SubstationModel(
      {required final String id,
      required final String name,
      required final String code,
      final String? description,
      required final String organizationId,
      required final SubstationLocation location,
      required final String voltageLevel,
      required final SubstationType type,
      required final SubstationStatus status,
      final List<String> equipmentIds,
      final Map<String, dynamic> technicalSpecs,
      final String? operatorId,
      final String? maintenanceSchedule,
      @TimestampConverter() final DateTime? lastMaintenanceDate,
      @TimestampConverter() final DateTime? nextMaintenanceDate,
      @TimestampConverter() final DateTime? commissioningDate,
      @TimestampConverter() final DateTime? createdAt,
      @TimestampConverter() final DateTime? updatedAt}) = _$SubstationModelImpl;
  const _SubstationModel._() : super._();

  factory _SubstationModel.fromJson(Map<String, dynamic> json) =
      _$SubstationModelImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get code;
  @override
  String? get description;
  @override
  String get organizationId;
  @override
  SubstationLocation get location;
  @override
  String get voltageLevel;
  @override // '132KV', '220KV', '400KV', etc.
  SubstationType get type;
  @override
  SubstationStatus get status;
  @override
  List<String> get equipmentIds;
  @override
  Map<String, dynamic> get technicalSpecs;
  @override
  String? get operatorId;
  @override
  String? get maintenanceSchedule;
  @override
  @TimestampConverter()
  DateTime? get lastMaintenanceDate;
  @override
  @TimestampConverter()
  DateTime? get nextMaintenanceDate;
  @override
  @TimestampConverter()
  DateTime? get commissioningDate;
  @override
  @TimestampConverter()
  DateTime? get createdAt;
  @override
  @TimestampConverter()
  DateTime? get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$SubstationModelImplCopyWith<_$SubstationModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SubstationLocation _$SubstationLocationFromJson(Map<String, dynamic> json) {
  return _SubstationLocation.fromJson(json);
}

/// @nodoc
mixin _$SubstationLocation {
  double get latitude => throw _privateConstructorUsedError;
  double get longitude => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  String? get city => throw _privateConstructorUsedError;
  String? get state => throw _privateConstructorUsedError;
  String? get pincode => throw _privateConstructorUsedError;
  String? get landmark => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SubstationLocationCopyWith<SubstationLocation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubstationLocationCopyWith<$Res> {
  factory $SubstationLocationCopyWith(
          SubstationLocation value, $Res Function(SubstationLocation) then) =
      _$SubstationLocationCopyWithImpl<$Res, SubstationLocation>;
  @useResult
  $Res call(
      {double latitude,
      double longitude,
      String address,
      String? city,
      String? state,
      String? pincode,
      String? landmark});
}

/// @nodoc
class _$SubstationLocationCopyWithImpl<$Res, $Val extends SubstationLocation>
    implements $SubstationLocationCopyWith<$Res> {
  _$SubstationLocationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? latitude = null,
    Object? longitude = null,
    Object? address = null,
    Object? city = freezed,
    Object? state = freezed,
    Object? pincode = freezed,
    Object? landmark = freezed,
  }) {
    return _then(_value.copyWith(
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      state: freezed == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String?,
      pincode: freezed == pincode
          ? _value.pincode
          : pincode // ignore: cast_nullable_to_non_nullable
              as String?,
      landmark: freezed == landmark
          ? _value.landmark
          : landmark // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SubstationLocationImplCopyWith<$Res>
    implements $SubstationLocationCopyWith<$Res> {
  factory _$$SubstationLocationImplCopyWith(_$SubstationLocationImpl value,
          $Res Function(_$SubstationLocationImpl) then) =
      __$$SubstationLocationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double latitude,
      double longitude,
      String address,
      String? city,
      String? state,
      String? pincode,
      String? landmark});
}

/// @nodoc
class __$$SubstationLocationImplCopyWithImpl<$Res>
    extends _$SubstationLocationCopyWithImpl<$Res, _$SubstationLocationImpl>
    implements _$$SubstationLocationImplCopyWith<$Res> {
  __$$SubstationLocationImplCopyWithImpl(_$SubstationLocationImpl _value,
      $Res Function(_$SubstationLocationImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? latitude = null,
    Object? longitude = null,
    Object? address = null,
    Object? city = freezed,
    Object? state = freezed,
    Object? pincode = freezed,
    Object? landmark = freezed,
  }) {
    return _then(_$SubstationLocationImpl(
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      state: freezed == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String?,
      pincode: freezed == pincode
          ? _value.pincode
          : pincode // ignore: cast_nullable_to_non_nullable
              as String?,
      landmark: freezed == landmark
          ? _value.landmark
          : landmark // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SubstationLocationImpl extends _SubstationLocation {
  const _$SubstationLocationImpl(
      {required this.latitude,
      required this.longitude,
      required this.address,
      this.city,
      this.state,
      this.pincode,
      this.landmark})
      : super._();

  factory _$SubstationLocationImpl.fromJson(Map<String, dynamic> json) =>
      _$$SubstationLocationImplFromJson(json);

  @override
  final double latitude;
  @override
  final double longitude;
  @override
  final String address;
  @override
  final String? city;
  @override
  final String? state;
  @override
  final String? pincode;
  @override
  final String? landmark;

  @override
  String toString() {
    return 'SubstationLocation(latitude: $latitude, longitude: $longitude, address: $address, city: $city, state: $state, pincode: $pincode, landmark: $landmark)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubstationLocationImpl &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.pincode, pincode) || other.pincode == pincode) &&
            (identical(other.landmark, landmark) ||
                other.landmark == landmark));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, latitude, longitude, address,
      city, state, pincode, landmark);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SubstationLocationImplCopyWith<_$SubstationLocationImpl> get copyWith =>
      __$$SubstationLocationImplCopyWithImpl<_$SubstationLocationImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SubstationLocationImplToJson(
      this,
    );
  }
}

abstract class _SubstationLocation extends SubstationLocation {
  const factory _SubstationLocation(
      {required final double latitude,
      required final double longitude,
      required final String address,
      final String? city,
      final String? state,
      final String? pincode,
      final String? landmark}) = _$SubstationLocationImpl;
  const _SubstationLocation._() : super._();

  factory _SubstationLocation.fromJson(Map<String, dynamic> json) =
      _$SubstationLocationImpl.fromJson;

  @override
  double get latitude;
  @override
  double get longitude;
  @override
  String get address;
  @override
  String? get city;
  @override
  String? get state;
  @override
  String? get pincode;
  @override
  String? get landmark;
  @override
  @JsonKey(ignore: true)
  _$$SubstationLocationImplCopyWith<_$SubstationLocationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

EquipmentModel _$EquipmentModelFromJson(Map<String, dynamic> json) {
  return _EquipmentModel.fromJson(json);
}

/// @nodoc
mixin _$EquipmentModel {
  String get id => throw _privateConstructorUsedError;
  String get substationId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get equipmentType =>
      throw _privateConstructorUsedError; // 'transformer', 'breaker', 'relay', etc.
  String get manufacturer => throw _privateConstructorUsedError;
  String get model => throw _privateConstructorUsedError;
  String? get serialNumber => throw _privateConstructorUsedError;
  EquipmentStatus get status => throw _privateConstructorUsedError;
  Map<String, dynamic> get specifications => throw _privateConstructorUsedError;
  Map<String, dynamic> get currentReadings =>
      throw _privateConstructorUsedError;
  String? get assignedTechnicianId => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get installationDate => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get lastInspectionDate => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get nextInspectionDate => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get warrantyExpiryDate => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EquipmentModelCopyWith<EquipmentModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EquipmentModelCopyWith<$Res> {
  factory $EquipmentModelCopyWith(
          EquipmentModel value, $Res Function(EquipmentModel) then) =
      _$EquipmentModelCopyWithImpl<$Res, EquipmentModel>;
  @useResult
  $Res call(
      {String id,
      String substationId,
      String name,
      String equipmentType,
      String manufacturer,
      String model,
      String? serialNumber,
      EquipmentStatus status,
      Map<String, dynamic> specifications,
      Map<String, dynamic> currentReadings,
      String? assignedTechnicianId,
      @TimestampConverter() DateTime? installationDate,
      @TimestampConverter() DateTime? lastInspectionDate,
      @TimestampConverter() DateTime? nextInspectionDate,
      @TimestampConverter() DateTime? warrantyExpiryDate,
      @TimestampConverter() DateTime? createdAt,
      @TimestampConverter() DateTime? updatedAt});
}

/// @nodoc
class _$EquipmentModelCopyWithImpl<$Res, $Val extends EquipmentModel>
    implements $EquipmentModelCopyWith<$Res> {
  _$EquipmentModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? substationId = null,
    Object? name = null,
    Object? equipmentType = null,
    Object? manufacturer = null,
    Object? model = null,
    Object? serialNumber = freezed,
    Object? status = null,
    Object? specifications = null,
    Object? currentReadings = null,
    Object? assignedTechnicianId = freezed,
    Object? installationDate = freezed,
    Object? lastInspectionDate = freezed,
    Object? nextInspectionDate = freezed,
    Object? warrantyExpiryDate = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      substationId: null == substationId
          ? _value.substationId
          : substationId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      equipmentType: null == equipmentType
          ? _value.equipmentType
          : equipmentType // ignore: cast_nullable_to_non_nullable
              as String,
      manufacturer: null == manufacturer
          ? _value.manufacturer
          : manufacturer // ignore: cast_nullable_to_non_nullable
              as String,
      model: null == model
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as String,
      serialNumber: freezed == serialNumber
          ? _value.serialNumber
          : serialNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as EquipmentStatus,
      specifications: null == specifications
          ? _value.specifications
          : specifications // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      currentReadings: null == currentReadings
          ? _value.currentReadings
          : currentReadings // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      assignedTechnicianId: freezed == assignedTechnicianId
          ? _value.assignedTechnicianId
          : assignedTechnicianId // ignore: cast_nullable_to_non_nullable
              as String?,
      installationDate: freezed == installationDate
          ? _value.installationDate
          : installationDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastInspectionDate: freezed == lastInspectionDate
          ? _value.lastInspectionDate
          : lastInspectionDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      nextInspectionDate: freezed == nextInspectionDate
          ? _value.nextInspectionDate
          : nextInspectionDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      warrantyExpiryDate: freezed == warrantyExpiryDate
          ? _value.warrantyExpiryDate
          : warrantyExpiryDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
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
abstract class _$$EquipmentModelImplCopyWith<$Res>
    implements $EquipmentModelCopyWith<$Res> {
  factory _$$EquipmentModelImplCopyWith(_$EquipmentModelImpl value,
          $Res Function(_$EquipmentModelImpl) then) =
      __$$EquipmentModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String substationId,
      String name,
      String equipmentType,
      String manufacturer,
      String model,
      String? serialNumber,
      EquipmentStatus status,
      Map<String, dynamic> specifications,
      Map<String, dynamic> currentReadings,
      String? assignedTechnicianId,
      @TimestampConverter() DateTime? installationDate,
      @TimestampConverter() DateTime? lastInspectionDate,
      @TimestampConverter() DateTime? nextInspectionDate,
      @TimestampConverter() DateTime? warrantyExpiryDate,
      @TimestampConverter() DateTime? createdAt,
      @TimestampConverter() DateTime? updatedAt});
}

/// @nodoc
class __$$EquipmentModelImplCopyWithImpl<$Res>
    extends _$EquipmentModelCopyWithImpl<$Res, _$EquipmentModelImpl>
    implements _$$EquipmentModelImplCopyWith<$Res> {
  __$$EquipmentModelImplCopyWithImpl(
      _$EquipmentModelImpl _value, $Res Function(_$EquipmentModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? substationId = null,
    Object? name = null,
    Object? equipmentType = null,
    Object? manufacturer = null,
    Object? model = null,
    Object? serialNumber = freezed,
    Object? status = null,
    Object? specifications = null,
    Object? currentReadings = null,
    Object? assignedTechnicianId = freezed,
    Object? installationDate = freezed,
    Object? lastInspectionDate = freezed,
    Object? nextInspectionDate = freezed,
    Object? warrantyExpiryDate = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$EquipmentModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      substationId: null == substationId
          ? _value.substationId
          : substationId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      equipmentType: null == equipmentType
          ? _value.equipmentType
          : equipmentType // ignore: cast_nullable_to_non_nullable
              as String,
      manufacturer: null == manufacturer
          ? _value.manufacturer
          : manufacturer // ignore: cast_nullable_to_non_nullable
              as String,
      model: null == model
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as String,
      serialNumber: freezed == serialNumber
          ? _value.serialNumber
          : serialNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as EquipmentStatus,
      specifications: null == specifications
          ? _value._specifications
          : specifications // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      currentReadings: null == currentReadings
          ? _value._currentReadings
          : currentReadings // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      assignedTechnicianId: freezed == assignedTechnicianId
          ? _value.assignedTechnicianId
          : assignedTechnicianId // ignore: cast_nullable_to_non_nullable
              as String?,
      installationDate: freezed == installationDate
          ? _value.installationDate
          : installationDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastInspectionDate: freezed == lastInspectionDate
          ? _value.lastInspectionDate
          : lastInspectionDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      nextInspectionDate: freezed == nextInspectionDate
          ? _value.nextInspectionDate
          : nextInspectionDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      warrantyExpiryDate: freezed == warrantyExpiryDate
          ? _value.warrantyExpiryDate
          : warrantyExpiryDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
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
class _$EquipmentModelImpl extends _EquipmentModel {
  const _$EquipmentModelImpl(
      {required this.id,
      required this.substationId,
      required this.name,
      required this.equipmentType,
      required this.manufacturer,
      required this.model,
      this.serialNumber,
      required this.status,
      final Map<String, dynamic> specifications = const {},
      final Map<String, dynamic> currentReadings = const {},
      this.assignedTechnicianId,
      @TimestampConverter() this.installationDate,
      @TimestampConverter() this.lastInspectionDate,
      @TimestampConverter() this.nextInspectionDate,
      @TimestampConverter() this.warrantyExpiryDate,
      @TimestampConverter() this.createdAt,
      @TimestampConverter() this.updatedAt})
      : _specifications = specifications,
        _currentReadings = currentReadings,
        super._();

  factory _$EquipmentModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$EquipmentModelImplFromJson(json);

  @override
  final String id;
  @override
  final String substationId;
  @override
  final String name;
  @override
  final String equipmentType;
// 'transformer', 'breaker', 'relay', etc.
  @override
  final String manufacturer;
  @override
  final String model;
  @override
  final String? serialNumber;
  @override
  final EquipmentStatus status;
  final Map<String, dynamic> _specifications;
  @override
  @JsonKey()
  Map<String, dynamic> get specifications {
    if (_specifications is EqualUnmodifiableMapView) return _specifications;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_specifications);
  }

  final Map<String, dynamic> _currentReadings;
  @override
  @JsonKey()
  Map<String, dynamic> get currentReadings {
    if (_currentReadings is EqualUnmodifiableMapView) return _currentReadings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_currentReadings);
  }

  @override
  final String? assignedTechnicianId;
  @override
  @TimestampConverter()
  final DateTime? installationDate;
  @override
  @TimestampConverter()
  final DateTime? lastInspectionDate;
  @override
  @TimestampConverter()
  final DateTime? nextInspectionDate;
  @override
  @TimestampConverter()
  final DateTime? warrantyExpiryDate;
  @override
  @TimestampConverter()
  final DateTime? createdAt;
  @override
  @TimestampConverter()
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'EquipmentModel(id: $id, substationId: $substationId, name: $name, equipmentType: $equipmentType, manufacturer: $manufacturer, model: $model, serialNumber: $serialNumber, status: $status, specifications: $specifications, currentReadings: $currentReadings, assignedTechnicianId: $assignedTechnicianId, installationDate: $installationDate, lastInspectionDate: $lastInspectionDate, nextInspectionDate: $nextInspectionDate, warrantyExpiryDate: $warrantyExpiryDate, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EquipmentModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.substationId, substationId) ||
                other.substationId == substationId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.equipmentType, equipmentType) ||
                other.equipmentType == equipmentType) &&
            (identical(other.manufacturer, manufacturer) ||
                other.manufacturer == manufacturer) &&
            (identical(other.model, model) || other.model == model) &&
            (identical(other.serialNumber, serialNumber) ||
                other.serialNumber == serialNumber) &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality()
                .equals(other._specifications, _specifications) &&
            const DeepCollectionEquality()
                .equals(other._currentReadings, _currentReadings) &&
            (identical(other.assignedTechnicianId, assignedTechnicianId) ||
                other.assignedTechnicianId == assignedTechnicianId) &&
            (identical(other.installationDate, installationDate) ||
                other.installationDate == installationDate) &&
            (identical(other.lastInspectionDate, lastInspectionDate) ||
                other.lastInspectionDate == lastInspectionDate) &&
            (identical(other.nextInspectionDate, nextInspectionDate) ||
                other.nextInspectionDate == nextInspectionDate) &&
            (identical(other.warrantyExpiryDate, warrantyExpiryDate) ||
                other.warrantyExpiryDate == warrantyExpiryDate) &&
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
      substationId,
      name,
      equipmentType,
      manufacturer,
      model,
      serialNumber,
      status,
      const DeepCollectionEquality().hash(_specifications),
      const DeepCollectionEquality().hash(_currentReadings),
      assignedTechnicianId,
      installationDate,
      lastInspectionDate,
      nextInspectionDate,
      warrantyExpiryDate,
      createdAt,
      updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EquipmentModelImplCopyWith<_$EquipmentModelImpl> get copyWith =>
      __$$EquipmentModelImplCopyWithImpl<_$EquipmentModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EquipmentModelImplToJson(
      this,
    );
  }
}

abstract class _EquipmentModel extends EquipmentModel {
  const factory _EquipmentModel(
      {required final String id,
      required final String substationId,
      required final String name,
      required final String equipmentType,
      required final String manufacturer,
      required final String model,
      final String? serialNumber,
      required final EquipmentStatus status,
      final Map<String, dynamic> specifications,
      final Map<String, dynamic> currentReadings,
      final String? assignedTechnicianId,
      @TimestampConverter() final DateTime? installationDate,
      @TimestampConverter() final DateTime? lastInspectionDate,
      @TimestampConverter() final DateTime? nextInspectionDate,
      @TimestampConverter() final DateTime? warrantyExpiryDate,
      @TimestampConverter() final DateTime? createdAt,
      @TimestampConverter() final DateTime? updatedAt}) = _$EquipmentModelImpl;
  const _EquipmentModel._() : super._();

  factory _EquipmentModel.fromJson(Map<String, dynamic> json) =
      _$EquipmentModelImpl.fromJson;

  @override
  String get id;
  @override
  String get substationId;
  @override
  String get name;
  @override
  String get equipmentType;
  @override // 'transformer', 'breaker', 'relay', etc.
  String get manufacturer;
  @override
  String get model;
  @override
  String? get serialNumber;
  @override
  EquipmentStatus get status;
  @override
  Map<String, dynamic> get specifications;
  @override
  Map<String, dynamic> get currentReadings;
  @override
  String? get assignedTechnicianId;
  @override
  @TimestampConverter()
  DateTime? get installationDate;
  @override
  @TimestampConverter()
  DateTime? get lastInspectionDate;
  @override
  @TimestampConverter()
  DateTime? get nextInspectionDate;
  @override
  @TimestampConverter()
  DateTime? get warrantyExpiryDate;
  @override
  @TimestampConverter()
  DateTime? get createdAt;
  @override
  @TimestampConverter()
  DateTime? get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$EquipmentModelImplCopyWith<_$EquipmentModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MaintenanceRecord _$MaintenanceRecordFromJson(Map<String, dynamic> json) {
  return _MaintenanceRecord.fromJson(json);
}

/// @nodoc
mixin _$MaintenanceRecord {
  String get id => throw _privateConstructorUsedError;
  String get equipmentId => throw _privateConstructorUsedError;
  String get substationId => throw _privateConstructorUsedError;
  MaintenanceType get type => throw _privateConstructorUsedError;
  MaintenanceStatus get status => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String? get findings => throw _privateConstructorUsedError;
  String? get actions => throw _privateConstructorUsedError;
  String? get technicianId => throw _privateConstructorUsedError;
  List<String> get photoUrls => throw _privateConstructorUsedError;
  Map<String, dynamic> get measurements => throw _privateConstructorUsedError;
  Map<String, String> get partsUsed => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get scheduledDate => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get startTime => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get endTime => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MaintenanceRecordCopyWith<MaintenanceRecord> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MaintenanceRecordCopyWith<$Res> {
  factory $MaintenanceRecordCopyWith(
          MaintenanceRecord value, $Res Function(MaintenanceRecord) then) =
      _$MaintenanceRecordCopyWithImpl<$Res, MaintenanceRecord>;
  @useResult
  $Res call(
      {String id,
      String equipmentId,
      String substationId,
      MaintenanceType type,
      MaintenanceStatus status,
      String description,
      String? findings,
      String? actions,
      String? technicianId,
      List<String> photoUrls,
      Map<String, dynamic> measurements,
      Map<String, String> partsUsed,
      @TimestampConverter() DateTime? scheduledDate,
      @TimestampConverter() DateTime? startTime,
      @TimestampConverter() DateTime? endTime,
      @TimestampConverter() DateTime? createdAt});
}

/// @nodoc
class _$MaintenanceRecordCopyWithImpl<$Res, $Val extends MaintenanceRecord>
    implements $MaintenanceRecordCopyWith<$Res> {
  _$MaintenanceRecordCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? equipmentId = null,
    Object? substationId = null,
    Object? type = null,
    Object? status = null,
    Object? description = null,
    Object? findings = freezed,
    Object? actions = freezed,
    Object? technicianId = freezed,
    Object? photoUrls = null,
    Object? measurements = null,
    Object? partsUsed = null,
    Object? scheduledDate = freezed,
    Object? startTime = freezed,
    Object? endTime = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      equipmentId: null == equipmentId
          ? _value.equipmentId
          : equipmentId // ignore: cast_nullable_to_non_nullable
              as String,
      substationId: null == substationId
          ? _value.substationId
          : substationId // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as MaintenanceType,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as MaintenanceStatus,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      findings: freezed == findings
          ? _value.findings
          : findings // ignore: cast_nullable_to_non_nullable
              as String?,
      actions: freezed == actions
          ? _value.actions
          : actions // ignore: cast_nullable_to_non_nullable
              as String?,
      technicianId: freezed == technicianId
          ? _value.technicianId
          : technicianId // ignore: cast_nullable_to_non_nullable
              as String?,
      photoUrls: null == photoUrls
          ? _value.photoUrls
          : photoUrls // ignore: cast_nullable_to_non_nullable
              as List<String>,
      measurements: null == measurements
          ? _value.measurements
          : measurements // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      partsUsed: null == partsUsed
          ? _value.partsUsed
          : partsUsed // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      scheduledDate: freezed == scheduledDate
          ? _value.scheduledDate
          : scheduledDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      startTime: freezed == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endTime: freezed == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MaintenanceRecordImplCopyWith<$Res>
    implements $MaintenanceRecordCopyWith<$Res> {
  factory _$$MaintenanceRecordImplCopyWith(_$MaintenanceRecordImpl value,
          $Res Function(_$MaintenanceRecordImpl) then) =
      __$$MaintenanceRecordImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String equipmentId,
      String substationId,
      MaintenanceType type,
      MaintenanceStatus status,
      String description,
      String? findings,
      String? actions,
      String? technicianId,
      List<String> photoUrls,
      Map<String, dynamic> measurements,
      Map<String, String> partsUsed,
      @TimestampConverter() DateTime? scheduledDate,
      @TimestampConverter() DateTime? startTime,
      @TimestampConverter() DateTime? endTime,
      @TimestampConverter() DateTime? createdAt});
}

/// @nodoc
class __$$MaintenanceRecordImplCopyWithImpl<$Res>
    extends _$MaintenanceRecordCopyWithImpl<$Res, _$MaintenanceRecordImpl>
    implements _$$MaintenanceRecordImplCopyWith<$Res> {
  __$$MaintenanceRecordImplCopyWithImpl(_$MaintenanceRecordImpl _value,
      $Res Function(_$MaintenanceRecordImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? equipmentId = null,
    Object? substationId = null,
    Object? type = null,
    Object? status = null,
    Object? description = null,
    Object? findings = freezed,
    Object? actions = freezed,
    Object? technicianId = freezed,
    Object? photoUrls = null,
    Object? measurements = null,
    Object? partsUsed = null,
    Object? scheduledDate = freezed,
    Object? startTime = freezed,
    Object? endTime = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_$MaintenanceRecordImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      equipmentId: null == equipmentId
          ? _value.equipmentId
          : equipmentId // ignore: cast_nullable_to_non_nullable
              as String,
      substationId: null == substationId
          ? _value.substationId
          : substationId // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as MaintenanceType,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as MaintenanceStatus,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      findings: freezed == findings
          ? _value.findings
          : findings // ignore: cast_nullable_to_non_nullable
              as String?,
      actions: freezed == actions
          ? _value.actions
          : actions // ignore: cast_nullable_to_non_nullable
              as String?,
      technicianId: freezed == technicianId
          ? _value.technicianId
          : technicianId // ignore: cast_nullable_to_non_nullable
              as String?,
      photoUrls: null == photoUrls
          ? _value._photoUrls
          : photoUrls // ignore: cast_nullable_to_non_nullable
              as List<String>,
      measurements: null == measurements
          ? _value._measurements
          : measurements // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      partsUsed: null == partsUsed
          ? _value._partsUsed
          : partsUsed // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      scheduledDate: freezed == scheduledDate
          ? _value.scheduledDate
          : scheduledDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      startTime: freezed == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endTime: freezed == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MaintenanceRecordImpl extends _MaintenanceRecord {
  const _$MaintenanceRecordImpl(
      {required this.id,
      required this.equipmentId,
      required this.substationId,
      required this.type,
      required this.status,
      required this.description,
      this.findings,
      this.actions,
      this.technicianId,
      final List<String> photoUrls = const [],
      final Map<String, dynamic> measurements = const {},
      final Map<String, String> partsUsed = const {},
      @TimestampConverter() this.scheduledDate,
      @TimestampConverter() this.startTime,
      @TimestampConverter() this.endTime,
      @TimestampConverter() this.createdAt})
      : _photoUrls = photoUrls,
        _measurements = measurements,
        _partsUsed = partsUsed,
        super._();

  factory _$MaintenanceRecordImpl.fromJson(Map<String, dynamic> json) =>
      _$$MaintenanceRecordImplFromJson(json);

  @override
  final String id;
  @override
  final String equipmentId;
  @override
  final String substationId;
  @override
  final MaintenanceType type;
  @override
  final MaintenanceStatus status;
  @override
  final String description;
  @override
  final String? findings;
  @override
  final String? actions;
  @override
  final String? technicianId;
  final List<String> _photoUrls;
  @override
  @JsonKey()
  List<String> get photoUrls {
    if (_photoUrls is EqualUnmodifiableListView) return _photoUrls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_photoUrls);
  }

  final Map<String, dynamic> _measurements;
  @override
  @JsonKey()
  Map<String, dynamic> get measurements {
    if (_measurements is EqualUnmodifiableMapView) return _measurements;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_measurements);
  }

  final Map<String, String> _partsUsed;
  @override
  @JsonKey()
  Map<String, String> get partsUsed {
    if (_partsUsed is EqualUnmodifiableMapView) return _partsUsed;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_partsUsed);
  }

  @override
  @TimestampConverter()
  final DateTime? scheduledDate;
  @override
  @TimestampConverter()
  final DateTime? startTime;
  @override
  @TimestampConverter()
  final DateTime? endTime;
  @override
  @TimestampConverter()
  final DateTime? createdAt;

  @override
  String toString() {
    return 'MaintenanceRecord(id: $id, equipmentId: $equipmentId, substationId: $substationId, type: $type, status: $status, description: $description, findings: $findings, actions: $actions, technicianId: $technicianId, photoUrls: $photoUrls, measurements: $measurements, partsUsed: $partsUsed, scheduledDate: $scheduledDate, startTime: $startTime, endTime: $endTime, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MaintenanceRecordImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.equipmentId, equipmentId) ||
                other.equipmentId == equipmentId) &&
            (identical(other.substationId, substationId) ||
                other.substationId == substationId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.findings, findings) ||
                other.findings == findings) &&
            (identical(other.actions, actions) || other.actions == actions) &&
            (identical(other.technicianId, technicianId) ||
                other.technicianId == technicianId) &&
            const DeepCollectionEquality()
                .equals(other._photoUrls, _photoUrls) &&
            const DeepCollectionEquality()
                .equals(other._measurements, _measurements) &&
            const DeepCollectionEquality()
                .equals(other._partsUsed, _partsUsed) &&
            (identical(other.scheduledDate, scheduledDate) ||
                other.scheduledDate == scheduledDate) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      equipmentId,
      substationId,
      type,
      status,
      description,
      findings,
      actions,
      technicianId,
      const DeepCollectionEquality().hash(_photoUrls),
      const DeepCollectionEquality().hash(_measurements),
      const DeepCollectionEquality().hash(_partsUsed),
      scheduledDate,
      startTime,
      endTime,
      createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MaintenanceRecordImplCopyWith<_$MaintenanceRecordImpl> get copyWith =>
      __$$MaintenanceRecordImplCopyWithImpl<_$MaintenanceRecordImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MaintenanceRecordImplToJson(
      this,
    );
  }
}

abstract class _MaintenanceRecord extends MaintenanceRecord {
  const factory _MaintenanceRecord(
          {required final String id,
          required final String equipmentId,
          required final String substationId,
          required final MaintenanceType type,
          required final MaintenanceStatus status,
          required final String description,
          final String? findings,
          final String? actions,
          final String? technicianId,
          final List<String> photoUrls,
          final Map<String, dynamic> measurements,
          final Map<String, String> partsUsed,
          @TimestampConverter() final DateTime? scheduledDate,
          @TimestampConverter() final DateTime? startTime,
          @TimestampConverter() final DateTime? endTime,
          @TimestampConverter() final DateTime? createdAt}) =
      _$MaintenanceRecordImpl;
  const _MaintenanceRecord._() : super._();

  factory _MaintenanceRecord.fromJson(Map<String, dynamic> json) =
      _$MaintenanceRecordImpl.fromJson;

  @override
  String get id;
  @override
  String get equipmentId;
  @override
  String get substationId;
  @override
  MaintenanceType get type;
  @override
  MaintenanceStatus get status;
  @override
  String get description;
  @override
  String? get findings;
  @override
  String? get actions;
  @override
  String? get technicianId;
  @override
  List<String> get photoUrls;
  @override
  Map<String, dynamic> get measurements;
  @override
  Map<String, String> get partsUsed;
  @override
  @TimestampConverter()
  DateTime? get scheduledDate;
  @override
  @TimestampConverter()
  DateTime? get startTime;
  @override
  @TimestampConverter()
  DateTime? get endTime;
  @override
  @TimestampConverter()
  DateTime? get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$MaintenanceRecordImplCopyWith<_$MaintenanceRecordImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
