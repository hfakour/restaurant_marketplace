import '../model/menu_item.dart';

class MenuRepository {
  Future<List<MenuItem>> fetchMenuForRestaurant(String restaurantId) async {
    // In real app, fetch by restaurantId from API!
    // For mock: always returns same data for now
    await Future.delayed(const Duration(milliseconds: 300));
    return [
      MenuItem(
        id: '1',
        name: 'Truffle Risotto',
        description: 'Creamy risotto with black truffles.',
        price: 29.99,
        imageUrl: 'https://images.unsplash.com/photo-1600891964599-f61ba0e24092',
      ),
      MenuItem(
        id: '2',
        name: 'Duck Confit',
        description: 'Slow-cooked duck with red wine glaze.',
        price: 34.50,
        imageUrl: 'https://images.unsplash.com/photo-1600891964599-f61ba0e24092',
      ),
      MenuItem(
        id: '3',
        name: 'Vegan Ratatouille',
        description: 'Mediterranean vegetables with herb oil.',
        price: 21.00,
        imageUrl: 'https://images.unsplash.com/photo-1600891964599-f61ba0e24092',
      ),
    ];
  }
}
