// domain/entities/reservation.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'reservation.freezed.dart';

enum ReservationStatus { pending, confirmed, cancelled, completed, noShow }

@freezed
class Reservation with _$Reservation {
  const factory Reservation({
    required String id,
    required String userId,
    required String restaurantId,
    required DateTime scheduledAt,
    required int partySize,
    String? specialRequest,
    @Default(ReservationStatus.pending) ReservationStatus status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Reservation;
}
