// presentation/screens/reservations_list_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_marketplace/features/reservations/presentation/screens/reservation_detail_screen.dart';

import '../../data/repositories/reservation_repository_impl.dart';
import '../../domain/entities/reservation.dart';
import '../../domain/value_objects/reservation_vos.dart';
import '../../domain/usecase/create_reservation.dart';
import '../../domain/usecase/update_reservation.dart';
import '../../domain/usecase/cancel_reservation.dart';
import '../../domain/usecase/get_reservation_detail.dart';
import '../../domain/usecase/list_user_reservation_refs.dart';
import '../../domain/usecase/watch_user_reservation_refs.dart';

import '../bloc/list/reservation_list_state.dart';
import '../controllers/reservations_controller.dart';

class ReservationsListScreen extends StatefulWidget {
  final UserId userId; // VO
  const ReservationsListScreen({super.key, required this.userId});

  @override
  State<ReservationsListScreen> createState() => _ReservationsListScreenState();
}

class _ReservationsListScreenState extends State<ReservationsListScreen> {
  late final ReservationsController controller;
  final _scroll = ScrollController();

  @override
  void initState() {
    super.initState();

    // ---- Minimal wiring (no DI / Provider) ----
    final repo = ReservationRepositoryImpl(); // in-memory impl; swap later
    controller = ReservationsController.fromUsecases(
      createReservation: CreateReservation(repo),
      updateReservation: UpdateReservation(repo),
      cancelReservation: CancelReservation(repo),
      getReservationDetail: GetReservationDetail(repo),
      listUserReservationRefs: ListUserReservationRefs(repo),
      watchUserReservationRefs: WatchUserReservationRefs(repo),
    );

    // initial load + optional watch
    controller.loadFirstPage(userId: widget.userId);
    controller.startWatch(userId: widget.userId);

    _scroll.addListener(_maybeLoadMore);
  }

  void _maybeLoadMore() {
    if (_scroll.position.pixels >= _scroll.position.maxScrollExtent - 200) {
      controller.loadMore();
    }
  }

  @override
  void dispose() {
    _scroll.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Reservations'),
        actions: [
          PopupMenuButton<ReservationStatus?>(
            icon: const Icon(Icons.filter_list),
            onSelected: (s) => controller.setFilter(s),
            itemBuilder: (ctx) => const [
              PopupMenuItem(value: null,        child: Text('All')),
              PopupMenuItem(value: ReservationStatus.pending,   child: Text('Pending')),
              PopupMenuItem(value: ReservationStatus.confirmed, child: Text('Confirmed')),
              PopupMenuItem(value: ReservationStatus.cancelled, child: Text('Cancelled')),
              PopupMenuItem(value: ReservationStatus.completed, child: Text('Completed')),
              PopupMenuItem(value: ReservationStatus.noShow,    child: Text('No Show')),
            ],
          ),
        ],
      ),
      body: BlocBuilder(
        bloc: controller.list, // <ReservationListCubit, ReservationListState>
        builder: (context, state) {
          final s = state as ReservationListState;

          if (s.isLoading && s.items.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          if (s.error != null && s.items.isEmpty) {
            return Center(child: Text('Error: ${s.error}'));
          }

          return RefreshIndicator(
            onRefresh: () => controller.refreshList(),
            child: ListView.builder(
              controller: _scroll,
              itemCount: s.items.length + (s.isLoadingMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index >= s.items.length) {
                  return const Padding(
                    padding: EdgeInsets.all(16),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                final ref = s.items[index];
                return ListTile(
                  title: Text('Party of ${ref.partySize ?? 0} · ${ref.statusSnapshot ?? '-'}'),
                  subtitle: Text(
                    ref.scheduledAt?.toLocal().toString() ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  onTap: () {
                    // Navigate to detail screen with VO id
                    final id = ReservationId.create(ref.reservationId);
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => ReservationDetailScreen(controller: controller, id: id),
                    ));
                  },
                  trailing: _CancelButton(controller: controller, refId: ref.reservationId),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class _CancelButton extends StatelessWidget {
  final ReservationsController controller;
  final String refId; // ref stores raw string id
  const _CancelButton({required this.controller, required this.refId});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.cancel),
      onPressed: () => controller.cancel(ReservationId.create(refId)),
      tooltip: 'Cancel',
    );
  }
}
