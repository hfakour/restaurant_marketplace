import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/food_detail_provider.dart';
import '../view/food_detail_screen.dart';
import '../data/food_mock_data.dart';
import '../repository/food_repository.dart';

// Override provider with test mock data
final testFoodRepositoryProvider = Provider<IFoodRepository>(
      (ref) => MockFoodRepository(mockFoods),
);

void main() {
  testWidgets('FoodDetailScreen renders, interacts, and adds to cart', (WidgetTester tester) async {
    // Pump the widget with overrides (for isolation/repeatability)
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

    // Wait for the async provider to resolve
    await tester.pumpAndSettle();

    // Should find food name
    expect(find.text('Grilled Chicken Salad'), findsOneWidget);

    // Should show price row and discount
    expect(find.text('\$24.99'), findsOneWidget); // original price
    expect(find.text('-20%'), findsOneWidget);    // discount

    // Should show a quantity selector and default quantity
    expect(find.text('Quantity'), findsOneWidget);
    expect(find.text('1'), findsWidgets); // initial quantity

    // Tap increment button to change quantity
    await tester.tap(find.widgetWithIcon(IconButton, Icons.add));
    await tester.pumpAndSettle();

    // Quantity should update
    expect(find.text('2'), findsWidgets);

    // Tap "Add extra cheese"
    await tester.tap(find.text('Add extra cheese - \$1.00'));
    await tester.pumpAndSettle();

    // Tap Add to Cart button
    await tester.tap(find.textContaining('Add to Cart'));
    await tester.pump(); // show snackbar

    // Should see SnackBar
    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to cart!'), findsOneWidget);

    // Check that reviews appear
    expect(find.text('Amelia W.'), findsOneWidget);
    expect(find.text('Absolutely divine! Perfect texture.'), findsOneWidget);
  });
}
