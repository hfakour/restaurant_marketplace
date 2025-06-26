// features/home/widgets/category_carousel/category_carousel.dart
import 'package:flutter/material.dart';

import '../../../../core/theme/home_styles.dart';
import '../../data/mock_categories.dart';
import 'category_circle.dart';


class CategoryCarousel extends StatelessWidget {
  const CategoryCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    final items = mockCategories
        .map((cat) => CategoryCircle(label: cat.label, iconData: cat.icon))
        .toList();
    final numPages = (items.length / 4).ceil();

    return Container(
      decoration: BoxDecoration(
        color: HomeStyles.cardBg,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(HomeStyles.cardRadius),
          topRight: Radius.circular(HomeStyles.cardRadius),
        ),
        boxShadow: [
          BoxShadow(
            color: HomeStyles.charcoal.withOpacity(0.06),
            blurRadius: HomeStyles.cardShadowBlur,
            offset: HomeStyles.cardShadowOffset,
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(6, 8, 6, 18),
      height: HomeStyles.categoryCardHeight,
      child: PageView.builder(
        itemCount: numPages,
        controller: PageController(viewportFraction: 1),
        itemBuilder: (context, pageIdx) {
          final start = pageIdx * 4;
          final pageItems = items.skip(start).take(4).toList();
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 0; i < pageItems.length; i++) ...[
                pageItems[i],
                if (i != pageItems.length - 1)
                  const SizedBox(width: HomeStyles.categoryItemSpacing),
              ],
            ],
          );
        },
      ),
    );
  }
}
