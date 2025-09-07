import 'dart:async';
import 'dart:convert';

import '../../domain/entities/reservation.dart';
import '../mappers/reservation_mapper.dart';
import '../models/reservation_model.dart';

/// Local persistence contract for Reservations.
/// The repository can do pagination on top of these list methods.
abstract class ReservationLocalDataSource {
  Future<Reservation?> getById(String id);

  Future<List<Reservation>> listForUser({
    required String userId,
    ReservationStatus? status,
  });

  Future<List<Reservation>> listForRestaurant({
    required String restaurantId,
    DateTime? start,
    DateTime? end,
    ReservationStatus? status,
  });

  Stream<List<Reservation>> watchForUser({
    required String userId,
    ReservationStatus? status,
  });

  Stream<List<Reservation>> watchForRestaurant({
    required String restaurantId,
    DateTime? start,
    DateTime? end,
    ReservationStatus? status,
  });

  /// Insert or update the whole reservation.
  Future<void> upsert(Reservation reservation);

  /// Status transitions.
  Future<void> updateStatus(String reservationId, ReservationStatus status, {DateTime? now});
  Future<void> confirm(String reservationId, {DateTime? now});
  Future<void> cancel(String reservationId, {DateTime? now});
  Future<void> complete(String reservationId, {DateTime? now});
  Future<void> markNoShow(String reservationId, {DateTime? now});

  /// Basic conflict search (same restaurant & exact scheduledAt).
  Future<List<Reservation>> findExactConflicts({
    required String restaurantId,
    required DateTime scheduledAt,
  });
}

/// Minimal key-value store so you can plug SharedPreferences/Hive/Isar later.
abstract class LocalStore {
  Future<String?> readString(String key);
  Future<void> writeString(String key, String value);
}

/// Simple in-memory store for tests/dev.
class InMemoryLocalStore implements LocalStore {
  final Map<String, String> _kv = {};
  @override
  Future<String?> readString(String key) async => _kv[key];
  @override
  Future<void> writeString(String key, String value) async {
    _kv[key] = value;
  }
}

/// JSON-backed implementation that stores the collection under one key.
/// Great for tests and early integration. Swap LocalStore for a real backend later.
class ReservationLocalDataSourceImpl implements ReservationLocalDataSource {
  static const _kCollectionKey = 'reservation_collection_v1';

  final LocalStore _store;

  /// Emits userId on user changes.
  final _userChanges = StreamController<String>.broadcast();

  /// Emits restaurantId on restaurant changes.
  final _restaurantChanges = StreamController<String>.broadcast();

  ReservationLocalDataSourceImpl(this._store);

  // ---------------- Storage helpers ----------------

  Future<Map<String, ReservationModel>> _load() async {
    final raw = await _store.readString(_kCollectionKey);
    if (raw == null || raw.isEmpty) return {};
    final Map<String, dynamic> decoded = jsonDecode(raw) as Map<String, dynamic>;
    return decoded.map(
          (k, v) => MapEntry(k, ReservationModel.fromJson(Map<String, dynamic>.from(v))),
    );
  }

  Future<void> _save(Map<String, ReservationModel> map) async {
    final jsonMap = map.map((k, v) => MapEntry(k, v.toJson()));
    await _store.writeString(_kCollectionKey, jsonEncode(jsonMap));
  }

  Map<String, Set<String>> _indexByUser(Map<String, ReservationModel> map) {
    final res = <String, Set<String>>{};
    for (final r in map.values) {
      res.putIfAbsent(r.userId, () => <String>{}).add(r.id);
    }
    return res;
  }

  Map<String, Set<String>> _indexByRestaurant(Map<String, ReservationModel> map) {
    final res = <String, Set<String>>{};
    for (final r in map.values) {
      res.putIfAbsent(r.restaurantId, () => <String>{}).add(r.id);
    }
    return res;
  }

  DateTime _now(DateTime? n) => n ?? DateTime.now();

  int _cmpNewFirst(Reservation a, Reservation b) {
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

  // ---------------- Query helpers ----------------

  List<Reservation> _selectUser({
    required Map<String, ReservationModel> map,
    required String userId,
    ReservationStatus? status,
  }) {
    final ids = _indexByUser(map)[userId];
    if (ids == null || ids.isEmpty) return const [];

    Iterable<ReservationModel> it = ids.map((id) => map[id]!).where((m) => m != null);
    if (status != null) it = it.where((m) => m.status == status.name);

    final list = it.map((m) => m.toDomain()).toList()..sort(_cmpNewFirst);
    return list;
  }

  List<Reservation> _selectRestaurant({
    required Map<String, ReservationModel> map,
    required String restaurantId,
    DateTime? start,
    DateTime? end,
    ReservationStatus? status,
  }) {
    final ids = _indexByRestaurant(map)[restaurantId];
    if (ids == null || ids.isEmpty) return const [];

    Iterable<ReservationModel> it = ids.map((id) => map[id]!).where((m) => m != null);

    if (start != null) it = it.where((m) => !m.scheduledAt.isBefore(start));
    if (end != null) it = it.where((m) => !m.scheduledAt.isAfter(end));
    if (status != null) it = it.where((m) => m.status == status.name);

    final list = it.map((m) => m.toDomain()).toList()..sort(_cmpNewFirst);
    return list;
  }

  // ---------------- Contract ----------------

  @override
  Future<Reservation?> getById(String id) async {
    final map = await _load();
    final m = map[id];
    return m?.toDomain();
  }

  @override
  Future<List<Reservation>> listForUser({
    required String userId,
    ReservationStatus? status,
  }) async {
    final map = await _load();
    return _selectUser(map: map, userId: userId, status: status);
  }

  @override
  Future<List<Reservation>> listForRestaurant({
    required String restaurantId,
    DateTime? start,
    DateTime? end,
    ReservationStatus? status,
  }) async {
    final map = await _load();
    return _selectRestaurant(
      map: map,
      restaurantId: restaurantId,
      start: start,
      end: end,
      status: status,
    );
  }

  @override
  Stream<List<Reservation>> watchForUser({
    required String userId,
    ReservationStatus? status,
  }) async* {
    // initial snapshot
    yield await listForUser(userId: userId, status: status);

    await for (final changedUserId in _userChanges.stream) {
      if (changedUserId != userId) continue;
      yield await listForUser(userId: userId, status: status);
    }
  }

  @override
  Stream<List<Reservation>> watchForRestaurant({
    required String restaurantId,
    DateTime? start,
    DateTime? end,
    ReservationStatus? status,
  }) async* {
    // initial snapshot
    yield await listForRestaurant(
      restaurantId: restaurantId,
      start: start,
      end: end,
      status: status,
    );

    await for (final changedRestaurantId in _restaurantChanges.stream) {
      if (changedRestaurantId != restaurantId) continue;
      yield await listForRestaurant(
        restaurantId: restaurantId,
        start: start,
        end: end,
        status: status,
      );
    }
  }

  @override
  Future<void> upsert(Reservation reservation) async {
    final map = await _load();
    final existing = map[reservation.id];

    // If userId/restaurantId changed, we don't need to maintain indexes here,
    // indexes are rebuilt from the map on demand. Just overwrite the record.
    map[reservation.id] = reservation.toModel();
    await _save(map);

    // Emit change events
    final u = reservation.userId;
    final r = reservation.restaurantId;
    _userChanges.add(u);
    _restaurantChanges.add(r);

    // If we had an existing record with different foreign keys, notify those too.
    if (existing != null) {
      if (existing.userId != u) _userChanges.add(existing.userId);
      if (existing.restaurantId != r) _restaurantChanges.add(existing.restaurantId);
    }
  }

  @override
  Future<void> updateStatus(String reservationId, ReservationStatus status, {DateTime? now}) async {
    final map = await _load();
    final m = map[reservationId];
    if (m == null) return;

    final n = _now(now);
    final updated = ReservationModel(
      id: m.id,
      userId: m.userId,
      restaurantId: m.restaurantId,
      scheduledAt: m.scheduledAt,
      partySize: m.partySize,
      specialRequest: m.specialRequest,
      status: status.name,
      createdAt: m.createdAt,
      updatedAt: n,
    );
    map[reservationId] = updated;
    await _save(map);

    _userChanges.add(m.userId);
    _restaurantChanges.add(m.restaurantId);
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
    final map = await _load();
    final ids = _indexByRestaurant(map)[restaurantId];
    if (ids == null || ids.isEmpty) return const [];
    final list = ids
        .map((id) => map[id]!)
        .where((m) =>
    m.restaurantId == restaurantId &&
        m.scheduledAt.isAtSameMomentAs(scheduledAt) &&
        m.status != ReservationStatus.cancelled.name)
        .map((m) => m.toDomain())
        .toList()
      ..sort(_cmpNewFirst);
    return list;
  }
}
