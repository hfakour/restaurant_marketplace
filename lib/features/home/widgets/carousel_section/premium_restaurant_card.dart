// features/home/widgets/carousel_section/premium_restaurant_card.dart
import 'package:flutter/material.dart';
import '../../../../core/theme/home_styles.dart';
import '../../model/restaurant.dart';
import 'restaurant_tag_chip.dart';
import 'restaurant_discount_chip.dart';

class PremiumRestaurantCard extends StatelessWidget {
  final Restaurant restaurant;
  const PremiumRestaurantCard({required this.restaurant, super.key});

  @override
  Widget build(BuildContext context) => Container(
    width: 280,
    decoration: BoxDecoration(
      color: HomeStyles.cardBg,
      borderRadius: BorderRadius.circular(17),
      border: Border.all(color: HomeStyles.subtleGray, width: 1.1),
    ),
    child: Padding(
      padding: const EdgeInsets.fromLTRB(13, 11, 13, 11),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(11),
            child: Image.network(
              restaurant.imageUrl,
              width: 56,
              height: 56,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                width: 56,
                height: 56,
                color: HomeStyles.subtleGray,
                child: Icon(Icons.restaurant, color: HomeStyles.charcoal.withOpacity(0.7), size: 24),
              ),
            ),
          ),
          const SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  restaurant.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 15.7,
                    color: HomeStyles.charcoal,
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
                        "${restaurant.rating}",
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 13.3,
                          color: HomeStyles.charcoal,
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      "(${restaurant.count})",
                      style: TextStyle(
                        color: HomeStyles.charcoal.withOpacity(0.44),
                        fontSize: 12.5,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                Wrap(
                  spacing: 6,
                  runSpacing: 5,
                  children: restaurant.tags.map((tag) => RestaurantTagChip(tag: tag)).toList(),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Expanded(
                      child: RestaurantDiscountChip(
                        label: restaurant.discount,
                        color: restaurant.discountColor,
                      ),
                    ),
                    const SizedBox(width: 7),
                    Expanded(
                      child: RestaurantDiscountChip(
                        label: restaurant.discountType,
                        color: HomeStyles.subtleGray,
                        textColor: HomeStyles.charcoal.withOpacity(0.9),
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
