import 'package:flutter/material.dart';


const kBgColor = Color(0xFFF8F4EF);
const kCardBg = Colors.white;
const kCharcoal = Color(0xFF232325);
const kSubtleGray = Color(0xFFEEEEEE);
const restaurantImgUrl =
    "https://www.starbaal.com/uploads/posts/dfdf5d.jpg?m=thumb&w=800&h=600&q=high";

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgColor,
      appBar: AppBar(
        backgroundColor: kCharcoal,
        elevation: 0,
        title: const Text(
          "Good evening, Hassan 👋",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w900,
            fontSize: 22,
            letterSpacing: -1,
          ),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final double categoryCardHeight = 110;
            final double cardOverlap = 25;

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
                        color: kCardBg,
                        border: Border.all(color: kSubtleGray, width: 1.3),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: kCharcoal.withOpacity(0.04),
                            blurRadius: 7,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
                        child: Row(
                          children: [
                            Icon(Icons.search, color: kCharcoal.withOpacity(0.65), size: 24),
                            const SizedBox(width: 10),
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Search foods or restaurants...",
                                  hintStyle: TextStyle(color: kCharcoal.withOpacity(0.30)),
                                ),
                                style: TextStyle(color: kCharcoal, fontWeight: FontWeight.w600),
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
                  margin: const EdgeInsets.only(top: 24, left: 8, right: 8),
                  child: const CategoryCarousel(),
                ),
                // Main Card - all carousels
                Expanded(
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        top: -cardOverlap, // This creates the overlap visually!
                        left: 8,
                        right: 8,
                        bottom: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            color: kCardBg,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: kCharcoal.withOpacity(0.07),
                                blurRadius: 14,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(16, 30, 16, 0),
                            child: ListView(
                              physics: const BouncingScrollPhysics(),
                              children: const [
                                _CarouselSection(
                                  title: "Fast Delivery",
                                  icon: Icons.delivery_dining,
                                  filter: "delivery",
                                ),
                                SizedBox(height: 24),
                                _CarouselSection(
                                  title: "Best Dining In",
                                  icon: Icons.restaurant,
                                  filter: "dinein",
                                ),
                                SizedBox(height: 24),
                                _CarouselSection(
                                  title: "Most Popular",
                                  icon: Icons.star,
                                  filter: "popular",
                                ),
                                SizedBox(height: 24),
                                _CarouselSection(
                                  title: "24 Hours",
                                  icon: Icons.nightlife,
                                  filter: "24hours",
                                ),
                                SizedBox(height: 24),

                              ],
                            ),
                          ),
                        ),
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

// -------------------- Category Carousel (remains the same) ---------------------
class CategoryCarousel extends StatelessWidget {
  final List<Map<String, dynamic>> categories = const [
    {"label": "Drinks", "icon": Icons.local_bar},
    {"label": "Vegan", "icon": Icons.eco},
    {"label": "Seafood", "icon": Icons.set_meal},
    {"label": "Fast Food", "icon": Icons.fastfood},
    {"label": "Bakery", "icon": Icons.bakery_dining},
    {"label": "Breakfast", "icon": Icons.breakfast_dining},
    {"label": "Asian", "icon": Icons.ramen_dining},
    {"label": "Pizza", "icon": Icons.local_pizza},
  ];

  const CategoryCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    final items = categories
        .map((cat) => _CategoryCircle(label: cat['label']!, iconData: cat['icon'] as IconData))
        .toList();
    final numPages = (items.length / 4).ceil();

    return Container(
      decoration: BoxDecoration(
        color: kCardBg,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        boxShadow: [
          BoxShadow(
            color: kCharcoal.withOpacity(0.06),
            blurRadius: 14,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(6, 8, 6, 18),
      child: PageView.builder(
        itemCount: numPages,
        controller: PageController(viewportFraction: 1),
        itemBuilder: (context, pageIdx) {
          final start = pageIdx * 4;
          final pageItems = items.skip(start).take(4).toList();
          const double itemSpacing = 35.0;
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 0; i < pageItems.length; i++) ...[
                pageItems[i],
                if (i != pageItems.length - 1)
                  const SizedBox(width: itemSpacing),
              ],
            ],
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
        Container(
          decoration: BoxDecoration(
            color: kSubtleGray,
            shape: BoxShape.circle,
            border: Border.all(color: kCharcoal.withOpacity(0.08), width: 1.1),
          ),
          child: CircleAvatar(
            backgroundColor: kCardBg,
            radius: 22,
            child: Icon(iconData, color: kCharcoal.withOpacity(0.7), size: 24),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: kCharcoal.withOpacity(0.80),
            fontSize: 13.1,
            letterSpacing: -0.2,
          ),
        ),
      ],
    );
  }
}

// -------------------- Premium Restaurant Carousel Section ---------------------

class _CarouselSection extends StatelessWidget {
  final String title;
  final IconData icon;
  final String filter;

  const _CarouselSection({
    required this.title,
    required this.icon,
    required this.filter,
  });

  // Demo data (could filter in real use)
  List<Map<String, dynamic>> get _restaurants => [
    {
      "name": "Saffron Palace",
      "rating": 4.8,
      "count": 180,
      "tags": ["Persian", "Fine Dining"],
      "discount": "-30% OFF",
      "discountType": "Dining In",
      "discountColor": Colors.pink,
      "imageUrl": restaurantImgUrl,
      "type": "dinein",
      "popular": true,
      "delivery": true,
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
      "type": "delivery",
      "popular": true,
      "delivery": true,
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
      "type": "delivery",
      "popular": false,
      "delivery": true,
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
      "type": "dinein",
      "popular": true,
      "delivery": false,
    },
  ];

  List<Map<String, dynamic>> get _filtered {
    switch (filter) {
      case "delivery":
        return _restaurants.where((r) => r["delivery"] == true).toList();
      case "dinein":
        return _restaurants.where((r) => r["type"] == "dinein").toList();
      case "popular":
        return _restaurants.where((r) => r["popular"] == true).toList();
      default:
        return _restaurants;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section header
        Padding(
          padding: const EdgeInsets.only(left: 2, bottom: 8),
          child: Row(
            children: [
              Icon(icon, color: kCharcoal.withOpacity(0.82), size: 22),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 18.5,
                  color: kCharcoal,
                  letterSpacing: -0.5,
                ),
              ),
            ],
          ),
        ),
        // Horizontal carousel
        SizedBox(
          height: 118, // Card height
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: _filtered.length,
            separatorBuilder: (_, __) => const SizedBox(width: 19),
            itemBuilder: (context, idx) {
              final rest = _filtered[idx];
              return _PremiumRestaurantCard(rest: rest);
            },
          ),
        ),
      ],
    );
  }
}

class _PremiumRestaurantCard extends StatelessWidget {
  final Map<String, dynamic> rest;
  const _PremiumRestaurantCard({required this.rest});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      decoration: BoxDecoration(
        color: kCardBg,
        borderRadius: BorderRadius.circular(17),
        boxShadow: [
          BoxShadow(
            color: kCharcoal.withOpacity(0.10),
            blurRadius: 14,
            offset: const Offset(0, 5),
          ),
        ],
        border: Border.all(color: kSubtleGray, width: 1.1),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(13, 11, 13, 11),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(11),
              child: Image.network(
                rest["imageUrl"] ?? restaurantImgUrl,
                width: 56,
                height: 56,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 56,
                  height: 56,
                  color: kSubtleGray,
                  child: Icon(Icons.restaurant, color: kCharcoal.withOpacity(0.7), size: 24),
                ),
              ),
            ),
            const SizedBox(width: 11),
            // Restaurant info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    rest["name"],
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 15.7,
                      color: kCharcoal,
                      letterSpacing: -0.2,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    children: [
                      Icon(Icons.star_rounded, color: Colors.amber[600], size: 16),
                      Padding(
                        padding: const EdgeInsets.only(left: 2),
                        child: Text(
                          "${rest["rating"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 13.3,
                            color: kCharcoal,
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        "(${rest["count"]})",
                        style: TextStyle(
                          color: kCharcoal.withOpacity(0.44),
                          fontSize: 12.5,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Wrap(
                    spacing: 6,
                    runSpacing: 5,
                    children: List.generate(
                      (rest["tags"] as List).length,
                          (idx) => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: kSubtleGray,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          rest["tags"][idx],
                          style: TextStyle(
                            color: kCharcoal,
                            fontWeight: FontWeight.w600,
                            fontSize: 11.5,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                        decoration: BoxDecoration(
                          color: (rest["discountColor"] as Color).withOpacity(0.14),
                          borderRadius: BorderRadius.circular(5.5),
                        ),
                        child: Text(
                          rest["discount"],
                          style: TextStyle(
                            color: rest["discountColor"],
                            fontWeight: FontWeight.w700,
                            fontSize: 12.3,
                          ),
                        ),
                      ),
                      const SizedBox(width: 7),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                        decoration: BoxDecoration(
                          color: kSubtleGray,
                          borderRadius: BorderRadius.circular(5.5),
                        ),
                        child: Text(
                          rest["discountType"],
                          style: TextStyle(
                            color: kCharcoal.withOpacity(0.9),
                            fontWeight: FontWeight.w700,
                            fontSize: 12.3,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
