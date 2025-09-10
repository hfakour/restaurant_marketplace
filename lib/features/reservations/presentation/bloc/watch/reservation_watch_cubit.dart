import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_marketplace/core/domain_refs/reservation_ref.dart';
import 'package:restaurant_marketplace/features/reservations/domain/entities/reservation.dart';
import 'package:restaurant_marketplace/features/reservations/domain/usecase/watch_user_reservation_refs.dart';
import 'package:restaurant_marketplace/features/reservations/domain/value_objects/reservation_vos.dart';

import 'reservation_watch_state.dart';

class ReservationWatchCubit extends Cubit<ReservationWatchState> {
  final WatchUserReservationRefs _watchRefs;
  StreamSubscription<List<ReservationRef>>? _sub;

  ReservationWatchCubit(this._watchRefs) : super(ReservationWatchState.initial());

  /// VO-only API: start watching a user's reservation refs.
  void start({required UserId userId, ReservationStatus? status}) {
    _sub?.cancel();
    emit(state.copyWith(isLoading: true, error: null));

    _sub = _watchRefs.byVO(userId: userId, status: status).listen(
          (items) => emit(state.copyWith(isLoading: false, items: items)),
      onError: (e, _) => emit(state.copyWith(isLoading: false, error: e.toString())),
    );
  }

  @override
  Future<void> close() {
    _sub?.cancel();
    return super.close();
  }
}
