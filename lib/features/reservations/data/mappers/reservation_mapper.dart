// data/mappers/reservation_mappers.dart
import '../../domain/entities/reservation.dart';
import '../models/reservation_model.dart';
import '../../../../core/domain_refs/reservation_ref.dart';

/// --------------------
/// Model ↔ Domain
/// --------------------

ReservationStatus _statusFromString(String s) {
  final i = ReservationStatus.values.indexWhere((e) => e.name == s);
  return i == -1 ? ReservationStatus.pending : ReservationStatus.values[i];
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

/// --------------------
/// Domain → Ref
/// --------------------

ReservationRef reservationToRef(Reservation r) {
  return ReservationRef(
    reservationId: r.id,
    statusSnapshot: r.status.name,
    scheduledAt: r.scheduledAt,
    restaurantId: r.restaurantId,
    partySize: r.partySize,
  );
}
