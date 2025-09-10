// presentation/screens/reservation_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/value_objects/reservation_vos.dart';
import '../bloc/detail/reservation_detail_state.dart';
import '../controllers/reservations_controller.dart';

class ReservationDetailScreen extends StatefulWidget {
  final ReservationsController controller;
  final ReservationId id;
  const ReservationDetailScreen({super.key, required this.controller, required this.id});

  @override
  State<ReservationDetailScreen> createState() => _ReservationDetailScreenState();
}

class _ReservationDetailScreenState extends State<ReservationDetailScreen> {
  @override
  void initState() {
    super.initState();
    widget.controller.loadDetail(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reservation Detail')),
      body: BlocBuilder(
        bloc: widget.controller.detail,
        builder: (context, state) {
          final s = state as ReservationDetailState;
          if (s.isLoading) return const Center(child: CircularProgressIndicator());
          if (s.error != null) return Center(child: Text('Error: ${s.error}'));
          final r = s.reservation;
          if (r == null) return const Center(child: Text('Not found'));

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text('ID: ${r.id.value}'),
              const SizedBox(height: 8),
              Text('User: ${r.userId.value}'),
              Text('Restaurant: ${r.restaurantId.value}'),
              Text('When: ${r.scheduledAt.value.toLocal()}'),
              Text('Party Size: ${r.partySize.value}'),
              Text('Status: ${r.status.name}'),
              if (r.specialRequest?.asNullable != null)
                Text('Note: ${r.specialRequest!.asNullable}'),
              const SizedBox(height: 16),
              FilledButton.icon(
                onPressed: () => widget.controller.cancel(r.id),
                icon: const Icon(Icons.cancel),
                label: const Text('Cancel Reservation'),
              ),
            ],
          );
        },
      ),
    );
  }
}
