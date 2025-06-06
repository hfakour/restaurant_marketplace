import '../../restaurant_detail/model/review.dart';
import '../model/food.dart';

// You may want to import FoodReview or Review depending on your model
final mockFood = Food(
  id: '1',
  name: 'Grilled Chicken Salad',
  description: 'Enjoy a rich blend of seasoned grilled chicken, arugula, baby greens, and a gourmet vinaigrette.',
  originalPrice: 24.99,
  discountPercentage: 20,
  imageUrl: 'https://images.unsplash.com/photo-1600891964599-f61ba0e24092',
  category: 'Main Course',
  tags: ['Halal', 'Organic', 'Gluten-Free', '🌶️ Medium Spicy'],
  ingredients: ['Chicken', 'Arugula', 'Greens', 'Vinaigrette'],
  allergens: ['🥜', '🌾', '🥛'],
  rating: 4.8,
  reviewsCount: 142,
  vendorName: 'Gourmet Bistro',
  vendorLocation: 'Downtown Branch',
  vendorImage: 'https://images.unsplash.com/photo-1555396273-367ea4eb4db5',
  reviews: [
    Review(name: 'Amelia W.', comment: 'Absolutely divine! Perfect texture.', rating: 5),
    Review(name: 'Lucas M.', comment: 'Flavors were excellent, will reorder.', rating: 4.5),
  ],
);
