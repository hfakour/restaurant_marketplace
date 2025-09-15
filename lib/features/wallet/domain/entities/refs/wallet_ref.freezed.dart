// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wallet_ref.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$WalletRef {
  String get walletId => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  double? get balanceSnapshot =>
      throw _privateConstructorUsedError; // UI-only; not authoritative
  String? get currencyCode => throw _privateConstructorUsedError;
  DateTime? get snapshotAt => throw _privateConstructorUsedError;

  /// Create a copy of WalletRef
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WalletRefCopyWith<WalletRef> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WalletRefCopyWith<$Res> {
  factory $WalletRefCopyWith(WalletRef value, $Res Function(WalletRef) then) =
      _$WalletRefCopyWithImpl<$Res, WalletRef>;
  @useResult
  $Res call({
    String walletId,
    bool isActive,
    double? balanceSnapshot,
    String? currencyCode,
    DateTime? snapshotAt,
  });
}

/// @nodoc
class _$WalletRefCopyWithImpl<$Res, $Val extends WalletRef>
    implements $WalletRefCopyWith<$Res> {
  _$WalletRefCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WalletRef
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? walletId = null,
    Object? isActive = null,
    Object? balanceSnapshot = freezed,
    Object? currencyCode = freezed,
    Object? snapshotAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            walletId: null == walletId
                ? _value.walletId
                : walletId // ignore: cast_nullable_to_non_nullable
                      as String,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
            balanceSnapshot: freezed == balanceSnapshot
                ? _value.balanceSnapshot
                : balanceSnapshot // ignore: cast_nullable_to_non_nullable
                      as double?,
            currencyCode: freezed == currencyCode
                ? _value.currencyCode
                : currencyCode // ignore: cast_nullable_to_non_nullable
                      as String?,
            snapshotAt: freezed == snapshotAt
                ? _value.snapshotAt
                : snapshotAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$WalletRefImplCopyWith<$Res>
    implements $WalletRefCopyWith<$Res> {
  factory _$$WalletRefImplCopyWith(
    _$WalletRefImpl value,
    $Res Function(_$WalletRefImpl) then,
  ) = __$$WalletRefImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String walletId,
    bool isActive,
    double? balanceSnapshot,
    String? currencyCode,
    DateTime? snapshotAt,
  });
}

/// @nodoc
class __$$WalletRefImplCopyWithImpl<$Res>
    extends _$WalletRefCopyWithImpl<$Res, _$WalletRefImpl>
    implements _$$WalletRefImplCopyWith<$Res> {
  __$$WalletRefImplCopyWithImpl(
    _$WalletRefImpl _value,
    $Res Function(_$WalletRefImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WalletRef
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? walletId = null,
    Object? isActive = null,
    Object? balanceSnapshot = freezed,
    Object? currencyCode = freezed,
    Object? snapshotAt = freezed,
  }) {
    return _then(
      _$WalletRefImpl(
        walletId: null == walletId
            ? _value.walletId
            : walletId // ignore: cast_nullable_to_non_nullable
                  as String,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
        balanceSnapshot: freezed == balanceSnapshot
            ? _value.balanceSnapshot
            : balanceSnapshot // ignore: cast_nullable_to_non_nullable
                  as double?,
        currencyCode: freezed == currencyCode
            ? _value.currencyCode
            : currencyCode // ignore: cast_nullable_to_non_nullable
                  as String?,
        snapshotAt: freezed == snapshotAt
            ? _value.snapshotAt
            : snapshotAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc

class _$WalletRefImpl implements _WalletRef {
  const _$WalletRefImpl({
    required this.walletId,
    this.isActive = false,
    this.balanceSnapshot,
    this.currencyCode,
    this.snapshotAt,
  });

  @override
  final String walletId;
  @override
  @JsonKey()
  final bool isActive;
  @override
  final double? balanceSnapshot;
  // UI-only; not authoritative
  @override
  final String? currencyCode;
  @override
  final DateTime? snapshotAt;

  @override
  String toString() {
    return 'WalletRef(walletId: $walletId, isActive: $isActive, balanceSnapshot: $balanceSnapshot, currencyCode: $currencyCode, snapshotAt: $snapshotAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WalletRefImpl &&
            (identical(other.walletId, walletId) ||
                other.walletId == walletId) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.balanceSnapshot, balanceSnapshot) ||
                other.balanceSnapshot == balanceSnapshot) &&
            (identical(other.currencyCode, currencyCode) ||
                other.currencyCode == currencyCode) &&
            (identical(other.snapshotAt, snapshotAt) ||
                other.snapshotAt == snapshotAt));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    walletId,
    isActive,
    balanceSnapshot,
    currencyCode,
    snapshotAt,
  );

  /// Create a copy of WalletRef
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WalletRefImplCopyWith<_$WalletRefImpl> get copyWith =>
      __$$WalletRefImplCopyWithImpl<_$WalletRefImpl>(this, _$identity);
}

abstract class _WalletRef implements WalletRef {
  const factory _WalletRef({
    required final String walletId,
    final bool isActive,
    final double? balanceSnapshot,
    final String? currencyCode,
    final DateTime? snapshotAt,
  }) = _$WalletRefImpl;

  @override
  String get walletId;
  @override
  bool get isActive;
  @override
  double? get balanceSnapshot; // UI-only; not authoritative
  @override
  String? get currencyCode;
  @override
  DateTime? get snapshotAt;

  /// Create a copy of WalletRef
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WalletRefImplCopyWith<_$WalletRefImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
