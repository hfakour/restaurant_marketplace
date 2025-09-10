// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'review_ref.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ReviewRef {
  String get reviewId => throw _privateConstructorUsedError;
  String? get userIdSnapshot =>
      throw _privateConstructorUsedError; // reviewer id
  int? get ratingSnapshot => throw _privateConstructorUsedError; // 1..5
  String? get commentSnapshot =>
      throw _privateConstructorUsedError; // short text
  DateTime? get createdAtSnapshot => throw _privateConstructorUsedError;

  /// Create a copy of ReviewRef
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReviewRefCopyWith<ReviewRef> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReviewRefCopyWith<$Res> {
  factory $ReviewRefCopyWith(ReviewRef value, $Res Function(ReviewRef) then) =
      _$ReviewRefCopyWithImpl<$Res, ReviewRef>;
  @useResult
  $Res call({
    String reviewId,
    String? userIdSnapshot,
    int? ratingSnapshot,
    String? commentSnapshot,
    DateTime? createdAtSnapshot,
  });
}

/// @nodoc
class _$ReviewRefCopyWithImpl<$Res, $Val extends ReviewRef>
    implements $ReviewRefCopyWith<$Res> {
  _$ReviewRefCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReviewRef
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reviewId = null,
    Object? userIdSnapshot = freezed,
    Object? ratingSnapshot = freezed,
    Object? commentSnapshot = freezed,
    Object? createdAtSnapshot = freezed,
  }) {
    return _then(
      _value.copyWith(
            reviewId: null == reviewId
                ? _value.reviewId
                : reviewId // ignore: cast_nullable_to_non_nullable
                      as String,
            userIdSnapshot: freezed == userIdSnapshot
                ? _value.userIdSnapshot
                : userIdSnapshot // ignore: cast_nullable_to_non_nullable
                      as String?,
            ratingSnapshot: freezed == ratingSnapshot
                ? _value.ratingSnapshot
                : ratingSnapshot // ignore: cast_nullable_to_non_nullable
                      as int?,
            commentSnapshot: freezed == commentSnapshot
                ? _value.commentSnapshot
                : commentSnapshot // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAtSnapshot: freezed == createdAtSnapshot
                ? _value.createdAtSnapshot
                : createdAtSnapshot // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ReviewRefImplCopyWith<$Res>
    implements $ReviewRefCopyWith<$Res> {
  factory _$$ReviewRefImplCopyWith(
    _$ReviewRefImpl value,
    $Res Function(_$ReviewRefImpl) then,
  ) = __$$ReviewRefImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String reviewId,
    String? userIdSnapshot,
    int? ratingSnapshot,
    String? commentSnapshot,
    DateTime? createdAtSnapshot,
  });
}

/// @nodoc
class __$$ReviewRefImplCopyWithImpl<$Res>
    extends _$ReviewRefCopyWithImpl<$Res, _$ReviewRefImpl>
    implements _$$ReviewRefImplCopyWith<$Res> {
  __$$ReviewRefImplCopyWithImpl(
    _$ReviewRefImpl _value,
    $Res Function(_$ReviewRefImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ReviewRef
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reviewId = null,
    Object? userIdSnapshot = freezed,
    Object? ratingSnapshot = freezed,
    Object? commentSnapshot = freezed,
    Object? createdAtSnapshot = freezed,
  }) {
    return _then(
      _$ReviewRefImpl(
        reviewId: null == reviewId
            ? _value.reviewId
            : reviewId // ignore: cast_nullable_to_non_nullable
                  as String,
        userIdSnapshot: freezed == userIdSnapshot
            ? _value.userIdSnapshot
            : userIdSnapshot // ignore: cast_nullable_to_non_nullable
                  as String?,
        ratingSnapshot: freezed == ratingSnapshot
            ? _value.ratingSnapshot
            : ratingSnapshot // ignore: cast_nullable_to_non_nullable
                  as int?,
        commentSnapshot: freezed == commentSnapshot
            ? _value.commentSnapshot
            : commentSnapshot // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAtSnapshot: freezed == createdAtSnapshot
            ? _value.createdAtSnapshot
            : createdAtSnapshot // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc

class _$ReviewRefImpl implements _ReviewRef {
  const _$ReviewRefImpl({
    required this.reviewId,
    this.userIdSnapshot,
    this.ratingSnapshot,
    this.commentSnapshot,
    this.createdAtSnapshot,
  });

  @override
  final String reviewId;
  @override
  final String? userIdSnapshot;
  // reviewer id
  @override
  final int? ratingSnapshot;
  // 1..5
  @override
  final String? commentSnapshot;
  // short text
  @override
  final DateTime? createdAtSnapshot;

  @override
  String toString() {
    return 'ReviewRef(reviewId: $reviewId, userIdSnapshot: $userIdSnapshot, ratingSnapshot: $ratingSnapshot, commentSnapshot: $commentSnapshot, createdAtSnapshot: $createdAtSnapshot)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReviewRefImpl &&
            (identical(other.reviewId, reviewId) ||
                other.reviewId == reviewId) &&
            (identical(other.userIdSnapshot, userIdSnapshot) ||
                other.userIdSnapshot == userIdSnapshot) &&
            (identical(other.ratingSnapshot, ratingSnapshot) ||
                other.ratingSnapshot == ratingSnapshot) &&
            (identical(other.commentSnapshot, commentSnapshot) ||
                other.commentSnapshot == commentSnapshot) &&
            (identical(other.createdAtSnapshot, createdAtSnapshot) ||
                other.createdAtSnapshot == createdAtSnapshot));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    reviewId,
    userIdSnapshot,
    ratingSnapshot,
    commentSnapshot,
    createdAtSnapshot,
  );

  /// Create a copy of ReviewRef
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReviewRefImplCopyWith<_$ReviewRefImpl> get copyWith =>
      __$$ReviewRefImplCopyWithImpl<_$ReviewRefImpl>(this, _$identity);
}

abstract class _ReviewRef implements ReviewRef {
  const factory _ReviewRef({
    required final String reviewId,
    final String? userIdSnapshot,
    final int? ratingSnapshot,
    final String? commentSnapshot,
    final DateTime? createdAtSnapshot,
  }) = _$ReviewRefImpl;

  @override
  String get reviewId;
  @override
  String? get userIdSnapshot; // reviewer id
  @override
  int? get ratingSnapshot; // 1..5
  @override
  String? get commentSnapshot; // short text
  @override
  DateTime? get createdAtSnapshot;

  /// Create a copy of ReviewRef
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReviewRefImplCopyWith<_$ReviewRefImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
