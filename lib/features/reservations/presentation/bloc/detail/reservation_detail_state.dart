import 'package:equatable/equatable.dart';
import 'package:restaurant_marketplace/features/reservations/domain/entities/reservation.dart';

class ReservationDetailState extends Equatable {
  final bool isLoading;
  final Reservation? reservation;
  final String? error;

  const ReservationDetailState({
    required this.isLoading,
    this.reservation,
    this.error,
  });

  factory ReservationDetailState.initial() =>
      const ReservationDetailState(isLoading: false);

  ReservationDetailState copyWith({
    bool? isLoading,
    Reservation? reservation,
    String? error,
  }) =>
      ReservationDetailState(
        isLoading: isLoading ?? this.isLoading,
        reservation: reservation ?? this.reservation,
        error: error,
      );

  @override
  List<Object?> get props => [isLoading, reservation, error];
}
