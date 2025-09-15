// domain/entities/restaurant.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:restaurant_marketplace/core/domain_refs/domain_refs.dart';

import '../../../menu/domain/entities/refs/menu_ref.dart';
import '../../../reviews/domain/entities/refs/review_ref.dart';

part 'restaurant.freezed.dart';

@freezed
class Restaurant with _$Restaurant {
  const factory Restaurant({
    required String id,

    // Identity
    required String name,
    String? description,
    String? contactNumber,
    String? email,

    // Location (public address only)
    AddressRef? addressRef,

    // Media
    String? logoUrl,
    String? coverUrl,
    @Default(<String>[]) List<String> galleryUrls,

    // Cross-feature refs (user-facing)
    @Default(<MenuRef>[]) List<MenuRef> menuRefs,
    @Default(<ReservationRef>[]) List<ReservationRef> reservationRefs,
    @Default(<OrderRef>[]) List<OrderRef> orderRefs,
    @Default(<ReviewRef>[]) List<ReviewRef> reviewRefs,

    // Taxonomy / tags
    @Default(<String>[]) List<String> cuisines, // e.g., ["Italian", "Vegan"]

    // Ratings / aggregates
    double? averageRating, // 0..5
    @Default(0) int ratingsCount,

    // Auditing
    DateTime? createdAt,
    DateTime? updatedAt,

    // Extra metadata (safe by design)
    @Default(<String, dynamic>{}) Map<String, dynamic> metadata,
  }) = _Restaurant;
}
