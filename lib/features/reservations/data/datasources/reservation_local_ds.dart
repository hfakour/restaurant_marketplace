// data/datasources/reservation_local_data_source.dart
import 'dart:async';
import 'dart:convert';

import 'package:restaurant_marketplace/features/reservations/domain/entities/refs/reservation_ref.dart';
import 'package:restaurant_marketplace/features/reservations/domain/entities/reservation.dart';
import 'package:restaurant_marketplace/features/reservations/data/mappers/reservation_mapper.dart';
import 'package:restaurant_marketplace/features/reservations/data/models/reservation_model.dart';

/// Local persistence contract for a **client** app.
abstract class ReservationLocalDataSource {
  Future<Reservation?> getById(String id);

  /// Returns lightweight refs (no paging here; repository can page)
  Future<List<ReservationRef>> listRefsForUser({
    required String userId,
    ReservationStatus? status,
  });

  /// Live lightweight refs for list UIs
  Stream<List<ReservationRef>> watchRefsForUser({
    required String userId,
    ReservationStatus? status,
  });

  /// Insert or update the whole reservation (used by create/update).
  Future<void> upsert(Reservation reservation);

  /// Client action: cancel
  Future<void> cancel(String reservationId, {DateTime? now});
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

  ReservationLocalDataSourceImpl(this._store);

  // ---------------- Storage helpers ----------------

  Future<Map<String, ReservationModel>> _load() async {
    final raw = await _store.readString(_kCollectionKey);
    if (raw == null || raw.isEmpty) return {};
    final Map<String, dynamic> decoded =
        jsonDecode(raw) as Map<String, dynamic>;
    return decoded.map(
      (k, v) =>
          MapEntry(k, ReservationModel.fromJson(Map<String, dynamic>.from(v))),
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

  DateTime _now(DateTime? n) => n ?? DateTime.now();

  int _cmpRefNewFirst(ReservationRef a, ReservationRef b) {
    final sa = a.scheduledAt?.millisecondsSinceEpoch ?? 0;
    final sb = b.scheduledAt?.millisecondsSinceEpoch ?? 0;
    final scmp = sb.compareTo(sa);
    if (scmp != 0) return scmp;
    return b.reservationId.compareTo(a.reservationId);
  }

  // ---------------- Query helpers ----------------

  List<ReservationRef> _selectUserRefs({
    required Map<String, ReservationModel> map,
    required String userId,
    ReservationStatus? status,
  }) {
    final ids = _indexByUser(map)[userId];
    if (ids == null || ids.isEmpty) return const [];

    // map -> domain -> ref (so ref always mirrors the entities)
    Iterable<ReservationRef> it = ids
        .map((id) => map[id]!)
        .map((m) => m.toDomain())
        .map(reservationToRef);

    if (status != null) {
      final wanted = status.name;
      it = it.where((ref) => ref.statusSnapshot == wanted);
    }

    final list = it.toList()..sort(_cmpRefNewFirst);
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
  Future<List<ReservationRef>> listRefsForUser({
    required String userId,
    ReservationStatus? status,
  }) async {
    final map = await _load();
    return _selectUserRefs(map: map, userId: userId, status: status);
  }

  @override
  Stream<List<ReservationRef>> watchRefsForUser({
    required String userId,
    ReservationStatus? status,
  }) async* {
    // initial snapshot
    yield await listRefsForUser(userId: userId, status: status);

    await for (final changedUserId in _userChanges.stream) {
      if (changedUserId != userId) continue;
      yield await listRefsForUser(userId: userId, status: status);
    }
  }

  @override
  Future<void> upsert(Reservation reservation) async {
    final map = await _load();
    final id = reservation.id.value; // <-- unwrap VO
    final uid = reservation.userId.value; // <-- unwrap VO

    final existing = map[id];
    map[id] = reservation.toModel(); // mapper unwraps VOs as needed
    await _save(map);

    // Notify the affected user(s)
    _userChanges.add(uid);
    if (existing != null && existing.userId != uid) {
      _userChanges.add(existing.userId);
    }
  }

  @override
  Future<void> cancel(String reservationId, {DateTime? now}) async {
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
      status: ReservationStatus.cancelled.name,
      createdAt: m.createdAt,
      updatedAt: n,
    );
    map[reservationId] = updated;
    await _save(map);

    _userChanges.add(m.userId);
  }

  // For tests
  void dispose() {
    _userChanges.close();
  }
}
