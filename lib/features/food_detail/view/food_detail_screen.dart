import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../restaurant_detail/view/restaurant_detail_screen.dart';
import '../provider/food_detail_provider.dart';

import '../widgets/food_image_banner.dart';
import '../widgets/vendor_info_row.dart';
import '../widgets/section_title.dart';
import '../widgets/price_row.dart';
import '../widgets/rating_row.dart';
import '../widgets/food_tags_wrap.dart';
import '../widgets/food_addon_checkbox.dart';
import '../widgets/customization_chips.dart';
import '../widgets/info_icon_text_row.dart';
import '../widgets/quantity_selector.dart';
import '../widgets/review_card.dart';
import '../widgets/add_to_cart_button.dart';

class FoodDetailScreen extends ConsumerWidget {
  final String foodId;
  const FoodDetailScreen({required this.foodId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final foodAsync = ref.watch(foodDetailProvider(foodId));
    final state = ref.watch(foodDetailViewModelProvider);
    final viewModel = ref.read(foodDetailViewModelProvider.notifier);

    return foodAsync.when(
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => Scaffold(
        body: Center(child: Text('Error: $e')),
      ),
      data: (food) {
        const gold = Color(0xFFD4AF37);
        double discountedPrice = food.discountedPrice;
        double deliveryFee = 3.99;
        double cheeseAddon = state.extraCheese ? 1.0 : 0.0;
        double total = (discountedPrice + cheeseAddon) * state.quantity + deliveryFee;

        return Scaffold(
          backgroundColor: const Color(0xFFF8F4EF),
          appBar: AppBar(
            title: const Text('Deluxe Cuisine'),
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            elevation: 0,
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top image banner
                FoodImageBanner(imageUrl: food.imageUrl),

                // Vendor info row
                VendorInfoRow(
                  vendorImage: food.vendorImage,
                  vendorName: food.vendorName,
                  vendorLocation: food.vendorLocation,
                  rating: food.rating,
                  reviewsCount: food.reviewsCount,
                  gold: gold,
                  onViewPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            RestaurantDetailScreen(restaurantId: '1'),
                      ),
                    );
                  },
                ),

                // Food details
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
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SectionTitle(title: food.name),
                      const SizedBox(height: 8),
                      Text(
                        'Category: ${food.category}',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      const SizedBox(height: 8),
                      RatingRow(
                        rating: food.rating,
                        reviewsCount: food.reviewsCount,
                      ),
                      const SizedBox(height: 8),
                      PriceRow(
                        originalPrice: food.originalPrice,
                        discountedPrice: discountedPrice,
                        discountPercentage: food.discountPercentage,
                        gold: gold,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        food.description,
                        style: const TextStyle(fontSize: 16, height: 1.5),
                      ),
                      const SizedBox(height: 16),
                      Text('Ingredients: ${food.ingredients.join(', ')}'),
                      const SizedBox(height: 8),
                      Text('Allergens: ${food.allergens.join(' ')}'),
                      const SizedBox(height: 8),
                      FoodTagsWrap(tags: food.tags),
                      const SizedBox(height: 16),

                      // Size options
                      const Text('Size Options:'),
                      DropdownButton<String>(
                        value: state.selectedSize,
                        onChanged: (String? newValue) =>
                            viewModel.changeSize(newValue ?? 'Regular'),
                        items: <String>['Regular', 'Large', 'Family']
                            .map<DropdownMenuItem<String>>(
                              (String value) => DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          ),
                        )
                            .toList(),
                      ),
                      const SizedBox(height: 8),

                      // Add-ons
                      FoodAddonCheckbox(
                        value: state.extraCheese,
                        onChanged: (_) => viewModel.toggleExtraCheese(),
                      ),
                      const SizedBox(height: 8),

                      // Customization
                      const Text('Customization:'),
                      CustomizationChips(
                        chips: const ['No onions', 'Well-done', 'Extra spice'],
                      ),
                      const SizedBox(height: 16),

                      // Delivery info rows
                      InfoIconTextRow(
                        icon: Icons.delivery_dining,
                        text: 'Delivery in 30–45 min • \$3.99 fee',
                      ),
                      const SizedBox(height: 4),
                      InfoIconTextRow(
                        icon: Icons.schedule,
                        text: 'Preparation Time: 15–20 minutes',
                      ),
                      const SizedBox(height: 16),

                      // Quantity selector
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Quantity', style: TextStyle(fontSize: 16)),
                          QuantitySelector(
                            quantity: state.quantity,
                            onIncrement: () => viewModel.changeQuantity(1),
                            onDecrement: () => viewModel.changeQuantity(-1),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      const Divider(thickness: 1),
                      const SizedBox(height: 8),
                      const Text(
                        'Customer Reviews',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      ...food.reviews.map((r) => ReviewCard(
                        name: r.name,
                        comment: r.comment,
                        rating: r.rating,
                      )),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Colors.grey.shade200)),
            ),
            child: AddToCartButton(
              total: total,
              onTap: () {
                // TODO: Add to cart logic
              },
            ),
          ),
        );
      },
    );
  });
}
}
