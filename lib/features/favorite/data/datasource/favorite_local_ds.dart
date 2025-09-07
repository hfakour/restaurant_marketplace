import 'dart:async';
import 'dart:convert';

import 'package:restaurant_marketplace/features/favorite/data/mapper/favorite_mapper.dart';

import '../../domain/entities/favorite.dart';
import '../model/favorite_model.dart';

/// Local persistence contract for Favorites.
abstract class FavoriteLocalDataSource {
  Future<Favorite?> getById(String id);

  Future<bool> isFavorited({
    required String userId,
    required FavoriteTargetType targetType,
    required String targetId,
    bool onlyActive = true,
  });

  Future<List<Favorite>> listForUser({
    required String userId,
    FavoriteTargetType? targetType,
    bool onlyActive = true,
  });

  Stream<List<Favorite>> watchForUser({
    required String userId,
    FavoriteTargetType? targetType,
    bool onlyActive = true,
  });

  /// Insert or update one Favorite.
  Future<void> upsert(Favorite favorite);

  Future<void> deactivate(String favoriteId);

  Future<void> deactivateByTarget({
    required String userId,
    required FavoriteTargetType targetType,
    required String targetId,
  });

  /// Toggle and return the new state (true = active/favorited).
  Future<bool> toggle({
    required String userId,
    required FavoriteTargetType targetType,
    required String targetId,
    String? titleSnapshot,
    String? imageUrlSnapshot,
    String? vendorIdSnapshot,
    DateTime? now,
  });
}

/// Minimal key-value store to plug different backends.
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

/// JSON-backed implementation that stores all favorites under a single key.
/// Adequate for small/medium sets. Swap `LocalStore` to SharedPreferences/Hive/Isar later.
class FavoriteLocalDataSourceImpl implements FavoriteLocalDataSource {
  static const _kCollectionKey = 'favorite_collection_v1';

  final LocalStore _store;
  final _userChange = StreamController<String>.broadcast(); // emits userId on change

  FavoriteLocalDataSourceImpl(this._store);

  // ------------------------ storage helpers ------------------------

  Future<Map<String, FavoriteModel>> _load() async {
    final raw = await _store.readString(_kCollectionKey);
    if (raw == null || raw.isEmpty) return {};
    final Map<String, dynamic> decoded = jsonDecode(raw) as Map<String, dynamic>;
    return decoded.map(
          (k, v) => MapEntry(k, FavoriteModel.fromJson(Map<String, dynamic>.from(v))),
    );
  }

  Future<void> _save(Map<String, FavoriteModel> map) async {
    final jsonMap = map.map((k, v) => MapEntry(k, v.toJson()));
    await _store.writeString(_kCollectionKey, jsonEncode(jsonMap));
  }

  // Derived indexes are rebuilt on demand from the stored map.
  Map<String, Set<String>> _indexByUser(Map<String, FavoriteModel> map) {
    final res = <String, Set<String>>{};
    for (final f in map.values) {
      res.putIfAbsent(f.userId, () => <String>{}).add(f.id);
    }
    return res;
  }

  Map<String, String> _indexByComposite(Map<String, FavoriteModel> map) {
    final res = <String, String>{};
    for (final f in map.values) {
      final key = _key(f.userId, f.targetType, f.targetId);
      res[key] = f.id;
    }
    return res;
  }

  String _key(String userId, String targetType, String targetId) =>
      '$userId|$targetType|$targetId';

  DateTime _now(DateTime? n) => n ?? DateTime.now();

  // ------------------------ querying helpers ------------------------

  List<Favorite> _selectUser({
    required Map<String, FavoriteModel> map,
    required String userId,
    FavoriteTargetType? targetType,
    bool onlyActive = true,
  }) {
    final byUser = _indexByUser(map)[userId];
    if (byUser == null || byUser.isEmpty) return const [];

    Iterable<FavoriteModel> it = byUser.map((id) => map[id]!).where((m) => m != null);

    if (onlyActive) it = it.where((m) => m.isActive);
    if (targetType != null) it = it.where((m) => m.targetType == targetType.name);

    final list = it.map((m) => m.toDomain()).toList()
      ..sort((a, b) {
        final ac = a.createdAt?.millisecondsSinceEpoch ?? 0;
        final bc = b.createdAt?.millisecondsSinceEpoch ?? 0;
        final cmp = bc.compareTo(ac);
        return cmp != 0 ? cmp : b.id.compareTo(a.id);
      });

    return list;
  }

  // ------------------------ FavoriteLocalDataSource ------------------------

  @override
  Future<Favorite?> getById(String id) async {
    final map = await _load();
    final m = map[id];
    return m?.toDomain();
  }

  @override
  Future<bool> isFavorited({
    required String userId,
    required FavoriteTargetType targetType,
    required String targetId,
    bool onlyActive = true,
  }) async {
    final map = await _load();
    final composite = _indexByComposite(map)[_key(userId, targetType.name, targetId)];
    if (composite == null) return false;
    final fav = map[composite]!;
    return onlyActive ? fav.isActive : true;
  }

  @override
  Future<List<Favorite>> listForUser({
    required String userId,
    FavoriteTargetType? targetType,
    bool onlyActive = true,
  }) async {
    final map = await _load();
    return _selectUser(
      map: map,
      userId: userId,
      targetType: targetType,
      onlyActive: onlyActive,
    );
  }

  @override
  Stream<List<Favorite>> watchForUser({
    required String userId,
    FavoriteTargetType? targetType,
    bool onlyActive = true,
  }) async* {
    // initial snapshot
    yield await listForUser(
      userId: userId,
      targetType: targetType,
      onlyActive: onlyActive,
    );

    await for (final changedUserId in _userChange.stream) {
      if (changedUserId != userId) continue;
      yield await listForUser(
        userId: userId,
        targetType: targetType,
        onlyActive: onlyActive,
      );
    }
  }

  @override
  Future<void> upsert(Favorite favorite) async {
    final map = await _load();
    map[favorite.id] = favorite.toModel();
    await _save(map);
    _userChange.add(favorite.userId);
  }

  @override
  Future<void> deactivate(String favoriteId) async {
    final map = await _load();
    final m = map[favoriteId];
    if (m == null) return;
    final updated = FavoriteModel(
      id: m.id,
      userId: m.userId,
      targetType: m.targetType,
      targetId: m.targetId,
      titleSnapshot: m.titleSnapshot,
      imageUrlSnapshot: m.imageUrlSnapshot,
      vendorIdSnapshot: m.vendorIdSnapshot,
      isActive: false,
      createdAt: m.createdAt,
      updatedAt: DateTime.now(),
    );
    map[favoriteId] = updated;
    await _save(map);
    _userChange.add(m.userId);
  }

  @override
  Future<void> deactivateByTarget({
    required String userId,
    required FavoriteTargetType targetType,
    required String targetId,
  }) async {
    final map = await _load();
    final compIndex = _indexByComposite(map);
    final id = compIndex[_key(userId, targetType.name, targetId)];
    if (id == null) return;
    await deactivate(id);
  }

  @override
  Future<bool> toggle({
    required String userId,
    required FavoriteTargetType targetType,
    required String targetId,
    String? titleSnapshot,
    String? imageUrlSnapshot,
    String? vendorIdSnapshot,
    DateTime? now,
  }) async {
    final n = _now(now);
    final map = await _load();
    final compIndex = _indexByComposite(map);
    final existingId = compIndex[_key(userId, targetType.name, targetId)];

    if (existingId == null) {
      final newId = '${userId}_${targetType.name}_$targetId'; // swap for UUID if you prefer
      map[newId] = FavoriteModel(
        id: newId,
        userId: userId,
        targetType: targetType.name,
        targetId: targetId,
        titleSnapshot: titleSnapshot,
        imageUrlSnapshot: imageUrlSnapshot,
        vendorIdSnapshot: vendorIdSnapshot,
        isActive: true,
        createdAt: n,
        updatedAt: n,
      );
      await _save(map);
      _userChange.add(userId);
      return true;
    }

    final current = map[existingId]!;
    final toggled = FavoriteModel(
      id: current.id,
      userId: current.userId,
      targetType: current.targetType,
      targetId: current.targetId,
      titleSnapshot: titleSnapshot ?? current.titleSnapshot,
      imageUrlSnapshot: imageUrlSnapshot ?? current.imageUrlSnapshot,
      vendorIdSnapshot: vendorIdSnapshot ?? current.vendorIdSnapshot,
      isActive: !current.isActive,
      createdAt: current.createdAt,
      updatedAt: n,
    );
    map[existingId] = toggled;
    await _save(map);
    _userChange.add(userId);
    return toggled.isActive;
  }
}
