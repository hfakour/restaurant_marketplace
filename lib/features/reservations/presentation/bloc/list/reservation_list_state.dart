import 'package:equatable/equatable.dart';
import 'package:restaurant_marketplace/core/domain_refs/reservation_ref.dart';
import 'package:restaurant_marketplace/features/reservations/domain/entities/reservation.dart';
import 'package:restaurant_marketplace/features/reservations/domain/value_objects/reservation_vos.dart';

class ReservationListState extends Equatable {
  final UserId? userId; // VO
  final ReservationStatus? filterStatus;
  final List<ReservationRef> items;
  final String? nextCursor;
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasMore;
  final String? error;

  const ReservationListState({
    required this.userId,
    required this.items,
    this.filterStatus,
    this.nextCursor,
    this.isLoading = false,
    this.isLoadingMore = false,
    this.hasMore = false,
    this.error,
  });

  factory ReservationListState.initial({UserId? userId, ReservationStatus? status}) =>
      ReservationListState(userId: userId, items: const [], filterStatus: status);

  ReservationListState copyWith({
    UserId? userId,
    ReservationStatus? filterStatus,
    List<ReservationRef>? items,
    String? nextCursor,
    bool? isLoading,
    bool? isLoadingMore,
    bool? hasMore,
    String? error,
  }) {
    return ReservationListState(
      userId: userId ?? this.userId,
      filterStatus: filterStatus ?? this.filterStatus,
      items: items ?? this.items,
      nextCursor: nextCursor ?? this.nextCursor,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
      error: error,
    );
  }

  @override
  List<Object?> get props => [
    userId,
    filterStatus,
    items,
    nextCursor,
    isLoading,
    isLoadingMore,
    hasMore,
    error,
  ];
}
