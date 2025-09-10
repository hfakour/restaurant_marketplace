// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'menu_ref.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$MenuRef {
  String get menuId => throw _privateConstructorUsedError;
  String? get titleSnapshot =>
      throw _privateConstructorUsedError; // e.g., "Lunch Menu"
  String? get coverUrlSnapshot =>
      throw _privateConstructorUsedError; // optional image
  bool get isActive => throw _privateConstructorUsedError;

  /// Create a copy of MenuRef
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MenuRefCopyWith<MenuRef> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MenuRefCopyWith<$Res> {
  factory $MenuRefCopyWith(MenuRef value, $Res Function(MenuRef) then) =
      _$MenuRefCopyWithImpl<$Res, MenuRef>;
  @useResult
  $Res call({
    String menuId,
    String? titleSnapshot,
    String? coverUrlSnapshot,
    bool isActive,
  });
}

/// @nodoc
class _$MenuRefCopyWithImpl<$Res, $Val extends MenuRef>
    implements $MenuRefCopyWith<$Res> {
  _$MenuRefCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MenuRef
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? menuId = null,
    Object? titleSnapshot = freezed,
    Object? coverUrlSnapshot = freezed,
    Object? isActive = null,
  }) {
    return _then(
      _value.copyWith(
            menuId: null == menuId
                ? _value.menuId
                : menuId // ignore: cast_nullable_to_non_nullable
                      as String,
            titleSnapshot: freezed == titleSnapshot
                ? _value.titleSnapshot
                : titleSnapshot // ignore: cast_nullable_to_non_nullable
                      as String?,
            coverUrlSnapshot: freezed == coverUrlSnapshot
                ? _value.coverUrlSnapshot
                : coverUrlSnapshot // ignore: cast_nullable_to_non_nullable
                      as String?,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MenuRefImplCopyWith<$Res> implements $MenuRefCopyWith<$Res> {
  factory _$$MenuRefImplCopyWith(
    _$MenuRefImpl value,
    $Res Function(_$MenuRefImpl) then,
  ) = __$$MenuRefImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String menuId,
    String? titleSnapshot,
    String? coverUrlSnapshot,
    bool isActive,
  });
}

/// @nodoc
class __$$MenuRefImplCopyWithImpl<$Res>
    extends _$MenuRefCopyWithImpl<$Res, _$MenuRefImpl>
    implements _$$MenuRefImplCopyWith<$Res> {
  __$$MenuRefImplCopyWithImpl(
    _$MenuRefImpl _value,
    $Res Function(_$MenuRefImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MenuRef
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? menuId = null,
    Object? titleSnapshot = freezed,
    Object? coverUrlSnapshot = freezed,
    Object? isActive = null,
  }) {
    return _then(
      _$MenuRefImpl(
        menuId: null == menuId
            ? _value.menuId
            : menuId // ignore: cast_nullable_to_non_nullable
                  as String,
        titleSnapshot: freezed == titleSnapshot
            ? _value.titleSnapshot
            : titleSnapshot // ignore: cast_nullable_to_non_nullable
                  as String?,
        coverUrlSnapshot: freezed == coverUrlSnapshot
            ? _value.coverUrlSnapshot
            : coverUrlSnapshot // ignore: cast_nullable_to_non_nullable
                  as String?,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$MenuRefImpl implements _MenuRef {
  const _$MenuRefImpl({
    required this.menuId,
    this.titleSnapshot,
    this.coverUrlSnapshot,
    this.isActive = false,
  });

  @override
  final String menuId;
  @override
  final String? titleSnapshot;
  // e.g., "Lunch Menu"
  @override
  final String? coverUrlSnapshot;
  // optional image
  @override
  @JsonKey()
  final bool isActive;

  @override
  String toString() {
    return 'MenuRef(menuId: $menuId, titleSnapshot: $titleSnapshot, coverUrlSnapshot: $coverUrlSnapshot, isActive: $isActive)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MenuRefImpl &&
            (identical(other.menuId, menuId) || other.menuId == menuId) &&
            (identical(other.titleSnapshot, titleSnapshot) ||
                other.titleSnapshot == titleSnapshot) &&
            (identical(other.coverUrlSnapshot, coverUrlSnapshot) ||
                other.coverUrlSnapshot == coverUrlSnapshot) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    menuId,
    titleSnapshot,
    coverUrlSnapshot,
    isActive,
  );

  /// Create a copy of MenuRef
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MenuRefImplCopyWith<_$MenuRefImpl> get copyWith =>
      __$$MenuRefImplCopyWithImpl<_$MenuRefImpl>(this, _$identity);
}

abstract class _MenuRef implements MenuRef {
  const factory _MenuRef({
    required final String menuId,
    final String? titleSnapshot,
    final String? coverUrlSnapshot,
    final bool isActive,
  }) = _$MenuRefImpl;

  @override
  String get menuId;
  @override
  String? get titleSnapshot; // e.g., "Lunch Menu"
  @override
  String? get coverUrlSnapshot; // optional image
  @override
  bool get isActive;

  /// Create a copy of MenuRef
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MenuRefImplCopyWith<_$MenuRefImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
