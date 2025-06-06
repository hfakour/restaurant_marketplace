import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/food_detail_provider.dart';
import '../widgets/add_to_cart_button.dart';
import '../widgets/customization_chips.dart';
import '../widgets/food_addon_checkbox.dart';
import '../widgets/food_image_banner.dart';
import '../widgets/food_tags_wrap.dart';
import '../widgets/info_icon_text_row.dart';
import '../widgets/price_row.dart';
import '../widgets/rating_row.dart';
import '../widgets/section_title.dart';
import '../widgets/vendor_info_row.dart';

class FoodDetailScreen extends ConsumerWidget {
  final String foodId;

  const FoodDetailScreen({required this.foodId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final foodAsync = ref.watch(foodDetailProvider(foodId));
    final state = ref.watch(foodDetailViewModelProvider);
    final viewModel = ref.read(foodDetailViewModelProvider.notifier);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Deluxe Cuisine'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: foodAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Failed to load food: $e')),
        data: (food) {
          final double unitPrice = food.originalPrice * (1 - food.discountPercentage / 100) + (state.extraCheese ? 1 : 0);
          final double totalPrice = unitPrice * state.quantity;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FoodImageBanner(imageUrl: food.imageUrl),
                VendorInfoRow(
                  vendorImage: food.vendor.image,
                  vendorName: food.vendor.name,
                  vendorLocation: food.vendor.location,
                  rating: food.rating,
                  reviewsCount: food.reviewsCount,
                  onViewRestaurant: () {},
                  padding: const EdgeInsets.all(16),
                ),
                Container(
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
                      const SizedBox(height: 8),
                      Text('Category: ${food.category}', style: TextStyle(color: Colors.grey[600])),
                      const SizedBox(height: 8),
                      RatingRow(rating: food.rating, reviewsCount: food.reviewsCount, iconSize: 24),
                      const SizedBox(height: 8),
                      PriceRow(
                        originalPrice: food.originalPrice,
                        discountedPrice: food.originalPrice * (1 - food.discountPercentage / 100),
                        discountPercent: food.discountPercentage,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        food.description,
                        style: const TextStyle(fontSize: 16, height: 1.5),
                      ),
                      const SizedBox(height: 16),
                      InfoIconTextRow(
                        icon: Icons.eco,
                        text: 'Ingredients: ${food.ingredients.join(', ')}',
                      ),
                      const SizedBox(height: 8),
                      InfoIconTextRow(
                        icon: Icons.warning_amber_rounded,
                        text: 'Allergens: ${food.allergens.join(' ')}',
                      ),
                      const SizedBox(height: 8),
                      FoodTagsWrap(tags: food.tags),
                      const SizedBox(height: 16),

                      // Size options
                      const SectionTitle('Size Options:', fontSize: 16),
                      DropdownButton<String>(
                        value: state.selectedSize,
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            viewModel.changeSize(newValue);
                          }
                        },
                        items: <String>['Regular', 'Large', 'Family']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 12),

                      // Add-ons (e.g. cheese)
                      const SectionTitle('Add-ons:', fontSize: 16),
                      FoodAddonCheckbox(
                        title: 'Add extra cheese - \$1.00',
                        value: state.extraCheese,
                        onChanged: (val) {
                          viewModel.toggleExtraCheese();
                        },
                      ),
                      const SizedBox(height: 12),

                      // Customization
                      const SectionTitle('Customization:', fontSize: 16),
                      CustomizationChips(options: food.tags),
                      const SizedBox(height: 16),

                      // Delivery info
                      InfoIconTextRow(icon: Icons.delivery_dining, text: 'Delivery in 30–45 min • \$3.99 fee'),
                      const SizedBox(height: 4),
                      InfoIconTextRow(icon: Icons.schedule, text: 'Preparation Time: 15–20 minutes'),

                      const SizedBox(height: 24),

                      // Reviews
                      const SectionTitle('Customer Reviews', fontSize: 18),
                      const SizedBox(height: 16),
                      ...food.reviews.map((r) => Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.brown.shade100,
                              backgroundImage: r.userAvatar != null ? NetworkImage(r.userAvatar!) : null,
                              child: r.userAvatar == null
                                  ? Text(r.userName[0], style: const TextStyle(color: Colors.brown))
                                  : null,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(r.userName, style: const TextStyle(fontWeight: FontWeight.w600)),
                                  Row(
                                    children: [
                                      Icon(Icons.star, color: Colors.amber, size: 16),
                                      const SizedBox(width: 2),
                                      Text('${r.rating}', style: const TextStyle(fontSize: 12)),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Text(r.comment),
                                ],
                              ),
                            )
                          ],
                        ),
                      )),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: foodAsync.maybeWhen(
        data: (food) {
          final double unitPrice = food.originalPrice * (1 - food.discountPercentage / 100) + (state.extraCheese ? 1 : 0);
          final double totalPrice = unitPrice * state.quantity;

          return Padding(
            padding: const EdgeInsets.all(16),
            child: AddToCartButton(
              quantity: state.quantity,
              total: totalPrice,
              onAdd: () => viewModel.changeQuantity(1),
              onIncrement: () => viewModel.changeQuantity(1),
              onDecrement: () => state.quantity == 1
                  ? viewModel.changeQuantity(-1)
                  : viewModel.changeQuantity(-1),
              enabled: true,
              bottomMargin: 0,
            ),
          );
        },
        orElse: () => const SizedBox.shrink(),
      ),
    );
  }
}
