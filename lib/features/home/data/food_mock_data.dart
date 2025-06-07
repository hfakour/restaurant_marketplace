// features/home/data/home_mock_data.dart

// Category data
final List<Map<String, String>> kCategories = [
  {'name': 'Drinks', 'image': 'https://images.unsplash.com/photo-1504674900247-0877df9cc836?auto=format&fit=crop&w=400&q=80'},
  {'name': 'Vegan', 'image': 'https://images.unsplash.com/photo-1502741338009-cac2772e18bc?auto=format&fit=crop&w=400&q=80'},
  {'name': 'Seafood', 'image': 'https://images.unsplash.com/photo-1504674900247-0877df9cc836?auto=format&fit=crop&w=400&q=80'},
  {'name': 'Fast Food', 'image': 'https://images.unsplash.com/photo-1414235077428-338989a2e8c0?auto=format&fit=crop&w=400&q=80'},
  {'name': 'Healthy', 'image': 'https://images.unsplash.com/photo-1519864600265-abb23847ef2c?auto=format&fit=crop&w=400&q=80'},
  {'name': 'Bakery', 'image': 'https://images.unsplash.com/photo-1502741338009-cac2772e18bc?auto=format&fit=crop&w=400&q=80'},
  {'name': 'Breakfast', 'image': 'https://images.unsplash.com/photo-1464306076886-debca5e8a6b0?auto=format&fit=crop&w=400&q=80'},
  {'name': 'Asian', 'image': 'https://images.unsplash.com/photo-1519864600265-abb23847ef2c?auto=format&fit=crop&w=400&q=80'},
  {'name': 'Pizza', 'image': 'https://images.unsplash.com/photo-1519864600265-abb23847ef2c?auto=format&fit=crop&w=400&q=80'},
  {'name': 'Dessert', 'image': 'https://images.unsplash.com/photo-1464306076886-debca5e8a6b0?auto=format&fit=crop&w=400&q=80'},
  {'name': 'Sandwich', 'image': 'https://images.unsplash.com/photo-1414235077428-338989a2e8c0?auto=format&fit=crop&w=400&q=80'},
  {'name': 'Kebab', 'image': 'https://images.unsplash.com/photo-1504674900247-0877df9cc836?auto=format&fit=crop&w=400&q=80'},
];

// Discount restaurants
final List<Map<String, dynamic>> kDiscountRestaurants = [
  {
    'id': '10',
    'name': 'Saffron Palace',
    'image': 'https://images.unsplash.com/photo-1555396273-367ea4eb4db5?auto=format&fit=crop&w=800&q=80',
    'tags': ['Persian', 'Fine Dining'],
    'rating': 4.8,
    'reviews': 180,
    'desc': 'Authentic Persian cuisine, up to 30% OFF.',
    'isOpen': true,
    'discount': 30,
    'type': 'dining',
  },
  {
    'id': '11',
    'name': 'Golden Fish Grill',
    'image': 'https://images.unsplash.com/photo-1504674900247-0877df9cc836?auto=format&fit=crop&w=800&q=80',
    'tags': ['Seafood', 'Delivery'],
    'rating': 4.7,
    'reviews': 156,
    'desc': 'Fresh seafood at great prices.',
    'isOpen': true,
    'discount': 15,
    'type': 'delivery',
  },
];

// Top Dining-In
final List<Map<String, dynamic>> kTopDiningIn = [
  {
    'id': '1',
    'name': 'La Belle Cuisine',
    'image': 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?auto=format&fit=crop&w=800&q=80',
    'tags': ['French', 'Gourmet'],
    'rating': 4.9,
    'reviews': 321,
    'desc': 'Michelin-starred French classics in an elegant, modern setting.',
    'isOpen': true,
    'type': 'dining',
  },
  {
    'id': '2',
    'name': 'The Golden Grill',
    'image': 'https://images.unsplash.com/photo-1504674900247-0877df9cc836?auto=format&fit=crop&w=800&q=80',
    'tags': ['Steakhouse', 'Fine Dining'],
    'rating': 4.7,
    'reviews': 242,
    'desc': 'Premium steaks, crafted cocktails, and luxury ambiance.',
    'isOpen': true,
    'type': 'dining',
  },
];

// Top Delivery
final List<Map<String, dynamic>> kTopDelivery = [
  {
    'id': '3',
    'name': 'Azure Waves',
    'image': 'https://images.unsplash.com/photo-1504674900247-0877df9cc836?auto=format&fit=crop&w=800&q=80',
    'tags': ['Seafood', 'Delivery'],
    'rating': 4.8,
    'reviews': 198,
    'desc': 'Fresh catches daily, delivered fast.',
    'isOpen': true,
    'type': 'delivery',
  },
  {
    'id': '4',
    'name': 'Express Bites',
    'image': 'https://images.unsplash.com/photo-1519864600265-abb23847ef2c?auto=format&fit=crop&w=800&q=80',
    'tags': ['Fast Food', 'Delivery'],
    'rating': 4.6,
    'reviews': 190,
    'desc': 'Super quick delivery & crispy fries.',
    'isOpen': true,
    'type': 'delivery',
    'fastest': true,
  },
];

// Fastest Delivery
final List<Map<String, dynamic>> kFastestDelivery = [
  {
    'id': '4',
    'name': 'Express Bites',
    'image': 'https://images.unsplash.com/photo-1519864600265-abb23847ef2c?auto=format&fit=crop&w=800&q=80',
    'tags': ['Fast Food', 'Delivery'],
    'rating': 4.6,
    'reviews': 190,
    'desc': 'Super quick delivery & crispy fries.',
    'isOpen': true,
    'type': 'delivery',
    'fastest': true,
  },
];
