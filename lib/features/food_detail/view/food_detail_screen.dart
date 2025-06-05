import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../restaurant_detail/view/restaurant_detail_screen.dart';
import '../viewmodel/food_detail_viewmodel.dart';

class FoodDetailScreen extends ConsumerWidget {
  final String foodId;
  const FoodDetailScreen({required this.foodId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final foodAsync = ref.watch(foodDetailProvider(foodId));
    final state = ref.watch(foodDetailViewModelProvider);
    final viewModel = ref.read(foodDetailViewModelProvider.notifier);

    final gold = const Color(0xFFD4AF37);

    return foodAsync.when(
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, _) => Scaffold(body: Center(child: Text('Error: $e'))),
      data: (food) {
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
                Stack(
                  children: [
                    Image.network(
                      food.imageUrl,
                      height: 280,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      bottom: 20,
                      left: 20,
                      child: Container(
                        color: Colors.black54,
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        child: const Text(
                          "Chef's Signature",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    )
                  ],
                ),

                // Vendor Info
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 28,
                        backgroundImage: NetworkImage(food.vendorImage),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(food.vendorName, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                            Text(food.vendorLocation, style: TextStyle(color: Colors.grey[600])),
                            Text('⭐ ${food.rating} (${food.reviewsCount} reviews)', style: TextStyle(color: Colors.grey[700])),
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RestaurantDetailScreen(restaurantId: '1'),
                            ),
                          );
                        }
                        , // Navigate to vendor? (future!)
                        child: Text('View Restaurant', style: TextStyle(color: gold)),
                      ),
                    ],
                  ),
                ),

                // Food Details
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                    boxShadow: [
                      BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, -4)),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(food.name, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w600, fontFamily: 'Georgia')),
                      const SizedBox(height: 8),
                      Text('Category: ${food.category}', style: TextStyle(color: Colors.grey[600])),
                      const SizedBox(height: 8),
                      RatingBarIndicator(
                        rating: food.rating,
                        itemBuilder: (context, index) => const Icon(Icons.star_rounded, color: Colors.amber),
                        itemSize: 24,
                      ),
                      Text('(${food.reviewsCount} Reviews)', style: TextStyle(color: Colors.grey[600])),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Text(
                            '\$${food.originalPrice.toStringAsFixed(2)}',
                            style: const TextStyle(fontSize: 20, color: Colors.grey, decoration: TextDecoration.lineThrough),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            '\$${discountedPrice.toStringAsFixed(2)}',
                            style: TextStyle(fontSize: 24, color: gold, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            '-${food.discountPercentage.toInt()}%',
                            style: const TextStyle(fontSize: 16, color: Colors.red, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(food.description, style: const TextStyle(fontSize: 16, height: 1.5)),
                      const SizedBox(height: 16),
                      Text('Ingredients: ${food.ingredients.join(', ')}'),
                      const SizedBox(height: 8),
                      Text('Allergens: ${food.allergens.join(' ')}'),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        children: food.tags.map((t) => Chip(label: Text(t), backgroundColor: Colors.brown.shade50)).toList(),
                      ),
                      const SizedBox(height: 16),
                      Text('Size Options:'),
                      DropdownButton<String>(
                        value: state.selectedSize,
                        onChanged: (String? newValue) => viewModel.changeSize(newValue ?? 'Regular'),
                        items: <String>['Regular', 'Large', 'Family']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 8),
                      Text('Add-ons:'),
                      CheckboxListTile(
                        title: const Text('Add extra cheese - \$1.00'),
                        value: state.extraCheese,
                        onChanged: (val) => viewModel.toggleExtraCheese(),
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                      const SizedBox(height: 8),
                      Text('Customization:'),
                      Wrap(
                        spacing: 8,
                        children: [
                          _tagChip('No onions'),
                          _tagChip('Well-done'),
                          _tagChip('Extra spice'),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: const [
                          Icon(Icons.delivery_dining, color: Colors.brown),
                          SizedBox(width: 8),
                          Text('Delivery in 30–45 min • \$3.99 fee'),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: const [
                          Icon(Icons.schedule, color: Colors.brown),
                          SizedBox(width: 8),
                          Text('Preparation Time: 15–20 minutes'),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Quantity', style: TextStyle(fontSize: 16)),
                          _quantitySelector(viewModel, state),
                        ],
                      ),
                      const SizedBox(height: 24),
                      const Divider(thickness: 1),
                      const SizedBox(height: 8),
                      const Text('Customer Reviews', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 16),
                      ...food.reviews.map((r) => _buildReview(r.name, r.comment, r.rating)),
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
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: gold,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: Text(
                'Add to Cart • \$${total.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 18, color: Colors.black),
              ),
            ),
          ),
        );
      },
    );
  }

  static Widget _tagChip(String label) => Chip(
    label: Text(label),
    backgroundColor: Colors.brown.shade50,
  );

  static Widget _buildReview(String name, String comment, double rating) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: Colors.brown.shade100,
            child: Text(name[0], style: const TextStyle(color: Colors.brown)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.w600)),
                RatingBarIndicator(
                  rating: rating,
                  itemBuilder: (context, index) => const Icon(Icons.star, color: Colors.amber),
                  itemSize: 16,
                ),
                const SizedBox(height: 4),
                Text(comment),
              ],
            ),
          )
        ],
      ),
    );
  }

  static Widget _quantitySelector(FoodDetailViewModel viewModel, FoodDetailState state) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.grey[200],
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.remove),
            onPressed: () => viewModel.changeQuantity(-1),
          ),
          Text(state.quantity.toString(), style: const TextStyle(fontSize: 18)),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => viewModel.changeQuantity(1),
          ),
        ],
      ),
    );
  }
}
