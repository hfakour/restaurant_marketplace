import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../restaurant_detail/view/restaurant_detail_screen.dart';

class TopRestaurantsSection extends StatelessWidget {
  final List<Map<String, dynamic>> restaurants;
  const TopRestaurantsSection({required this.restaurants, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Top Restaurants',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'Georgia',
            ),
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: restaurants
                .map((r) => _restaurantCard(context, r))
                .toList(),
          ),
        ),
        const SizedBox(height: 32),
      ],
    );
  }

  static Widget _restaurantCard(BuildContext context, Map r) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => RestaurantDetailScreen(restaurantId: r['id'])),
        );
      },
      child: Card(
        elevation: 6,
        margin: const EdgeInsets.symmetric(vertical: 10),
        color: Colors.white,
        shadowColor: Colors.brown.shade100,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(22), bottomLeft: Radius.circular(22)),
              child: Image.network(
                r['image'],
                width: 110,
                height: 110,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(14, 12, 18, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      r['name'],
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Georgia',
                          fontSize: 18),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        ...List<Widget>.from(r['tags'].map((t) => Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Chip(
                            label: Text(
                              t,
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.brown),
                            ),
                            backgroundColor: Colors.brown.shade50,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ))),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      r['desc'],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.brown.shade600,
                        fontFamily: 'Georgia',
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        RatingBarIndicator(
                          rating: r['rating'],
                          itemBuilder: (context, index) =>
                          const Icon(Icons.star, color: Color(0xFFD4AF37)),
                          itemSize: 18,
                        ),
                        const SizedBox(width: 6),
                        Text('${r['rating']}',
                            style: const TextStyle(
                                color: Color(0xFFD4AF37),
                                fontWeight: FontWeight.bold)),
                        const SizedBox(width: 6),
                        Text('(${r['reviews']} reviews)',
                            style: TextStyle(
                                color: Colors.brown.shade400, fontSize: 12)),
                        const Spacer(),
                        if (!r['isOpen'])
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.red.shade50,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text(
                              'Closed',
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        if (r['isOpen'])
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.green.shade50,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text(
                              'Open',
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
