import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:restaurant_marketplace/features/food_detail/model/vendor.dart';
import 'review.dart';
part 'food.freezed.dart';
part 'food.g.dart';

@freezed
class Food with _$Food {
  const factory Food({
    required String id,
    required String name,
    required String restaurantId,
    required String description,
    required double originalPrice,
    required double discountPercentage,
    required String imageUrl,
    required String category,
    required List<String> tags,
    required List<String> ingredients,
    required List<String> allergens,
    required double rating,
    required int reviewsCount,
    required Vendor vendor,
    @Default([]) List<Review> reviews,
  }) = _Food;

  factory Food.fromJson(Map<String, dynamic> json) => _$FoodFromJson(json);
}

