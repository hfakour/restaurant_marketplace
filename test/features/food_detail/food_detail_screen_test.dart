import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:restaurant_marketplace/features/food_detail/provider/food_detail_provider.dart';

import 'package:restaurant_marketplace/features/food_detail/view/food_detail_screen.dart';
import 'package:restaurant_marketplace/features/food_detail/data/food_mock_data.dart';
import 'package:restaurant_marketplace/features/food_detail/repository/food_repository.dart';

void main() {
  // Override the repo provider to use the in-memory test mock
  final testFoodRepositoryProvider = Provider<IFoodRepository>(
        (ref) => MockFoodRepository(mockFoods),
  );

  testWidgets('FoodDetailScreen renders, interacts, and adds to cart', (WidgetTester tester) async {
    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            foodRepositoryProvider.overrideWithProvider(testFoodRepositoryProvider),
          ],
          child: const MaterialApp(
            home: FoodDetailScreen(foodId: '1'),
          ),
        ),
      );

      // Wait for FutureProvider/async data to load
      await tester.pumpAndSettle();

      // Basic rendering assertions
      expect(find.text('Grilled Chicken Salad'), findsOneWidget);
      expect(find.text('\$24.99'), findsOneWidget);
      expect(find.text('-20%'), findsOneWidget);

      // Quantity default
      expect(find.text('Quantity'), findsOneWidget);
      expect(find.text('1'), findsWidgets);

      // Increment quantity
      await tester.tap(find.widgetWithIcon(IconButton, Icons.add));
      await tester.pumpAndSettle();
      expect(find.text('2'), findsWidgets);

      // Toggle cheese
      await tester.tap(find.text('Add extra cheese - \$1.00'));
      await tester.pumpAndSettle();

      // Add to cart
      await tester.tap(find.textContaining('Add to Cart'));
      await tester.pump();

      // SnackBar should appear
      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text('Added to cart!'), findsOneWidget);

      // Reviews
      expect(find.text('Amelia W.'), findsOneWidget);
      expect(find.text('Absolutely divine! Perfect texture.'), findsOneWidget);
    });
  });
}
