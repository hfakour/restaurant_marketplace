// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'restaurant.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$Restaurant {
  String get id => throw _privateConstructorUsedError; // Identity
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get contactNumber => throw _privateConstructorUsedError;
  String? get email =>
      throw _privateConstructorUsedError; // Location (public address only)
  AddressRef? get addressRef => throw _privateConstructorUsedError; // Media
  String? get logoUrl => throw _privateConstructorUsedError;
  String? get coverUrl => throw _privateConstructorUsedError;
  List<String> get galleryUrls =>
      throw _privateConstructorUsedError; // Cross-feature refs (user-facing)
  List<MenuRef> get menuRefs =>
      throw _privateConstructorUsedError; // NEW: menus
  List<ReservationRef> get reservationRefs =>
      throw _privateConstructorUsedError;
  List<OrderRef> get orderRefs => throw _privateConstructorUsedError;
  List<ReviewRef> get reviewRefs =>
      throw _privateConstructorUsedError; // user reviews
  // Taxonomy / tags
  List<String> get cuisines =>
      throw _privateConstructorUsedError; // e.g., ["Italian", "Vegan"]
  // Ratings / aggregates
  double? get averageRating => throw _privateConstructorUsedError; // 0..5
  int get ratingsCount => throw _privateConstructorUsedError; // Auditing
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt =>
      throw _privateConstructorUsedError; // Extra metadata (safe by design)
  Map<String, dynamic> get metadata => throw _privateConstructorUsedError;

  /// Create a copy of Restaurant
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RestaurantCopyWith<Restaurant> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RestaurantCopyWith<$Res> {
  factory $RestaurantCopyWith(
    Restaurant value,
    $Res Function(Restaurant) then,
  ) = _$RestaurantCopyWithImpl<$Res, Restaurant>;
  @useResult
  $Res call({
    String id,
    String name,
    String? description,
    String? contactNumber,
    String? email,
    AddressRef? addressRef,
    String? logoUrl,
    String? coverUrl,
    List<String> galleryUrls,
    List<MenuRef> menuRefs,
    List<ReservationRef> reservationRefs,
    List<OrderRef> orderRefs,
    List<ReviewRef> reviewRefs,
    List<String> cuisines,
    double? averageRating,
    int ratingsCount,
    DateTime? createdAt,
    DateTime? updatedAt,
    Map<String, dynamic> metadata,
  });

  $AddressRefCopyWith<$Res>? get addressRef;
}

/// @nodoc
class _$RestaurantCopyWithImpl<$Res, $Val extends Restaurant>
    implements $RestaurantCopyWith<$Res> {
  _$RestaurantCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Restaurant
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? contactNumber = freezed,
    Object? email = freezed,
    Object? addressRef = freezed,
    Object? logoUrl = freezed,
    Object? coverUrl = freezed,
    Object? galleryUrls = null,
    Object? menuRefs = null,
    Object? reservationRefs = null,
    Object? orderRefs = null,
    Object? reviewRefs = null,
    Object? cuisines = null,
    Object? averageRating = freezed,
    Object? ratingsCount = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? metadata = null,
  }) {
    return _then(
      _value.copyWith(
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
            contactNumber: freezed == contactNumber
                ? _value.contactNumber
                : contactNumber // ignore: cast_nullable_to_non_nullable
                      as String?,
            email: freezed == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String?,
            addressRef: freezed == addressRef
                ? _value.addressRef
                : addressRef // ignore: cast_nullable_to_non_nullable
                      as AddressRef?,
            logoUrl: freezed == logoUrl
                ? _value.logoUrl
                : logoUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            coverUrl: freezed == coverUrl
                ? _value.coverUrl
                : coverUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            galleryUrls: null == galleryUrls
                ? _value.galleryUrls
                : galleryUrls // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            menuRefs: null == menuRefs
                ? _value.menuRefs
                : menuRefs // ignore: cast_nullable_to_non_nullable
                      as List<MenuRef>,
            reservationRefs: null == reservationRefs
                ? _value.reservationRefs
                : reservationRefs // ignore: cast_nullable_to_non_nullable
                      as List<ReservationRef>,
            orderRefs: null == orderRefs
                ? _value.orderRefs
                : orderRefs // ignore: cast_nullable_to_non_nullable
                      as List<OrderRef>,
            reviewRefs: null == reviewRefs
                ? _value.reviewRefs
                : reviewRefs // ignore: cast_nullable_to_non_nullable
                      as List<ReviewRef>,
            cuisines: null == cuisines
                ? _value.cuisines
                : cuisines // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            averageRating: freezed == averageRating
                ? _value.averageRating
                : averageRating // ignore: cast_nullable_to_non_nullable
                      as double?,
            ratingsCount: null == ratingsCount
                ? _value.ratingsCount
                : ratingsCount // ignore: cast_nullable_to_non_nullable
                      as int,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            updatedAt: freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            metadata: null == metadata
                ? _value.metadata
                : metadata // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>,
          )
          as $Val,
    );
  }

  /// Create a copy of Restaurant
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressRefCopyWith<$Res>? get addressRef {
    if (_value.addressRef == null) {
      return null;
    }

    return $AddressRefCopyWith<$Res>(_value.addressRef!, (value) {
      return _then(_value.copyWith(addressRef: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$RestaurantImplCopyWith<$Res>
    implements $RestaurantCopyWith<$Res> {
  factory _$$RestaurantImplCopyWith(
    _$RestaurantImpl value,
    $Res Function(_$RestaurantImpl) then,
  ) = __$$RestaurantImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String? description,
    String? contactNumber,
    String? email,
    AddressRef? addressRef,
    String? logoUrl,
    String? coverUrl,
    List<String> galleryUrls,
    List<MenuRef> menuRefs,
    List<ReservationRef> reservationRefs,
    List<OrderRef> orderRefs,
    List<ReviewRef> reviewRefs,
    List<String> cuisines,
    double? averageRating,
    int ratingsCount,
    DateTime? createdAt,
    DateTime? updatedAt,
    Map<String, dynamic> metadata,
  });

  @override
  $AddressRefCopyWith<$Res>? get addressRef;
}

/// @nodoc
class __$$RestaurantImplCopyWithImpl<$Res>
    extends _$RestaurantCopyWithImpl<$Res, _$RestaurantImpl>
    implements _$$RestaurantImplCopyWith<$Res> {
  __$$RestaurantImplCopyWithImpl(
    _$RestaurantImpl _value,
    $Res Function(_$RestaurantImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Restaurant
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? contactNumber = freezed,
    Object? email = freezed,
    Object? addressRef = freezed,
    Object? logoUrl = freezed,
    Object? coverUrl = freezed,
    Object? galleryUrls = null,
    Object? menuRefs = null,
    Object? reservationRefs = null,
    Object? orderRefs = null,
    Object? reviewRefs = null,
    Object? cuisines = null,
    Object? averageRating = freezed,
    Object? ratingsCount = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? metadata = null,
  }) {
    return _then(
      _$RestaurantImpl(
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
        contactNumber: freezed == contactNumber
            ? _value.contactNumber
            : contactNumber // ignore: cast_nullable_to_non_nullable
                  as String?,
        email: freezed == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String?,
        addressRef: freezed == addressRef
            ? _value.addressRef
            : addressRef // ignore: cast_nullable_to_non_nullable
                  as AddressRef?,
        logoUrl: freezed == logoUrl
            ? _value.logoUrl
            : logoUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        coverUrl: freezed == coverUrl
            ? _value.coverUrl
            : coverUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        galleryUrls: null == galleryUrls
            ? _value._galleryUrls
            : galleryUrls // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        menuRefs: null == menuRefs
            ? _value._menuRefs
            : menuRefs // ignore: cast_nullable_to_non_nullable
                  as List<MenuRef>,
        reservationRefs: null == reservationRefs
            ? _value._reservationRefs
            : reservationRefs // ignore: cast_nullable_to_non_nullable
                  as List<ReservationRef>,
        orderRefs: null == orderRefs
            ? _value._orderRefs
            : orderRefs // ignore: cast_nullable_to_non_nullable
                  as List<OrderRef>,
        reviewRefs: null == reviewRefs
            ? _value._reviewRefs
            : reviewRefs // ignore: cast_nullable_to_non_nullable
                  as List<ReviewRef>,
        cuisines: null == cuisines
            ? _value._cuisines
            : cuisines // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        averageRating: freezed == averageRating
            ? _value.averageRating
            : averageRating // ignore: cast_nullable_to_non_nullable
                  as double?,
        ratingsCount: null == ratingsCount
            ? _value.ratingsCount
            : ratingsCount // ignore: cast_nullable_to_non_nullable
                  as int,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        updatedAt: freezed == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        metadata: null == metadata
            ? _value._metadata
            : metadata // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
      ),
    );
  }
}

/// @nodoc

class _$RestaurantImpl implements _Restaurant {
  const _$RestaurantImpl({
    required this.id,
    required this.name,
    this.description,
    this.contactNumber,
    this.email,
    this.addressRef,
    this.logoUrl,
    this.coverUrl,
    final List<String> galleryUrls = const <String>[],
    final List<MenuRef> menuRefs = const <MenuRef>[],
    final List<ReservationRef> reservationRefs = const <ReservationRef>[],
    final List<OrderRef> orderRefs = const <OrderRef>[],
    final List<ReviewRef> reviewRefs = const <ReviewRef>[],
    final List<String> cuisines = const <String>[],
    this.averageRating,
    this.ratingsCount = 0,
    this.createdAt,
    this.updatedAt,
    final Map<String, dynamic> metadata = const <String, dynamic>{},
  }) : _galleryUrls = galleryUrls,
       _menuRefs = menuRefs,
       _reservationRefs = reservationRefs,
       _orderRefs = orderRefs,
       _reviewRefs = reviewRefs,
       _cuisines = cuisines,
       _metadata = metadata;

  @override
  final String id;
  // Identity
  @override
  final String name;
  @override
  final String? description;
  @override
  final String? contactNumber;
  @override
  final String? email;
  // Location (public address only)
  @override
  final AddressRef? addressRef;
  // Media
  @override
  final String? logoUrl;
  @override
  final String? coverUrl;
  final List<String> _galleryUrls;
  @override
  @JsonKey()
  List<String> get galleryUrls {
    if (_galleryUrls is EqualUnmodifiableListView) return _galleryUrls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_galleryUrls);
  }

  // Cross-feature refs (user-facing)
  final List<MenuRef> _menuRefs;
  // Cross-feature refs (user-facing)
  @override
  @JsonKey()
  List<MenuRef> get menuRefs {
    if (_menuRefs is EqualUnmodifiableListView) return _menuRefs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_menuRefs);
  }

  // NEW: menus
  final List<ReservationRef> _reservationRefs;
  // NEW: menus
  @override
  @JsonKey()
  List<ReservationRef> get reservationRefs {
    if (_reservationRefs is EqualUnmodifiableListView) return _reservationRefs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_reservationRefs);
  }

  final List<OrderRef> _orderRefs;
  @override
  @JsonKey()
  List<OrderRef> get orderRefs {
    if (_orderRefs is EqualUnmodifiableListView) return _orderRefs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_orderRefs);
  }

  final List<ReviewRef> _reviewRefs;
  @override
  @JsonKey()
  List<ReviewRef> get reviewRefs {
    if (_reviewRefs is EqualUnmodifiableListView) return _reviewRefs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_reviewRefs);
  }

  // user reviews
  // Taxonomy / tags
  final List<String> _cuisines;
  // user reviews
  // Taxonomy / tags
  @override
  @JsonKey()
  List<String> get cuisines {
    if (_cuisines is EqualUnmodifiableListView) return _cuisines;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_cuisines);
  }

  // e.g., ["Italian", "Vegan"]
  // Ratings / aggregates
  @override
  final double? averageRating;
  // 0..5
  @override
  @JsonKey()
  final int ratingsCount;
  // Auditing
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  // Extra metadata (safe by design)
  final Map<String, dynamic> _metadata;
  // Extra metadata (safe by design)
  @override
  @JsonKey()
  Map<String, dynamic> get metadata {
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_metadata);
  }

  @override
  String toString() {
    return 'Restaurant(id: $id, name: $name, description: $description, contactNumber: $contactNumber, email: $email, addressRef: $addressRef, logoUrl: $logoUrl, coverUrl: $coverUrl, galleryUrls: $galleryUrls, menuRefs: $menuRefs, reservationRefs: $reservationRefs, orderRefs: $orderRefs, reviewRefs: $reviewRefs, cuisines: $cuisines, averageRating: $averageRating, ratingsCount: $ratingsCount, createdAt: $createdAt, updatedAt: $updatedAt, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RestaurantImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.contactNumber, contactNumber) ||
                other.contactNumber == contactNumber) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.addressRef, addressRef) ||
                other.addressRef == addressRef) &&
            (identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl) &&
            (identical(other.coverUrl, coverUrl) ||
                other.coverUrl == coverUrl) &&
            const DeepCollectionEquality().equals(
              other._galleryUrls,
              _galleryUrls,
            ) &&
            const DeepCollectionEquality().equals(other._menuRefs, _menuRefs) &&
            const DeepCollectionEquality().equals(
              other._reservationRefs,
              _reservationRefs,
            ) &&
            const DeepCollectionEquality().equals(
              other._orderRefs,
              _orderRefs,
            ) &&
            const DeepCollectionEquality().equals(
              other._reviewRefs,
              _reviewRefs,
            ) &&
            const DeepCollectionEquality().equals(other._cuisines, _cuisines) &&
            (identical(other.averageRating, averageRating) ||
                other.averageRating == averageRating) &&
            (identical(other.ratingsCount, ratingsCount) ||
                other.ratingsCount == ratingsCount) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    name,
    description,
    contactNumber,
    email,
    addressRef,
    logoUrl,
    coverUrl,
    const DeepCollectionEquality().hash(_galleryUrls),
    const DeepCollectionEquality().hash(_menuRefs),
    const DeepCollectionEquality().hash(_reservationRefs),
    const DeepCollectionEquality().hash(_orderRefs),
    const DeepCollectionEquality().hash(_reviewRefs),
    const DeepCollectionEquality().hash(_cuisines),
    averageRating,
    ratingsCount,
    createdAt,
    updatedAt,
    const DeepCollectionEquality().hash(_metadata),
  ]);

  /// Create a copy of Restaurant
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RestaurantImplCopyWith<_$RestaurantImpl> get copyWith =>
      __$$RestaurantImplCopyWithImpl<_$RestaurantImpl>(this, _$identity);
}

abstract class _Restaurant implements Restaurant {
  const factory _Restaurant({
    required final String id,
    required final String name,
    final String? description,
    final String? contactNumber,
    final String? email,
    final AddressRef? addressRef,
    final String? logoUrl,
    final String? coverUrl,
    final List<String> galleryUrls,
    final List<MenuRef> menuRefs,
    final List<ReservationRef> reservationRefs,
    final List<OrderRef> orderRefs,
    final List<ReviewRef> reviewRefs,
    final List<String> cuisines,
    final double? averageRating,
    final int ratingsCount,
    final DateTime? createdAt,
    final DateTime? updatedAt,
    final Map<String, dynamic> metadata,
  }) = _$RestaurantImpl;

  @override
  String get id; // Identity
  @override
  String get name;
  @override
  String? get description;
  @override
  String? get contactNumber;
  @override
  String? get email; // Location (public address only)
  @override
  AddressRef? get addressRef; // Media
  @override
  String? get logoUrl;
  @override
  String? get coverUrl;
  @override
  List<String> get galleryUrls; // Cross-feature refs (user-facing)
  @override
  List<MenuRef> get menuRefs; // NEW: menus
  @override
  List<ReservationRef> get reservationRefs;
  @override
  List<OrderRef> get orderRefs;
  @override
  List<ReviewRef> get reviewRefs; // user reviews
  // Taxonomy / tags
  @override
  List<String> get cuisines; // e.g., ["Italian", "Vegan"]
  // Ratings / aggregates
  @override
  double? get averageRating; // 0..5
  @override
  int get ratingsCount; // Auditing
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt; // Extra metadata (safe by design)
  @override
  Map<String, dynamic> get metadata;

  /// Create a copy of Restaurant
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RestaurantImplCopyWith<_$RestaurantImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
