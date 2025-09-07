// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavoriteModel _$FavoriteModelFromJson(Map<String, dynamic> json) =>
    FavoriteModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      targetType: json['targetType'] as String,
      targetId: json['targetId'] as String,
      titleSnapshot: json['titleSnapshot'] as String?,
      imageUrlSnapshot: json['imageUrlSnapshot'] as String?,
      vendorIdSnapshot: json['vendorIdSnapshot'] as String?,
      isActive: json['isActive'] as bool? ?? true,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$FavoriteModelToJson(FavoriteModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'targetType': instance.targetType,
      'targetId': instance.targetId,
      'titleSnapshot': instance.titleSnapshot,
      'imageUrlSnapshot': instance.imageUrlSnapshot,
      'vendorIdSnapshot': instance.vendorIdSnapshot,
      'isActive': instance.isActive,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
