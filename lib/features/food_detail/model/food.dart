class Food {
  final String id;
  final String name;
  final String description;
  final double originalPrice;
  final double discountPercentage;
  final String imageUrl;
  final String category;
  final List<String> tags;
  final List<String> ingredients;
  final List<String> allergens;
  final double rating;
  final int reviewsCount;
  final String vendorName;
  final String vendorLocation;
  final String vendorImage;
  final List<FoodReview> reviews;

  Food({
    required this.id,
    required this.name,
    required this.description,
    required this.originalPrice,
    required this.discountPercentage,
    required this.imageUrl,
    required this.category,
    required this.tags,
    required this.ingredients,
    required this.allergens,
    required this.rating,
    required this.reviewsCount,
    required this.vendorName,
    required this.vendorLocation,
    required this.vendorImage,
    required this.reviews,
  });

  double get discountedPrice => originalPrice * (1 - discountPercentage / 100);
}

class FoodReview {
  final String name;
  final String comment;
  final double rating;

  FoodReview({required this.name, required this.comment, required this.rating});
}
