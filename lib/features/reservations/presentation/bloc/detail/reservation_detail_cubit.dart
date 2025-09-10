import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_marketplace/features/reservations/domain/usecase/get_reservation_detail.dart';
import 'package:restaurant_marketplace/features/reservations/domain/value_objects/reservation_vos.dart';

import 'reservation_detail_state.dart';

class ReservationDetailCubit extends Cubit<ReservationDetailState> {
  final GetReservationDetail _getDetail;
  ReservationDetailCubit(this._getDetail)
      : super(ReservationDetailState.initial());

  /// VO-only API: load details for a ReservationId
  Future<void> load(ReservationId id) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      final res = await _getDetail.byVO(id); // uses VO-aware use case
      emit(state.copyWith(isLoading: false, reservation: res));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }
}
