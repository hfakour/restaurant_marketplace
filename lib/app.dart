import 'package:flutter/material.dart';
// 👇 adjust this path to where your ProfileScreen.dart lives
import 'package:restaurant_marketplace/features/profile/presentation/screens/profile_screen.dart';

import 'features/wallet/presentation/screens/wallet_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: const Color(0xFFBFEA3C), // lemon green
        useMaterial3: true,
        brightness: Brightness.light,
      ),
      home: const DemoPage(),
    );
  }
}

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  static const _lemon = Color(0xFFBFEA3C);

  int _selectedIndex = 2;

  final _pages = const [
    Center(child: Text('Cart')),
    Center(child: Text('History')),
    Center(child: Text('Home')),
    Center(child: Text('Search')),
    Center(child: Text('Profile')), // placeholder, Profile opens via push
  ];

  void _handleTap(int index) {
    // Profile tab => open Profile
    if (index == 4) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => const ProfileScreen()),
      );
      return;
    }
    // Search tab no longer opens wallet. Simply update the selected index to display
    // a placeholder page. The actual search feature can be implemented later.
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final bottomInset = media.padding.bottom;

    return Scaffold(
      extendBody: true,
      body: _pages[_selectedIndex],
      bottomNavigationBar: Material(
        color: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            HillBottomNavBar(
              barHeight: 72,
              radius: 22,
              hillWidth: 120,
              hillPeak: 18,
              color: _lemon,
              currentIndex: _selectedIndex,
              onTap: _handleTap,
              items: const [
                HillNavBarItem(icon: Icons.shopping_cart, label: 'Cart'),
                HillNavBarItem(icon: Icons.history, label: 'History'),
                HillNavBarItem(icon: Icons.home, label: 'Home'),
                HillNavBarItem(icon: Icons.search, label: 'Search'),
                HillNavBarItem(icon: Icons.person, label: 'Profile'),
              ],
            ),
            if (bottomInset > 0) Container(height: bottomInset, color: _lemon),
          ],
        ),
      ),
    );
  }
}

/* ───────────────────────────── NAV BAR API ───────────────────────────── */

/// Data for a single nav item (icon + label).
class HillNavBarItem {
  final IconData icon;
  final String label;
  const HillNavBarItem({required this.icon, required this.label});
}

/// Bottom navigation bar with a center “hill” shape covering part of the orb.
/// Indexes: 0..4, where 2 is the center.
class HillBottomNavBar extends StatelessWidget {
  const HillBottomNavBar({
    super.key,
    required this.barHeight,
    required this.radius,
    required this.hillWidth,
    required this.hillPeak,
    required this.color,
    required this.items,
    required this.currentIndex,
    required this.onTap,
  }) : assert(items.length == 5, 'Provide exactly 5 items');

  final double barHeight;
  final double radius;
  final double hillWidth;
  final double hillPeak;
  final Color color;
  final List<HillNavBarItem> items;
  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    final navBarHeight = hillPeak + barHeight;

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        return SizedBox(
          height: navBarHeight,
          width: double.infinity,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // Background (row + hill)
              IgnorePointer(
                child: CustomPaint(
                  size: Size(width, navBarHeight),
                  painter: _NavBarBackgroundPainter(
                    color: color,
                    radius: radius,
                    barHeight: barHeight,
                    hillWidth: hillWidth,
                    hillPeak: hillPeak,
                  ),
                ),
              ),

              // Center orb – drawn before items so the hill overlaps its lower edge
              const Positioned.fill(
                top: 13,
                bottom: null,
                child: _CenterOrbSlot(),
              ),

              // Left (0,1) • gap for orb • Right (3,4)
              Positioned(
                top: hillPeak,
                left: 0,
                right: 0,
                height: barHeight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      // Left side items
                      ...[0, 1].map((i) => Expanded(
                        child: _NavItemButton(
                          item: items[i],
                          active: currentIndex == i,
                          onTap: () => onTap(i),
                        ),
                      )),
                      SizedBox(width: hillWidth * 0.5), // center gap for orb tap area
                      // Right side items
                      ...[3, 4].map((i) => Expanded(
                        child: _NavItemButton(
                          item: items[i],
                          active: currentIndex == i,
                          onTap: () => onTap(i),
                        ),
                      )),
                    ],
                  ),
                ),
              ),

              // Real center orb button (interactive) positioned on top
              Positioned(
                top: 13,
                left: 0,
                right: 0,
                child: Center(
                  child: _CenterOrbButton(
                    diameter: 56,
                    fillColor: color,
                    icon: items[2].icon,
                    label: items[2].label,
                    isActive: currentIndex == 2,
                    onTap: () => onTap(2),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

/* ───────────────────────────── NAV PARTS ───────────────────────────── */

/// Provides a visual slot to ensure layout consistency when computing size.
/// (Non-interactive; keeps the paint order comment-readable.)
class _CenterOrbSlot extends StatelessWidget {
  const _CenterOrbSlot();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: SizedBox.square(dimension: 56),
    );
  }
}

class _NavItemButton extends StatelessWidget {
  const _NavItemButton({
    required this.item,
    required this.active,
    required this.onTap,
  });

  final HillNavBarItem item;
  final bool active;
  final VoidCallback onTap;

  static const Color _activeColor = Color(0xFF2E7D32);

  @override
  Widget build(BuildContext context) {
    final Color inactive = Colors.black.withValues(alpha: 0.72);

    final overlay = WidgetStateProperty.resolveWith<Color?>((states) {
      if (states.contains(WidgetState.pressed)) return Colors.black.withValues(alpha: 0.10);
      if (states.contains(WidgetState.hovered)) return Colors.black.withValues(alpha: 0.06);
      if (states.contains(WidgetState.focused)) return Colors.black.withValues(alpha: 0.08);
      return null;
    });

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        overlayColor: overlay,
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedScale(
                scale: active ? 1.12 : 1.0,
                duration: const Duration(milliseconds: 150),
                child: Icon(item.icon, color: active ? _activeColor : inactive),
              ),
              const SizedBox(height: 2),
              Text(
                item.label,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                  color: active ? _activeColor : inactive,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CenterOrbButton extends StatelessWidget {
  const _CenterOrbButton({
    required this.diameter,
    required this.fillColor,
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  final double diameter;
  final Color fillColor;
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  static const Color _activeColor = Color(0xFF2E7D32);

  @override
  Widget build(BuildContext context) {
    final overlay = WidgetStateProperty.resolveWith<Color?>((states) {
      if (states.contains(WidgetState.pressed)) return Colors.black.withValues(alpha: 0.16);
      if (states.contains(WidgetState.hovered)) return Colors.black.withValues(alpha: 0.08);
      if (states.contains(WidgetState.focused)) return Colors.black.withValues(alpha: 0.10);
      return null;
    });

    final ringColor = isActive ? _activeColor : Colors.black;

    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(width: diameter, height: diameter),
      child: Material(
        color: fillColor,
        shape: CircleBorder(side: BorderSide(color: ringColor, width: 3)),
        clipBehavior: Clip.antiAlias,
        elevation: 2,
        child: InkWell(
          onTap: onTap,
          customBorder: const CircleBorder(),
          overlayColor: overlay,
          splashFactory: InkRipple.splashFactory,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: ringColor, size: 22),
              const SizedBox(height: 2),
              Text(
                label,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                  color: ringColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/* ─────────────────────────── BACKGROUND PAINTER ─────────────────────────── */

class _NavBarBackgroundPainter extends CustomPainter {
  _NavBarBackgroundPainter({
    required this.color,
    required this.radius,
    required this.barHeight,
    required this.hillWidth,
    required this.hillPeak,
  });

  final Color color;
  final double radius;
  final double barHeight;
  final double hillWidth;
  final double hillPeak;

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final barTop = hillPeak;
    final barBottom = barTop + barHeight;

    final paintFill = Paint()..color = color;

    // Rounded bar (top corners only)
    final rrect = RRect.fromLTRBAndCorners(
      0, barTop, w, barBottom,
      topLeft: Radius.circular(radius),
      topRight: Radius.circular(radius),
    );
    canvas.drawRRect(rrect, paintFill);

    // Center hill
    final leftX = (w - hillWidth) / 2;
    final rightX = leftX + hillWidth;
    final baseY = barTop;
    final peakY = baseY - hillPeak;
    final midX = (leftX + rightX) / 2;
    final k = hillWidth * 0.25;

    final hill = Path()
      ..moveTo(leftX, baseY)
      ..cubicTo(leftX + k, baseY, midX - k, peakY, midX, peakY)
      ..cubicTo(midX + k, peakY, rightX - k, baseY, rightX, baseY)
      ..lineTo(rightX, baseY + 1)
      ..lineTo(leftX, baseY + 1)
      ..close();

    canvas.drawPath(hill, paintFill);
  }

  @override
  bool shouldRepaint(covariant _NavBarBackgroundPainter old) =>
      old.color != color ||
          old.radius != radius ||
          old.barHeight != barHeight ||
          old.hillWidth != hillWidth ||
          old.hillPeak != hillPeak;
}
