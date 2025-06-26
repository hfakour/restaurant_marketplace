import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodel/menu_viewmodel.dart';
import '../../food_detail/view/food_detail_screen.dart';
import '../../cart/view/cart_screen.dart';

// --- COLOR PALETTE ---
const bgColor = Color(0xFFEDECEC);
const cardBg = Colors.white;
const charcoal = Color(0xFF232325);
const subtleGray = Color(0xFFEEEEEE);
const gold = Color(0xFFD4AF37);

// --- QUANTITY STATE MANAGEMENT ---
final menuQuantityProvider = StateNotifierProvider<MenuQuantityNotifier, Map<String, int>>(
      (ref) => MenuQuantityNotifier(),
);

class MenuQuantityNotifier extends StateNotifier<Map<String, int>> {
  MenuQuantityNotifier() : super({});
  void set(String foodId, int qty) {
    if (qty < 0) qty = 0;
    state = {...state, foodId: qty};
  }
  int get totalCount => state.values.fold(0, (sum, item) => sum + item);
}

class MenuScreen extends ConsumerWidget {
  final String restaurantId;
  const MenuScreen({required this.restaurantId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final menuAsync = ref.watch(menuProvider(restaurantId));
    final textTheme = Theme.of(context).textTheme;

    final menuQty = ref.watch(menuQuantityProvider);
    final totalCount = menuQty.values.fold(0, (sum, item) => sum + item);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: charcoal,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        titleSpacing: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 22),
          onPressed: () => Navigator.of(context).maybePop(),
          tooltip: 'Back',
        ),
        title: const Text(
          'Menu',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w900,
            fontFamily: 'Georgia',
            fontSize: 22,
            letterSpacing: -1,
          ),
        ),
      ),
      body: menuAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (menu) {
          return Stack(
            children: [
              ListView.separated(
                padding: const EdgeInsets.fromLTRB(18, 20, 18, 90),
                itemCount: menu.length,
                separatorBuilder: (_, __) => const SizedBox(height: 15),
                itemBuilder: (context, index) {
                  final item = menu[index];
                  final quantity = menuQty[item.id] ?? 0;
                  return _MenuItemRow(
                    key: ValueKey(item.id), // <--- unique key for each item
                    item: item,
                    quantity: quantity,
                    textTheme: textTheme,
                    onQuantityChanged: (q) => ref.read(menuQuantityProvider.notifier).set(item.id, q),
                  );
                },
              ),
              // FAB
              if (totalCount > 0)
                Positioned(
                  right: 18,
                  bottom: 26,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      FloatingActionButton(
                        backgroundColor: charcoal,
                        foregroundColor: Colors.white,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const CartScreen()),
                          );
                        },
                        child: const Icon(Icons.shopping_cart_checkout, size: 30),
                      ),
                      Positioned(
                        right: 1,
                        top: 0,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: subtleGray,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            '$totalCount',
                            style: const TextStyle(
                              color: charcoal,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Georgia',
                              fontSize: 14.3,
                              letterSpacing: -0.7,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

// --- Menu Item Row: 3 columns, all vertically centered ---
class _MenuItemRow extends StatelessWidget {
  final dynamic item;
  final int quantity;
  final TextTheme textTheme;
  final void Function(int) onQuantityChanged;

  const _MenuItemRow({
    required this.item,
    required this.quantity,
    required this.textTheme,
    required this.onQuantityChanged,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: cardBg,
      borderRadius: BorderRadius.circular(17),
      child: InkWell(
        borderRadius: BorderRadius.circular(17),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FoodDetailScreen(foodId: item.id),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: cardBg,
            borderRadius: BorderRadius.circular(17),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: .3),
                blurRadius: 11,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 1. IMAGE COLUMN
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  item.imageUrl,
                  width: 64,
                  height: 64,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    width: 64,
                    height: 64,
                    color: subtleGray,
                    child: const Icon(Icons.restaurant_menu, color: charcoal, size: 26),
                  ),
                ),
              ),
              const SizedBox(width: 18),

              // 2. DESCRIPTION & PRICE COLUMN
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      item.name,
                      style: textTheme.titleMedium?.copyWith(
                        fontFamily: 'Georgia',
                        fontWeight: FontWeight.bold,
                        fontSize: 17.6,
                        color: charcoal,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 3),
                    Text(
                      item.description,
                      style: textTheme.bodyMedium?.copyWith(
                        fontSize: 14.2,
                        color: charcoal.withValues(alpha: .7),
                        fontFamily: 'Georgia',
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 7),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '\$${item.price}',
                        style: textTheme.titleMedium?.copyWith(
                          fontFamily: 'Georgia',
                          fontWeight: FontWeight.w900,
                          color: charcoal,
                          fontSize: 16.3,
                          letterSpacing: -0.6,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),

              // 3. QUANTITY (Horizontal Row)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _CircleIconButton(
                    icon: Icons.remove,
                    onTap: quantity > 0 ? () => onQuantityChanged(quantity - 1) : null,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      '$quantity',
                      style: textTheme.titleMedium?.copyWith(
                        fontFamily: 'Georgia',
                        fontWeight: FontWeight.w700,
                        fontSize: 16.3,
                        color: charcoal,
                      ),
                    ),
                  ),
                  _CircleIconButton(
                    icon: Icons.add,
                    fillColor: subtleGray,
                    iconColor: charcoal,
                    onTap: () => onQuantityChanged(quantity + 1),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- Small Circle Icon Button for Quantity (+/-) ---
class _CircleIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  final Color fillColor;
  final Color iconColor;

  const _CircleIconButton({
    required this.icon,
    this.onTap,
    this.fillColor = subtleGray,
    this.iconColor = charcoal,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: fillColor,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: SizedBox(
          width: 28,
          height: 28,
          child: Icon(icon, color: iconColor, size: 18),
        ),
      ),
    );
  }
}
