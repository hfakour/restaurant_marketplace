part of 'reservations_bloc.dart';

sealed class ReservationsEvent extends Equatable {
  const ReservationsEvent();
  @override
  List<Object?> get props => [];
}

class LoadReservations extends ReservationsEvent {
  const LoadReservations();
}

class CancelReservationEvent extends ReservationsEvent {
  const CancelReservationEvent(this.reservationId);
  final String reservationId;
}
