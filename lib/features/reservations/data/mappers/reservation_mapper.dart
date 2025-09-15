// data/mappers/reservation_mappers.dart
import '../../domain/entities/reservation.dart';
import '../../domain/value_objects/reservation_vos.dart';
import '../models/reservation_model.dart';
import '../../domain/entities/refs/reservation_ref.dart';

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
      id: ReservationId.create(id),
      userId: UserId.create(userId),
      restaurantId: RestaurantId.create(restaurantId),
      scheduledAt: UtcDateTime.create(scheduledAt),
      partySize: PartySize.create(partySize),
      specialRequest: SpecialRequest.create(specialRequest),
      status: _statusFromString(status),
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

extension ReservationDomainX on Reservation {
  ReservationModel toModel() {
    return ReservationModel(
      id: id.value,
      userId: userId.value,
      restaurantId: restaurantId.value,
      scheduledAt: scheduledAt.value,
      partySize: partySize.value,
      specialRequest: specialRequest?.asNullable,
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
    reservationId: r.id.value,
    statusSnapshot: r.status.name,
    scheduledAt: r.scheduledAt.value,
    restaurantId: r.restaurantId.value,
    partySize: r.partySize.value,
  );
}
