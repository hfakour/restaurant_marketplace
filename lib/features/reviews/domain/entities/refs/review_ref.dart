import 'package:freezed_annotation/freezed_annotation.dart';

part 'review_ref.freezed.dart';

@freezed
class ReviewRef with _$ReviewRef {
  const factory ReviewRef({
    required String reviewId,
    String? userIdSnapshot,       // reviewer id
    int? ratingSnapshot,          // 1..5
    String? commentSnapshot,      // short text
    DateTime? createdAtSnapshot,
  }) = _ReviewRef;
}
