import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:restaurant_marketplace/features/reservations/domain/entities/reservation.dart';
import 'package:restaurant_marketplace/features/reservations/domain/usecase/create_reservation.dart';
import 'package:restaurant_marketplace/features/reservations/domain/usecase/update_reservation.dart';
import 'package:restaurant_marketplace/features/reservations/domain/usecase/cancel_reservation.dart';
import 'package:restaurant_marketplace/features/reservations/domain/value_objects/reservation_vos.dart';
import 'package:restaurant_marketplace/features/reservations/domain/value_objects/reservation_vo_adapters.dart';

import 'reservation_actions_state.dart';

class ReservationActionsCubit extends Cubit<ReservationActionsState> {
  final CreateReservation _create;
  final UpdateReservation _update;
  final CancelReservation _cancel;

  ReservationActionsCubit(this._create, this._update, this._cancel)
      : super(ReservationActionsState.idle());

  // ---------- CREATE (VOs only) ----------
  Future<void> createFromVOs({
    required ReservationId id,
    required UserId userId,
    required RestaurantId restaurantId,
    required UtcDateTime scheduledAt,
    required PartySize partySize,
    SpecialRequest? specialRequest,
    bool mustBeInFuture = false,
  }) async {
    emit(state.copyWith(action: ReservationAction.creating, error: null, createdId: null));
    try {
      await _create.fromVOs(
        id: id,
        userId: userId,
        restaurantId: restaurantId,
        scheduledAt: scheduledAt,
        partySize: partySize,
        specialRequest: specialRequest,
        mustBeInFuture: mustBeInFuture,
      );
      // We trust the repo to persist id.value; we keep the VO here.
      emit(state.copyWith(action: ReservationAction.success, createdId: id));
    } catch (e) {
      emit(state.copyWith(action: ReservationAction.failure, error: e.toString()));
    } finally {
      emit(ReservationActionsState.idle());
    }
  }

  // ---------- UPDATE (entities already VO-based) ----------
  Future<void> updateReservation(Reservation reservation) async {
    emit(state.copyWith(action: ReservationAction.updating, error: null));
    try {
      await _update(reservation);
      emit(state.copyWith(action: ReservationAction.success));
    } catch (e) {
      emit(state.copyWith(action: ReservationAction.failure, error: e.toString()));
    } finally {
      emit(ReservationActionsState.idle());
    }
  }

  /// Optional helper: rebuild entities from VOs at the boundary.
  Future<void> updateFromVOs({
    required ReservationId id,
    required UserId userId,
    required RestaurantId restaurantId,
    required UtcDateTime scheduledAt,
    required PartySize partySize,
    SpecialRequest? specialRequest,
  }) async {
    emit(state.copyWith(action: ReservationAction.updating, error: null));
    try {
      final entity = makeReservationFromVOs(
        id: id,
        userId: userId,
        restaurantId: restaurantId,
        scheduledAt: scheduledAt,
        partySize: partySize,
        specialRequest: specialRequest,
      );
      await _update(entity);
      emit(state.copyWith(action: ReservationAction.success));
    } catch (e) {
      emit(state.copyWith(action: ReservationAction.failure, error: e.toString()));
    } finally {
      emit(ReservationActionsState.idle());
    }
  }

  // ---------- CANCEL (VOs only) ----------
  Future<void> cancelByVO(ReservationId id) async {
    emit(state.copyWith(action: ReservationAction.canceling, error: null));
    try {
      await _cancel.byVO(id);
      emit(state.copyWith(action: ReservationAction.success));
    } catch (e) {
      emit(state.copyWith(action: ReservationAction.failure, error: e.toString()));
    } finally {
      emit(ReservationActionsState.idle());
    }
  }
}
