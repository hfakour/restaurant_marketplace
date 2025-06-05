import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../restaurant_detail/view/restaurant_detail_screen.dart';

class RestaurantCarouselSection extends StatelessWidget {
  final String title;
  final List<Map<String, dynamic>> restaurants;

  const RestaurantCarouselSection({
    required this.title,
    required this.restaurants,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (restaurants.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'Georgia',
            ),
          ),
        ),
        SizedBox(
          height: 300, // slightly increased for more content
          child: LayoutBuilder(
            builder: (context, constraints) {
              final screenWidth = constraints.maxWidth > 0
                  ? constraints.maxWidth
                  : MediaQuery.of(context).size.width;
              // Card width: 74% of screen, min 180, max 320
              final cardWidth = screenWidth * 0.74;
              final width = cardWidth.clamp(180.0, 320.0);

              return ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                scrollDirection: Axis.horizontal,
                itemCount: restaurants.length,
                separatorBuilder: (_, __) => const SizedBox(width: 14),
                itemBuilder: (context, idx) {
                  final r = restaurants[idx];
                  return _restaurantCard(context, r, width);
                },
              );
            },
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  static Widget _restaurantCard(BuildContext context, Map r, double width) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => RestaurantDetailScreen(restaurantId: r['id'])),
        );
      },
      child: Container(
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.brown.shade100,
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              child: AspectRatio(
                aspectRatio: 16 / 6.7, // for a nice horizontal card image
                child: Image.network(
                  r['image'],
                  width: width,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 8, 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    r['name'],
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Georgia',
                        fontSize: 16),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      RatingBarIndicator(
                        rating: r['rating'],
                        itemBuilder: (context, index) =>
                        const Icon(Icons.star, color: Color(0xFFD4AF37)),
                        itemSize: 16,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '${r['rating']}',
                        style: const TextStyle(
                          color: Color(0xFFD4AF37),
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text('(${r['reviews']})',
                          style: TextStyle(
                              color: Colors.brown.shade400, fontSize: 11)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      ...List<Widget>.from(r['tags'].map((t) => Padding(
                        padding: const EdgeInsets.only(right: 6),
                        child: Chip(
                          label: Text(
                            t,
                            style: const TextStyle(fontSize: 10, color: Colors.brown),
                          ),
                          backgroundColor: Colors.brown.shade50,
                          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                      ))),
                    ],
                  ),
                  if (r['discount'] != null && r['discount'] > 0)
                    Container(
                      margin: const EdgeInsets.only(top: 2),
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.red.shade50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '-${r['discount']}% OFF',
                        style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  if (r['fastest'] == true)
                    Container(
                      margin: const EdgeInsets.only(top: 2),
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'Fastest Delivery',
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  if (r['type'] == 'dining')
                    Container(
                      margin: const EdgeInsets.only(top: 2),
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.brown.shade50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'Dining In',
                        style: TextStyle(
                          color: Colors.brown,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  if (r['type'] == 'delivery')
                    Container(
                      margin: const EdgeInsets.only(top: 2),
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'Delivery',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
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
