import '../../domain/entities/reservation.dart';
import '../models/reservation_model.dart';

ReservationStatus _statusFromString(String s) {
  return ReservationStatus.values.firstWhere(
        (e) => e.name == s,
    orElse: () => ReservationStatus.pending,
  );
}

extension ReservationModelX on ReservationModel {
  Reservation toDomain() {
    return Reservation(
      id: id,
      userId: userId,
      restaurantId: restaurantId,
      scheduledAt: scheduledAt,
      partySize: partySize,
      specialRequest: specialRequest,
      status: _statusFromString(status),
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

extension ReservationDomainX on Reservation {
  ReservationModel toModel() {
    return ReservationModel(
      id: id,
      userId: userId,
      restaurantId: restaurantId,
      scheduledAt: scheduledAt,
      partySize: partySize,
      specialRequest: specialRequest,
      status: status.name,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
