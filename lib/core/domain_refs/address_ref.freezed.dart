// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'address_ref.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$AddressRef {
  String get addressId => throw _privateConstructorUsedError;
  String? get labelSnapshot => throw _privateConstructorUsedError;
  bool get isDefault => throw _privateConstructorUsedError;

  /// Create a copy of AddressRef
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AddressRefCopyWith<AddressRef> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddressRefCopyWith<$Res> {
  factory $AddressRefCopyWith(
    AddressRef value,
    $Res Function(AddressRef) then,
  ) = _$AddressRefCopyWithImpl<$Res, AddressRef>;
  @useResult
  $Res call({String addressId, String? labelSnapshot, bool isDefault});
}

/// @nodoc
class _$AddressRefCopyWithImpl<$Res, $Val extends AddressRef>
    implements $AddressRefCopyWith<$Res> {
  _$AddressRefCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AddressRef
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? addressId = null,
    Object? labelSnapshot = freezed,
    Object? isDefault = null,
  }) {
    return _then(
      _value.copyWith(
            addressId: null == addressId
                ? _value.addressId
                : addressId // ignore: cast_nullable_to_non_nullable
                      as String,
            labelSnapshot: freezed == labelSnapshot
                ? _value.labelSnapshot
                : labelSnapshot // ignore: cast_nullable_to_non_nullable
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
abstract class _$$AddressRefImplCopyWith<$Res>
    implements $AddressRefCopyWith<$Res> {
  factory _$$AddressRefImplCopyWith(
    _$AddressRefImpl value,
    $Res Function(_$AddressRefImpl) then,
  ) = __$$AddressRefImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String addressId, String? labelSnapshot, bool isDefault});
}

/// @nodoc
class __$$AddressRefImplCopyWithImpl<$Res>
    extends _$AddressRefCopyWithImpl<$Res, _$AddressRefImpl>
    implements _$$AddressRefImplCopyWith<$Res> {
  __$$AddressRefImplCopyWithImpl(
    _$AddressRefImpl _value,
    $Res Function(_$AddressRefImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AddressRef
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? addressId = null,
    Object? labelSnapshot = freezed,
    Object? isDefault = null,
  }) {
    return _then(
      _$AddressRefImpl(
        addressId: null == addressId
            ? _value.addressId
            : addressId // ignore: cast_nullable_to_non_nullable
                  as String,
        labelSnapshot: freezed == labelSnapshot
            ? _value.labelSnapshot
            : labelSnapshot // ignore: cast_nullable_to_non_nullable
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

class _$AddressRefImpl implements _AddressRef {
  const _$AddressRefImpl({
    required this.addressId,
    this.labelSnapshot,
    this.isDefault = false,
  });

  @override
  final String addressId;
  @override
  final String? labelSnapshot;
  @override
  @JsonKey()
  final bool isDefault;

  @override
  String toString() {
    return 'AddressRef(addressId: $addressId, labelSnapshot: $labelSnapshot, isDefault: $isDefault)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddressRefImpl &&
            (identical(other.addressId, addressId) ||
                other.addressId == addressId) &&
            (identical(other.labelSnapshot, labelSnapshot) ||
                other.labelSnapshot == labelSnapshot) &&
            (identical(other.isDefault, isDefault) ||
                other.isDefault == isDefault));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, addressId, labelSnapshot, isDefault);

  /// Create a copy of AddressRef
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddressRefImplCopyWith<_$AddressRefImpl> get copyWith =>
      __$$AddressRefImplCopyWithImpl<_$AddressRefImpl>(this, _$identity);
}

abstract class _AddressRef implements AddressRef {
  const factory _AddressRef({
    required final String addressId,
    final String? labelSnapshot,
    final bool isDefault,
  }) = _$AddressRefImpl;

  @override
  String get addressId;
  @override
  String? get labelSnapshot;
  @override
  bool get isDefault;

  /// Create a copy of AddressRef
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddressRefImplCopyWith<_$AddressRefImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
