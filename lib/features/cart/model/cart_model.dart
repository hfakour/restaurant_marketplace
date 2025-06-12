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

// Example/mock data for demo purposes
final mockCart = [
  CartItem(
    name: 'Grilled Chicken Salad',
    restaurant: 'Gourmet Bistro',
    imageUrl: 'https://www.starbaal.com/uploads/posts/dfdf5d.jpg?m=thumb&w=800&h=600&q=high',
    price: 19.99,
    quantity: 2,
    tags: ['Gluten-Free', 'Medium Spicy', 'Low Carb', 'High Protein', 'Vegan', 'Dairy Free'],
  ),
  CartItem(
    name: 'Vegan Avocado Toast',
    restaurant: 'Green Eats',
    imageUrl: 'https://www.starbaal.com/uploads/posts/dfdf5d.jpg?m=thumb&w=800&h=600&q=high',
    price: 12.50,
    quantity: 1,
    tags: ['Vegan', 'Organic'],
  ),
];
