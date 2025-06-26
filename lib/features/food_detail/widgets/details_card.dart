import 'package:flutter/material.dart';

import 'section.dart';
import 'review_tile.dart';
import 'gap.dart';
import 'section_title.dart';
import 'food_tags_wrap.dart';
import 'food_addon_checkbox.dart';
import 'customization_chips.dart';
import 'price_row.dart';
import 'rating_row.dart';
import 'info_icon_text_row.dart';

class DetailsCard extends StatelessWidget {
  final dynamic food;
  final dynamic state;
  final dynamic viewModel;

  const DetailsCard({
    required this.food,
    required this.state,
    required this.viewModel,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, -4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionTitle(food.name, fontSize: 28),
          const Gap(8),
          Text('Category: ${food.category}', style: TextStyle(color: Colors.grey[600])),
          const Gap(8),
          RatingRow(rating: food.rating, reviewsCount: food.reviewsCount, iconSize: 24),
          const Gap(8),
          PriceRow(
            originalPrice: food.originalPrice,
            discountedPrice: food.originalPrice * (1 - food.discountPercentage / 100),
            discountPercent: food.discountPercentage,
          ),
          const Gap(16),
          Text(food.description, style: const TextStyle(fontSize: 16, height: 1.5)),
          const Gap(16),
          InfoIconTextRow(
            icon: Icons.eco,
            text: 'Ingredients: ${food.ingredients.join(', ')}',
          ),
          const Gap(8),
          InfoIconTextRow(
            icon: Icons.warning_amber_rounded,
            text: 'Allergens: ${food.allergens.join(' ')}',
          ),
          const Gap(8),
          FoodTagsWrap(tags: food.tags),
          const Gap(16),
          // Size options section
          Section(
            title: 'Size Options:',
            child: DropdownButton<String>(
              value: state.selectedSize,
              onChanged: (String? newValue) {
                if (newValue != null) viewModel.changeSize(newValue);
              },
              items: <String>['Regular', 'Large', 'Family']
                  .map((value) => DropdownMenuItem<String>(
                value: value, child: Text(value),
              ))
                  .toList(),
            ),
          ),
          const Gap(12),
          // Add-ons section
          Section(
            title: 'Add-ons:',
            child: FoodAddonCheckbox(
              title: 'Add extra cheese - \$1.00',
              value: state.extraCheese,
              onChanged: (val) => viewModel.toggleExtraCheese(),
            ),
          ),
          const Gap(12),
          // Customization chips
          Section(
            title: 'Customization:',
            child: CustomizationChips(options: food.tags),
          ),
          const Gap(16),
          InfoIconTextRow(
            icon: Icons.delivery_dining,
            text: 'Delivery in 30–45 min • \$3.99 fee',
          ),
          const Gap(4),
          InfoIconTextRow(
            icon: Icons.schedule,
            text: 'Preparation Time: 15–20 minutes',
          ),
          const Gap(24),
          SectionTitle('Customer Reviews', fontSize: 18),
          const Gap(16),
          ...food.reviews.map((r) => Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: ReviewTile(r: r),
          )),
        ],
      ),
    );
  }
}
