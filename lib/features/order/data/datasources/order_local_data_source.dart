import 'dart:async';
import 'dart:convert';

import 'package:restaurant_marketplace/features/order/data/mapper/order_mapper.dart';

import '../../domain/entities/order.dart';
import '../model/order_model.dart';


/// Local persistence contract for Orders.
abstract class OrderLocalDataSource {
  Future<Order?> getById(String id);

  Future<List<Order>> listForUser({
    required String userId,
    OrderStatus? status,
  });

  Future<List<Order>> search({
    OrderStatus? status,
    DateTime? createdFrom,
    DateTime? createdTo,
  });

  Stream<List<Order>> watchForUser({
    required String userId,
    OrderStatus? status,
  });

  /// Insert or update a full order aggregate.
  Future<void> upsert(Order order);

  /// Update only the status + canonical timestamps.
  Future<Order?> setStatus(String orderId, OrderStatus status, {DateTime? now});
}

/// Minimal key-value storage abstraction.
abstract class LocalStore {
  Future<String?> readString(String key);
  Future<void> writeString(String key, String value);
}

/// In-memory KV store, useful for tests/dev.
class InMemoryLocalStore implements LocalStore {
  final Map<String, String> _kv = {};
  @override
  Future<String?> readString(String key) async => _kv[key];
  @override
  Future<void> writeString(String key, String value) async => _kv[key] = value;
}

/// JSON-backed local data source storing the entire orders collection under one key.
/// Great for small/medium data; switch to Hive/Isar/SQLite with a new LocalStore later.
class OrderLocalDataSourceImpl implements OrderLocalDataSource {
  static const _kCollectionKey = 'orders_collection_v1';

  final LocalStore _store;
  final _userChange = StreamController<String>.broadcast(); // emits userId

  OrderLocalDataSourceImpl(this._store);

  // ---------- persistence helpers ----------
  Future<Map<String, OrderModel>> _load() async {
    final raw = await _store.readString(_kCollectionKey);
    if (raw == null || raw.isEmpty) return {};
    final Map<String, dynamic> decoded = jsonDecode(raw) as Map<String, dynamic>;
    return decoded.map((k, v) => MapEntry(k, OrderModel.fromJson(Map<String, dynamic>.from(v))));
  }

  Future<void> _save(Map<String, OrderModel> map) async {
    final encoded = map.map((k, v) => MapEntry(k, v.toJson()));
    await _store.writeString(_kCollectionKey, jsonEncode(encoded));
  }

  Map<String, Set<String>> _indexByUser(Map<String, OrderModel> map) {
    final res = <String, Set<String>>{};
    for (final m in map.values) {
      res.putIfAbsent(m.userId, () => <String>{}).add(m.id);
    }
    return res;
  }

  List<Order> _sort(List<Order> list) {
    list.sort((a, b) {
      final ac = a.createdAt?.millisecondsSinceEpoch ?? 0;
      final bc = b.createdAt?.millisecondsSinceEpoch ?? 0;
      final cmp = bc.compareTo(ac);
      return cmp != 0 ? cmp : b.id.compareTo(a.id);
    });
    return list;
  }

  List<Order> _filterStatus(Iterable<Order> it, OrderStatus? st) =>
      st == null ? it.toList() : it.where((o) => o.status == st).toList();

  List<Order> _filterCreatedRange(
      Iterable<Order> it, {
        DateTime? from,
        DateTime? to,
      }) {
    return it.where((o) {
      final c = o.createdAt;
      if (c == null) return false; // adjust if you want to include nulls
      final after = from == null || !c.isBefore(from);
      final before = to == null || !c.isAfter(to);
      return after && before;
    }).toList();
  }

  // ---------- OrderLocalDataSource ----------

  @override
  Future<Order?> getById(String id) async {
    final map = await _load();
    final m = map[id];
    return m?.toDomain();
  }

  @override
  Future<List<Order>> listForUser({
    required String userId,
    OrderStatus? status,
  }) async {
    final map = await _load();
    final ids = _indexByUser(map)[userId] ?? const <String>{};
    final orders = ids.map((id) => map[id]!.toDomain()).toList();
    final filtered = _filterStatus(orders, status);
    return _sort(filtered);
  }

  @override
  Future<List<Order>> search({
    OrderStatus? status,
    DateTime? createdFrom,
    DateTime? createdTo,
  }) async {
    final map = await _load();
    final all = map.values.map((m) => m.toDomain()).toList();
    final byStatus = _filterStatus(all, status);
    final ranged = _filterCreatedRange(byStatus, from: createdFrom, to: createdTo);
    return _sort(ranged);
  }

  @override
  Stream<List<Order>> watchForUser({
    required String userId,
    OrderStatus? status,
  }) async* {
    Future<List<Order>> snap() => listForUser(userId: userId, status: status);

    // initial
    yield await snap();

    await for (final changedUser in _userChange.stream) {
      if (changedUser != userId) continue;
      yield await snap();
    }
  }

  @override
  Future<void> upsert(Order order) async {
    final map = await _load();
    map[order.id] = order.toModel();
    await _save(map);
    _userChange.add(order.userId);
  }

  @override
  Future<Order?> setStatus(String orderId, OrderStatus status, {DateTime? now}) async {
    final n = now ?? DateTime.now();
    final map = await _load();
    final cur = map[orderId];
    if (cur == null) return null;

    final curDomain = cur.toDomain();
    Order next = curDomain.copyWith(
      status: status,
      updatedAt: n,
      cancelledAt: curDomain.cancelledAt,
      completedAt: curDomain.completedAt,
    );

    switch (status) {
      case OrderStatus.cancelled:
        next = next.copyWith(cancelledAt: next.cancelledAt ?? n);
        break;
      case OrderStatus.completed:
        next = next.copyWith(completedAt: next.completedAt ?? n);
        break;
      default:
        break;
    }

    map[orderId] = next.toModel();
    await _save(map);
    _userChange.add(next.userId);
    return next;
  }
}
