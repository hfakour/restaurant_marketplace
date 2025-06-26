import '../../menu/model/menu_item.dart';
import 'review.dart';

class Restaurant {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final String chefName;
  final String chefImage;
  final String chefDescription;
  final List<String> galleryImages;
  final List<String> tags;
  final List<MenuItem> menu;
  final List<Review> reviews;
  final String location;
  final String hours;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.chefName,
    required this.chefImage,
    required this.chefDescription,
    required this.galleryImages,
    required this.tags,
    required this.menu,
    required this.reviews,
    required this.location,
    required this.hours,
  });
}
