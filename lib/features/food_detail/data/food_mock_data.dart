import '../model/food.dart';
import '../model/review.dart';
import '../model/vendor.dart';

final mockVendor = Vendor(
  id: "1",
  name: 'Gourmet Bistro',
  location: 'Downtown Branch',
  image: 'https://images.unsplash.com/photo-1555396273-367ea4eb4db5',
);

final mockReviews = [
  Review(
    userName: 'Amelia W.',
    comment: 'Absolutely divine! Perfect texture.',
    rating: 5,
    userAvatar: 'https://randomuser.me/api/portraits/women/1.jpg',
    createdAt: DateTime(2024, 5, 2, 12, 45),
  ),
  Review(
    userName: 'Lucas M.',
    comment: 'Flavors were excellent, will reorder.',
    rating: 4.5,
    userAvatar: 'https://randomuser.me/api/portraits/men/2.jpg',
    createdAt: DateTime(2024, 5, 4, 9, 30),
  ),
];

final mockFoods = [
  Food(
    id: '1',
    name: 'Grilled Chicken Salad',
    restaurantId:'1',
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
    vendor: mockVendor,
    reviews: mockReviews,
  ),Food(
    id: '2',
    restaurantId:'2',
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
    vendor: mockVendor,
    reviews: mockReviews,
  ),Food(
    id: '3',
    restaurantId:'3',
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
    vendor: mockVendor,
    reviews: mockReviews,
  ),
  // Add more Food instances for richer testing
];
