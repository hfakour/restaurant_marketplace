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

Food _$FoodFromJson(Map<String, dynamic> json) {
  return _Food.fromJson(json);
}

/// @nodoc
mixin _$Food {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get restaurantId => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  double get originalPrice => throw _privateConstructorUsedError;
  double get discountPercentage => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  List<String> get tags => throw _privateConstructorUsedError;
  List<String> get ingredients => throw _privateConstructorUsedError;
  List<String> get allergens => throw _privateConstructorUsedError;
  double get rating => throw _privateConstructorUsedError;
  int get reviewsCount => throw _privateConstructorUsedError;
  Vendor get vendor => throw _privateConstructorUsedError;
  List<Review> get reviews => throw _privateConstructorUsedError;

  /// Serializes this Food to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

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
    String name,
    String restaurantId,
    String description,
    double originalPrice,
    double discountPercentage,
    String imageUrl,
    String category,
    List<String> tags,
    List<String> ingredients,
    List<String> allergens,
    double rating,
    int reviewsCount,
    Vendor vendor,
    List<Review> reviews,
  });

  $VendorCopyWith<$Res> get vendor;
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
    Object? name = null,
    Object? restaurantId = null,
    Object? description = null,
    Object? originalPrice = null,
    Object? discountPercentage = null,
    Object? imageUrl = null,
    Object? category = null,
    Object? tags = null,
    Object? ingredients = null,
    Object? allergens = null,
    Object? rating = null,
    Object? reviewsCount = null,
    Object? vendor = null,
    Object? reviews = null,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            name:
                null == name
                    ? _value.name
                    : name // ignore: cast_nullable_to_non_nullable
                        as String,
            restaurantId:
                null == restaurantId
                    ? _value.restaurantId
                    : restaurantId // ignore: cast_nullable_to_non_nullable
                        as String,
            description:
                null == description
                    ? _value.description
                    : description // ignore: cast_nullable_to_non_nullable
                        as String,
            originalPrice:
                null == originalPrice
                    ? _value.originalPrice
                    : originalPrice // ignore: cast_nullable_to_non_nullable
                        as double,
            discountPercentage:
                null == discountPercentage
                    ? _value.discountPercentage
                    : discountPercentage // ignore: cast_nullable_to_non_nullable
                        as double,
            imageUrl:
                null == imageUrl
                    ? _value.imageUrl
                    : imageUrl // ignore: cast_nullable_to_non_nullable
                        as String,
            category:
                null == category
                    ? _value.category
                    : category // ignore: cast_nullable_to_non_nullable
                        as String,
            tags:
                null == tags
                    ? _value.tags
                    : tags // ignore: cast_nullable_to_non_nullable
                        as List<String>,
            ingredients:
                null == ingredients
                    ? _value.ingredients
                    : ingredients // ignore: cast_nullable_to_non_nullable
                        as List<String>,
            allergens:
                null == allergens
                    ? _value.allergens
                    : allergens // ignore: cast_nullable_to_non_nullable
                        as List<String>,
            rating:
                null == rating
                    ? _value.rating
                    : rating // ignore: cast_nullable_to_non_nullable
                        as double,
            reviewsCount:
                null == reviewsCount
                    ? _value.reviewsCount
                    : reviewsCount // ignore: cast_nullable_to_non_nullable
                        as int,
            vendor:
                null == vendor
                    ? _value.vendor
                    : vendor // ignore: cast_nullable_to_non_nullable
                        as Vendor,
            reviews:
                null == reviews
                    ? _value.reviews
                    : reviews // ignore: cast_nullable_to_non_nullable
                        as List<Review>,
          )
          as $Val,
    );
  }

  /// Create a copy of Food
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $VendorCopyWith<$Res> get vendor {
    return $VendorCopyWith<$Res>(_value.vendor, (value) {
      return _then(_value.copyWith(vendor: value) as $Val);
    });
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
    String name,
    String restaurantId,
    String description,
    double originalPrice,
    double discountPercentage,
    String imageUrl,
    String category,
    List<String> tags,
    List<String> ingredients,
    List<String> allergens,
    double rating,
    int reviewsCount,
    Vendor vendor,
    List<Review> reviews,
  });

  @override
  $VendorCopyWith<$Res> get vendor;
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
    Object? name = null,
    Object? restaurantId = null,
    Object? description = null,
    Object? originalPrice = null,
    Object? discountPercentage = null,
    Object? imageUrl = null,
    Object? category = null,
    Object? tags = null,
    Object? ingredients = null,
    Object? allergens = null,
    Object? rating = null,
    Object? reviewsCount = null,
    Object? vendor = null,
    Object? reviews = null,
  }) {
    return _then(
      _$FoodImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        name:
            null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                    as String,
        restaurantId:
            null == restaurantId
                ? _value.restaurantId
                : restaurantId // ignore: cast_nullable_to_non_nullable
                    as String,
        description:
            null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                    as String,
        originalPrice:
            null == originalPrice
                ? _value.originalPrice
                : originalPrice // ignore: cast_nullable_to_non_nullable
                    as double,
        discountPercentage:
            null == discountPercentage
                ? _value.discountPercentage
                : discountPercentage // ignore: cast_nullable_to_non_nullable
                    as double,
        imageUrl:
            null == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                    as String,
        category:
            null == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                    as String,
        tags:
            null == tags
                ? _value._tags
                : tags // ignore: cast_nullable_to_non_nullable
                    as List<String>,
        ingredients:
            null == ingredients
                ? _value._ingredients
                : ingredients // ignore: cast_nullable_to_non_nullable
                    as List<String>,
        allergens:
            null == allergens
                ? _value._allergens
                : allergens // ignore: cast_nullable_to_non_nullable
                    as List<String>,
        rating:
            null == rating
                ? _value.rating
                : rating // ignore: cast_nullable_to_non_nullable
                    as double,
        reviewsCount:
            null == reviewsCount
                ? _value.reviewsCount
                : reviewsCount // ignore: cast_nullable_to_non_nullable
                    as int,
        vendor:
            null == vendor
                ? _value.vendor
                : vendor // ignore: cast_nullable_to_non_nullable
                    as Vendor,
        reviews:
            null == reviews
                ? _value._reviews
                : reviews // ignore: cast_nullable_to_non_nullable
                    as List<Review>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$FoodImpl implements _Food {
  const _$FoodImpl({
    required this.id,
    required this.name,
    required this.restaurantId,
    required this.description,
    required this.originalPrice,
    required this.discountPercentage,
    required this.imageUrl,
    required this.category,
    required final List<String> tags,
    required final List<String> ingredients,
    required final List<String> allergens,
    required this.rating,
    required this.reviewsCount,
    required this.vendor,
    final List<Review> reviews = const [],
  }) : _tags = tags,
       _ingredients = ingredients,
       _allergens = allergens,
       _reviews = reviews;

  factory _$FoodImpl.fromJson(Map<String, dynamic> json) =>
      _$$FoodImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String restaurantId;
  @override
  final String description;
  @override
  final double originalPrice;
  @override
  final double discountPercentage;
  @override
  final String imageUrl;
  @override
  final String category;
  final List<String> _tags;
  @override
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  final List<String> _ingredients;
  @override
  List<String> get ingredients {
    if (_ingredients is EqualUnmodifiableListView) return _ingredients;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_ingredients);
  }

  final List<String> _allergens;
  @override
  List<String> get allergens {
    if (_allergens is EqualUnmodifiableListView) return _allergens;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allergens);
  }

  @override
  final double rating;
  @override
  final int reviewsCount;
  @override
  final Vendor vendor;
  final List<Review> _reviews;
  @override
  @JsonKey()
  List<Review> get reviews {
    if (_reviews is EqualUnmodifiableListView) return _reviews;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_reviews);
  }

  @override
  String toString() {
    return 'Food(id: $id, name: $name, restaurantId: $restaurantId, description: $description, originalPrice: $originalPrice, discountPercentage: $discountPercentage, imageUrl: $imageUrl, category: $category, tags: $tags, ingredients: $ingredients, allergens: $allergens, rating: $rating, reviewsCount: $reviewsCount, vendor: $vendor, reviews: $reviews)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FoodImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.restaurantId, restaurantId) ||
                other.restaurantId == restaurantId) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.originalPrice, originalPrice) ||
                other.originalPrice == originalPrice) &&
            (identical(other.discountPercentage, discountPercentage) ||
                other.discountPercentage == discountPercentage) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.category, category) ||
                other.category == category) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            const DeepCollectionEquality().equals(
              other._ingredients,
              _ingredients,
            ) &&
            const DeepCollectionEquality().equals(
              other._allergens,
              _allergens,
            ) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.reviewsCount, reviewsCount) ||
                other.reviewsCount == reviewsCount) &&
            (identical(other.vendor, vendor) || other.vendor == vendor) &&
            const DeepCollectionEquality().equals(other._reviews, _reviews));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    restaurantId,
    description,
    originalPrice,
    discountPercentage,
    imageUrl,
    category,
    const DeepCollectionEquality().hash(_tags),
    const DeepCollectionEquality().hash(_ingredients),
    const DeepCollectionEquality().hash(_allergens),
    rating,
    reviewsCount,
    vendor,
    const DeepCollectionEquality().hash(_reviews),
  );

  /// Create a copy of Food
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FoodImplCopyWith<_$FoodImpl> get copyWith =>
      __$$FoodImplCopyWithImpl<_$FoodImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FoodImplToJson(this);
  }
}

abstract class _Food implements Food {
  const factory _Food({
    required final String id,
    required final String name,
    required final String restaurantId,
    required final String description,
    required final double originalPrice,
    required final double discountPercentage,
    required final String imageUrl,
    required final String category,
    required final List<String> tags,
    required final List<String> ingredients,
    required final List<String> allergens,
    required final double rating,
    required final int reviewsCount,
    required final Vendor vendor,
    final List<Review> reviews,
  }) = _$FoodImpl;

  factory _Food.fromJson(Map<String, dynamic> json) = _$FoodImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get restaurantId;
  @override
  String get description;
  @override
  double get originalPrice;
  @override
  double get discountPercentage;
  @override
  String get imageUrl;
  @override
  String get category;
  @override
  List<String> get tags;
  @override
  List<String> get ingredients;
  @override
  List<String> get allergens;
  @override
  double get rating;
  @override
  int get reviewsCount;
  @override
  Vendor get vendor;
  @override
  List<Review> get reviews;

  /// Create a copy of Food
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FoodImplCopyWith<_$FoodImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
