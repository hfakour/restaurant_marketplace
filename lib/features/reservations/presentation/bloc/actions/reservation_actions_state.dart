import 'package:equatable/equatable.dart';
import 'package:restaurant_marketplace/features/reservations/domain/value_objects/reservation_vos.dart';

enum ReservationAction { idle, creating, updating, canceling, success, failure }

class ReservationActionsState extends Equatable {
  final ReservationAction action;
  /// VO of the reservation created in the last create action (if any)
  final ReservationId? createdId;
  final String? error;

  const ReservationActionsState({
    required this.action,
    this.createdId,
    this.error,
  });

  factory ReservationActionsState.idle() =>
      const ReservationActionsState(action: ReservationAction.idle);

  ReservationActionsState copyWith({
    ReservationAction? action,
    ReservationId? createdId,
    String? error,
  }) =>
      ReservationActionsState(
        action: action ?? this.action,
        createdId: createdId,
        error: error,
      );

  @override
  List<Object?> get props => [action, createdId, error];
}
