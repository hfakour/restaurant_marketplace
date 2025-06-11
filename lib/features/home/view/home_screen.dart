import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: HomeScreen()));

const kBgColor = Color(0xFFF8F4EF);
const kCardBg = Colors.white;
const kBrown = Color(0xFF8D6748);
const restaurantImgUrl =
    "https://www.starbaal.com/uploads/posts/dfdf5d.jpg?m=thumb&w=800&h=600&q=high";

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgColor,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          "Good evening, Hassan 👋",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final double categoryCardHeight = 140;
            final double cardOverlap = 37;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                // Search Card
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      decoration: BoxDecoration(
                        color: kBgColor,
                        border: Border.all(color: Colors.brown.shade100, width: 2),
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.brown.withOpacity(0.03),
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 7),
                        child: Row(
                          children: [
                            Icon(Icons.search, color: kBrown, size: 24),
                            const SizedBox(width: 10),
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Search foods or restaurants...",
                                  hintStyle: TextStyle(color: kBrown.withOpacity(0.35)),
                                ),
                                style: TextStyle(color: kBrown),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                // Category Carousel (1 row, 4 per page)
                Container(
                  height: categoryCardHeight,
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 22, left: 8, right: 8),
                  child: CategoryCarousel(),
                ),
                // Main Restaurant Card (overlap)
                Expanded(
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        top: -cardOverlap,
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: MainRestaurantCard(topPadding: cardOverlap + 8),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class CategoryCarousel extends StatelessWidget {
  final List<Map<String, dynamic>> categories = const [
    {"label": "Drinks", "icon": Icons.local_bar},
    {"label": "Vegan", "icon": Icons.eco},
    {"label": "Seafood", "icon": Icons.set_meal},
    {"label": "Fast Food", "icon": Icons.fastfood},
    {"label": "Healthy", "icon": Icons.local_dining},
    {"label": "Bakery", "icon": Icons.bakery_dining},
    {"label": "Breakfast", "icon": Icons.breakfast_dining},
    {"label": "Asian", "icon": Icons.ramen_dining},
    {"label": "Pizza", "icon": Icons.local_pizza},
    {"label": "Dessert", "icon": Icons.icecream},
  ];

  const CategoryCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    final items = categories
        .map((cat) =>
        _CategoryCircle(label: cat['label']!, iconData: cat['icon'] as IconData))
        .toList();
    final numPages = (items.length / 4).ceil();

    return Container(
      decoration: BoxDecoration(
        color: kCardBg,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(22),
          topRight: Radius.circular(22),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 18,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 10),
      child: PageView.builder(
        itemCount: numPages,
        controller: PageController(viewportFraction: 1),
        itemBuilder: (context, pageIdx) {
          final start = pageIdx * 4;
          final pageItems = items.skip(start).take(4).toList();
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: pageItems,
          );
        },
      ),
    );
  }
}

class _CategoryCircle extends StatelessWidget {
  final String label;
  final IconData iconData;
  const _CategoryCircle({required this.label, required this.iconData});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: kBgColor,
          radius: 25,
          child: Icon(iconData, color: kBrown, size: 28),
        ),
        const SizedBox(height: 7),
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: kBrown,
            fontSize: 13.5,
          ),
        ),
      ],
    );
  }
}

class MainRestaurantCard extends StatelessWidget {
  final double topPadding;
  // Demo data
  final List<Map<String, dynamic>> restaurants = const [
    {
      "name": "Saffron Palace",
      "rating": 4.8,
      "count": 180,
      "tags": ["Persian", "Fine Dining"],
      "discount": "-30% OFF",
      "discountType": "Dining In",
      "discountColor": Colors.pink,
      "imageUrl": restaurantImgUrl,
    },
    {
      "name": "Golden Fish Grill",
      "rating": 4.7,
      "count": 156,
      "tags": ["Seafood", "Delivery"],
      "discount": "-15% OFF",
      "discountType": "Delivery",
      "discountColor": Colors.blue,
      "imageUrl": restaurantImgUrl,
    },
    {
      "name": "Sakura Sushi",
      "rating": 4.6,
      "count": 140,
      "tags": ["Japanese", "Seafood"],
      "discount": "-10% OFF",
      "discountType": "Delivery",
      "discountColor": Colors.green,
      "imageUrl": restaurantImgUrl,
    },
    {
      "name": "Le Croissant",
      "rating": 4.9,
      "count": 202,
      "tags": ["Bakery", "Breakfast"],
      "discount": "-25% OFF",
      "discountType": "Dine In",
      "discountColor": Colors.orange,
      "imageUrl": restaurantImgUrl,
    },
  ];

  const MainRestaurantCard({super.key, this.topPadding = 40});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: kCardBg,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(22),
          topRight: Radius.circular(22),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 14,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
        child: ListView.separated(
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: restaurants.length,
          separatorBuilder: (_, __) =>
          const Divider(height: 28, thickness: 0.6, color: Colors.black12),
          itemBuilder: (context, i) {
            final rest = restaurants[i];
            return _RestaurantListTile(rest: rest);
          },
        ),
      ),
    );
  }
}

class _RestaurantListTile extends StatelessWidget {
  final Map<String, dynamic> rest;
  const _RestaurantListTile({required this.rest});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Restaurant image (premium style)
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.network(
            rest["imageUrl"] ?? restaurantImgUrl,
            width: 56,
            height: 56,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              width: 56,
              height: 56,
              color: kBgColor,
              child: const Icon(Icons.restaurant, color: kBrown, size: 26),
            ),
          ),
        ),
        const SizedBox(width: 16),
        // Restaurant info
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                rest["name"],
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 17.5,
                  color: kBrown,
                  letterSpacing: -0.2,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                children: [
                  const Icon(Icons.star_rounded, color: Colors.amber, size: 18),
                  Padding(
                    padding: const EdgeInsets.only(left: 3),
                    child: Text(
                      "${rest["rating"]}",
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                        color: kBrown,
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    "(${rest["count"]})",
                    style: TextStyle(
                      color: kBrown.withOpacity(0.47),
                      fontSize: 13.5,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Wrap(
                spacing: 8,
                runSpacing: 6,
                children: List.generate(
                  (rest["tags"] as List).length,
                      (idx) => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: kBgColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      rest["tags"][idx],
                      style: const TextStyle(
                        color: kBrown,
                        fontWeight: FontWeight.w600,
                        fontSize: 13.5,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: (rest["discountColor"] as Color).withOpacity(0.13),
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Text(
                      rest["discount"],
                      style: TextStyle(
                        color: rest["discountColor"],
                        fontWeight: FontWeight.bold,
                        fontSize: 13.5,
                      ),
                    ),
                  ),
                  const SizedBox(width: 7),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: kBgColor,
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Text(
                      rest["discountType"],
                      style: const TextStyle(
                        color: kBrown,
                        fontWeight: FontWeight.bold,
                        fontSize: 13.5,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
