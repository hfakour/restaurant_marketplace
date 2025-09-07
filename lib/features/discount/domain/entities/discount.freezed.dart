// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'discount.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$Discount {
  String get id => throw _privateConstructorUsedError;

  /// Human-readable code if trigger == code. Unique when present.
  String? get code => throw _privateConstructorUsedError;

  /// Classification.
  DiscountTrigger get trigger => throw _privateConstructorUsedError;
  DiscountValueType get valueType => throw _privateConstructorUsedError;

  /// If percentage: 0–100. If fixedAmount: amount’s numeric part in [amount] with currency.
  double get percentage => throw _privateConstructorUsedError;

  /// Fixed value for fixed-amount discounts; currency must be set.
  Money? get amount => throw _privateConstructorUsedError;

  /// Application rules.
  DiscountScope get scope => throw _privateConstructorUsedError;
  List<String> get productIds =>
      throw _privateConstructorUsedError; // when scope == specificProducts
  List<String> get categoryIds =>
      throw _privateConstructorUsedError; // when scope == specificCategories
  /// Order-level constraints.
  Money? get minimumSubtotal =>
      throw _privateConstructorUsedError; // requires currency
  int? get minimumQuantity =>
      throw _privateConstructorUsedError; // sum of quantities across matched items
  /// Stacking/usage control.
  bool get isActive => throw _privateConstructorUsedError;
  bool get stackable => throw _privateConstructorUsedError;
  int? get maxGlobalRedemptions =>
      throw _privateConstructorUsedError; // total allowed across all users
  int get globalRedemptionsUsed => throw _privateConstructorUsedError;
  int? get maxPerUser => throw _privateConstructorUsedError; // per-user limit
  /// Validity window.
  DateTime? get startsAt => throw _privateConstructorUsedError;
  DateTime? get endsAt => throw _privateConstructorUsedError;

  /// Optional targeting.
  List<String> get eligibleUserIds =>
      throw _privateConstructorUsedError; // whitelist users
  bool get newUsersOnly => throw _privateConstructorUsedError;

  /// Metadata for analytics/integrations.
  Map<String, String>? get metadata => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError; // internal name
  String? get description => throw _privateConstructorUsedError; // UI copy
  /// Audit.
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Create a copy of Discount
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DiscountCopyWith<Discount> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DiscountCopyWith<$Res> {
  factory $DiscountCopyWith(Discount value, $Res Function(Discount) then) =
      _$DiscountCopyWithImpl<$Res, Discount>;
  @useResult
  $Res call({
    String id,
    String? code,
    DiscountTrigger trigger,
    DiscountValueType valueType,
    double percentage,
    Money? amount,
    DiscountScope scope,
    List<String> productIds,
    List<String> categoryIds,
    Money? minimumSubtotal,
    int? minimumQuantity,
    bool isActive,
    bool stackable,
    int? maxGlobalRedemptions,
    int globalRedemptionsUsed,
    int? maxPerUser,
    DateTime? startsAt,
    DateTime? endsAt,
    List<String> eligibleUserIds,
    bool newUsersOnly,
    Map<String, String>? metadata,
    String? name,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class _$DiscountCopyWithImpl<$Res, $Val extends Discount>
    implements $DiscountCopyWith<$Res> {
  _$DiscountCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Discount
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? code = freezed,
    Object? trigger = null,
    Object? valueType = null,
    Object? percentage = null,
    Object? amount = freezed,
    Object? scope = null,
    Object? productIds = null,
    Object? categoryIds = null,
    Object? minimumSubtotal = freezed,
    Object? minimumQuantity = freezed,
    Object? isActive = null,
    Object? stackable = null,
    Object? maxGlobalRedemptions = freezed,
    Object? globalRedemptionsUsed = null,
    Object? maxPerUser = freezed,
    Object? startsAt = freezed,
    Object? endsAt = freezed,
    Object? eligibleUserIds = null,
    Object? newUsersOnly = null,
    Object? metadata = freezed,
    Object? name = freezed,
    Object? description = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            code: freezed == code
                ? _value.code
                : code // ignore: cast_nullable_to_non_nullable
                      as String?,
            trigger: null == trigger
                ? _value.trigger
                : trigger // ignore: cast_nullable_to_non_nullable
                      as DiscountTrigger,
            valueType: null == valueType
                ? _value.valueType
                : valueType // ignore: cast_nullable_to_non_nullable
                      as DiscountValueType,
            percentage: null == percentage
                ? _value.percentage
                : percentage // ignore: cast_nullable_to_non_nullable
                      as double,
            amount: freezed == amount
                ? _value.amount
                : amount // ignore: cast_nullable_to_non_nullable
                      as Money?,
            scope: null == scope
                ? _value.scope
                : scope // ignore: cast_nullable_to_non_nullable
                      as DiscountScope,
            productIds: null == productIds
                ? _value.productIds
                : productIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            categoryIds: null == categoryIds
                ? _value.categoryIds
                : categoryIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            minimumSubtotal: freezed == minimumSubtotal
                ? _value.minimumSubtotal
                : minimumSubtotal // ignore: cast_nullable_to_non_nullable
                      as Money?,
            minimumQuantity: freezed == minimumQuantity
                ? _value.minimumQuantity
                : minimumQuantity // ignore: cast_nullable_to_non_nullable
                      as int?,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
            stackable: null == stackable
                ? _value.stackable
                : stackable // ignore: cast_nullable_to_non_nullable
                      as bool,
            maxGlobalRedemptions: freezed == maxGlobalRedemptions
                ? _value.maxGlobalRedemptions
                : maxGlobalRedemptions // ignore: cast_nullable_to_non_nullable
                      as int?,
            globalRedemptionsUsed: null == globalRedemptionsUsed
                ? _value.globalRedemptionsUsed
                : globalRedemptionsUsed // ignore: cast_nullable_to_non_nullable
                      as int,
            maxPerUser: freezed == maxPerUser
                ? _value.maxPerUser
                : maxPerUser // ignore: cast_nullable_to_non_nullable
                      as int?,
            startsAt: freezed == startsAt
                ? _value.startsAt
                : startsAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            endsAt: freezed == endsAt
                ? _value.endsAt
                : endsAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            eligibleUserIds: null == eligibleUserIds
                ? _value.eligibleUserIds
                : eligibleUserIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            newUsersOnly: null == newUsersOnly
                ? _value.newUsersOnly
                : newUsersOnly // ignore: cast_nullable_to_non_nullable
                      as bool,
            metadata: freezed == metadata
                ? _value.metadata
                : metadata // ignore: cast_nullable_to_non_nullable
                      as Map<String, String>?,
            name: freezed == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String?,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            updatedAt: freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DiscountImplCopyWith<$Res>
    implements $DiscountCopyWith<$Res> {
  factory _$$DiscountImplCopyWith(
    _$DiscountImpl value,
    $Res Function(_$DiscountImpl) then,
  ) = __$$DiscountImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String? code,
    DiscountTrigger trigger,
    DiscountValueType valueType,
    double percentage,
    Money? amount,
    DiscountScope scope,
    List<String> productIds,
    List<String> categoryIds,
    Money? minimumSubtotal,
    int? minimumQuantity,
    bool isActive,
    bool stackable,
    int? maxGlobalRedemptions,
    int globalRedemptionsUsed,
    int? maxPerUser,
    DateTime? startsAt,
    DateTime? endsAt,
    List<String> eligibleUserIds,
    bool newUsersOnly,
    Map<String, String>? metadata,
    String? name,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class __$$DiscountImplCopyWithImpl<$Res>
    extends _$DiscountCopyWithImpl<$Res, _$DiscountImpl>
    implements _$$DiscountImplCopyWith<$Res> {
  __$$DiscountImplCopyWithImpl(
    _$DiscountImpl _value,
    $Res Function(_$DiscountImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Discount
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? code = freezed,
    Object? trigger = null,
    Object? valueType = null,
    Object? percentage = null,
    Object? amount = freezed,
    Object? scope = null,
    Object? productIds = null,
    Object? categoryIds = null,
    Object? minimumSubtotal = freezed,
    Object? minimumQuantity = freezed,
    Object? isActive = null,
    Object? stackable = null,
    Object? maxGlobalRedemptions = freezed,
    Object? globalRedemptionsUsed = null,
    Object? maxPerUser = freezed,
    Object? startsAt = freezed,
    Object? endsAt = freezed,
    Object? eligibleUserIds = null,
    Object? newUsersOnly = null,
    Object? metadata = freezed,
    Object? name = freezed,
    Object? description = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$DiscountImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        code: freezed == code
            ? _value.code
            : code // ignore: cast_nullable_to_non_nullable
                  as String?,
        trigger: null == trigger
            ? _value.trigger
            : trigger // ignore: cast_nullable_to_non_nullable
                  as DiscountTrigger,
        valueType: null == valueType
            ? _value.valueType
            : valueType // ignore: cast_nullable_to_non_nullable
                  as DiscountValueType,
        percentage: null == percentage
            ? _value.percentage
            : percentage // ignore: cast_nullable_to_non_nullable
                  as double,
        amount: freezed == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as Money?,
        scope: null == scope
            ? _value.scope
            : scope // ignore: cast_nullable_to_non_nullable
                  as DiscountScope,
        productIds: null == productIds
            ? _value._productIds
            : productIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        categoryIds: null == categoryIds
            ? _value._categoryIds
            : categoryIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        minimumSubtotal: freezed == minimumSubtotal
            ? _value.minimumSubtotal
            : minimumSubtotal // ignore: cast_nullable_to_non_nullable
                  as Money?,
        minimumQuantity: freezed == minimumQuantity
            ? _value.minimumQuantity
            : minimumQuantity // ignore: cast_nullable_to_non_nullable
                  as int?,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
        stackable: null == stackable
            ? _value.stackable
            : stackable // ignore: cast_nullable_to_non_nullable
                  as bool,
        maxGlobalRedemptions: freezed == maxGlobalRedemptions
            ? _value.maxGlobalRedemptions
            : maxGlobalRedemptions // ignore: cast_nullable_to_non_nullable
                  as int?,
        globalRedemptionsUsed: null == globalRedemptionsUsed
            ? _value.globalRedemptionsUsed
            : globalRedemptionsUsed // ignore: cast_nullable_to_non_nullable
                  as int,
        maxPerUser: freezed == maxPerUser
            ? _value.maxPerUser
            : maxPerUser // ignore: cast_nullable_to_non_nullable
                  as int?,
        startsAt: freezed == startsAt
            ? _value.startsAt
            : startsAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        endsAt: freezed == endsAt
            ? _value.endsAt
            : endsAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        eligibleUserIds: null == eligibleUserIds
            ? _value._eligibleUserIds
            : eligibleUserIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        newUsersOnly: null == newUsersOnly
            ? _value.newUsersOnly
            : newUsersOnly // ignore: cast_nullable_to_non_nullable
                  as bool,
        metadata: freezed == metadata
            ? _value._metadata
            : metadata // ignore: cast_nullable_to_non_nullable
                  as Map<String, String>?,
        name: freezed == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String?,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        updatedAt: freezed == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc

class _$DiscountImpl implements _Discount {
  const _$DiscountImpl({
    required this.id,
    this.code,
    this.trigger = DiscountTrigger.code,
    this.valueType = DiscountValueType.percentage,
    this.percentage = 0.0,
    this.amount,
    this.scope = DiscountScope.entireOrder,
    final List<String> productIds = const <String>[],
    final List<String> categoryIds = const <String>[],
    this.minimumSubtotal,
    this.minimumQuantity,
    this.isActive = true,
    this.stackable = false,
    this.maxGlobalRedemptions,
    this.globalRedemptionsUsed = 0,
    this.maxPerUser,
    this.startsAt,
    this.endsAt,
    final List<String> eligibleUserIds = const <String>[],
    this.newUsersOnly = false,
    final Map<String, String>? metadata,
    this.name,
    this.description,
    this.createdAt,
    this.updatedAt,
  }) : _productIds = productIds,
       _categoryIds = categoryIds,
       _eligibleUserIds = eligibleUserIds,
       _metadata = metadata;

  @override
  final String id;

  /// Human-readable code if trigger == code. Unique when present.
  @override
  final String? code;

  /// Classification.
  @override
  @JsonKey()
  final DiscountTrigger trigger;
  @override
  @JsonKey()
  final DiscountValueType valueType;

  /// If percentage: 0–100. If fixedAmount: amount’s numeric part in [amount] with currency.
  @override
  @JsonKey()
  final double percentage;

  /// Fixed value for fixed-amount discounts; currency must be set.
  @override
  final Money? amount;

  /// Application rules.
  @override
  @JsonKey()
  final DiscountScope scope;
  final List<String> _productIds;
  @override
  @JsonKey()
  List<String> get productIds {
    if (_productIds is EqualUnmodifiableListView) return _productIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_productIds);
  }

  // when scope == specificProducts
  final List<String> _categoryIds;
  // when scope == specificProducts
  @override
  @JsonKey()
  List<String> get categoryIds {
    if (_categoryIds is EqualUnmodifiableListView) return _categoryIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categoryIds);
  }

  // when scope == specificCategories
  /// Order-level constraints.
  @override
  final Money? minimumSubtotal;
  // requires currency
  @override
  final int? minimumQuantity;
  // sum of quantities across matched items
  /// Stacking/usage control.
  @override
  @JsonKey()
  final bool isActive;
  @override
  @JsonKey()
  final bool stackable;
  @override
  final int? maxGlobalRedemptions;
  // total allowed across all users
  @override
  @JsonKey()
  final int globalRedemptionsUsed;
  @override
  final int? maxPerUser;
  // per-user limit
  /// Validity window.
  @override
  final DateTime? startsAt;
  @override
  final DateTime? endsAt;

  /// Optional targeting.
  final List<String> _eligibleUserIds;

  /// Optional targeting.
  @override
  @JsonKey()
  List<String> get eligibleUserIds {
    if (_eligibleUserIds is EqualUnmodifiableListView) return _eligibleUserIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_eligibleUserIds);
  }

  // whitelist users
  @override
  @JsonKey()
  final bool newUsersOnly;

  /// Metadata for analytics/integrations.
  final Map<String, String>? _metadata;

  /// Metadata for analytics/integrations.
  @override
  Map<String, String>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final String? name;
  // internal name
  @override
  final String? description;
  // UI copy
  /// Audit.
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'Discount(id: $id, code: $code, trigger: $trigger, valueType: $valueType, percentage: $percentage, amount: $amount, scope: $scope, productIds: $productIds, categoryIds: $categoryIds, minimumSubtotal: $minimumSubtotal, minimumQuantity: $minimumQuantity, isActive: $isActive, stackable: $stackable, maxGlobalRedemptions: $maxGlobalRedemptions, globalRedemptionsUsed: $globalRedemptionsUsed, maxPerUser: $maxPerUser, startsAt: $startsAt, endsAt: $endsAt, eligibleUserIds: $eligibleUserIds, newUsersOnly: $newUsersOnly, metadata: $metadata, name: $name, description: $description, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DiscountImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.trigger, trigger) || other.trigger == trigger) &&
            (identical(other.valueType, valueType) ||
                other.valueType == valueType) &&
            (identical(other.percentage, percentage) ||
                other.percentage == percentage) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.scope, scope) || other.scope == scope) &&
            const DeepCollectionEquality().equals(
              other._productIds,
              _productIds,
            ) &&
            const DeepCollectionEquality().equals(
              other._categoryIds,
              _categoryIds,
            ) &&
            (identical(other.minimumSubtotal, minimumSubtotal) ||
                other.minimumSubtotal == minimumSubtotal) &&
            (identical(other.minimumQuantity, minimumQuantity) ||
                other.minimumQuantity == minimumQuantity) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.stackable, stackable) ||
                other.stackable == stackable) &&
            (identical(other.maxGlobalRedemptions, maxGlobalRedemptions) ||
                other.maxGlobalRedemptions == maxGlobalRedemptions) &&
            (identical(other.globalRedemptionsUsed, globalRedemptionsUsed) ||
                other.globalRedemptionsUsed == globalRedemptionsUsed) &&
            (identical(other.maxPerUser, maxPerUser) ||
                other.maxPerUser == maxPerUser) &&
            (identical(other.startsAt, startsAt) ||
                other.startsAt == startsAt) &&
            (identical(other.endsAt, endsAt) || other.endsAt == endsAt) &&
            const DeepCollectionEquality().equals(
              other._eligibleUserIds,
              _eligibleUserIds,
            ) &&
            (identical(other.newUsersOnly, newUsersOnly) ||
                other.newUsersOnly == newUsersOnly) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    code,
    trigger,
    valueType,
    percentage,
    amount,
    scope,
    const DeepCollectionEquality().hash(_productIds),
    const DeepCollectionEquality().hash(_categoryIds),
    minimumSubtotal,
    minimumQuantity,
    isActive,
    stackable,
    maxGlobalRedemptions,
    globalRedemptionsUsed,
    maxPerUser,
    startsAt,
    endsAt,
    const DeepCollectionEquality().hash(_eligibleUserIds),
    newUsersOnly,
    const DeepCollectionEquality().hash(_metadata),
    name,
    description,
    createdAt,
    updatedAt,
  ]);

  /// Create a copy of Discount
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DiscountImplCopyWith<_$DiscountImpl> get copyWith =>
      __$$DiscountImplCopyWithImpl<_$DiscountImpl>(this, _$identity);
}

abstract class _Discount implements Discount {
  const factory _Discount({
    required final String id,
    final String? code,
    final DiscountTrigger trigger,
    final DiscountValueType valueType,
    final double percentage,
    final Money? amount,
    final DiscountScope scope,
    final List<String> productIds,
    final List<String> categoryIds,
    final Money? minimumSubtotal,
    final int? minimumQuantity,
    final bool isActive,
    final bool stackable,
    final int? maxGlobalRedemptions,
    final int globalRedemptionsUsed,
    final int? maxPerUser,
    final DateTime? startsAt,
    final DateTime? endsAt,
    final List<String> eligibleUserIds,
    final bool newUsersOnly,
    final Map<String, String>? metadata,
    final String? name,
    final String? description,
    final DateTime? createdAt,
    final DateTime? updatedAt,
  }) = _$DiscountImpl;

  @override
  String get id;

  /// Human-readable code if trigger == code. Unique when present.
  @override
  String? get code;

  /// Classification.
  @override
  DiscountTrigger get trigger;
  @override
  DiscountValueType get valueType;

  /// If percentage: 0–100. If fixedAmount: amount’s numeric part in [amount] with currency.
  @override
  double get percentage;

  /// Fixed value for fixed-amount discounts; currency must be set.
  @override
  Money? get amount;

  /// Application rules.
  @override
  DiscountScope get scope;
  @override
  List<String> get productIds; // when scope == specificProducts
  @override
  List<String> get categoryIds; // when scope == specificCategories
  /// Order-level constraints.
  @override
  Money? get minimumSubtotal; // requires currency
  @override
  int? get minimumQuantity; // sum of quantities across matched items
  /// Stacking/usage control.
  @override
  bool get isActive;
  @override
  bool get stackable;
  @override
  int? get maxGlobalRedemptions; // total allowed across all users
  @override
  int get globalRedemptionsUsed;
  @override
  int? get maxPerUser; // per-user limit
  /// Validity window.
  @override
  DateTime? get startsAt;
  @override
  DateTime? get endsAt;

  /// Optional targeting.
  @override
  List<String> get eligibleUserIds; // whitelist users
  @override
  bool get newUsersOnly;

  /// Metadata for analytics/integrations.
  @override
  Map<String, String>? get metadata;
  @override
  String? get name; // internal name
  @override
  String? get description; // UI copy
  /// Audit.
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of Discount
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DiscountImplCopyWith<_$DiscountImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
