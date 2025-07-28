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
  String? get logoUrl => throw _privateConstructorUsedError;
  String get industry =>
      throw _privateConstructorUsedError; // 'electrical', 'manufacturing', etc.
  String? get website => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  OrganizationAddress get address => throw _privateConstructorUsedError;
  SubscriptionTier get subscriptionTier => throw _privateConstructorUsedError;
  Map<String, dynamic> get settings => throw _privateConstructorUsedError;
  Map<String, int> get limits =>
      throw _privateConstructorUsedError; // user_limit, storage_limit, etc.
  bool get isActive => throw _privateConstructorUsedError;
  String? get ownerId => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get subscriptionExpiryAt => throw _privateConstructorUsedError;
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
      String? logoUrl,
      String industry,
      String? website,
      String? email,
      String? phone,
      OrganizationAddress address,
      SubscriptionTier subscriptionTier,
      Map<String, dynamic> settings,
      Map<String, int> limits,
      bool isActive,
      String? ownerId,
      @TimestampConverter() DateTime? subscriptionExpiryAt,
      @TimestampConverter() DateTime? createdAt,
      @TimestampConverter() DateTime? updatedAt});

  $OrganizationAddressCopyWith<$Res> get address;
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
    Object? logoUrl = freezed,
    Object? industry = null,
    Object? website = freezed,
    Object? email = freezed,
    Object? phone = freezed,
    Object? address = null,
    Object? subscriptionTier = null,
    Object? settings = null,
    Object? limits = null,
    Object? isActive = null,
    Object? ownerId = freezed,
    Object? subscriptionExpiryAt = freezed,
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
      logoUrl: freezed == logoUrl
          ? _value.logoUrl
          : logoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      industry: null == industry
          ? _value.industry
          : industry // ignore: cast_nullable_to_non_nullable
              as String,
      website: freezed == website
          ? _value.website
          : website // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as OrganizationAddress,
      subscriptionTier: null == subscriptionTier
          ? _value.subscriptionTier
          : subscriptionTier // ignore: cast_nullable_to_non_nullable
              as SubscriptionTier,
      settings: null == settings
          ? _value.settings
          : settings // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      limits: null == limits
          ? _value.limits
          : limits // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      ownerId: freezed == ownerId
          ? _value.ownerId
          : ownerId // ignore: cast_nullable_to_non_nullable
              as String?,
      subscriptionExpiryAt: freezed == subscriptionExpiryAt
          ? _value.subscriptionExpiryAt
          : subscriptionExpiryAt // ignore: cast_nullable_to_non_nullable
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
  $OrganizationAddressCopyWith<$Res> get address {
    return $OrganizationAddressCopyWith<$Res>(_value.address, (value) {
      return _then(_value.copyWith(address: value) as $Val);
    });
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
      String? logoUrl,
      String industry,
      String? website,
      String? email,
      String? phone,
      OrganizationAddress address,
      SubscriptionTier subscriptionTier,
      Map<String, dynamic> settings,
      Map<String, int> limits,
      bool isActive,
      String? ownerId,
      @TimestampConverter() DateTime? subscriptionExpiryAt,
      @TimestampConverter() DateTime? createdAt,
      @TimestampConverter() DateTime? updatedAt});

  @override
  $OrganizationAddressCopyWith<$Res> get address;
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
    Object? logoUrl = freezed,
    Object? industry = null,
    Object? website = freezed,
    Object? email = freezed,
    Object? phone = freezed,
    Object? address = null,
    Object? subscriptionTier = null,
    Object? settings = null,
    Object? limits = null,
    Object? isActive = null,
    Object? ownerId = freezed,
    Object? subscriptionExpiryAt = freezed,
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
      logoUrl: freezed == logoUrl
          ? _value.logoUrl
          : logoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      industry: null == industry
          ? _value.industry
          : industry // ignore: cast_nullable_to_non_nullable
              as String,
      website: freezed == website
          ? _value.website
          : website // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as OrganizationAddress,
      subscriptionTier: null == subscriptionTier
          ? _value.subscriptionTier
          : subscriptionTier // ignore: cast_nullable_to_non_nullable
              as SubscriptionTier,
      settings: null == settings
          ? _value._settings
          : settings // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      limits: null == limits
          ? _value._limits
          : limits // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      ownerId: freezed == ownerId
          ? _value.ownerId
          : ownerId // ignore: cast_nullable_to_non_nullable
              as String?,
      subscriptionExpiryAt: freezed == subscriptionExpiryAt
          ? _value.subscriptionExpiryAt
          : subscriptionExpiryAt // ignore: cast_nullable_to_non_nullable
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
class _$OrganizationModelImpl extends _OrganizationModel {
  const _$OrganizationModelImpl(
      {required this.id,
      required this.name,
      this.description,
      this.logoUrl,
      required this.industry,
      this.website,
      this.email,
      this.phone,
      required this.address,
      required this.subscriptionTier,
      required final Map<String, dynamic> settings,
      final Map<String, int> limits = const {},
      this.isActive = true,
      this.ownerId,
      @TimestampConverter() this.subscriptionExpiryAt,
      @TimestampConverter() this.createdAt,
      @TimestampConverter() this.updatedAt})
      : _settings = settings,
        _limits = limits,
        super._();

  factory _$OrganizationModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrganizationModelImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String? description;
  @override
  final String? logoUrl;
  @override
  final String industry;
// 'electrical', 'manufacturing', etc.
  @override
  final String? website;
  @override
  final String? email;
  @override
  final String? phone;
  @override
  final OrganizationAddress address;
  @override
  final SubscriptionTier subscriptionTier;
  final Map<String, dynamic> _settings;
  @override
  Map<String, dynamic> get settings {
    if (_settings is EqualUnmodifiableMapView) return _settings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_settings);
  }

  final Map<String, int> _limits;
  @override
  @JsonKey()
  Map<String, int> get limits {
    if (_limits is EqualUnmodifiableMapView) return _limits;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_limits);
  }

// user_limit, storage_limit, etc.
  @override
  @JsonKey()
  final bool isActive;
  @override
  final String? ownerId;
  @override
  @TimestampConverter()
  final DateTime? subscriptionExpiryAt;
  @override
  @TimestampConverter()
  final DateTime? createdAt;
  @override
  @TimestampConverter()
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'OrganizationModel(id: $id, name: $name, description: $description, logoUrl: $logoUrl, industry: $industry, website: $website, email: $email, phone: $phone, address: $address, subscriptionTier: $subscriptionTier, settings: $settings, limits: $limits, isActive: $isActive, ownerId: $ownerId, subscriptionExpiryAt: $subscriptionExpiryAt, createdAt: $createdAt, updatedAt: $updatedAt)';
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
            (identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl) &&
            (identical(other.industry, industry) ||
                other.industry == industry) &&
            (identical(other.website, website) || other.website == website) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.subscriptionTier, subscriptionTier) ||
                other.subscriptionTier == subscriptionTier) &&
            const DeepCollectionEquality().equals(other._settings, _settings) &&
            const DeepCollectionEquality().equals(other._limits, _limits) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.ownerId, ownerId) || other.ownerId == ownerId) &&
            (identical(other.subscriptionExpiryAt, subscriptionExpiryAt) ||
                other.subscriptionExpiryAt == subscriptionExpiryAt) &&
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
      logoUrl,
      industry,
      website,
      email,
      phone,
      address,
      subscriptionTier,
      const DeepCollectionEquality().hash(_settings),
      const DeepCollectionEquality().hash(_limits),
      isActive,
      ownerId,
      subscriptionExpiryAt,
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

abstract class _OrganizationModel extends OrganizationModel {
  const factory _OrganizationModel(
          {required final String id,
          required final String name,
          final String? description,
          final String? logoUrl,
          required final String industry,
          final String? website,
          final String? email,
          final String? phone,
          required final OrganizationAddress address,
          required final SubscriptionTier subscriptionTier,
          required final Map<String, dynamic> settings,
          final Map<String, int> limits,
          final bool isActive,
          final String? ownerId,
          @TimestampConverter() final DateTime? subscriptionExpiryAt,
          @TimestampConverter() final DateTime? createdAt,
          @TimestampConverter() final DateTime? updatedAt}) =
      _$OrganizationModelImpl;
  const _OrganizationModel._() : super._();

  factory _OrganizationModel.fromJson(Map<String, dynamic> json) =
      _$OrganizationModelImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String? get description;
  @override
  String? get logoUrl;
  @override
  String get industry;
  @override // 'electrical', 'manufacturing', etc.
  String? get website;
  @override
  String? get email;
  @override
  String? get phone;
  @override
  OrganizationAddress get address;
  @override
  SubscriptionTier get subscriptionTier;
  @override
  Map<String, dynamic> get settings;
  @override
  Map<String, int> get limits;
  @override // user_limit, storage_limit, etc.
  bool get isActive;
  @override
  String? get ownerId;
  @override
  @TimestampConverter()
  DateTime? get subscriptionExpiryAt;
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

OrganizationAddress _$OrganizationAddressFromJson(Map<String, dynamic> json) {
  return _OrganizationAddress.fromJson(json);
}

/// @nodoc
mixin _$OrganizationAddress {
  String get street => throw _privateConstructorUsedError;
  String get city => throw _privateConstructorUsedError;
  String get state => throw _privateConstructorUsedError;
  String get country => throw _privateConstructorUsedError;
  String get pincode => throw _privateConstructorUsedError;
  String? get landmark => throw _privateConstructorUsedError;
  double? get latitude => throw _privateConstructorUsedError;
  double? get longitude => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OrganizationAddressCopyWith<OrganizationAddress> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrganizationAddressCopyWith<$Res> {
  factory $OrganizationAddressCopyWith(
          OrganizationAddress value, $Res Function(OrganizationAddress) then) =
      _$OrganizationAddressCopyWithImpl<$Res, OrganizationAddress>;
  @useResult
  $Res call(
      {String street,
      String city,
      String state,
      String country,
      String pincode,
      String? landmark,
      double? latitude,
      double? longitude});
}

/// @nodoc
class _$OrganizationAddressCopyWithImpl<$Res, $Val extends OrganizationAddress>
    implements $OrganizationAddressCopyWith<$Res> {
  _$OrganizationAddressCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? street = null,
    Object? city = null,
    Object? state = null,
    Object? country = null,
    Object? pincode = null,
    Object? landmark = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
  }) {
    return _then(_value.copyWith(
      street: null == street
          ? _value.street
          : street // ignore: cast_nullable_to_non_nullable
              as String,
      city: null == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String,
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String,
      country: null == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String,
      pincode: null == pincode
          ? _value.pincode
          : pincode // ignore: cast_nullable_to_non_nullable
              as String,
      landmark: freezed == landmark
          ? _value.landmark
          : landmark // ignore: cast_nullable_to_non_nullable
              as String?,
      latitude: freezed == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double?,
      longitude: freezed == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OrganizationAddressImplCopyWith<$Res>
    implements $OrganizationAddressCopyWith<$Res> {
  factory _$$OrganizationAddressImplCopyWith(_$OrganizationAddressImpl value,
          $Res Function(_$OrganizationAddressImpl) then) =
      __$$OrganizationAddressImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String street,
      String city,
      String state,
      String country,
      String pincode,
      String? landmark,
      double? latitude,
      double? longitude});
}

/// @nodoc
class __$$OrganizationAddressImplCopyWithImpl<$Res>
    extends _$OrganizationAddressCopyWithImpl<$Res, _$OrganizationAddressImpl>
    implements _$$OrganizationAddressImplCopyWith<$Res> {
  __$$OrganizationAddressImplCopyWithImpl(_$OrganizationAddressImpl _value,
      $Res Function(_$OrganizationAddressImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? street = null,
    Object? city = null,
    Object? state = null,
    Object? country = null,
    Object? pincode = null,
    Object? landmark = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
  }) {
    return _then(_$OrganizationAddressImpl(
      street: null == street
          ? _value.street
          : street // ignore: cast_nullable_to_non_nullable
              as String,
      city: null == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String,
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String,
      country: null == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String,
      pincode: null == pincode
          ? _value.pincode
          : pincode // ignore: cast_nullable_to_non_nullable
              as String,
      landmark: freezed == landmark
          ? _value.landmark
          : landmark // ignore: cast_nullable_to_non_nullable
              as String?,
      latitude: freezed == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double?,
      longitude: freezed == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OrganizationAddressImpl extends _OrganizationAddress {
  const _$OrganizationAddressImpl(
      {required this.street,
      required this.city,
      required this.state,
      required this.country,
      required this.pincode,
      this.landmark,
      this.latitude,
      this.longitude})
      : super._();

  factory _$OrganizationAddressImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrganizationAddressImplFromJson(json);

  @override
  final String street;
  @override
  final String city;
  @override
  final String state;
  @override
  final String country;
  @override
  final String pincode;
  @override
  final String? landmark;
  @override
  final double? latitude;
  @override
  final double? longitude;

  @override
  String toString() {
    return 'OrganizationAddress(street: $street, city: $city, state: $state, country: $country, pincode: $pincode, landmark: $landmark, latitude: $latitude, longitude: $longitude)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrganizationAddressImpl &&
            (identical(other.street, street) || other.street == street) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.pincode, pincode) || other.pincode == pincode) &&
            (identical(other.landmark, landmark) ||
                other.landmark == landmark) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, street, city, state, country,
      pincode, landmark, latitude, longitude);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OrganizationAddressImplCopyWith<_$OrganizationAddressImpl> get copyWith =>
      __$$OrganizationAddressImplCopyWithImpl<_$OrganizationAddressImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrganizationAddressImplToJson(
      this,
    );
  }
}

abstract class _OrganizationAddress extends OrganizationAddress {
  const factory _OrganizationAddress(
      {required final String street,
      required final String city,
      required final String state,
      required final String country,
      required final String pincode,
      final String? landmark,
      final double? latitude,
      final double? longitude}) = _$OrganizationAddressImpl;
  const _OrganizationAddress._() : super._();

  factory _OrganizationAddress.fromJson(Map<String, dynamic> json) =
      _$OrganizationAddressImpl.fromJson;

  @override
  String get street;
  @override
  String get city;
  @override
  String get state;
  @override
  String get country;
  @override
  String get pincode;
  @override
  String? get landmark;
  @override
  double? get latitude;
  @override
  double? get longitude;
  @override
  @JsonKey(ignore: true)
  _$$OrganizationAddressImplCopyWith<_$OrganizationAddressImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Department _$DepartmentFromJson(Map<String, dynamic> json) {
  return _Department.fromJson(json);
}

/// @nodoc
mixin _$Department {
  String get id => throw _privateConstructorUsedError;
  String get organizationId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get managerId => throw _privateConstructorUsedError;
  String? get parentDepartmentId => throw _privateConstructorUsedError;
  List<String> get childDepartments => throw _privateConstructorUsedError;
  Map<String, dynamic> get settings => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DepartmentCopyWith<Department> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DepartmentCopyWith<$Res> {
  factory $DepartmentCopyWith(
          Department value, $Res Function(Department) then) =
      _$DepartmentCopyWithImpl<$Res, Department>;
  @useResult
  $Res call(
      {String id,
      String organizationId,
      String name,
      String? description,
      String? managerId,
      String? parentDepartmentId,
      List<String> childDepartments,
      Map<String, dynamic> settings,
      bool isActive,
      @TimestampConverter() DateTime? createdAt,
      @TimestampConverter() DateTime? updatedAt});
}

/// @nodoc
class _$DepartmentCopyWithImpl<$Res, $Val extends Department>
    implements $DepartmentCopyWith<$Res> {
  _$DepartmentCopyWithImpl(this._value, this._then);

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
    Object? managerId = freezed,
    Object? parentDepartmentId = freezed,
    Object? childDepartments = null,
    Object? settings = null,
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
      managerId: freezed == managerId
          ? _value.managerId
          : managerId // ignore: cast_nullable_to_non_nullable
              as String?,
      parentDepartmentId: freezed == parentDepartmentId
          ? _value.parentDepartmentId
          : parentDepartmentId // ignore: cast_nullable_to_non_nullable
              as String?,
      childDepartments: null == childDepartments
          ? _value.childDepartments
          : childDepartments // ignore: cast_nullable_to_non_nullable
              as List<String>,
      settings: null == settings
          ? _value.settings
          : settings // ignore: cast_nullable_to_non_nullable
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
abstract class _$$DepartmentImplCopyWith<$Res>
    implements $DepartmentCopyWith<$Res> {
  factory _$$DepartmentImplCopyWith(
          _$DepartmentImpl value, $Res Function(_$DepartmentImpl) then) =
      __$$DepartmentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String organizationId,
      String name,
      String? description,
      String? managerId,
      String? parentDepartmentId,
      List<String> childDepartments,
      Map<String, dynamic> settings,
      bool isActive,
      @TimestampConverter() DateTime? createdAt,
      @TimestampConverter() DateTime? updatedAt});
}

/// @nodoc
class __$$DepartmentImplCopyWithImpl<$Res>
    extends _$DepartmentCopyWithImpl<$Res, _$DepartmentImpl>
    implements _$$DepartmentImplCopyWith<$Res> {
  __$$DepartmentImplCopyWithImpl(
      _$DepartmentImpl _value, $Res Function(_$DepartmentImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? organizationId = null,
    Object? name = null,
    Object? description = freezed,
    Object? managerId = freezed,
    Object? parentDepartmentId = freezed,
    Object? childDepartments = null,
    Object? settings = null,
    Object? isActive = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$DepartmentImpl(
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
      managerId: freezed == managerId
          ? _value.managerId
          : managerId // ignore: cast_nullable_to_non_nullable
              as String?,
      parentDepartmentId: freezed == parentDepartmentId
          ? _value.parentDepartmentId
          : parentDepartmentId // ignore: cast_nullable_to_non_nullable
              as String?,
      childDepartments: null == childDepartments
          ? _value._childDepartments
          : childDepartments // ignore: cast_nullable_to_non_nullable
              as List<String>,
      settings: null == settings
          ? _value._settings
          : settings // ignore: cast_nullable_to_non_nullable
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
class _$DepartmentImpl extends _Department {
  const _$DepartmentImpl(
      {required this.id,
      required this.organizationId,
      required this.name,
      this.description,
      this.managerId,
      this.parentDepartmentId,
      final List<String> childDepartments = const [],
      final Map<String, dynamic> settings = const {},
      this.isActive = true,
      @TimestampConverter() this.createdAt,
      @TimestampConverter() this.updatedAt})
      : _childDepartments = childDepartments,
        _settings = settings,
        super._();

  factory _$DepartmentImpl.fromJson(Map<String, dynamic> json) =>
      _$$DepartmentImplFromJson(json);

  @override
  final String id;
  @override
  final String organizationId;
  @override
  final String name;
  @override
  final String? description;
  @override
  final String? managerId;
  @override
  final String? parentDepartmentId;
  final List<String> _childDepartments;
  @override
  @JsonKey()
  List<String> get childDepartments {
    if (_childDepartments is EqualUnmodifiableListView)
      return _childDepartments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_childDepartments);
  }

  final Map<String, dynamic> _settings;
  @override
  @JsonKey()
  Map<String, dynamic> get settings {
    if (_settings is EqualUnmodifiableMapView) return _settings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_settings);
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
    return 'Department(id: $id, organizationId: $organizationId, name: $name, description: $description, managerId: $managerId, parentDepartmentId: $parentDepartmentId, childDepartments: $childDepartments, settings: $settings, isActive: $isActive, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DepartmentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.organizationId, organizationId) ||
                other.organizationId == organizationId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.managerId, managerId) ||
                other.managerId == managerId) &&
            (identical(other.parentDepartmentId, parentDepartmentId) ||
                other.parentDepartmentId == parentDepartmentId) &&
            const DeepCollectionEquality()
                .equals(other._childDepartments, _childDepartments) &&
            const DeepCollectionEquality().equals(other._settings, _settings) &&
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
      managerId,
      parentDepartmentId,
      const DeepCollectionEquality().hash(_childDepartments),
      const DeepCollectionEquality().hash(_settings),
      isActive,
      createdAt,
      updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DepartmentImplCopyWith<_$DepartmentImpl> get copyWith =>
      __$$DepartmentImplCopyWithImpl<_$DepartmentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DepartmentImplToJson(
      this,
    );
  }
}

abstract class _Department extends Department {
  const factory _Department(
      {required final String id,
      required final String organizationId,
      required final String name,
      final String? description,
      final String? managerId,
      final String? parentDepartmentId,
      final List<String> childDepartments,
      final Map<String, dynamic> settings,
      final bool isActive,
      @TimestampConverter() final DateTime? createdAt,
      @TimestampConverter() final DateTime? updatedAt}) = _$DepartmentImpl;
  const _Department._() : super._();

  factory _Department.fromJson(Map<String, dynamic> json) =
      _$DepartmentImpl.fromJson;

  @override
  String get id;
  @override
  String get organizationId;
  @override
  String get name;
  @override
  String? get description;
  @override
  String? get managerId;
  @override
  String? get parentDepartmentId;
  @override
  List<String> get childDepartments;
  @override
  Map<String, dynamic> get settings;
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
  _$$DepartmentImplCopyWith<_$DepartmentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
