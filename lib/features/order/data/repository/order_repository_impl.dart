// data/repositories/order_repository_impl.dart
import 'dart:async';
import 'package:collection/collection.dart';

import '../../domain/entities/order.dart';
import '../../domain/repositories/order_repository.dart';

/// In-memory repository implementation for Orders.
/// Good for tests/dev; swap with a Local/Remote data source later.
class OrderRepositoryImpl implements OrderRepository {
  final Map<String, Order> _byId = {};
  final Map<String, Set<String>> _byUser = {}; // userId -> orderIds
  final _changes = StreamController<String>.broadcast(); // emits userId on change

  OrderRepositoryImpl({Iterable<Order>? seed}) {
    if (seed != null) {
      for (final o in seed) {
        _insert(o);
      }
    }
  }

  // ---------- indexing helpers ----------

  void _insert(Order o) {
    _byId[o.id] = o;
    _byUser.putIfAbsent(o.userId, () => <String>{}).add(o.id);
  }

  void _reindex(Order old, Order updated) {
    if (old.userId != updated.userId) {
      _byUser[old.userId]?.remove(old.id);
      _byUser.putIfAbsent(updated.userId, () => <String>{}).add(updated.id);
    }
    _byId[updated.id] = updated;
  }

  List<Order> _sort(List<Order> list) {
    list.sort((a, b) {
      // Newest first by createdAt; fallback to id
      final ac = a.createdAt?.millisecondsSinceEpoch ?? 0;
      final bc = b.createdAt?.millisecondsSinceEpoch ?? 0;
      final cmp = bc.compareTo(ac);
      return cmp != 0 ? cmp : b.id.compareTo(a.id);
    });
    return list;
  }

  List<Order> _filterStatus(Iterable<Order> it, OrderStatus? status) =>
      status == null ? it.toList() : it.where((o) => o.status == status).toList();

  List<Order> _filterCreatedRange(
      Iterable<Order> it, {
        DateTime? from,
        DateTime? to,
      }) {
    return it.where((o) {
      final c = o.createdAt;
      if (c == null) return false; // if you want to keep, change to 'true'
      final after = from == null || !c.isBefore(from);
      final before = to == null || !c.isAfter(to);
      return after && before;
    }).toList();
  }

  List<Order> _page(List<Order> all, int start, int limit) =>
      all.skip(start).take(limit).toList();

  // ---------- OrderRepository ----------

  @override
  Future<Order?> getById(String id) async => _byId[id];

  @override
  Future<OrderSearchPage> listForUser({
    required String userId,
    OrderStatus? status,
    int limit = 20,
    String? cursor,
  }) async {
    final start = int.tryParse(cursor ?? '0') ?? 0;
    final ids = _byUser[userId];
    if (ids == null || ids.isEmpty) {
      return const OrderSearchPage(items: [], nextCursor: null);
    }

    final filtered = _filterStatus(
      ids.map((id) => _byId[id]).whereNotNull(),
      status,
    );

    final sorted = _sort(filtered);
    final page = _page(sorted, start, limit);
    final next = (start + page.length) < sorted.length ? '${start + limit}' : null;

    return OrderSearchPage(items: page, nextCursor: next);
  }

  @override
  Future<OrderSearchPage> search({
    OrderStatus? status,
    DateTime? createdFrom,
    DateTime? createdTo,
    int limit = 20,
    String? cursor,
  }) async {
    final start = int.tryParse(cursor ?? '0') ?? 0;

    Iterable<Order> it = _byId.values;
    it = _filterStatus(it, status);
    final ranged = _filterCreatedRange(it, from: createdFrom, to: createdTo);
    final sorted = _sort(ranged);
    final page = _page(sorted, start, limit);
    final next = (start + page.length) < sorted.length ? '${start + limit}' : null;

    return OrderSearchPage(items: page, nextCursor: next);
  }

  @override
  Stream<List<Order>> watchForUser({
    required String userId,
    OrderStatus? status,
  }) async* {
    List<Order> snapshot() {
      final ids = _byUser[userId] ?? const <String>{};
      final list = _filterStatus(ids.map((id) => _byId[id]).whereNotNull(), status);
      return _sort(list);
    }

    // initial
    yield snapshot();

    await for (final changedUser in _changes.stream) {
      if (changedUser != userId) continue;
      yield snapshot();
    }
  }

  @override
  Future<String> create(Order order) async {
    if (_byId.containsKey(order.id)) {
      throw StateError('Order with id ${order.id} already exists');
    }
    _insert(order);
    _changes.add(order.userId);
    return order.id;
  }

  @override
  Future<void> update(Order order) async {
    final current = _byId[order.id];
    if (current == null) {
      _insert(order);
      _changes.add(order.userId);
      return;
    }
    _reindex(current, order);
    _changes.add(order.userId);
  }

  @override
  Future<Order?> setStatus(String orderId, OrderStatus status, {DateTime? now}) async {
    final n = now ?? DateTime.now();
    final cur = _byId[orderId];
    if (cur == null) return null;

    Order next = cur.copyWith(
      status: status,
      updatedAt: n,
      cancelledAt: cur.cancelledAt,
      completedAt: cur.completedAt,
    );

    // Canonical timestamps for notable transitions
    switch (status) {
      case OrderStatus.cancelled:
        next = next.copyWith(cancelledAt: next.cancelledAt ?? n);
        break;
      case OrderStatus.completed:
        next = next.copyWith(completedAt: next.completedAt ?? n);
        break;
      default:
      // no-op
        break;
    }

    _reindex(cur, next);
    _changes.add(next.userId);
    return next;
  }
}
