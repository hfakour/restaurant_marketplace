import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Import your actual screens here:
import '../../features/cart/view/cart_screen.dart';
import 'features/home/view/home_screen.dart';
import '../../features/profile/view/profile_screen.dart';

// --- Riverpod Provider for Bottom Nav Index ---
final bottomNavIndexProvider = StateProvider<int>((ref) => 1);

// --- Main App ---
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    // Wrap your MaterialApp with ProviderScope for Riverpod to work globally
    return ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const _AppShell(),
        theme: ThemeData(
          fontFamily: 'Georgia',
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: const Color(0xFFD4AF37), // Gold for highlights
            secondary: const Color(0xFF232325), // Charcoal
            background: const Color(0xFFF8F4EF), // App background
          ),
        ),
      ),
    );
  }
}

// --- Bottom Navigation Shell ---
class _AppShell extends ConsumerWidget {
  const _AppShell({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(bottomNavIndexProvider);

    final screens = [
      const CartScreen(),
      const HomeScreen(),
      const ProfileScreen(),
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
          backgroundColor: const Color(0xFF232325),
          selectedItemColor: const Color(0xFFD4AF37), // Gold
          unselectedItemColor: const Color(0xFFEEEEEE),
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
          onTap: (selected) =>
          ref.read(bottomNavIndexProvider.notifier).state = selected,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'Cart',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
