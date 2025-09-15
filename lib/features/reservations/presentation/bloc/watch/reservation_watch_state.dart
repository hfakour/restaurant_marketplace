import 'package:equatable/equatable.dart';
import 'package:restaurant_marketplace/features/reservations/domain/entities/refs/reservation_ref.dart';

class ReservationWatchState extends Equatable {
  final bool isLoading;
  final List<ReservationRef> items;
  final String? error;

  const ReservationWatchState({
    required this.isLoading,
    required this.items,
    this.error,
  });

  factory ReservationWatchState.initial() =>
      const ReservationWatchState(isLoading: false, items: []);

  ReservationWatchState copyWith({
    bool? isLoading,
    List<ReservationRef>? items,
    String? error,
  }) =>
      ReservationWatchState(
        isLoading: isLoading ?? this.isLoading,
        items: items ?? this.items,
        error: error,
      );

  @override
  List<Object?> get props => [isLoading, items, error];
}
