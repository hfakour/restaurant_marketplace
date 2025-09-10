// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'food.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$Food {
  String get id => throw _privateConstructorUsedError; // Ownership
  String get restaurantId => throw _privateConstructorUsedError; // Identity
  String get name => throw _privateConstructorUsedError;
  String? get description =>
      throw _privateConstructorUsedError; // Pricing (simple; keep in cents to avoid double rounding issues)
  int? get priceCents =>
      throw _privateConstructorUsedError; // e.g., 1299 for $12.99
  String? get currencyCode => throw _privateConstructorUsedError; // e.g., "USD"
  // Media
  String? get imageUrl => throw _privateConstructorUsedError;
  List<String> get galleryUrls =>
      throw _privateConstructorUsedError; // Tags & dietary information
  List<String> get tags =>
      throw _privateConstructorUsedError; // e.g., ["Spicy", "Popular", "Lunch"]
  List<String> get allergens =>
      throw _privateConstructorUsedError; // e.g., ["Peanuts", "Dairy"]
  // Reviews (user-facing, lightweight)
  List<ReviewRef> get reviewRefs =>
      throw _privateConstructorUsedError; // Ratings / aggregates (user-facing)
  double? get averageRating => throw _privateConstructorUsedError; // 0..5
  int get ratingsCount =>
      throw _privateConstructorUsedError; // Availability (user-facing)
  bool get isAvailable => throw _privateConstructorUsedError; // Auditing
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt =>
      throw _privateConstructorUsedError; // Extra metadata (safe by design)
  Map<String, dynamic> get metadata => throw _privateConstructorUsedError;

  /// Create a copy of Food
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FoodCopyWith<Food> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FoodCopyWith<$Res> {
  factory $FoodCopyWith(Food value, $Res Function(Food) then) =
      _$FoodCopyWithImpl<$Res, Food>;
  @useResult
  $Res call({
    String id,
    String restaurantId,
    String name,
    String? description,
    int? priceCents,
    String? currencyCode,
    String? imageUrl,
    List<String> galleryUrls,
    List<String> tags,
    List<String> allergens,
    List<ReviewRef> reviewRefs,
    double? averageRating,
    int ratingsCount,
    bool isAvailable,
    DateTime? createdAt,
    DateTime? updatedAt,
    Map<String, dynamic> metadata,
  });
}

/// @nodoc
class _$FoodCopyWithImpl<$Res, $Val extends Food>
    implements $FoodCopyWith<$Res> {
  _$FoodCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Food
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? restaurantId = null,
    Object? name = null,
    Object? description = freezed,
    Object? priceCents = freezed,
    Object? currencyCode = freezed,
    Object? imageUrl = freezed,
    Object? galleryUrls = null,
    Object? tags = null,
    Object? allergens = null,
    Object? reviewRefs = null,
    Object? averageRating = freezed,
    Object? ratingsCount = null,
    Object? isAvailable = null,
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
            restaurantId: null == restaurantId
                ? _value.restaurantId
                : restaurantId // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            priceCents: freezed == priceCents
                ? _value.priceCents
                : priceCents // ignore: cast_nullable_to_non_nullable
                      as int?,
            currencyCode: freezed == currencyCode
                ? _value.currencyCode
                : currencyCode // ignore: cast_nullable_to_non_nullable
                      as String?,
            imageUrl: freezed == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            galleryUrls: null == galleryUrls
                ? _value.galleryUrls
                : galleryUrls // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            tags: null == tags
                ? _value.tags
                : tags // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            allergens: null == allergens
                ? _value.allergens
                : allergens // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            reviewRefs: null == reviewRefs
                ? _value.reviewRefs
                : reviewRefs // ignore: cast_nullable_to_non_nullable
                      as List<ReviewRef>,
            averageRating: freezed == averageRating
                ? _value.averageRating
                : averageRating // ignore: cast_nullable_to_non_nullable
                      as double?,
            ratingsCount: null == ratingsCount
                ? _value.ratingsCount
                : ratingsCount // ignore: cast_nullable_to_non_nullable
                      as int,
            isAvailable: null == isAvailable
                ? _value.isAvailable
                : isAvailable // ignore: cast_nullable_to_non_nullable
                      as bool,
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
}

/// @nodoc
abstract class _$$FoodImplCopyWith<$Res> implements $FoodCopyWith<$Res> {
  factory _$$FoodImplCopyWith(
    _$FoodImpl value,
    $Res Function(_$FoodImpl) then,
  ) = __$$FoodImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String restaurantId,
    String name,
    String? description,
    int? priceCents,
    String? currencyCode,
    String? imageUrl,
    List<String> galleryUrls,
    List<String> tags,
    List<String> allergens,
    List<ReviewRef> reviewRefs,
    double? averageRating,
    int ratingsCount,
    bool isAvailable,
    DateTime? createdAt,
    DateTime? updatedAt,
    Map<String, dynamic> metadata,
  });
}

/// @nodoc
class __$$FoodImplCopyWithImpl<$Res>
    extends _$FoodCopyWithImpl<$Res, _$FoodImpl>
    implements _$$FoodImplCopyWith<$Res> {
  __$$FoodImplCopyWithImpl(_$FoodImpl _value, $Res Function(_$FoodImpl) _then)
    : super(_value, _then);

  /// Create a copy of Food
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? restaurantId = null,
    Object? name = null,
    Object? description = freezed,
    Object? priceCents = freezed,
    Object? currencyCode = freezed,
    Object? imageUrl = freezed,
    Object? galleryUrls = null,
    Object? tags = null,
    Object? allergens = null,
    Object? reviewRefs = null,
    Object? averageRating = freezed,
    Object? ratingsCount = null,
    Object? isAvailable = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? metadata = null,
  }) {
    return _then(
      _$FoodImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        restaurantId: null == restaurantId
            ? _value.restaurantId
            : restaurantId // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        priceCents: freezed == priceCents
            ? _value.priceCents
            : priceCents // ignore: cast_nullable_to_non_nullable
                  as int?,
        currencyCode: freezed == currencyCode
            ? _value.currencyCode
            : currencyCode // ignore: cast_nullable_to_non_nullable
                  as String?,
        imageUrl: freezed == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        galleryUrls: null == galleryUrls
            ? _value._galleryUrls
            : galleryUrls // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        tags: null == tags
            ? _value._tags
            : tags // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        allergens: null == allergens
            ? _value._allergens
            : allergens // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        reviewRefs: null == reviewRefs
            ? _value._reviewRefs
            : reviewRefs // ignore: cast_nullable_to_non_nullable
                  as List<ReviewRef>,
        averageRating: freezed == averageRating
            ? _value.averageRating
            : averageRating // ignore: cast_nullable_to_non_nullable
                  as double?,
        ratingsCount: null == ratingsCount
            ? _value.ratingsCount
            : ratingsCount // ignore: cast_nullable_to_non_nullable
                  as int,
        isAvailable: null == isAvailable
            ? _value.isAvailable
            : isAvailable // ignore: cast_nullable_to_non_nullable
                  as bool,
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

class _$FoodImpl implements _Food {
  const _$FoodImpl({
    required this.id,
    required this.restaurantId,
    required this.name,
    this.description,
    this.priceCents,
    this.currencyCode,
    this.imageUrl,
    final List<String> galleryUrls = const <String>[],
    final List<String> tags = const <String>[],
    final List<String> allergens = const <String>[],
    final List<ReviewRef> reviewRefs = const <ReviewRef>[],
    this.averageRating,
    this.ratingsCount = 0,
    this.isAvailable = true,
    this.createdAt,
    this.updatedAt,
    final Map<String, dynamic> metadata = const <String, dynamic>{},
  }) : _galleryUrls = galleryUrls,
       _tags = tags,
       _allergens = allergens,
       _reviewRefs = reviewRefs,
       _metadata = metadata;

  @override
  final String id;
  // Ownership
  @override
  final String restaurantId;
  // Identity
  @override
  final String name;
  @override
  final String? description;
  // Pricing (simple; keep in cents to avoid double rounding issues)
  @override
  final int? priceCents;
  // e.g., 1299 for $12.99
  @override
  final String? currencyCode;
  // e.g., "USD"
  // Media
  @override
  final String? imageUrl;
  final List<String> _galleryUrls;
  @override
  @JsonKey()
  List<String> get galleryUrls {
    if (_galleryUrls is EqualUnmodifiableListView) return _galleryUrls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_galleryUrls);
  }

  // Tags & dietary information
  final List<String> _tags;
  // Tags & dietary information
  @override
  @JsonKey()
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  // e.g., ["Spicy", "Popular", "Lunch"]
  final List<String> _allergens;
  // e.g., ["Spicy", "Popular", "Lunch"]
  @override
  @JsonKey()
  List<String> get allergens {
    if (_allergens is EqualUnmodifiableListView) return _allergens;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allergens);
  }

  // e.g., ["Peanuts", "Dairy"]
  // Reviews (user-facing, lightweight)
  final List<ReviewRef> _reviewRefs;
  // e.g., ["Peanuts", "Dairy"]
  // Reviews (user-facing, lightweight)
  @override
  @JsonKey()
  List<ReviewRef> get reviewRefs {
    if (_reviewRefs is EqualUnmodifiableListView) return _reviewRefs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_reviewRefs);
  }

  // Ratings / aggregates (user-facing)
  @override
  final double? averageRating;
  // 0..5
  @override
  @JsonKey()
  final int ratingsCount;
  // Availability (user-facing)
  @override
  @JsonKey()
  final bool isAvailable;
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
    return 'Food(id: $id, restaurantId: $restaurantId, name: $name, description: $description, priceCents: $priceCents, currencyCode: $currencyCode, imageUrl: $imageUrl, galleryUrls: $galleryUrls, tags: $tags, allergens: $allergens, reviewRefs: $reviewRefs, averageRating: $averageRating, ratingsCount: $ratingsCount, isAvailable: $isAvailable, createdAt: $createdAt, updatedAt: $updatedAt, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FoodImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.restaurantId, restaurantId) ||
                other.restaurantId == restaurantId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.priceCents, priceCents) ||
                other.priceCents == priceCents) &&
            (identical(other.currencyCode, currencyCode) ||
                other.currencyCode == currencyCode) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            const DeepCollectionEquality().equals(
              other._galleryUrls,
              _galleryUrls,
            ) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            const DeepCollectionEquality().equals(
              other._allergens,
              _allergens,
            ) &&
            const DeepCollectionEquality().equals(
              other._reviewRefs,
              _reviewRefs,
            ) &&
            (identical(other.averageRating, averageRating) ||
                other.averageRating == averageRating) &&
            (identical(other.ratingsCount, ratingsCount) ||
                other.ratingsCount == ratingsCount) &&
            (identical(other.isAvailable, isAvailable) ||
                other.isAvailable == isAvailable) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    restaurantId,
    name,
    description,
    priceCents,
    currencyCode,
    imageUrl,
    const DeepCollectionEquality().hash(_galleryUrls),
    const DeepCollectionEquality().hash(_tags),
    const DeepCollectionEquality().hash(_allergens),
    const DeepCollectionEquality().hash(_reviewRefs),
    averageRating,
    ratingsCount,
    isAvailable,
    createdAt,
    updatedAt,
    const DeepCollectionEquality().hash(_metadata),
  );

  /// Create a copy of Food
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FoodImplCopyWith<_$FoodImpl> get copyWith =>
      __$$FoodImplCopyWithImpl<_$FoodImpl>(this, _$identity);
}

abstract class _Food implements Food {
  const factory _Food({
    required final String id,
    required final String restaurantId,
    required final String name,
    final String? description,
    final int? priceCents,
    final String? currencyCode,
    final String? imageUrl,
    final List<String> galleryUrls,
    final List<String> tags,
    final List<String> allergens,
    final List<ReviewRef> reviewRefs,
    final double? averageRating,
    final int ratingsCount,
    final bool isAvailable,
    final DateTime? createdAt,
    final DateTime? updatedAt,
    final Map<String, dynamic> metadata,
  }) = _$FoodImpl;

  @override
  String get id; // Ownership
  @override
  String get restaurantId; // Identity
  @override
  String get name;
  @override
  String? get description; // Pricing (simple; keep in cents to avoid double rounding issues)
  @override
  int? get priceCents; // e.g., 1299 for $12.99
  @override
  String? get currencyCode; // e.g., "USD"
  // Media
  @override
  String? get imageUrl;
  @override
  List<String> get galleryUrls; // Tags & dietary information
  @override
  List<String> get tags; // e.g., ["Spicy", "Popular", "Lunch"]
  @override
  List<String> get allergens; // e.g., ["Peanuts", "Dairy"]
  // Reviews (user-facing, lightweight)
  @override
  List<ReviewRef> get reviewRefs; // Ratings / aggregates (user-facing)
  @override
  double? get averageRating; // 0..5
  @override
  int get ratingsCount; // Availability (user-facing)
  @override
  bool get isAvailable; // Auditing
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt; // Extra metadata (safe by design)
  @override
  Map<String, dynamic> get metadata;

  /// Create a copy of Food
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FoodImplCopyWith<_$FoodImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
