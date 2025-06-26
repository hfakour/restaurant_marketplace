import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_marketplace/features/home/view/home_screen.dart';
import 'package:restaurant_marketplace/features/home/widgets/carousel_section/carousel_section.dart';
import 'package:restaurant_marketplace/features/home/widgets/category_carousel/category_carousel.dart';
import 'package:restaurant_marketplace/features/home/widgets/search_bar.dart';
import 'package:network_image_mock/network_image_mock.dart';

void main() {
  testWidgets('renders HomeScreen with all major components',
          (WidgetTester tester) async {
        await mockNetworkImagesFor(() async {
          await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

          // Basic presence checks
          expect(find.byType(AppBar), findsOneWidget); // HomeAppBar extends AppBar?
          expect(find.byType(SafeArea), findsOneWidget);
          expect(find.byType(Column), findsWidgets);
          expect(find.byType(SingleChildScrollView), findsNothing); // adjust if used
          expect(find.byType(Image), findsWidgets); // Restaurants have images

          // Custom widget presence
          expect(find.byType(HomeSearchBar), findsOneWidget);
          expect(find.byType(CategoryCarousel), findsOneWidget);
          expect(find.byType(CarouselSection), findsWidgets);
        });
      });
}
