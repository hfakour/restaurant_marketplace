part of 'reservations_bloc.dart';

sealed class ReservationsState extends Equatable {
  const ReservationsState();
  @override
  List<Object?> get props => [];
}

class ReservationsInitial extends ReservationsState {
  const ReservationsInitial();
}

class ReservationsLoading extends ReservationsState {
  const ReservationsLoading();
}

class ReservationsLoaded extends ReservationsState {
  const ReservationsLoaded(this.items);
  final List<Reservation> items;
  @override
  List<Object?> get props => [items];
}

class ReservationsError extends ReservationsState {
  const ReservationsError(this.error);
  final Object error;
  @override
  List<Object?> get props => [error];
}
