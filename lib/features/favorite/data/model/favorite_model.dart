import 'package:freezed_annotation/freezed_annotation.dart';

part 'favorite_model.g.dart';

/// Flat JSON-friendly DTO for persistence.
@JsonSerializable()
class FavoriteModel {
  final String id;
  final String userId;

  /// Stored as enum name: 'product' | 'vendor' | 'category' | 'service' | 'content'
  final String targetType;
  final String targetId;

  final String? titleSnapshot;
  final String? imageUrlSnapshot;
  final String? vendorIdSnapshot;

  final bool isActive;

  final DateTime? createdAt;
  final DateTime? updatedAt;

  const FavoriteModel({
    required this.id,
    required this.userId,
    required this.targetType,
    required this.targetId,
    this.titleSnapshot,
    this.imageUrlSnapshot,
    this.vendorIdSnapshot,
    this.isActive = true,
    this.createdAt,
    this.updatedAt,
  });

  factory FavoriteModel.fromJson(Map<String, dynamic> json) =>
      _$FavoriteModelFromJson(json);

  Map<String, dynamic> toJson() => _$FavoriteModelToJson(this);
}
