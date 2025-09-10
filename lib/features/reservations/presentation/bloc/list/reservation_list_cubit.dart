import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_marketplace/features/reservations/domain/entities/reservation.dart';
import 'package:restaurant_marketplace/features/reservations/domain/usecase/list_user_reservation_refs.dart';
import 'package:restaurant_marketplace/features/reservations/domain/value_objects/reservation_vos.dart';

import 'reservation_list_state.dart';

class ReservationListCubit extends Cubit<ReservationListState> {
  final ListUserReservationRefs _listRefs;

  ReservationListCubit(this._listRefs)
      : super(ReservationListState.initial());

  Future<void> loadFirstPage({
    required UserId userId,
    ReservationStatus? status,
    int limit = 20,
  }) async {
    emit(ReservationListState.initial(userId: userId, status: status)
        .copyWith(isLoading: true, error: null));

    try {
      final page = await _listRefs(
        userId: userId.value,  // unwrap VO at boundary
        status: status,
        limit: limit,
      );
      emit(state.copyWith(
        items: page.items,
        nextCursor: page.nextCursor,
        isLoading: false,
        hasMore: page.nextCursor != null,
      ));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> loadMore({int limit = 20}) async {
    final cursor = state.nextCursor;
    final uid = state.userId;
    if (state.isLoadingMore || cursor == null || uid == null) return;

    emit(state.copyWith(isLoadingMore: true, error: null));
    try {
      final page = await _listRefs(
        userId: uid.value,          // unwrap VO
        status: state.filterStatus,
        limit: limit,
        cursor: cursor,
      );
      emit(state.copyWith(
        items: [...state.items, ...page.items],
        nextCursor: page.nextCursor,
        isLoadingMore: false,
        hasMore: page.nextCursor != null,
      ));
    } catch (e) {
      emit(state.copyWith(isLoadingMore: false, error: e.toString()));
    }
  }

  Future<void> refresh({int limit = 20}) {
    final uid = state.userId;
    if (uid == null) return Future.value();
    return loadFirstPage(
      userId: uid,
      status: state.filterStatus,
      limit: limit,
    );
  }

  Future<void> setFilter(ReservationStatus? status, {int limit = 20}) {
    final uid = state.userId;
    if (uid == null) return Future.value();
    return loadFirstPage(userId: uid, status: status, limit: limit);
  }
}
