// cart/cart_model.dart
// Cart item model and mock data for development/testing.

class CartItem {
  final String name;
  final String restaurant;
  final String imageUrl;
  final double price;
  final int quantity;
  final List<String> tags;

  CartItem({
    required this.name,
    required this.restaurant,
    required this.imageUrl,
    required this.price,
    required this.quantity,
    this.tags = const [],
  });
}


