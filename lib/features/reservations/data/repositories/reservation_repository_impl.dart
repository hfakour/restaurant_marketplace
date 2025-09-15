// data/repositories/reservation_repository_impl.dart
import 'dart:async';

import 'package:restaurant_marketplace/features/reservations/domain/entities/refs/reservation_ref.dart';
import 'package:restaurant_marketplace/features/reservations/domain/entities/reservation.dart';
import 'package:restaurant_marketplace/features/reservations/domain/repositories/reservation_repository.dart';
import 'package:restaurant_marketplace/features/reservations/data/mappers/reservation_mapper.dart';

/// In-memory implementation for client app (tests, early wiring).
/// - Lists/streams use lightweight ReservationRef
/// - Details are fetched by id as full Reservation
class ReservationRepositoryImpl implements ReservationRepository {
  // ---------------- Storage ----------------

  // Full entities by id (key = reservationId string)
  final Map<String, Reservation> _byId = {};

  // Index: userId string -> {reservationId string}
  final Map<String, Set<String>> _byUser = {};

  // Lightweight refs per user: userId string -> (reservationId string -> ref)
  final Map<String, Map<String, ReservationRef>> _refsByUser = {};

  // Change stream: emits userId (string) whose list changed
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

  void _insertIndexes(Reservation r) {
    final id = r.id.value;
    final uid = r.userId.value;
    _byId[id] = r;
    _byUser.putIfAbsent(uid, () => <String>{}).add(id);
  }

  void _removeFromUserIndex(String userId, String reservationId) {
    final s = _byUser[userId];
    s?.remove(reservationId);
    if (s != null && s.isEmpty) _byUser.remove(userId);

    final m = _refsByUser[userId];
    m?.remove(reservationId);
    if (m != null && m.isEmpty) _refsByUser.remove(userId);
  }

  void _reindexIfUserChanged(Reservation oldR, Reservation newR) {
    // Freezed VOs compare by value, so this is safe.
    if (oldR.userId == newR.userId) return;

    final oldUid = oldR.userId.value;
    final newUid = newR.userId.value;
    final rid = oldR.id.value;

    _removeFromUserIndex(oldUid, rid);
    _byUser.putIfAbsent(newUid, () => <String>{}).add(rid);

    // Move ref bucket entry
    final oldBucket = _refsByUser.putIfAbsent(oldUid, () => <String, ReservationRef>{});
    final ref = oldBucket.remove(rid);
    if (ref != null) {
      _refsByUser.putIfAbsent(newUid, () => <String, ReservationRef>{})[rid] = ref;
    }
  }

  void _upsertRefForUser(Reservation r) {
    final uid = r.userId.value;
    final rid = r.id.value;
    final bucket = _refsByUser.putIfAbsent(uid, () => <String, ReservationRef>{});
    bucket[rid] = reservationToRef(r); // use the mapper
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
    final rid = reservation.id.value;
    final uid = reservation.userId.value;

    if (_byId.containsKey(rid)) {
      throw StateError('Reservation with id $rid already exists');
    }
    _insertIndexes(reservation);
    _upsertRefForUser(reservation);
    _userChanges.add(uid);
    return rid;
  }

  @override
  Future<void> update(Reservation reservation) async {
    final rid = reservation.id.value;
    final uid = reservation.userId.value;

    final current = _byId[rid];
    if (current == null) {
      // upsert semantics for safety
      _insertIndexes(reservation);
      _upsertRefForUser(reservation);
      _userChanges.add(uid);
      return;
    }

    _reindexIfUserChanged(current, reservation);
    _byId[rid] = reservation;

    // refresh snapshot
    _upsertRefForUser(reservation);

    // notify both old and new user buckets if user moved
    _userChanges.add(current.userId.value);
    _userChanges.add(uid);
  }

  @override
  Future<void> cancel(String reservationId, {DateTime? now}) async {
    final r = _byId[reservationId];
    if (r == null) return;

    final n = _now(now);
    final cancelled = r.copyWith(status: ReservationStatus.cancelled, updatedAt: n);

    _byId[reservationId] = cancelled;
    _upsertRefForUser(cancelled);
    _userChanges.add(cancelled.userId.value);
  }

  // ---------------- Dispose (for tests) ----------------

  void dispose() {
    _userChanges.close();
  }
}
