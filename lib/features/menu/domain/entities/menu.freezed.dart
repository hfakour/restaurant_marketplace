// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'menu.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$Menu {
  String get id => throw _privateConstructorUsedError; // Ownership
  String get restaurantId => throw _privateConstructorUsedError; // Identity
  String get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError; // Media
  String? get coverUrl => throw _privateConstructorUsedError;
  List<String> get galleryUrls =>
      throw _privateConstructorUsedError; // Composition (lightweight relation to foods via refs)
  List<FoodRef> get foodRefs => throw _privateConstructorUsedError; // Status
  bool get isActive => throw _privateConstructorUsedError; // Auditing
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt =>
      throw _privateConstructorUsedError; // Extra metadata (safe by design)
  Map<String, dynamic> get metadata => throw _privateConstructorUsedError;

  /// Create a copy of Menu
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MenuCopyWith<Menu> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MenuCopyWith<$Res> {
  factory $MenuCopyWith(Menu value, $Res Function(Menu) then) =
      _$MenuCopyWithImpl<$Res, Menu>;
  @useResult
  $Res call({
    String id,
    String restaurantId,
    String title,
    String? description,
    String? coverUrl,
    List<String> galleryUrls,
    List<FoodRef> foodRefs,
    bool isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
    Map<String, dynamic> metadata,
  });
}

/// @nodoc
class _$MenuCopyWithImpl<$Res, $Val extends Menu>
    implements $MenuCopyWith<$Res> {
  _$MenuCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Menu
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? restaurantId = null,
    Object? title = null,
    Object? description = freezed,
    Object? coverUrl = freezed,
    Object? galleryUrls = null,
    Object? foodRefs = null,
    Object? isActive = null,
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
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            coverUrl: freezed == coverUrl
                ? _value.coverUrl
                : coverUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            galleryUrls: null == galleryUrls
                ? _value.galleryUrls
                : galleryUrls // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            foodRefs: null == foodRefs
                ? _value.foodRefs
                : foodRefs // ignore: cast_nullable_to_non_nullable
                      as List<FoodRef>,
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
abstract class _$$MenuImplCopyWith<$Res> implements $MenuCopyWith<$Res> {
  factory _$$MenuImplCopyWith(
    _$MenuImpl value,
    $Res Function(_$MenuImpl) then,
  ) = __$$MenuImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String restaurantId,
    String title,
    String? description,
    String? coverUrl,
    List<String> galleryUrls,
    List<FoodRef> foodRefs,
    bool isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
    Map<String, dynamic> metadata,
  });
}

/// @nodoc
class __$$MenuImplCopyWithImpl<$Res>
    extends _$MenuCopyWithImpl<$Res, _$MenuImpl>
    implements _$$MenuImplCopyWith<$Res> {
  __$$MenuImplCopyWithImpl(_$MenuImpl _value, $Res Function(_$MenuImpl) _then)
    : super(_value, _then);

  /// Create a copy of Menu
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? restaurantId = null,
    Object? title = null,
    Object? description = freezed,
    Object? coverUrl = freezed,
    Object? galleryUrls = null,
    Object? foodRefs = null,
    Object? isActive = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? metadata = null,
  }) {
    return _then(
      _$MenuImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        restaurantId: null == restaurantId
            ? _value.restaurantId
            : restaurantId // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        coverUrl: freezed == coverUrl
            ? _value.coverUrl
            : coverUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        galleryUrls: null == galleryUrls
            ? _value._galleryUrls
            : galleryUrls // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        foodRefs: null == foodRefs
            ? _value._foodRefs
            : foodRefs // ignore: cast_nullable_to_non_nullable
                  as List<FoodRef>,
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
        metadata: null == metadata
            ? _value._metadata
            : metadata // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
      ),
    );
  }
}

/// @nodoc

class _$MenuImpl implements _Menu {
  const _$MenuImpl({
    required this.id,
    required this.restaurantId,
    required this.title,
    this.description,
    this.coverUrl,
    final List<String> galleryUrls = const <String>[],
    final List<FoodRef> foodRefs = const <FoodRef>[],
    this.isActive = true,
    this.createdAt,
    this.updatedAt,
    final Map<String, dynamic> metadata = const <String, dynamic>{},
  }) : _galleryUrls = galleryUrls,
       _foodRefs = foodRefs,
       _metadata = metadata;

  @override
  final String id;
  // Ownership
  @override
  final String restaurantId;
  // Identity
  @override
  final String title;
  @override
  final String? description;
  // Media
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

  // Composition (lightweight relation to foods via refs)
  final List<FoodRef> _foodRefs;
  // Composition (lightweight relation to foods via refs)
  @override
  @JsonKey()
  List<FoodRef> get foodRefs {
    if (_foodRefs is EqualUnmodifiableListView) return _foodRefs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_foodRefs);
  }

  // Status
  @override
  @JsonKey()
  final bool isActive;
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
    return 'Menu(id: $id, restaurantId: $restaurantId, title: $title, description: $description, coverUrl: $coverUrl, galleryUrls: $galleryUrls, foodRefs: $foodRefs, isActive: $isActive, createdAt: $createdAt, updatedAt: $updatedAt, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MenuImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.restaurantId, restaurantId) ||
                other.restaurantId == restaurantId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.coverUrl, coverUrl) ||
                other.coverUrl == coverUrl) &&
            const DeepCollectionEquality().equals(
              other._galleryUrls,
              _galleryUrls,
            ) &&
            const DeepCollectionEquality().equals(other._foodRefs, _foodRefs) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
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
    title,
    description,
    coverUrl,
    const DeepCollectionEquality().hash(_galleryUrls),
    const DeepCollectionEquality().hash(_foodRefs),
    isActive,
    createdAt,
    updatedAt,
    const DeepCollectionEquality().hash(_metadata),
  );

  /// Create a copy of Menu
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MenuImplCopyWith<_$MenuImpl> get copyWith =>
      __$$MenuImplCopyWithImpl<_$MenuImpl>(this, _$identity);
}

abstract class _Menu implements Menu {
  const factory _Menu({
    required final String id,
    required final String restaurantId,
    required final String title,
    final String? description,
    final String? coverUrl,
    final List<String> galleryUrls,
    final List<FoodRef> foodRefs,
    final bool isActive,
    final DateTime? createdAt,
    final DateTime? updatedAt,
    final Map<String, dynamic> metadata,
  }) = _$MenuImpl;

  @override
  String get id; // Ownership
  @override
  String get restaurantId; // Identity
  @override
  String get title;
  @override
  String? get description; // Media
  @override
  String? get coverUrl;
  @override
  List<String> get galleryUrls; // Composition (lightweight relation to foods via refs)
  @override
  List<FoodRef> get foodRefs; // Status
  @override
  bool get isActive; // Auditing
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt; // Extra metadata (safe by design)
  @override
  Map<String, dynamic> get metadata;

  /// Create a copy of Menu
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MenuImplCopyWith<_$MenuImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
