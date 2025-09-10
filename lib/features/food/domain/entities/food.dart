// domain/entities/food.dart
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/domain_refs/review_ref.dart';

part 'food.freezed.dart';

@freezed
class Food with _$Food {
  const factory Food({
    required String id,

    // Ownership
    required String restaurantId,

    // Identity
    required String name,
    String? description,

    // Pricing (simple; keep in cents to avoid double rounding issues)
    int? priceCents,            // e.g., 1299 for $12.99
    String? currencyCode,       // e.g., "USD"

    // Media
    String? imageUrl,
    @Default(<String>[]) List<String> galleryUrls,

    // Tags & dietary information
    @Default(<String>[]) List<String> tags,       // e.g., ["Spicy", "Popular", "Lunch"]
    @Default(<String>[]) List<String> allergens,  // e.g., ["Peanuts", "Dairy"]

    // Reviews (user-facing, lightweight)
    @Default(<ReviewRef>[]) List<ReviewRef> reviewRefs,

    // Ratings / aggregates (user-facing)
    double? averageRating,      // 0..5
    @Default(0) int ratingsCount,

    // Availability (user-facing)
    @Default(true) bool isAvailable,

    // Auditing
    DateTime? createdAt,
    DateTime? updatedAt,

    // Extra metadata (safe by design)
    @Default(<String, dynamic>{}) Map<String, dynamic> metadata,
  }) = _Food;
}
