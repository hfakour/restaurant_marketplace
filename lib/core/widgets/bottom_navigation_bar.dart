import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_marketplace/features/checkout/view/checkout_screen.dart';
import 'package:restaurant_marketplace/features/restaurant_admin/view/restaurant_admin.screen.dart';
import 'package:restaurant_marketplace/features/securiry/view/secuurity.screen.dart';
import '../../features/favorite/view/favorite_screen.dart';
import '../../features/help_and_support/view/help_and_support.screen.dart';
import '../../features/home/view/home_screen.dart';
import '../../features/orders/view/orders_screen.dart';
import '../../features/payment_method/view/peyment_method.screen.dart';
import '../../features/preference/view/preference.screen.dart';
import '../../features/profile/view/profile_screen.dart';
import '../../features/search/view/search.screen.dart';

final bottomNavIndexProvider = StateProvider<int>((ref) => 0);

class AppShell extends ConsumerWidget {
  const AppShell({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(bottomNavIndexProvider);

    final screens = [
      const RestaurantAdminPanel(),
      const HomeScreen(), // Home
      // Shop (Cart)
      const ProfileScreen(), // Profile
    ];

    return Scaffold(
      body: screens[index],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: index,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.black,
          selectedItemColor: const Color(0xFFD4AF37),
          // Gold
          unselectedItemColor: Colors.brown.shade300,
          selectedIconTheme: const IconThemeData(size: 30),
          unselectedIconTheme: const IconThemeData(size: 26),
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'Georgia',
          ),
          unselectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            fontFamily: 'Georgia',
          ),
          onTap:
              (selected) =>
          ref.read(bottomNavIndexProvider.notifier).state = selected,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'Cart',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}
