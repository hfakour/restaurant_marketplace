import 'package:freezed_annotation/freezed_annotation.dart';

part 'reservation_model.freezed.dart';
part 'reservation_model.g.dart';

/// Flat, JSON-friendly DTO stored locally.
///
/// - Still stringifies [status] as enum name for storage.
/// - Freezed gives you immutability, copyWith, equality, etc.
@freezed
class ReservationModel with _$ReservationModel {
  const factory ReservationModel({
    required String id,
    required String userId,
    required String restaurantId,
    required DateTime scheduledAt,
    required int partySize,
    String? specialRequest,

    /// Stored as enum name: 'pending' | 'confirmed' | 'cancelled' | 'completed' | 'noShow'
    required String status,

    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _ReservationModel;

  factory ReservationModel.fromJson(Map<String, dynamic> json) =>
      _$ReservationModelFromJson(json);
}
