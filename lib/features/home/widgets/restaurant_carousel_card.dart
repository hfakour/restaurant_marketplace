import 'package:flutter/material.dart';
import 'package:restaurant_marketplace/features/home/widgets/rating_bar_with_text.dart';
import 'package:restaurant_marketplace/features/home/widgets/tag_chip.dart';

import 'discount_badge.dart';
import 'delivery_type_badge.dart';

class RestaurantCarouselCard extends StatelessWidget {
  final Map<String, dynamic> data;
  const RestaurantCarouselCard({required this.data, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
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
              aspectRatio: 16 / 6.7,
              child: Image.network(
                data['image'],
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                    Container(color: Colors.brown.shade50, child: const Icon(Icons.restaurant)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 8, 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data['name'],
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Georgia',
                      fontSize: 16),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                RatingBarWithText(
                  rating: data['rating'],
                  reviews: data['reviews'],
                ),
                const SizedBox(height: 4),
                Wrap(
                  spacing: 6,
                  children: [
                    ...List<Widget>.from(
                      (data['tags'] as List).map((t) => TagChip(t)),
                    ),
                  ],
                ),
                if (data['discount'] != null && data['discount'] > 0)
                  DiscountBadge(data['discount']),
                if (data['fastest'] == true)
                  const DeliveryTypeBadge('Fastest'),
                if (data['type'] == 'dining')
                  const DeliveryTypeBadge('Dining In'),
                if (data['type'] == 'delivery')
                  const DeliveryTypeBadge('Delivery'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
