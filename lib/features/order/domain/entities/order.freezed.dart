// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$OrderItem {
  String get id => throw _privateConstructorUsedError;
  String get sku =>
      throw _privateConstructorUsedError; // inventory SKU or service code
  String get name =>
      throw _privateConstructorUsedError; // snapshot for audit/UI
  String? get variant => throw _privateConstructorUsedError; // e.g. color/size
  int get quantity => throw _privateConstructorUsedError;
  Money get unitPrice =>
      throw _privateConstructorUsedError; // price per unit at purchase
  Money get lineSubtotal =>
      throw _privateConstructorUsedError; // unitPrice * quantity before discounts/tax
  Money get lineDiscount =>
      throw _privateConstructorUsedError; // total discount applied to this line
  Money get lineTax =>
      throw _privateConstructorUsedError; // tax portion for this line
  Money get lineTotal =>
      throw _privateConstructorUsedError; // final for this line
  Map<String, String>? get attributes =>
      throw _privateConstructorUsedError; // arbitrary attributes snapshot
  String? get productId => throw _privateConstructorUsedError;

  /// Create a copy of OrderItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderItemCopyWith<OrderItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderItemCopyWith<$Res> {
  factory $OrderItemCopyWith(OrderItem value, $Res Function(OrderItem) then) =
      _$OrderItemCopyWithImpl<$Res, OrderItem>;
  @useResult
  $Res call({
    String id,
    String sku,
    String name,
    String? variant,
    int quantity,
    Money unitPrice,
    Money lineSubtotal,
    Money lineDiscount,
    Money lineTax,
    Money lineTotal,
    Map<String, String>? attributes,
    String? productId,
  });
}

/// @nodoc
class _$OrderItemCopyWithImpl<$Res, $Val extends OrderItem>
    implements $OrderItemCopyWith<$Res> {
  _$OrderItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrderItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? sku = null,
    Object? name = null,
    Object? variant = freezed,
    Object? quantity = null,
    Object? unitPrice = null,
    Object? lineSubtotal = null,
    Object? lineDiscount = null,
    Object? lineTax = null,
    Object? lineTotal = null,
    Object? attributes = freezed,
    Object? productId = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            sku: null == sku
                ? _value.sku
                : sku // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            variant: freezed == variant
                ? _value.variant
                : variant // ignore: cast_nullable_to_non_nullable
                      as String?,
            quantity: null == quantity
                ? _value.quantity
                : quantity // ignore: cast_nullable_to_non_nullable
                      as int,
            unitPrice: null == unitPrice
                ? _value.unitPrice
                : unitPrice // ignore: cast_nullable_to_non_nullable
                      as Money,
            lineSubtotal: null == lineSubtotal
                ? _value.lineSubtotal
                : lineSubtotal // ignore: cast_nullable_to_non_nullable
                      as Money,
            lineDiscount: null == lineDiscount
                ? _value.lineDiscount
                : lineDiscount // ignore: cast_nullable_to_non_nullable
                      as Money,
            lineTax: null == lineTax
                ? _value.lineTax
                : lineTax // ignore: cast_nullable_to_non_nullable
                      as Money,
            lineTotal: null == lineTotal
                ? _value.lineTotal
                : lineTotal // ignore: cast_nullable_to_non_nullable
                      as Money,
            attributes: freezed == attributes
                ? _value.attributes
                : attributes // ignore: cast_nullable_to_non_nullable
                      as Map<String, String>?,
            productId: freezed == productId
                ? _value.productId
                : productId // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$OrderItemImplCopyWith<$Res>
    implements $OrderItemCopyWith<$Res> {
  factory _$$OrderItemImplCopyWith(
    _$OrderItemImpl value,
    $Res Function(_$OrderItemImpl) then,
  ) = __$$OrderItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String sku,
    String name,
    String? variant,
    int quantity,
    Money unitPrice,
    Money lineSubtotal,
    Money lineDiscount,
    Money lineTax,
    Money lineTotal,
    Map<String, String>? attributes,
    String? productId,
  });
}

/// @nodoc
class __$$OrderItemImplCopyWithImpl<$Res>
    extends _$OrderItemCopyWithImpl<$Res, _$OrderItemImpl>
    implements _$$OrderItemImplCopyWith<$Res> {
  __$$OrderItemImplCopyWithImpl(
    _$OrderItemImpl _value,
    $Res Function(_$OrderItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OrderItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? sku = null,
    Object? name = null,
    Object? variant = freezed,
    Object? quantity = null,
    Object? unitPrice = null,
    Object? lineSubtotal = null,
    Object? lineDiscount = null,
    Object? lineTax = null,
    Object? lineTotal = null,
    Object? attributes = freezed,
    Object? productId = freezed,
  }) {
    return _then(
      _$OrderItemImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        sku: null == sku
            ? _value.sku
            : sku // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        variant: freezed == variant
            ? _value.variant
            : variant // ignore: cast_nullable_to_non_nullable
                  as String?,
        quantity: null == quantity
            ? _value.quantity
            : quantity // ignore: cast_nullable_to_non_nullable
                  as int,
        unitPrice: null == unitPrice
            ? _value.unitPrice
            : unitPrice // ignore: cast_nullable_to_non_nullable
                  as Money,
        lineSubtotal: null == lineSubtotal
            ? _value.lineSubtotal
            : lineSubtotal // ignore: cast_nullable_to_non_nullable
                  as Money,
        lineDiscount: null == lineDiscount
            ? _value.lineDiscount
            : lineDiscount // ignore: cast_nullable_to_non_nullable
                  as Money,
        lineTax: null == lineTax
            ? _value.lineTax
            : lineTax // ignore: cast_nullable_to_non_nullable
                  as Money,
        lineTotal: null == lineTotal
            ? _value.lineTotal
            : lineTotal // ignore: cast_nullable_to_non_nullable
                  as Money,
        attributes: freezed == attributes
            ? _value._attributes
            : attributes // ignore: cast_nullable_to_non_nullable
                  as Map<String, String>?,
        productId: freezed == productId
            ? _value.productId
            : productId // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$OrderItemImpl implements _OrderItem {
  const _$OrderItemImpl({
    required this.id,
    required this.sku,
    required this.name,
    this.variant,
    this.quantity = 1,
    this.unitPrice = const Money(0.0, 'USD'),
    this.lineSubtotal = const Money(0.0, 'USD'),
    this.lineDiscount = const Money(0.0, 'USD'),
    this.lineTax = const Money(0.0, 'USD'),
    this.lineTotal = const Money(0.0, 'USD'),
    final Map<String, String>? attributes,
    this.productId,
  }) : _attributes = attributes;

  @override
  final String id;
  @override
  final String sku;
  // inventory SKU or service code
  @override
  final String name;
  // snapshot for audit/UI
  @override
  final String? variant;
  // e.g. color/size
  @override
  @JsonKey()
  final int quantity;
  @override
  @JsonKey()
  final Money unitPrice;
  // price per unit at purchase
  @override
  @JsonKey()
  final Money lineSubtotal;
  // unitPrice * quantity before discounts/tax
  @override
  @JsonKey()
  final Money lineDiscount;
  // total discount applied to this line
  @override
  @JsonKey()
  final Money lineTax;
  // tax portion for this line
  @override
  @JsonKey()
  final Money lineTotal;
  // final for this line
  final Map<String, String>? _attributes;
  // final for this line
  @override
  Map<String, String>? get attributes {
    final value = _attributes;
    if (value == null) return null;
    if (_attributes is EqualUnmodifiableMapView) return _attributes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  // arbitrary attributes snapshot
  @override
  final String? productId;

  @override
  String toString() {
    return 'OrderItem(id: $id, sku: $sku, name: $name, variant: $variant, quantity: $quantity, unitPrice: $unitPrice, lineSubtotal: $lineSubtotal, lineDiscount: $lineDiscount, lineTax: $lineTax, lineTotal: $lineTotal, attributes: $attributes, productId: $productId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.sku, sku) || other.sku == sku) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.variant, variant) || other.variant == variant) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.unitPrice, unitPrice) ||
                other.unitPrice == unitPrice) &&
            (identical(other.lineSubtotal, lineSubtotal) ||
                other.lineSubtotal == lineSubtotal) &&
            (identical(other.lineDiscount, lineDiscount) ||
                other.lineDiscount == lineDiscount) &&
            (identical(other.lineTax, lineTax) || other.lineTax == lineTax) &&
            (identical(other.lineTotal, lineTotal) ||
                other.lineTotal == lineTotal) &&
            const DeepCollectionEquality().equals(
              other._attributes,
              _attributes,
            ) &&
            (identical(other.productId, productId) ||
                other.productId == productId));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    sku,
    name,
    variant,
    quantity,
    unitPrice,
    lineSubtotal,
    lineDiscount,
    lineTax,
    lineTotal,
    const DeepCollectionEquality().hash(_attributes),
    productId,
  );

  /// Create a copy of OrderItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderItemImplCopyWith<_$OrderItemImpl> get copyWith =>
      __$$OrderItemImplCopyWithImpl<_$OrderItemImpl>(this, _$identity);
}

abstract class _OrderItem implements OrderItem {
  const factory _OrderItem({
    required final String id,
    required final String sku,
    required final String name,
    final String? variant,
    final int quantity,
    final Money unitPrice,
    final Money lineSubtotal,
    final Money lineDiscount,
    final Money lineTax,
    final Money lineTotal,
    final Map<String, String>? attributes,
    final String? productId,
  }) = _$OrderItemImpl;

  @override
  String get id;
  @override
  String get sku; // inventory SKU or service code
  @override
  String get name; // snapshot for audit/UI
  @override
  String? get variant; // e.g. color/size
  @override
  int get quantity;
  @override
  Money get unitPrice; // price per unit at purchase
  @override
  Money get lineSubtotal; // unitPrice * quantity before discounts/tax
  @override
  Money get lineDiscount; // total discount applied to this line
  @override
  Money get lineTax; // tax portion for this line
  @override
  Money get lineTotal; // final for this line
  @override
  Map<String, String>? get attributes; // arbitrary attributes snapshot
  @override
  String? get productId;

  /// Create a copy of OrderItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderItemImplCopyWith<_$OrderItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$PaymentInfo {
  PaymentMethod get method => throw _privateConstructorUsedError;
  String? get provider => throw _privateConstructorUsedError; // e.g. 'Stripe'
  String? get chargeId =>
      throw _privateConstructorUsedError; // PSP charge/payment ID
  bool get authorized => throw _privateConstructorUsedError;
  bool get captured => throw _privateConstructorUsedError;
  DateTime? get authorizedAt => throw _privateConstructorUsedError;
  DateTime? get capturedAt => throw _privateConstructorUsedError;
  String? get last4 => throw _privateConstructorUsedError;

  /// Create a copy of PaymentInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PaymentInfoCopyWith<PaymentInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaymentInfoCopyWith<$Res> {
  factory $PaymentInfoCopyWith(
    PaymentInfo value,
    $Res Function(PaymentInfo) then,
  ) = _$PaymentInfoCopyWithImpl<$Res, PaymentInfo>;
  @useResult
  $Res call({
    PaymentMethod method,
    String? provider,
    String? chargeId,
    bool authorized,
    bool captured,
    DateTime? authorizedAt,
    DateTime? capturedAt,
    String? last4,
  });
}

/// @nodoc
class _$PaymentInfoCopyWithImpl<$Res, $Val extends PaymentInfo>
    implements $PaymentInfoCopyWith<$Res> {
  _$PaymentInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PaymentInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? method = null,
    Object? provider = freezed,
    Object? chargeId = freezed,
    Object? authorized = null,
    Object? captured = null,
    Object? authorizedAt = freezed,
    Object? capturedAt = freezed,
    Object? last4 = freezed,
  }) {
    return _then(
      _value.copyWith(
            method: null == method
                ? _value.method
                : method // ignore: cast_nullable_to_non_nullable
                      as PaymentMethod,
            provider: freezed == provider
                ? _value.provider
                : provider // ignore: cast_nullable_to_non_nullable
                      as String?,
            chargeId: freezed == chargeId
                ? _value.chargeId
                : chargeId // ignore: cast_nullable_to_non_nullable
                      as String?,
            authorized: null == authorized
                ? _value.authorized
                : authorized // ignore: cast_nullable_to_non_nullable
                      as bool,
            captured: null == captured
                ? _value.captured
                : captured // ignore: cast_nullable_to_non_nullable
                      as bool,
            authorizedAt: freezed == authorizedAt
                ? _value.authorizedAt
                : authorizedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            capturedAt: freezed == capturedAt
                ? _value.capturedAt
                : capturedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            last4: freezed == last4
                ? _value.last4
                : last4 // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PaymentInfoImplCopyWith<$Res>
    implements $PaymentInfoCopyWith<$Res> {
  factory _$$PaymentInfoImplCopyWith(
    _$PaymentInfoImpl value,
    $Res Function(_$PaymentInfoImpl) then,
  ) = __$$PaymentInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    PaymentMethod method,
    String? provider,
    String? chargeId,
    bool authorized,
    bool captured,
    DateTime? authorizedAt,
    DateTime? capturedAt,
    String? last4,
  });
}

/// @nodoc
class __$$PaymentInfoImplCopyWithImpl<$Res>
    extends _$PaymentInfoCopyWithImpl<$Res, _$PaymentInfoImpl>
    implements _$$PaymentInfoImplCopyWith<$Res> {
  __$$PaymentInfoImplCopyWithImpl(
    _$PaymentInfoImpl _value,
    $Res Function(_$PaymentInfoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PaymentInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? method = null,
    Object? provider = freezed,
    Object? chargeId = freezed,
    Object? authorized = null,
    Object? captured = null,
    Object? authorizedAt = freezed,
    Object? capturedAt = freezed,
    Object? last4 = freezed,
  }) {
    return _then(
      _$PaymentInfoImpl(
        method: null == method
            ? _value.method
            : method // ignore: cast_nullable_to_non_nullable
                  as PaymentMethod,
        provider: freezed == provider
            ? _value.provider
            : provider // ignore: cast_nullable_to_non_nullable
                  as String?,
        chargeId: freezed == chargeId
            ? _value.chargeId
            : chargeId // ignore: cast_nullable_to_non_nullable
                  as String?,
        authorized: null == authorized
            ? _value.authorized
            : authorized // ignore: cast_nullable_to_non_nullable
                  as bool,
        captured: null == captured
            ? _value.captured
            : captured // ignore: cast_nullable_to_non_nullable
                  as bool,
        authorizedAt: freezed == authorizedAt
            ? _value.authorizedAt
            : authorizedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        capturedAt: freezed == capturedAt
            ? _value.capturedAt
            : capturedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        last4: freezed == last4
            ? _value.last4
            : last4 // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$PaymentInfoImpl implements _PaymentInfo {
  const _$PaymentInfoImpl({
    required this.method,
    this.provider,
    this.chargeId,
    this.authorized = false,
    this.captured = false,
    this.authorizedAt,
    this.capturedAt,
    this.last4,
  });

  @override
  final PaymentMethod method;
  @override
  final String? provider;
  // e.g. 'Stripe'
  @override
  final String? chargeId;
  // PSP charge/payment ID
  @override
  @JsonKey()
  final bool authorized;
  @override
  @JsonKey()
  final bool captured;
  @override
  final DateTime? authorizedAt;
  @override
  final DateTime? capturedAt;
  @override
  final String? last4;

  @override
  String toString() {
    return 'PaymentInfo(method: $method, provider: $provider, chargeId: $chargeId, authorized: $authorized, captured: $captured, authorizedAt: $authorizedAt, capturedAt: $capturedAt, last4: $last4)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaymentInfoImpl &&
            (identical(other.method, method) || other.method == method) &&
            (identical(other.provider, provider) ||
                other.provider == provider) &&
            (identical(other.chargeId, chargeId) ||
                other.chargeId == chargeId) &&
            (identical(other.authorized, authorized) ||
                other.authorized == authorized) &&
            (identical(other.captured, captured) ||
                other.captured == captured) &&
            (identical(other.authorizedAt, authorizedAt) ||
                other.authorizedAt == authorizedAt) &&
            (identical(other.capturedAt, capturedAt) ||
                other.capturedAt == capturedAt) &&
            (identical(other.last4, last4) || other.last4 == last4));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    method,
    provider,
    chargeId,
    authorized,
    captured,
    authorizedAt,
    capturedAt,
    last4,
  );

  /// Create a copy of PaymentInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PaymentInfoImplCopyWith<_$PaymentInfoImpl> get copyWith =>
      __$$PaymentInfoImplCopyWithImpl<_$PaymentInfoImpl>(this, _$identity);
}

abstract class _PaymentInfo implements PaymentInfo {
  const factory _PaymentInfo({
    required final PaymentMethod method,
    final String? provider,
    final String? chargeId,
    final bool authorized,
    final bool captured,
    final DateTime? authorizedAt,
    final DateTime? capturedAt,
    final String? last4,
  }) = _$PaymentInfoImpl;

  @override
  PaymentMethod get method;
  @override
  String? get provider; // e.g. 'Stripe'
  @override
  String? get chargeId; // PSP charge/payment ID
  @override
  bool get authorized;
  @override
  bool get captured;
  @override
  DateTime? get authorizedAt;
  @override
  DateTime? get capturedAt;
  @override
  String? get last4;

  /// Create a copy of PaymentInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaymentInfoImplCopyWith<_$PaymentInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$FulfillmentInfo {
  FulfillmentType get type =>
      throw _privateConstructorUsedError; // For shipping:
  String? get carrier => throw _privateConstructorUsedError;
  String? get trackingNumber => throw _privateConstructorUsedError;
  String? get shippingAddressId =>
      throw _privateConstructorUsedError; // points to Address by ID
  // For pickup:
  String? get pickupLocationId => throw _privateConstructorUsedError;
  DateTime? get pickupReadyAt => throw _privateConstructorUsedError; // Common:
  DateTime? get estimatedDeliveryStart => throw _privateConstructorUsedError;
  DateTime? get estimatedDeliveryEnd => throw _privateConstructorUsedError;
  String? get note => throw _privateConstructorUsedError;

  /// Create a copy of FulfillmentInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FulfillmentInfoCopyWith<FulfillmentInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FulfillmentInfoCopyWith<$Res> {
  factory $FulfillmentInfoCopyWith(
    FulfillmentInfo value,
    $Res Function(FulfillmentInfo) then,
  ) = _$FulfillmentInfoCopyWithImpl<$Res, FulfillmentInfo>;
  @useResult
  $Res call({
    FulfillmentType type,
    String? carrier,
    String? trackingNumber,
    String? shippingAddressId,
    String? pickupLocationId,
    DateTime? pickupReadyAt,
    DateTime? estimatedDeliveryStart,
    DateTime? estimatedDeliveryEnd,
    String? note,
  });
}

/// @nodoc
class _$FulfillmentInfoCopyWithImpl<$Res, $Val extends FulfillmentInfo>
    implements $FulfillmentInfoCopyWith<$Res> {
  _$FulfillmentInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FulfillmentInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? carrier = freezed,
    Object? trackingNumber = freezed,
    Object? shippingAddressId = freezed,
    Object? pickupLocationId = freezed,
    Object? pickupReadyAt = freezed,
    Object? estimatedDeliveryStart = freezed,
    Object? estimatedDeliveryEnd = freezed,
    Object? note = freezed,
  }) {
    return _then(
      _value.copyWith(
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as FulfillmentType,
            carrier: freezed == carrier
                ? _value.carrier
                : carrier // ignore: cast_nullable_to_non_nullable
                      as String?,
            trackingNumber: freezed == trackingNumber
                ? _value.trackingNumber
                : trackingNumber // ignore: cast_nullable_to_non_nullable
                      as String?,
            shippingAddressId: freezed == shippingAddressId
                ? _value.shippingAddressId
                : shippingAddressId // ignore: cast_nullable_to_non_nullable
                      as String?,
            pickupLocationId: freezed == pickupLocationId
                ? _value.pickupLocationId
                : pickupLocationId // ignore: cast_nullable_to_non_nullable
                      as String?,
            pickupReadyAt: freezed == pickupReadyAt
                ? _value.pickupReadyAt
                : pickupReadyAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            estimatedDeliveryStart: freezed == estimatedDeliveryStart
                ? _value.estimatedDeliveryStart
                : estimatedDeliveryStart // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            estimatedDeliveryEnd: freezed == estimatedDeliveryEnd
                ? _value.estimatedDeliveryEnd
                : estimatedDeliveryEnd // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            note: freezed == note
                ? _value.note
                : note // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$FulfillmentInfoImplCopyWith<$Res>
    implements $FulfillmentInfoCopyWith<$Res> {
  factory _$$FulfillmentInfoImplCopyWith(
    _$FulfillmentInfoImpl value,
    $Res Function(_$FulfillmentInfoImpl) then,
  ) = __$$FulfillmentInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    FulfillmentType type,
    String? carrier,
    String? trackingNumber,
    String? shippingAddressId,
    String? pickupLocationId,
    DateTime? pickupReadyAt,
    DateTime? estimatedDeliveryStart,
    DateTime? estimatedDeliveryEnd,
    String? note,
  });
}

/// @nodoc
class __$$FulfillmentInfoImplCopyWithImpl<$Res>
    extends _$FulfillmentInfoCopyWithImpl<$Res, _$FulfillmentInfoImpl>
    implements _$$FulfillmentInfoImplCopyWith<$Res> {
  __$$FulfillmentInfoImplCopyWithImpl(
    _$FulfillmentInfoImpl _value,
    $Res Function(_$FulfillmentInfoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FulfillmentInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? carrier = freezed,
    Object? trackingNumber = freezed,
    Object? shippingAddressId = freezed,
    Object? pickupLocationId = freezed,
    Object? pickupReadyAt = freezed,
    Object? estimatedDeliveryStart = freezed,
    Object? estimatedDeliveryEnd = freezed,
    Object? note = freezed,
  }) {
    return _then(
      _$FulfillmentInfoImpl(
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as FulfillmentType,
        carrier: freezed == carrier
            ? _value.carrier
            : carrier // ignore: cast_nullable_to_non_nullable
                  as String?,
        trackingNumber: freezed == trackingNumber
            ? _value.trackingNumber
            : trackingNumber // ignore: cast_nullable_to_non_nullable
                  as String?,
        shippingAddressId: freezed == shippingAddressId
            ? _value.shippingAddressId
            : shippingAddressId // ignore: cast_nullable_to_non_nullable
                  as String?,
        pickupLocationId: freezed == pickupLocationId
            ? _value.pickupLocationId
            : pickupLocationId // ignore: cast_nullable_to_non_nullable
                  as String?,
        pickupReadyAt: freezed == pickupReadyAt
            ? _value.pickupReadyAt
            : pickupReadyAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        estimatedDeliveryStart: freezed == estimatedDeliveryStart
            ? _value.estimatedDeliveryStart
            : estimatedDeliveryStart // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        estimatedDeliveryEnd: freezed == estimatedDeliveryEnd
            ? _value.estimatedDeliveryEnd
            : estimatedDeliveryEnd // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        note: freezed == note
            ? _value.note
            : note // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$FulfillmentInfoImpl implements _FulfillmentInfo {
  const _$FulfillmentInfoImpl({
    required this.type,
    this.carrier,
    this.trackingNumber,
    this.shippingAddressId,
    this.pickupLocationId,
    this.pickupReadyAt,
    this.estimatedDeliveryStart,
    this.estimatedDeliveryEnd,
    this.note,
  });

  @override
  final FulfillmentType type;
  // For shipping:
  @override
  final String? carrier;
  @override
  final String? trackingNumber;
  @override
  final String? shippingAddressId;
  // points to Address by ID
  // For pickup:
  @override
  final String? pickupLocationId;
  @override
  final DateTime? pickupReadyAt;
  // Common:
  @override
  final DateTime? estimatedDeliveryStart;
  @override
  final DateTime? estimatedDeliveryEnd;
  @override
  final String? note;

  @override
  String toString() {
    return 'FulfillmentInfo(type: $type, carrier: $carrier, trackingNumber: $trackingNumber, shippingAddressId: $shippingAddressId, pickupLocationId: $pickupLocationId, pickupReadyAt: $pickupReadyAt, estimatedDeliveryStart: $estimatedDeliveryStart, estimatedDeliveryEnd: $estimatedDeliveryEnd, note: $note)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FulfillmentInfoImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.carrier, carrier) || other.carrier == carrier) &&
            (identical(other.trackingNumber, trackingNumber) ||
                other.trackingNumber == trackingNumber) &&
            (identical(other.shippingAddressId, shippingAddressId) ||
                other.shippingAddressId == shippingAddressId) &&
            (identical(other.pickupLocationId, pickupLocationId) ||
                other.pickupLocationId == pickupLocationId) &&
            (identical(other.pickupReadyAt, pickupReadyAt) ||
                other.pickupReadyAt == pickupReadyAt) &&
            (identical(other.estimatedDeliveryStart, estimatedDeliveryStart) ||
                other.estimatedDeliveryStart == estimatedDeliveryStart) &&
            (identical(other.estimatedDeliveryEnd, estimatedDeliveryEnd) ||
                other.estimatedDeliveryEnd == estimatedDeliveryEnd) &&
            (identical(other.note, note) || other.note == note));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    type,
    carrier,
    trackingNumber,
    shippingAddressId,
    pickupLocationId,
    pickupReadyAt,
    estimatedDeliveryStart,
    estimatedDeliveryEnd,
    note,
  );

  /// Create a copy of FulfillmentInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FulfillmentInfoImplCopyWith<_$FulfillmentInfoImpl> get copyWith =>
      __$$FulfillmentInfoImplCopyWithImpl<_$FulfillmentInfoImpl>(
        this,
        _$identity,
      );
}

abstract class _FulfillmentInfo implements FulfillmentInfo {
  const factory _FulfillmentInfo({
    required final FulfillmentType type,
    final String? carrier,
    final String? trackingNumber,
    final String? shippingAddressId,
    final String? pickupLocationId,
    final DateTime? pickupReadyAt,
    final DateTime? estimatedDeliveryStart,
    final DateTime? estimatedDeliveryEnd,
    final String? note,
  }) = _$FulfillmentInfoImpl;

  @override
  FulfillmentType get type; // For shipping:
  @override
  String? get carrier;
  @override
  String? get trackingNumber;
  @override
  String? get shippingAddressId; // points to Address by ID
  // For pickup:
  @override
  String? get pickupLocationId;
  @override
  DateTime? get pickupReadyAt; // Common:
  @override
  DateTime? get estimatedDeliveryStart;
  @override
  DateTime? get estimatedDeliveryEnd;
  @override
  String? get note;

  /// Create a copy of FulfillmentInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FulfillmentInfoImplCopyWith<_$FulfillmentInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$Order {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  OrderStatus get status => throw _privateConstructorUsedError;

  /// Optional external references for integrations.
  String? get orderNumber =>
      throw _privateConstructorUsedError; // human-facing order code
  String? get externalRef =>
      throw _privateConstructorUsedError; // ERP/OMS reference
  /// Cart snapshot.
  List<OrderItem> get items => throw _privateConstructorUsedError;

  /// Discount/coupon codes actually applied at checkout.
  List<String> get appliedDiscountCodes => throw _privateConstructorUsedError;

  /// Totals snapshot (authoritative at the time of purchase).
  Money get subtotal =>
      throw _privateConstructorUsedError; // sum of line subtotals
  Money get discountTotal =>
      throw _privateConstructorUsedError; // sum of all discounts
  Money get shippingTotal => throw _privateConstructorUsedError;
  Money get taxTotal => throw _privateConstructorUsedError;
  Money get feesTotal =>
      throw _privateConstructorUsedError; // service/handling fees
  Money get grandTotal =>
      throw _privateConstructorUsedError; // payable: subtotal - discount + shipping + tax + fees
  /// Amounts paid/refunded.
  Money get amountAuthorized => throw _privateConstructorUsedError;
  Money get amountCaptured => throw _privateConstructorUsedError;
  Money get amountRefunded => throw _privateConstructorUsedError;

  /// Payment & fulfillment snapshots.
  PaymentInfo? get payment => throw _privateConstructorUsedError;
  FulfillmentInfo? get fulfillment => throw _privateConstructorUsedError;

  /// Optional address references (billing/shipping) by ID.
  String? get billingAddressId => throw _privateConstructorUsedError;
  String? get shippingAddressId => throw _privateConstructorUsedError;

  /// Optional wallet used (by ID) when method == wallet.
  String? get walletId => throw _privateConstructorUsedError;

  /// Audit fields.
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  DateTime? get cancelledAt => throw _privateConstructorUsedError;
  DateTime? get completedAt => throw _privateConstructorUsedError;

  /// Free-form metadata for integrations/analytics.
  Map<String, String>? get metadata => throw _privateConstructorUsedError;
  String? get note => throw _privateConstructorUsedError;

  /// Create a copy of Order
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderCopyWith<Order> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderCopyWith<$Res> {
  factory $OrderCopyWith(Order value, $Res Function(Order) then) =
      _$OrderCopyWithImpl<$Res, Order>;
  @useResult
  $Res call({
    String id,
    String userId,
    OrderStatus status,
    String? orderNumber,
    String? externalRef,
    List<OrderItem> items,
    List<String> appliedDiscountCodes,
    Money subtotal,
    Money discountTotal,
    Money shippingTotal,
    Money taxTotal,
    Money feesTotal,
    Money grandTotal,
    Money amountAuthorized,
    Money amountCaptured,
    Money amountRefunded,
    PaymentInfo? payment,
    FulfillmentInfo? fulfillment,
    String? billingAddressId,
    String? shippingAddressId,
    String? walletId,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? cancelledAt,
    DateTime? completedAt,
    Map<String, String>? metadata,
    String? note,
  });

  $PaymentInfoCopyWith<$Res>? get payment;
  $FulfillmentInfoCopyWith<$Res>? get fulfillment;
}

/// @nodoc
class _$OrderCopyWithImpl<$Res, $Val extends Order>
    implements $OrderCopyWith<$Res> {
  _$OrderCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Order
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? status = null,
    Object? orderNumber = freezed,
    Object? externalRef = freezed,
    Object? items = null,
    Object? appliedDiscountCodes = null,
    Object? subtotal = null,
    Object? discountTotal = null,
    Object? shippingTotal = null,
    Object? taxTotal = null,
    Object? feesTotal = null,
    Object? grandTotal = null,
    Object? amountAuthorized = null,
    Object? amountCaptured = null,
    Object? amountRefunded = null,
    Object? payment = freezed,
    Object? fulfillment = freezed,
    Object? billingAddressId = freezed,
    Object? shippingAddressId = freezed,
    Object? walletId = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? cancelledAt = freezed,
    Object? completedAt = freezed,
    Object? metadata = freezed,
    Object? note = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as OrderStatus,
            orderNumber: freezed == orderNumber
                ? _value.orderNumber
                : orderNumber // ignore: cast_nullable_to_non_nullable
                      as String?,
            externalRef: freezed == externalRef
                ? _value.externalRef
                : externalRef // ignore: cast_nullable_to_non_nullable
                      as String?,
            items: null == items
                ? _value.items
                : items // ignore: cast_nullable_to_non_nullable
                      as List<OrderItem>,
            appliedDiscountCodes: null == appliedDiscountCodes
                ? _value.appliedDiscountCodes
                : appliedDiscountCodes // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            subtotal: null == subtotal
                ? _value.subtotal
                : subtotal // ignore: cast_nullable_to_non_nullable
                      as Money,
            discountTotal: null == discountTotal
                ? _value.discountTotal
                : discountTotal // ignore: cast_nullable_to_non_nullable
                      as Money,
            shippingTotal: null == shippingTotal
                ? _value.shippingTotal
                : shippingTotal // ignore: cast_nullable_to_non_nullable
                      as Money,
            taxTotal: null == taxTotal
                ? _value.taxTotal
                : taxTotal // ignore: cast_nullable_to_non_nullable
                      as Money,
            feesTotal: null == feesTotal
                ? _value.feesTotal
                : feesTotal // ignore: cast_nullable_to_non_nullable
                      as Money,
            grandTotal: null == grandTotal
                ? _value.grandTotal
                : grandTotal // ignore: cast_nullable_to_non_nullable
                      as Money,
            amountAuthorized: null == amountAuthorized
                ? _value.amountAuthorized
                : amountAuthorized // ignore: cast_nullable_to_non_nullable
                      as Money,
            amountCaptured: null == amountCaptured
                ? _value.amountCaptured
                : amountCaptured // ignore: cast_nullable_to_non_nullable
                      as Money,
            amountRefunded: null == amountRefunded
                ? _value.amountRefunded
                : amountRefunded // ignore: cast_nullable_to_non_nullable
                      as Money,
            payment: freezed == payment
                ? _value.payment
                : payment // ignore: cast_nullable_to_non_nullable
                      as PaymentInfo?,
            fulfillment: freezed == fulfillment
                ? _value.fulfillment
                : fulfillment // ignore: cast_nullable_to_non_nullable
                      as FulfillmentInfo?,
            billingAddressId: freezed == billingAddressId
                ? _value.billingAddressId
                : billingAddressId // ignore: cast_nullable_to_non_nullable
                      as String?,
            shippingAddressId: freezed == shippingAddressId
                ? _value.shippingAddressId
                : shippingAddressId // ignore: cast_nullable_to_non_nullable
                      as String?,
            walletId: freezed == walletId
                ? _value.walletId
                : walletId // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            updatedAt: freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            cancelledAt: freezed == cancelledAt
                ? _value.cancelledAt
                : cancelledAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            completedAt: freezed == completedAt
                ? _value.completedAt
                : completedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            metadata: freezed == metadata
                ? _value.metadata
                : metadata // ignore: cast_nullable_to_non_nullable
                      as Map<String, String>?,
            note: freezed == note
                ? _value.note
                : note // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of Order
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PaymentInfoCopyWith<$Res>? get payment {
    if (_value.payment == null) {
      return null;
    }

    return $PaymentInfoCopyWith<$Res>(_value.payment!, (value) {
      return _then(_value.copyWith(payment: value) as $Val);
    });
  }

  /// Create a copy of Order
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FulfillmentInfoCopyWith<$Res>? get fulfillment {
    if (_value.fulfillment == null) {
      return null;
    }

    return $FulfillmentInfoCopyWith<$Res>(_value.fulfillment!, (value) {
      return _then(_value.copyWith(fulfillment: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$OrderImplCopyWith<$Res> implements $OrderCopyWith<$Res> {
  factory _$$OrderImplCopyWith(
    _$OrderImpl value,
    $Res Function(_$OrderImpl) then,
  ) = __$$OrderImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String userId,
    OrderStatus status,
    String? orderNumber,
    String? externalRef,
    List<OrderItem> items,
    List<String> appliedDiscountCodes,
    Money subtotal,
    Money discountTotal,
    Money shippingTotal,
    Money taxTotal,
    Money feesTotal,
    Money grandTotal,
    Money amountAuthorized,
    Money amountCaptured,
    Money amountRefunded,
    PaymentInfo? payment,
    FulfillmentInfo? fulfillment,
    String? billingAddressId,
    String? shippingAddressId,
    String? walletId,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? cancelledAt,
    DateTime? completedAt,
    Map<String, String>? metadata,
    String? note,
  });

  @override
  $PaymentInfoCopyWith<$Res>? get payment;
  @override
  $FulfillmentInfoCopyWith<$Res>? get fulfillment;
}

/// @nodoc
class __$$OrderImplCopyWithImpl<$Res>
    extends _$OrderCopyWithImpl<$Res, _$OrderImpl>
    implements _$$OrderImplCopyWith<$Res> {
  __$$OrderImplCopyWithImpl(
    _$OrderImpl _value,
    $Res Function(_$OrderImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Order
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? status = null,
    Object? orderNumber = freezed,
    Object? externalRef = freezed,
    Object? items = null,
    Object? appliedDiscountCodes = null,
    Object? subtotal = null,
    Object? discountTotal = null,
    Object? shippingTotal = null,
    Object? taxTotal = null,
    Object? feesTotal = null,
    Object? grandTotal = null,
    Object? amountAuthorized = null,
    Object? amountCaptured = null,
    Object? amountRefunded = null,
    Object? payment = freezed,
    Object? fulfillment = freezed,
    Object? billingAddressId = freezed,
    Object? shippingAddressId = freezed,
    Object? walletId = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? cancelledAt = freezed,
    Object? completedAt = freezed,
    Object? metadata = freezed,
    Object? note = freezed,
  }) {
    return _then(
      _$OrderImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as OrderStatus,
        orderNumber: freezed == orderNumber
            ? _value.orderNumber
            : orderNumber // ignore: cast_nullable_to_non_nullable
                  as String?,
        externalRef: freezed == externalRef
            ? _value.externalRef
            : externalRef // ignore: cast_nullable_to_non_nullable
                  as String?,
        items: null == items
            ? _value._items
            : items // ignore: cast_nullable_to_non_nullable
                  as List<OrderItem>,
        appliedDiscountCodes: null == appliedDiscountCodes
            ? _value._appliedDiscountCodes
            : appliedDiscountCodes // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        subtotal: null == subtotal
            ? _value.subtotal
            : subtotal // ignore: cast_nullable_to_non_nullable
                  as Money,
        discountTotal: null == discountTotal
            ? _value.discountTotal
            : discountTotal // ignore: cast_nullable_to_non_nullable
                  as Money,
        shippingTotal: null == shippingTotal
            ? _value.shippingTotal
            : shippingTotal // ignore: cast_nullable_to_non_nullable
                  as Money,
        taxTotal: null == taxTotal
            ? _value.taxTotal
            : taxTotal // ignore: cast_nullable_to_non_nullable
                  as Money,
        feesTotal: null == feesTotal
            ? _value.feesTotal
            : feesTotal // ignore: cast_nullable_to_non_nullable
                  as Money,
        grandTotal: null == grandTotal
            ? _value.grandTotal
            : grandTotal // ignore: cast_nullable_to_non_nullable
                  as Money,
        amountAuthorized: null == amountAuthorized
            ? _value.amountAuthorized
            : amountAuthorized // ignore: cast_nullable_to_non_nullable
                  as Money,
        amountCaptured: null == amountCaptured
            ? _value.amountCaptured
            : amountCaptured // ignore: cast_nullable_to_non_nullable
                  as Money,
        amountRefunded: null == amountRefunded
            ? _value.amountRefunded
            : amountRefunded // ignore: cast_nullable_to_non_nullable
                  as Money,
        payment: freezed == payment
            ? _value.payment
            : payment // ignore: cast_nullable_to_non_nullable
                  as PaymentInfo?,
        fulfillment: freezed == fulfillment
            ? _value.fulfillment
            : fulfillment // ignore: cast_nullable_to_non_nullable
                  as FulfillmentInfo?,
        billingAddressId: freezed == billingAddressId
            ? _value.billingAddressId
            : billingAddressId // ignore: cast_nullable_to_non_nullable
                  as String?,
        shippingAddressId: freezed == shippingAddressId
            ? _value.shippingAddressId
            : shippingAddressId // ignore: cast_nullable_to_non_nullable
                  as String?,
        walletId: freezed == walletId
            ? _value.walletId
            : walletId // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        updatedAt: freezed == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        cancelledAt: freezed == cancelledAt
            ? _value.cancelledAt
            : cancelledAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        completedAt: freezed == completedAt
            ? _value.completedAt
            : completedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        metadata: freezed == metadata
            ? _value._metadata
            : metadata // ignore: cast_nullable_to_non_nullable
                  as Map<String, String>?,
        note: freezed == note
            ? _value.note
            : note // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$OrderImpl implements _Order {
  const _$OrderImpl({
    required this.id,
    required this.userId,
    this.status = OrderStatus.pending,
    this.orderNumber,
    this.externalRef,
    final List<OrderItem> items = const <OrderItem>[],
    final List<String> appliedDiscountCodes = const <String>[],
    this.subtotal = const Money(0.0, 'USD'),
    this.discountTotal = const Money(0.0, 'USD'),
    this.shippingTotal = const Money(0.0, 'USD'),
    this.taxTotal = const Money(0.0, 'USD'),
    this.feesTotal = const Money(0.0, 'USD'),
    this.grandTotal = const Money(0.0, 'USD'),
    this.amountAuthorized = const Money(0.0, 'USD'),
    this.amountCaptured = const Money(0.0, 'USD'),
    this.amountRefunded = const Money(0.0, 'USD'),
    this.payment,
    this.fulfillment,
    this.billingAddressId,
    this.shippingAddressId,
    this.walletId,
    this.createdAt,
    this.updatedAt,
    this.cancelledAt,
    this.completedAt,
    final Map<String, String>? metadata,
    this.note,
  }) : _items = items,
       _appliedDiscountCodes = appliedDiscountCodes,
       _metadata = metadata;

  @override
  final String id;
  @override
  final String userId;
  @override
  @JsonKey()
  final OrderStatus status;

  /// Optional external references for integrations.
  @override
  final String? orderNumber;
  // human-facing order code
  @override
  final String? externalRef;
  // ERP/OMS reference
  /// Cart snapshot.
  final List<OrderItem> _items;
  // ERP/OMS reference
  /// Cart snapshot.
  @override
  @JsonKey()
  List<OrderItem> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  /// Discount/coupon codes actually applied at checkout.
  final List<String> _appliedDiscountCodes;

  /// Discount/coupon codes actually applied at checkout.
  @override
  @JsonKey()
  List<String> get appliedDiscountCodes {
    if (_appliedDiscountCodes is EqualUnmodifiableListView)
      return _appliedDiscountCodes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_appliedDiscountCodes);
  }

  /// Totals snapshot (authoritative at the time of purchase).
  @override
  @JsonKey()
  final Money subtotal;
  // sum of line subtotals
  @override
  @JsonKey()
  final Money discountTotal;
  // sum of all discounts
  @override
  @JsonKey()
  final Money shippingTotal;
  @override
  @JsonKey()
  final Money taxTotal;
  @override
  @JsonKey()
  final Money feesTotal;
  // service/handling fees
  @override
  @JsonKey()
  final Money grandTotal;
  // payable: subtotal - discount + shipping + tax + fees
  /// Amounts paid/refunded.
  @override
  @JsonKey()
  final Money amountAuthorized;
  @override
  @JsonKey()
  final Money amountCaptured;
  @override
  @JsonKey()
  final Money amountRefunded;

  /// Payment & fulfillment snapshots.
  @override
  final PaymentInfo? payment;
  @override
  final FulfillmentInfo? fulfillment;

  /// Optional address references (billing/shipping) by ID.
  @override
  final String? billingAddressId;
  @override
  final String? shippingAddressId;

  /// Optional wallet used (by ID) when method == wallet.
  @override
  final String? walletId;

  /// Audit fields.
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final DateTime? cancelledAt;
  @override
  final DateTime? completedAt;

  /// Free-form metadata for integrations/analytics.
  final Map<String, String>? _metadata;

  /// Free-form metadata for integrations/analytics.
  @override
  Map<String, String>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final String? note;

  @override
  String toString() {
    return 'Order(id: $id, userId: $userId, status: $status, orderNumber: $orderNumber, externalRef: $externalRef, items: $items, appliedDiscountCodes: $appliedDiscountCodes, subtotal: $subtotal, discountTotal: $discountTotal, shippingTotal: $shippingTotal, taxTotal: $taxTotal, feesTotal: $feesTotal, grandTotal: $grandTotal, amountAuthorized: $amountAuthorized, amountCaptured: $amountCaptured, amountRefunded: $amountRefunded, payment: $payment, fulfillment: $fulfillment, billingAddressId: $billingAddressId, shippingAddressId: $shippingAddressId, walletId: $walletId, createdAt: $createdAt, updatedAt: $updatedAt, cancelledAt: $cancelledAt, completedAt: $completedAt, metadata: $metadata, note: $note)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.orderNumber, orderNumber) ||
                other.orderNumber == orderNumber) &&
            (identical(other.externalRef, externalRef) ||
                other.externalRef == externalRef) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            const DeepCollectionEquality().equals(
              other._appliedDiscountCodes,
              _appliedDiscountCodes,
            ) &&
            (identical(other.subtotal, subtotal) ||
                other.subtotal == subtotal) &&
            (identical(other.discountTotal, discountTotal) ||
                other.discountTotal == discountTotal) &&
            (identical(other.shippingTotal, shippingTotal) ||
                other.shippingTotal == shippingTotal) &&
            (identical(other.taxTotal, taxTotal) ||
                other.taxTotal == taxTotal) &&
            (identical(other.feesTotal, feesTotal) ||
                other.feesTotal == feesTotal) &&
            (identical(other.grandTotal, grandTotal) ||
                other.grandTotal == grandTotal) &&
            (identical(other.amountAuthorized, amountAuthorized) ||
                other.amountAuthorized == amountAuthorized) &&
            (identical(other.amountCaptured, amountCaptured) ||
                other.amountCaptured == amountCaptured) &&
            (identical(other.amountRefunded, amountRefunded) ||
                other.amountRefunded == amountRefunded) &&
            (identical(other.payment, payment) || other.payment == payment) &&
            (identical(other.fulfillment, fulfillment) ||
                other.fulfillment == fulfillment) &&
            (identical(other.billingAddressId, billingAddressId) ||
                other.billingAddressId == billingAddressId) &&
            (identical(other.shippingAddressId, shippingAddressId) ||
                other.shippingAddressId == shippingAddressId) &&
            (identical(other.walletId, walletId) ||
                other.walletId == walletId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.cancelledAt, cancelledAt) ||
                other.cancelledAt == cancelledAt) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata) &&
            (identical(other.note, note) || other.note == note));
  }

  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    userId,
    status,
    orderNumber,
    externalRef,
    const DeepCollectionEquality().hash(_items),
    const DeepCollectionEquality().hash(_appliedDiscountCodes),
    subtotal,
    discountTotal,
    shippingTotal,
    taxTotal,
    feesTotal,
    grandTotal,
    amountAuthorized,
    amountCaptured,
    amountRefunded,
    payment,
    fulfillment,
    billingAddressId,
    shippingAddressId,
    walletId,
    createdAt,
    updatedAt,
    cancelledAt,
    completedAt,
    const DeepCollectionEquality().hash(_metadata),
    note,
  ]);

  /// Create a copy of Order
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderImplCopyWith<_$OrderImpl> get copyWith =>
      __$$OrderImplCopyWithImpl<_$OrderImpl>(this, _$identity);
}

abstract class _Order implements Order {
  const factory _Order({
    required final String id,
    required final String userId,
    final OrderStatus status,
    final String? orderNumber,
    final String? externalRef,
    final List<OrderItem> items,
    final List<String> appliedDiscountCodes,
    final Money subtotal,
    final Money discountTotal,
    final Money shippingTotal,
    final Money taxTotal,
    final Money feesTotal,
    final Money grandTotal,
    final Money amountAuthorized,
    final Money amountCaptured,
    final Money amountRefunded,
    final PaymentInfo? payment,
    final FulfillmentInfo? fulfillment,
    final String? billingAddressId,
    final String? shippingAddressId,
    final String? walletId,
    final DateTime? createdAt,
    final DateTime? updatedAt,
    final DateTime? cancelledAt,
    final DateTime? completedAt,
    final Map<String, String>? metadata,
    final String? note,
  }) = _$OrderImpl;

  @override
  String get id;
  @override
  String get userId;
  @override
  OrderStatus get status;

  /// Optional external references for integrations.
  @override
  String? get orderNumber; // human-facing order code
  @override
  String? get externalRef; // ERP/OMS reference
  /// Cart snapshot.
  @override
  List<OrderItem> get items;

  /// Discount/coupon codes actually applied at checkout.
  @override
  List<String> get appliedDiscountCodes;

  /// Totals snapshot (authoritative at the time of purchase).
  @override
  Money get subtotal; // sum of line subtotals
  @override
  Money get discountTotal; // sum of all discounts
  @override
  Money get shippingTotal;
  @override
  Money get taxTotal;
  @override
  Money get feesTotal; // service/handling fees
  @override
  Money get grandTotal; // payable: subtotal - discount + shipping + tax + fees
  /// Amounts paid/refunded.
  @override
  Money get amountAuthorized;
  @override
  Money get amountCaptured;
  @override
  Money get amountRefunded;

  /// Payment & fulfillment snapshots.
  @override
  PaymentInfo? get payment;
  @override
  FulfillmentInfo? get fulfillment;

  /// Optional address references (billing/shipping) by ID.
  @override
  String? get billingAddressId;
  @override
  String? get shippingAddressId;

  /// Optional wallet used (by ID) when method == wallet.
  @override
  String? get walletId;

  /// Audit fields.
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  DateTime? get cancelledAt;
  @override
  DateTime? get completedAt;

  /// Free-form metadata for integrations/analytics.
  @override
  Map<String, String>? get metadata;
  @override
  String? get note;

  /// Create a copy of Order
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderImplCopyWith<_$OrderImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
