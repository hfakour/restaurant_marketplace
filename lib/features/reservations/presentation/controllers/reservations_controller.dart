// presentation/controller/reservations_controller.dart
import 'dart:async';

import '../../domain/entities/reservation.dart';
import '../../domain/usecase/cancel_reservation.dart';
import '../../domain/usecase/create_reservation.dart';
import '../../domain/usecase/get_reservation_detail.dart';
import '../../domain/usecase/list_user_reservation_refs.dart';
import '../../domain/usecase/update_reservation.dart';
import '../../domain/usecase/watch_user_reservation_refs.dart';
import '../../domain/value_objects/reservation_vos.dart';

import '../bloc/actions/reservation_actions_cubit.dart';
import '../bloc/detail/reservation_detail_cubit.dart';
import '../bloc/list/reservation_list_cubit.dart';
import '../bloc/watch/reservation_watch_cubit.dart';

/// High-level façade for the Reservations feature.
/// - Owns the Cubits
/// - Exposes VO-only methods for screens/widgets
class ReservationsController {
  // Cubits
  final ReservationActionsCubit actions;
  final ReservationDetailCubit detail;
  final ReservationListCubit list;
  final ReservationWatchCubit watch;

  ReservationsController._({
    required this.actions,
    required this.detail,
    required this.list,
    required this.watch,
  });

  /// Factory: inject use cases (from DI) and build cubits.
  factory ReservationsController.fromUsecases({
    required CreateReservation createReservation,
    required UpdateReservation updateReservation,
    required CancelReservation cancelReservation,
    required GetReservationDetail getReservationDetail,
    required ListUserReservationRefs listUserReservationRefs,
    required WatchUserReservationRefs watchUserReservationRefs,
  }) {
    return ReservationsController._(
      actions: ReservationActionsCubit(createReservation, updateReservation, cancelReservation),
      detail:  ReservationDetailCubit(getReservationDetail),
      list:    ReservationListCubit(listUserReservationRefs),
      watch:   ReservationWatchCubit(watchUserReservationRefs),
    );
  }

  // ------------------ Convenience VO-only APIs ------------------

  // Actions
  Future<void> create({
    required ReservationId id,
    required UserId userId,
    required RestaurantId restaurantId,
    required UtcDateTime scheduledAt,
    required PartySize partySize,
    SpecialRequest? specialRequest,
    bool mustBeInFuture = false,
  }) => actions.createFromVOs(
    id: id,
    userId: userId,
    restaurantId: restaurantId,
    scheduledAt: scheduledAt,
    partySize: partySize,
    specialRequest: specialRequest,
    mustBeInFuture: mustBeInFuture,
  );

  Future<void> updateEntity(Reservation reservation) => actions.updateReservation(reservation);

  Future<void> updateFromVOs({
    required ReservationId id,
    required UserId userId,
    required RestaurantId restaurantId,
    required UtcDateTime scheduledAt,
    required PartySize partySize,
    SpecialRequest? specialRequest,
  }) => actions.updateFromVOs(
    id: id,
    userId: userId,
    restaurantId: restaurantId,
    scheduledAt: scheduledAt,
    partySize: partySize,
    specialRequest: specialRequest,
  );

  Future<void> cancel(ReservationId id) => actions.cancelByVO(id);

  // Detail
  Future<void> loadDetail(ReservationId id) => detail.load(id);

  // List (paged)
  Future<void> loadFirstPage({required UserId userId, ReservationStatus? status, int limit = 20}) =>
      list.loadFirstPage(userId: userId, status: status, limit: limit);

  Future<void> loadMore({int limit = 20}) => list.loadMore(limit: limit);

  Future<void> refreshList({int limit = 20}) => list.refresh(limit: limit);

  Future<void> setFilter(ReservationStatus? status, {int limit = 20}) =>
      list.setFilter(status, limit: limit);

  // Watch (live)
  void startWatch({required UserId userId, ReservationStatus? status}) =>
      watch.start(userId: userId, status: status);

  // Dispose all cubits (e.g., from a StatefulWidget’s dispose)
  Future<void> dispose() async {
    await Future.wait([
      actions.close(),
      detail.close(),
      list.close(),
      watch.close(),
    ]);
  }
}
