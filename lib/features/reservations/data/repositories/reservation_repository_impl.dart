// data/repositories/reservation_repository_impl.dart
import 'dart:async';

import 'package:restaurant_marketplace/core/domain_refs/reservation_ref.dart';
import 'package:restaurant_marketplace/features/reservations/domain/entities/reservation.dart';
import 'package:restaurant_marketplace/features/reservations/domain/repositories/reservation_repository.dart';

/// In-memory implementation for client app (tests, early wiring).
/// - Lists/streams use lightweight ReservationRef
/// - Details are fetched by id as full Reservation
class ReservationRepositoryImpl implements ReservationRepository {
  // ---------------- Storage ----------------

  // Full entities by id
  final Map<String, Reservation> _byId = {};

  // Index: userId -> {reservationId}
  final Map<String, Set<String>> _byUser = {};

  // Lightweight refs per user: userId -> (reservationId -> ref)
  final Map<String, Map<String, ReservationRef>> _refsByUser = {};

  // Change stream: emits userId whose list changed
  final _userChanges = StreamController<String>.broadcast();

  ReservationRepositoryImpl({Iterable<Reservation>? seed}) {
    if (seed != null) {
      for (final r in seed) {
        _insertIndexes(r);
        _upsertRefForUser(r);
      }
    }
  }

  // ---------------- Helpers ----------------

  // Entity -> Ref snapshot (kept private; same shape as discussed)
  ReservationRef _toRef(Reservation r) => ReservationRef(
    reservationId: r.id,
    statusSnapshot: r.status.name,
    scheduledAt: r.scheduledAt,
    restaurantId: r.restaurantId,
    partySize: r.partySize,
  );

  void _insertIndexes(Reservation r) {
    _byId[r.id] = r;
    _byUser.putIfAbsent(r.userId, () => <String>{}).add(r.id);
  }

  void _removeFromUserIndex(String userId, String reservationId) {
    final s = _byUser[userId];
    s?.remove(reservationId);
    if (s != null && s.isEmpty) _byUser.remove(userId);

    final m = _refsByUser[userId];
    m?.remove(reservationId);
    if (m != null && m.isEmpty) _refsByUser.remove(userId);
  }

  void _reindexIfUserChanged(Reservation old, Reservation newer) {
    if (old.userId == newer.userId) return;
    _removeFromUserIndex(old.userId, old.id);
    _byUser.putIfAbsent(newer.userId, () => <String>{}).add(newer.id);

    // Move ref to new user
    final oldBucket = _refsByUser.putIfAbsent(old.userId, () => <String, ReservationRef>{});
    final ref = oldBucket.remove(old.id);
    if (ref != null) {
      _refsByUser.putIfAbsent(newer.userId, () => <String, ReservationRef>{})[newer.id] = ref;
    }
  }

  void _upsertRefForUser(Reservation r) {
    final bucket = _refsByUser.putIfAbsent(r.userId, () => <String, ReservationRef>{});
    bucket[r.id] = _toRef(r);
  }

  DateTime _now(DateTime? n) => n ?? DateTime.now();

  // Sort refs: scheduledAt desc, then id desc (stable + deterministic)
  int _cmpRefNewFirst(ReservationRef a, ReservationRef b) {
    final sa = a.scheduledAt?.millisecondsSinceEpoch ?? 0;
    final sb = b.scheduledAt?.millisecondsSinceEpoch ?? 0;
    final scmp = sb.compareTo(sa);
    if (scmp != 0) return scmp;
    return (b.reservationId).compareTo(a.reservationId);
  }

  List<ReservationRef> _filterRefsForUser(
      String userId, {
        ReservationStatus? status,
      }) {
    final map = _refsByUser[userId];
    if (map == null || map.isEmpty) return const [];
    Iterable<ReservationRef> it = map.values;

    if (status != null) {
      final wanted = status.name;
      it = it.where((ref) => ref.statusSnapshot == wanted);
    }

    final list = it.toList()..sort(_cmpRefNewFirst);
    return list;
  }

  // ---------------- Contract ----------------

  @override
  Future<Reservation?> getById(String id) async => _byId[id];

  @override
  Future<ReservationRefPage> listRefsForUser({
    required String userId,
    ReservationStatus? status,
    int limit = 50,
    String? cursor,
  }) async {
    final start = int.tryParse(cursor ?? '0') ?? 0;
    final all = _filterRefsForUser(userId, status: status);
    final page = all.skip(start).take(limit).toList();
    final hasMore = (start + page.length) < all.length;
    final next = hasMore ? '${start + page.length}' : null;
    return ReservationRefPage(items: page, nextCursor: next);
  }

  @override
  Stream<List<ReservationRef>> watchRefsForUser({
    required String userId,
    ReservationStatus? status,
  }) async* {
    // initial
    yield _filterRefsForUser(userId, status: status);

    await for (final changedUser in _userChanges.stream) {
      if (changedUser != userId) continue;
      yield _filterRefsForUser(userId, status: status);
    }
  }

  @override
  Future<String> create(Reservation reservation) async {
    if (_byId.containsKey(reservation.id)) {
      throw StateError('Reservation with id ${reservation.id} already exists');
    }
    _insertIndexes(reservation);
    _upsertRefForUser(reservation);
    _userChanges.add(reservation.userId);
    return reservation.id;
  }

  @override
  Future<void> update(Reservation reservation) async {
    final current = _byId[reservation.id];
    if (current == null) {
      // upsert semantics for safety
      _insertIndexes(reservation);
      _upsertRefForUser(reservation);
      _userChanges.add(reservation.userId);
      return;
    }

    _reindexIfUserChanged(current, reservation);
    _byId[reservation.id] = reservation;

    // refresh snapshot
    _upsertRefForUser(reservation);

    // notify both old and new user buckets if user moved
    _userChanges.add(current.userId);
    _userChanges.add(reservation.userId);
  }

  @override
  Future<void> cancel(String reservationId, {DateTime? now}) async {
    final r = _byId[reservationId];
    if (r == null) return;

    final n = _now(now);
    final cancelled = r.copyWith(status: ReservationStatus.cancelled, updatedAt: n);

    _byId[reservationId] = cancelled;
    _upsertRefForUser(cancelled);
    _userChanges.add(cancelled.userId);
  }

  // ---------------- Dispose (for tests) ----------------

  void dispose() {
    _userChanges.close();
  }
}
