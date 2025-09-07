// data/repositories/reservation_repository_impl.dart
import 'dart:async';
import 'package:collection/collection.dart';

import '../../domain/entities/reservation.dart';
import '../../domain/repositories/reservation_repository.dart';

/// In-memory implementation suitable for tests and early wiring.
/// Swap this with a Local/Remote DS backed impl without changing callers.
class ReservationRepositoryImpl implements ReservationRepository {
  // Primary store
  final Map<String, Reservation> _byId = {};

  // Indexes
  final Map<String, Set<String>> _byUser = {};       // userId -> {reservationId}
  final Map<String, Set<String>> _byRestaurant = {}; // restaurantId -> {reservationId}

  // Change streams
  final _userChanges = StreamController<String>.broadcast();        // emits userId
  final _restaurantChanges = StreamController<String>.broadcast();  // emits restaurantId

  ReservationRepositoryImpl({Iterable<Reservation>? seed}) {
    if (seed != null) {
      for (final r in seed) {
        _insertIndexes(r);
      }
    }
  }

  // ---------------- Helpers ----------------

  void _insertIndexes(Reservation r) {
    _byId[r.id] = r;
    _byUser.putIfAbsent(r.userId, () => <String>{}).add(r.id);
    _byRestaurant.putIfAbsent(r.restaurantId, () => <String>{}).add(r.id);
  }

  void _reindexIfKeysChanged(Reservation old, Reservation newer) {
    if (old.userId != newer.userId) {
      _byUser[old.userId]?.remove(old.id);
      _byUser.putIfAbsent(newer.userId, () => <String>{}).add(newer.id);
    }
    if (old.restaurantId != newer.restaurantId) {
      _byRestaurant[old.restaurantId]?.remove(old.id);
      _byRestaurant.putIfAbsent(newer.restaurantId, () => <String>{}).add(newer.id);
    }
  }

  DateTime _now(DateTime? n) => n ?? DateTime.now();

  int _cmpNewFirst(Reservation a, Reservation b) {
    // Sort by scheduledAt desc, then createdAt desc, then id desc
    final sa = a.scheduledAt.millisecondsSinceEpoch;
    final sb = b.scheduledAt.millisecondsSinceEpoch;
    final scmp = sb.compareTo(sa);
    if (scmp != 0) return scmp;

    final ca = a.createdAt?.millisecondsSinceEpoch ?? 0;
    final cb = b.createdAt?.millisecondsSinceEpoch ?? 0;
    final ccmp = cb.compareTo(ca);
    if (ccmp != 0) return ccmp;

    return b.id.compareTo(a.id);
  }

  List<Reservation> _filterUser(String userId, {ReservationStatus? status}) {
    final ids = _byUser[userId];
    if (ids == null || ids.isEmpty) return const [];
    Iterable<Reservation> it = ids.map((id) => _byId[id]).whereNotNull();
    if (status != null) it = it.where((r) => r.status == status);
    final list = it.toList()..sort(_cmpNewFirst);
    return list;
  }

  List<Reservation> _filterRestaurant(
      String restaurantId, {
        DateTime? start,
        DateTime? end,
        ReservationStatus? status,
      }) {
    final ids = _byRestaurant[restaurantId];
    if (ids == null || ids.isEmpty) return const [];
    Iterable<Reservation> it = ids.map((id) => _byId[id]).whereNotNull();

    if (start != null) it = it.where((r) => !r.scheduledAt.isBefore(start));
    if (end != null) it = it.where((r) => !r.scheduledAt.isAfter(end));
    if (status != null) it = it.where((r) => r.status == status);

    final list = it.toList()..sort(_cmpNewFirst);
    return list;
  }

  Reservation _setStatus(Reservation r, ReservationStatus s, DateTime n) =>
      r.copyWith(status: s, updatedAt: n);

  // --------------- Contract ----------------

  @override
  Future<Reservation?> getById(String id) async => _byId[id];

  @override
  Future<ReservationSearchPage> listForUser({
    required String userId,
    ReservationStatus? status,
    int limit = 50,
    String? cursor,
  }) async {
    final start = int.tryParse(cursor ?? '0') ?? 0;
    final all = _filterUser(userId, status: status);
    final page = all.skip(start).take(limit).toList();
    final next = (start + page.length) < all.length ? '${start + limit}' : null;
    return ReservationSearchPage(items: page, nextCursor: next);
  }

  @override
  Future<ReservationSearchPage> listForRestaurant({
    required String restaurantId,
    DateTime? start,
    DateTime? end,
    ReservationStatus? status,
    int limit = 50,
    String? cursor,
  }) async {
    final off = int.tryParse(cursor ?? '0') ?? 0;
    final all = _filterRestaurant(
      restaurantId,
      start: start,
      end: end,
      status: status,
    );
    final page = all.skip(off).take(limit).toList();
    final next = (off + page.length) < all.length ? '${off + limit}' : null;
    return ReservationSearchPage(items: page, nextCursor: next);
  }

  @override
  Stream<List<Reservation>> watchForUser({
    required String userId,
    ReservationStatus? status,
  }) async* {
    // initial
    yield _filterUser(userId, status: status);

    await for (final changedUser in _userChanges.stream) {
      if (changedUser != userId) continue;
      yield _filterUser(userId, status: status);
    }
  }

  @override
  Stream<List<Reservation>> watchForRestaurant({
    required String restaurantId,
    DateTime? start,
    DateTime? end,
    ReservationStatus? status,
  }) async* {
    // initial
    yield _filterRestaurant(restaurantId, start: start, end: end, status: status);

    await for (final changedRestaurant in _restaurantChanges.stream) {
      if (changedRestaurant != restaurantId) continue;
      yield _filterRestaurant(restaurantId, start: start, end: end, status: status);
    }
  }

  @override
  Future<String> create(Reservation reservation) async {
    if (_byId.containsKey(reservation.id)) {
      throw StateError('Reservation with id ${reservation.id} already exists');
    }
    _insertIndexes(reservation);
    _userChanges.add(reservation.userId);
    _restaurantChanges.add(reservation.restaurantId);
    return reservation.id;
  }

  @override
  Future<void> update(Reservation reservation) async {
    final current = _byId[reservation.id];
    if (current == null) {
      // upsert semantics
      _insertIndexes(reservation);
      _userChanges.add(reservation.userId);
      _restaurantChanges.add(reservation.restaurantId);
      return;
    }
    _reindexIfKeysChanged(current, reservation);
    _byId[reservation.id] = reservation;
    _userChanges.add(reservation.userId);
    _restaurantChanges.add(reservation.restaurantId);
  }

  @override
  Future<void> updateStatus(String reservationId, ReservationStatus status, {DateTime? now}) async {
    final r = _byId[reservationId];
    if (r == null) return;
    final n = _now(now);
    final updated = _setStatus(r, status, n);
    _byId[reservationId] = updated;
    _userChanges.add(updated.userId);
    _restaurantChanges.add(updated.restaurantId);
  }

  @override
  Future<void> confirm(String reservationId, {DateTime? now}) =>
      updateStatus(reservationId, ReservationStatus.confirmed, now: now);

  @override
  Future<void> cancel(String reservationId, {DateTime? now}) =>
      updateStatus(reservationId, ReservationStatus.cancelled, now: now);

  @override
  Future<void> complete(String reservationId, {DateTime? now}) =>
      updateStatus(reservationId, ReservationStatus.completed, now: now);

  @override
  Future<void> markNoShow(String reservationId, {DateTime? now}) =>
      updateStatus(reservationId, ReservationStatus.noShow, now: now);

  @override
  Future<List<Reservation>> findExactConflicts({
    required String restaurantId,
    required DateTime scheduledAt,
  }) async {
    final ids = _byRestaurant[restaurantId];
    if (ids == null || ids.isEmpty) return const [];
    return ids
        .map((id) => _byId[id])
        .whereNotNull()
        .where((r) =>
    r.restaurantId == restaurantId &&
        r.scheduledAt.isAtSameMomentAs(scheduledAt) &&
        r.status != ReservationStatus.cancelled)
        .toList()
      ..sort(_cmpNewFirst);
  }
}
