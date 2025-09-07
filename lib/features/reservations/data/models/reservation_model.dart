import 'package:freezed_annotation/freezed_annotation.dart';

part 'reservation_model.g.dart';

/// Flat, JSON-friendly DTO stored locally.
@JsonSerializable()
class ReservationModel {
  final String id;
  final String userId;
  final String restaurantId;
  final DateTime scheduledAt;
  final int partySize;
  final String? specialRequest;

  /// Stored as enum name: 'pending' | 'confirmed' | 'cancelled' | 'completed' | 'noShow'
  final String status;

  final DateTime? createdAt;
  final DateTime? updatedAt;

  const ReservationModel({
    required this.id,
    required this.userId,
    required this.restaurantId,
    required this.scheduledAt,
    required this.partySize,
    this.specialRequest,
    required this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory ReservationModel.fromJson(Map<String, dynamic> json) =>
      _$ReservationModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReservationModelToJson(this);
}
