import 'package:flutter/material.dart';
import '../../food_detail/widgets/section_title.dart';
import 'restaurant_carousel_card.dart';

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
          child: SectionTitle(title),
        ),
        SizedBox(
          height: 300,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
            scrollDirection: Axis.horizontal,
            itemCount: restaurants.length,
            separatorBuilder: (_, __) => const SizedBox(width: 14),
            itemBuilder: (context, idx) {
              return RestaurantCarouselCard(data: restaurants[idx]);
            },
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
