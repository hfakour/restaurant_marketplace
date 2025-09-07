// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payment_method_ref.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$PaymentMethodRef {
  String get paymentMethodId =>
      throw _privateConstructorUsedError; // e.g., pm_... from PSP
  String? get brand =>
      throw _privateConstructorUsedError; // "visa", "mastercard", etc.
  String? get last4 => throw _privateConstructorUsedError; // safe for display
  bool get isDefault => throw _privateConstructorUsedError;

  /// Create a copy of PaymentMethodRef
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PaymentMethodRefCopyWith<PaymentMethodRef> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaymentMethodRefCopyWith<$Res> {
  factory $PaymentMethodRefCopyWith(
    PaymentMethodRef value,
    $Res Function(PaymentMethodRef) then,
  ) = _$PaymentMethodRefCopyWithImpl<$Res, PaymentMethodRef>;
  @useResult
  $Res call({
    String paymentMethodId,
    String? brand,
    String? last4,
    bool isDefault,
  });
}

/// @nodoc
class _$PaymentMethodRefCopyWithImpl<$Res, $Val extends PaymentMethodRef>
    implements $PaymentMethodRefCopyWith<$Res> {
  _$PaymentMethodRefCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PaymentMethodRef
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? paymentMethodId = null,
    Object? brand = freezed,
    Object? last4 = freezed,
    Object? isDefault = null,
  }) {
    return _then(
      _value.copyWith(
            paymentMethodId: null == paymentMethodId
                ? _value.paymentMethodId
                : paymentMethodId // ignore: cast_nullable_to_non_nullable
                      as String,
            brand: freezed == brand
                ? _value.brand
                : brand // ignore: cast_nullable_to_non_nullable
                      as String?,
            last4: freezed == last4
                ? _value.last4
                : last4 // ignore: cast_nullable_to_non_nullable
                      as String?,
            isDefault: null == isDefault
                ? _value.isDefault
                : isDefault // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PaymentMethodRefImplCopyWith<$Res>
    implements $PaymentMethodRefCopyWith<$Res> {
  factory _$$PaymentMethodRefImplCopyWith(
    _$PaymentMethodRefImpl value,
    $Res Function(_$PaymentMethodRefImpl) then,
  ) = __$$PaymentMethodRefImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String paymentMethodId,
    String? brand,
    String? last4,
    bool isDefault,
  });
}

/// @nodoc
class __$$PaymentMethodRefImplCopyWithImpl<$Res>
    extends _$PaymentMethodRefCopyWithImpl<$Res, _$PaymentMethodRefImpl>
    implements _$$PaymentMethodRefImplCopyWith<$Res> {
  __$$PaymentMethodRefImplCopyWithImpl(
    _$PaymentMethodRefImpl _value,
    $Res Function(_$PaymentMethodRefImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PaymentMethodRef
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? paymentMethodId = null,
    Object? brand = freezed,
    Object? last4 = freezed,
    Object? isDefault = null,
  }) {
    return _then(
      _$PaymentMethodRefImpl(
        paymentMethodId: null == paymentMethodId
            ? _value.paymentMethodId
            : paymentMethodId // ignore: cast_nullable_to_non_nullable
                  as String,
        brand: freezed == brand
            ? _value.brand
            : brand // ignore: cast_nullable_to_non_nullable
                  as String?,
        last4: freezed == last4
            ? _value.last4
            : last4 // ignore: cast_nullable_to_non_nullable
                  as String?,
        isDefault: null == isDefault
            ? _value.isDefault
            : isDefault // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$PaymentMethodRefImpl implements _PaymentMethodRef {
  const _$PaymentMethodRefImpl({
    required this.paymentMethodId,
    this.brand,
    this.last4,
    this.isDefault = false,
  });

  @override
  final String paymentMethodId;
  // e.g., pm_... from PSP
  @override
  final String? brand;
  // "visa", "mastercard", etc.
  @override
  final String? last4;
  // safe for display
  @override
  @JsonKey()
  final bool isDefault;

  @override
  String toString() {
    return 'PaymentMethodRef(paymentMethodId: $paymentMethodId, brand: $brand, last4: $last4, isDefault: $isDefault)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaymentMethodRefImpl &&
            (identical(other.paymentMethodId, paymentMethodId) ||
                other.paymentMethodId == paymentMethodId) &&
            (identical(other.brand, brand) || other.brand == brand) &&
            (identical(other.last4, last4) || other.last4 == last4) &&
            (identical(other.isDefault, isDefault) ||
                other.isDefault == isDefault));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, paymentMethodId, brand, last4, isDefault);

  /// Create a copy of PaymentMethodRef
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PaymentMethodRefImplCopyWith<_$PaymentMethodRefImpl> get copyWith =>
      __$$PaymentMethodRefImplCopyWithImpl<_$PaymentMethodRefImpl>(
        this,
        _$identity,
      );
}

abstract class _PaymentMethodRef implements PaymentMethodRef {
  const factory _PaymentMethodRef({
    required final String paymentMethodId,
    final String? brand,
    final String? last4,
    final bool isDefault,
  }) = _$PaymentMethodRefImpl;

  @override
  String get paymentMethodId; // e.g., pm_... from PSP
  @override
  String? get brand; // "visa", "mastercard", etc.
  @override
  String? get last4; // safe for display
  @override
  bool get isDefault;

  /// Create a copy of PaymentMethodRef
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaymentMethodRefImplCopyWith<_$PaymentMethodRefImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
