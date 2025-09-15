import 'package:freezed_annotation/freezed_annotation.dart';

part 'reservation_ref.freezed.dart';


@freezed
class ReservationRef with _$ReservationRef {
  const factory ReservationRef({
    required String reservationId,
    String? statusSnapshot,
    DateTime? scheduledAt,
    String? restaurantId,
    int? partySize,
  }) = _ReservationRef;
}
