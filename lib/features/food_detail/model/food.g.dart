// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FoodImpl _$$FoodImplFromJson(Map<String, dynamic> json) => _$FoodImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  restaurantId: json['restaurantId'] as String,
  description: json['description'] as String,
  originalPrice: (json['originalPrice'] as num).toDouble(),
  discountPercentage: (json['discountPercentage'] as num).toDouble(),
  imageUrl: json['imageUrl'] as String,
  category: json['category'] as String,
  tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
  ingredients:
      (json['ingredients'] as List<dynamic>).map((e) => e as String).toList(),
  allergens:
      (json['allergens'] as List<dynamic>).map((e) => e as String).toList(),
  rating: (json['rating'] as num).toDouble(),
  reviewsCount: (json['reviewsCount'] as num).toInt(),
  vendor: Vendor.fromJson(json['vendor'] as Map<String, dynamic>),
  reviews:
      (json['reviews'] as List<dynamic>?)
          ?.map((e) => Review.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$$FoodImplToJson(_$FoodImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'restaurantId': instance.restaurantId,
      'description': instance.description,
      'originalPrice': instance.originalPrice,
      'discountPercentage': instance.discountPercentage,
      'imageUrl': instance.imageUrl,
      'category': instance.category,
      'tags': instance.tags,
      'ingredients': instance.ingredients,
      'allergens': instance.allergens,
      'rating': instance.rating,
      'reviewsCount': instance.reviewsCount,
      'vendor': instance.vendor,
      'reviews': instance.reviews,
    };
