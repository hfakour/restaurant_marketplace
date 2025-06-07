import 'package:flutter/material.dart';
import 'package:restaurant_marketplace/features/home/widgets/rating_bar_with_text.dart';
import 'package:restaurant_marketplace/features/home/widgets/tag_chip.dart';

import 'restaurant_status_badge.dart';

class TopRestaurantCard extends StatelessWidget {
  final Map<String, dynamic> data;
  const TopRestaurantCard({required this.data, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
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
              data['image'],
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
                    data['name'],
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Georgia',
                        fontSize: 18),
                  ),
                  const SizedBox(height: 4),
                  Wrap(
                    spacing: 8,
                    children: [
                      ...List<Widget>.from(
                        (data['tags'] as List).map((t) => TagChip(t)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    data['desc'],
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
                      RatingBarWithText(
                        rating: data['rating'],
                        reviews: data['reviews'],
                      ),
                      const Spacer(),
                      RestaurantStatusBadge(isOpen: data['isOpen']),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
