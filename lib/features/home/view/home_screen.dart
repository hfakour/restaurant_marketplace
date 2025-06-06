import 'package:flutter/material.dart';
import 'restaurant_carousel_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
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

    // Helper to chunk categories into groups of 8 (2 rows × 4 columns)
    List<List<Map<String, String>>> pagedCategories = [];
    for (var i = 0; i < categories.length; i += 8) {
      pagedCategories.add(categories.skip(i).take(8).map((e) => e.cast<String, String>()).toList());
    }

    // Mocked restaurant data for different categories:
    final discountRestaurants = [
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

    final topDiningIn = [
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

    final topDelivery = [
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

    final fastestDelivery = [
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

    return Scaffold(
      backgroundColor: const Color(0xFFF8F4EF),
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          'Good evening, Hassan 👋',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Georgia',
            fontWeight: FontWeight.bold,
            fontSize: 24,
            letterSpacing: 1,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search bar
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 18, 20, 2),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.brown.withOpacity(0.06),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search foods or restaurants...',
                      hintStyle: TextStyle(
                        color: Colors.brown.shade300,
                        fontFamily: 'Georgia',
                        fontSize: 16,
                      ),
                      prefixIcon: const Icon(Icons.search, color: Color(0xFFD4AF37)),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 18),
                    ),
                    style: const TextStyle(
                      color: Colors.brown,
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Georgia',
                    ),
                    onChanged: (value) {
                      // TODO: Implement search logic
                    },
                  ),
                ),
              ),
              const SizedBox(height: 10),
              // Main Categories - Horizontal paged carousel (2 rows, 4 columns per page)
              SizedBox(
                height: 220, // enough for 2 rows of circles + labels
                child: PageView.builder(
                  controller: PageController(viewportFraction: 0.98),
                  itemCount: pagedCategories.length,
                  itemBuilder: (context, pageIdx) {
                    final page = pagedCategories[pageIdx];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: GridView.builder(
                        itemCount: page.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          mainAxisSpacing: 18,
                          crossAxisSpacing: 10,
                          childAspectRatio: 0.82,
                        ),
                        itemBuilder: (context, i) => _categoryCircleTile(
                          page[i]['name']!,
                          page[i]['image']!,
                        ),
                      ),
                    );
                  },
                ),
              ),
              RestaurantCarouselSection(
                title: "Discount Restaurants",
                restaurants: discountRestaurants,
              ),
              RestaurantCarouselSection(
                title: "Top Dining-In",
                restaurants: topDiningIn,
              ),
              RestaurantCarouselSection(
                title: "Top Delivery",
                restaurants: topDelivery,
              ),
              RestaurantCarouselSection(
                title: "Fastest Delivery",
                restaurants: fastestDelivery,
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _categoryCircleTile(String name, String imageUrl) {
    return Column(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.brown.withOpacity(0.10),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ClipOval(
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const Icon(Icons.fastfood, color: Colors.brown),
            ),
          ),
        ),
        const SizedBox(height: 4),
        SizedBox(
          width: 64,
          child: Text(
            name,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontFamily: 'Georgia',
              fontWeight: FontWeight.w600,
              fontSize: 12,
              color: Colors.brown,
            ),
          ),
        ),
      ],
    );
  }
}
