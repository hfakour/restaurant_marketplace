import 'dart:async';
import 'dart:convert';


import 'package:restaurant_marketplace/features/discount/data/mapper/discount_mapper.dart';

import '../../domain/entities/discount.dart';
import '../model/discount_model.dart';

/// Abstract persistence contract for local storage.
abstract class DiscountLocalDataSource {
  Future<Discount?> getById(String id, {bool onlyActive = false, DateTime? now});
  Future<Discount?> getByCode(String code, {bool onlyActive = true, DateTime? now});

  Future<List<Discount>> listAll({bool onlyActive = true, DateTime? now});

  /// Upsert (create or update).
  Future<void> upsert(Discount discount);

  /// Soft disable.
  Future<void> deactivate(String id);

  /// Atomically increment redemption counters if allowed.
  Future<bool> tryConsumeRedemption({
    required String discountId,
    required String userId,
    DateTime? now,
  });

  /// Change stream for active set.
  Stream<List<Discount>> watchActive({DateTime? now});
}

/// Minimal key-value storage abstraction (backed by SharedPreferences/Hive/etc.)
abstract class LocalStore {
  Future<void> writeString(String key, String value);
  Future<String?> readString(String key);
}

class InMemoryLocalStore implements LocalStore {
  final Map<String, String> _kv = {};
  @override
  Future<void> writeString(String key, String value) async {
    _kv[key] = value;
  }

  @override
  Future<String?> readString(String key) async => _kv[key];
}

/// JSON-backed implementation that persists a whole collection under a single key.
/// Safe for small to medium sets; swap to Hive/Isar for large datasets.
class DiscountLocalDataSourceImpl implements DiscountLocalDataSource {
  static const _kCollectionKey = 'discount_collection_v1';
  static const _kRedemptionsKey = 'discount_redemptions_v1'; // per-user tracking

  final LocalStore _store;
  final _change = StreamController<void>.broadcast();

  DiscountLocalDataSourceImpl(this._store);

  DateTime _now(DateTime? n) => n ?? DateTime.now();

  Future<Map<String, DiscountModel>> _load() async {
    final raw = await _store.readString(_kCollectionKey);
    if (raw == null || raw.isEmpty) return {};
    final Map<String, dynamic> decoded = jsonDecode(raw) as Map<String, dynamic>;
    return decoded.map((k, v) => MapEntry(k, DiscountModel.fromJson(Map<String, dynamic>.from(v))));
  }

  Future<void> _save(Map<String, DiscountModel> map) async {
    final encoded = map.map((k, v) => MapEntry(k, v.toJson()));
    await _store.writeString(_kCollectionKey, jsonEncode(encoded));
    _change.add(null);
  }

  Future<Map<String, Set<String>>> _loadRedemptions() async {
    final raw = await _store.readString(_kRedemptionsKey);
    if (raw == null || raw.isEmpty) return {};
    final Map<String, dynamic> decoded = jsonDecode(raw) as Map<String, dynamic>;
    return decoded.map((k, v) => MapEntry(k, Set<String>.from(v as List)));
  }

  Future<void> _saveRedemptions(Map<String, Set<String>> map) async {
    final encoded = map.map((k, v) => MapEntry(k, v.toList()));
    await _store.writeString(_kRedemptionsKey, jsonEncode(encoded));
  }

  bool _isWithinWindow(Discount d, DateTime now) {
    final startsOk = d.startsAt == null || !now.isBefore(d.startsAt!);
    final endsOk = d.endsAt == null || !now.isAfter(d.endsAt!);
    return startsOk && endsOk;
  }

  bool _activeAndValid(Discount d, DateTime now) =>
      d.isActive && _isWithinWindow(d, now);

  @override
  Future<Discount?> getById(String id, {bool onlyActive = false, DateTime? now}) async {
    final n = _now(now);
    final map = await _load();
    final model = map[id];
    if (model == null) return null;
    final d = model.toDomain();
    if (onlyActive && !_activeAndValid(d, n)) return null;
    return d;
  }

  @override
  Future<Discount?> getByCode(String code, {bool onlyActive = true, DateTime? now}) async {
    final n = _now(now);
    final map = await _load();
    final model = map.values.firstWhere(
          (m) => (m.code ?? '').toLowerCase() == code.toLowerCase(),
      orElse: () => null as DiscountModel,
    );
    if (model == null) return null;
    final d = model.toDomain();
    if (onlyActive && !_activeAndValid(d, n)) return null;
    return d;
  }

  @override
  Future<List<Discount>> listAll({bool onlyActive = true, DateTime? now}) async {
    final n = _now(now);
    final map = await _load();
    final list = map.values.map((e) => e.toDomain()).toList();
    list.sort((a, b) {
      final ac = a.createdAt?.millisecondsSinceEpoch ?? 0;
      final bc = b.createdAt?.millisecondsSinceEpoch ?? 0;
      final cmp = bc.compareTo(ac);
      return cmp != 0 ? cmp : b.id.compareTo(a.id);
    });
    return onlyActive ? list.where((d) => _activeAndValid(d, n)).toList() : list;
  }

  @override
  Future<void> upsert(Discount discount) async {
    final map = await _load();
    map[discount.id] = discount.toModel();
    await _save(map);
  }

  @override
  Future<void> deactivate(String id) async {
    final map = await _load();
    final model = map[id];
    if (model == null) return;
    map[id] = DiscountModel(
      id: model.id,
      code: model.code,
      trigger: model.trigger,
      valueType: model.valueType,
      percentage: model.percentage,
      amount: model.amount,
      scope: model.scope,
      productIds: model.productIds,
      categoryIds: model.categoryIds,
      minimumSubtotal: model.minimumSubtotal,
      minimumQuantity: model.minimumQuantity,
      isActive: false,
      stackable: model.stackable,
      maxGlobalRedemptions: model.maxGlobalRedemptions,
      globalRedemptionsUsed: model.globalRedemptionsUsed,
      maxPerUser: model.maxPerUser,
      startsAt: model.startsAt,
      endsAt: model.endsAt,
      eligibleUserIds: model.eligibleUserIds,
      newUsersOnly: model.newUsersOnly,
      metadata: model.metadata,
      name: model.name,
      description: model.description,
      createdAt: model.createdAt,
      updatedAt: DateTime.now(),
    );
    await _save(map);
  }

  @override
  Future<bool> tryConsumeRedemption({
    required String discountId,
    required String userId,
    DateTime? now,
  }) async {
    final n = _now(now);

    final map = await _load();
    final model = map[discountId];
    if (model == null) return false;

    final d = model.toDomain();
    if (!_activeAndValid(d, n)) return false;

    // Global limit
    if (d.maxGlobalRedemptions != null &&
        d.globalRedemptionsUsed >= d.maxGlobalRedemptions!) {
      return false;
    }

    // Per-user limit (we track unique users who used it at least once)
    final red = await _loadRedemptions();
    final users = red.putIfAbsent(discountId, () => <String>{});
    if (d.maxPerUser != null) {
      final usedByUser = users.contains(userId) ? 1 : 0;
      if (usedByUser >= d.maxPerUser!) return false;
    }

    // Apply consume: bump counters & record user
    final updated = d.copyWith(
      globalRedemptionsUsed: d.globalRedemptionsUsed + 1,
      updatedAt: n,
    );

    map[discountId] = updated.toModel();
    users.add(userId);
    red[discountId] = users;

    await _save(map);
    await _saveRedemptions(red);
    return true;
  }

  @override
  Stream<List<Discount>> watchActive({DateTime? now}) async* {
    final n = _now(now);
    Future<List<Discount>> snap() async {
      final list = await listAll(onlyActive: true, now: n);
      return list;
    }

    // initial
    yield await snap();
    await for (final _ in _change.stream) {
      yield await snap();
    }
  }
}
