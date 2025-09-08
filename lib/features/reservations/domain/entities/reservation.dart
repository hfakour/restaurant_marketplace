// domain/entities/reservation.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import '../value_objects/reservation_vos.dart';

part 'reservation.freezed.dart';

enum ReservationStatus { pending, confirmed, cancelled, completed, noShow }

@freezed
class Reservation with _$Reservation {
  const Reservation._(); // allows custom getters below

  const factory Reservation({
    required ReservationId id,
    required UserId userId,
    required RestaurantId restaurantId,
    required UtcDateTime scheduledAt,
    required PartySize partySize,
    SpecialRequest? specialRequest,
    @Default(ReservationStatus.pending) ReservationStatus status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Reservation;

  // --- Convenience (keeps the rest of the app ergonomic) ---
  String get idStr => id.value;
  String get userIdStr => userId.value;
  String get restaurantIdStr => restaurantId.value;
  DateTime get scheduledAtUtc => scheduledAt.value;
  int get partySizeInt => partySize.value;
  String? get specialRequestStr => specialRequest?.asNullable;
}
