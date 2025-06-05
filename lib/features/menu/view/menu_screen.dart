import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodel/menu_viewmodel.dart';
import '../../food_detail/view/food_detail_screen.dart';

class MenuScreen extends ConsumerWidget {
  final String restaurantId;
  const MenuScreen({required this.restaurantId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final menuAsync = ref.watch(menuProvider(restaurantId));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu'),
        backgroundColor: Colors.brown,
      ),
      body: menuAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (menu) {
          return ListView.builder(
            itemCount: menu.length,
            itemBuilder: (context, index) {
              final item = menu[index];
              return Card(
                margin: const EdgeInsets.all(12),
                child: ListTile(
                  leading: Image.network(item.imageUrl, width: 60, fit: BoxFit.cover),
                  title: Text(item.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(item.description),
                  trailing: Text('\$${item.price}', style: const TextStyle(color: Color(0xFFD4AF37))),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FoodDetailScreen(foodId: item.id),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
