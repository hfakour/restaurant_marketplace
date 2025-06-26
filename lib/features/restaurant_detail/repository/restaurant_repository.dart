import '../model/restaurant.dart';
import '../model/review.dart';
import '../../menu/model/menu_item.dart';

class RestaurantRepository {
  Future<Restaurant> fetchRestaurantById(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return Restaurant(
      id: '1',
      name: 'La Belle Cuisine',
      description: 'Nestled in the heart of the city, La Belle Cuisine offers a journey through the flavors of France...',
      imageUrl: 'https://images.unsplash.com/photo-1579027989536-b7b1f875659b',
      chefName: 'Chef Giovanni',
      chefImage: 'https://images.unsplash.com/photo-1603415526960-f7e0328b77f8',
      chefDescription: 'Michelin-starred chef with over 20 years of culinary artistry.',
      galleryImages: [
        'https://images.unsplash.com/photo-1579027989536-b7b1f875659b',
        'https://images.unsplash.com/photo-1559339352-11b4b4d7e7c5',
        'https://images.unsplash.com/photo-1528605248644-14dd04022da1'
      ],
      tags: ['French', 'Gourmet', 'Vegan Options'],
      menu: [
        MenuItem(
            id: '101',
            name: 'Truffle Risotto',
            description: 'Creamy risotto with black truffles.',
            price: 29.99,
            imageUrl: 'https://images.unsplash.com/photo-1519864600265-abb23847ef2c'
        ),
        MenuItem(
            id: '102',
            name: 'Duck Confit',
            description: 'Slow-cooked duck with red wine glaze.',
            price: 34.50,
            imageUrl: 'https://images.unsplash.com/photo-1519864600265-abb23847ef2c'
        ),
        MenuItem(
            id: '103',
            name: 'Vegan Ratatouille',
            description: 'Mediterranean vegetables with herb oil.',
            price: 21.00,
            imageUrl: 'https://images.unsplash.com/photo-1519864600265-abb23847ef2c'
        ),
      ],
      reviews: [
        Review(name: 'Amelia W.', comment: 'Elegant ambiance and food was divine.', rating: 5),
        Review(name: 'Lucas M.', comment: 'Flawless service and presentation.', rating: 4.5),
      ],
      location: 'https://www.google.com/maps/place/Eiffel+Tower/@48.8584,2.2945,17z',
      hours: 'Mon–Sun: 11:00 AM – 10:00 PM',
    );
  }
}
