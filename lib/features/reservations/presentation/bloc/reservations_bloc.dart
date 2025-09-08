import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/reservation.dart';
import '../../domain/usecases/list_reservations_for_user.dart';
import '../../domain/usecases/cancel_reservation.dart';

part 'reservations_event.dart';
part 'reservations_state.dart';

class ReservationsBloc extends Bloc<ReservationsEvent, ReservationsState> {
  ReservationsBloc({
    required ListReservationsForUser listReservationsForUser,
    required CancelReservation cancelReservation,
    required this.userId,
  })  : _listReservationsForUser = listReservationsForUser,
        _cancelReservation = cancelReservation,
        super(const ReservationsInitial()) {
    on<LoadReservations>(_onLoad);
    on<CancelReservationEvent>(_onCancel);
  }

  final String userId;
  final ListReservationsForUser _listReservationsForUser;
  final CancelReservation _cancelReservation;

  Future<void> _onLoad(
      LoadReservations event, Emitter<ReservationsState> emit) async {
    emit(const ReservationsLoading());
    try {
      final list = await _listReservationsForUser(userId);
      emit(ReservationsLoaded(list));
    } catch (e) {
      emit(ReservationsError(e));
    }
  }

  Future<void> _onCancel(
      CancelReservationEvent event, Emitter<ReservationsState> emit) async {
    emit(const ReservationsLoading());
    try {
      await _cancelReservation(event.reservationId);
      final list = await _listReservationsForUser(userId);
      emit(ReservationsLoaded(list));
    } catch (e) {
      emit(ReservationsError(e));
    }
  }
}
