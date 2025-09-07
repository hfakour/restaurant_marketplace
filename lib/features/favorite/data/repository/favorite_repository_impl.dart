// data/repositories/favorite_repository_impl.dart
import 'dart:async';
import 'package:collection/collection.dart';

import '../../domain/entities/favorite.dart';
import '../../domain/repositories/favorite_repository.dart';

/// In-memory implementation suitable for tests and early wiring.
/// Swap this out later with a local/remote data source without changing callers.
class FavoriteRepositoryImpl implements FavoriteRepository {
  /// Primary storage by ID.
  final Map<String, Favorite> _byId = {};

  /// Index: userId -> set of favorite IDs for quick listing.
  final Map<String, Set<String>> _byUser = {};

  /// Index: composite (userId|type|targetId) -> favorite ID for quick lookup/toggle.
  final Map<String, String> _byComposite = {};

  final _changes = StreamController<String>.broadcast(); // emits userId on change

  /// If you pass an initial set (e.g., for tests), we’ll index it.
  FavoriteRepositoryImpl({Iterable<Favorite>? seed}) {
    if (seed != null) {
      for (final f in seed) {
        _insertIndexes(f);
      }
    }
  }

  // ---- Helpers -------------------------------------------------------------

  String _key(String userId, FavoriteTargetType type, String targetId) =>
      '$userId|${type.name}|$targetId';

  void _insertIndexes(Favorite f) {
    _byId[f.id] = f;
    _byUser.putIfAbsent(f.userId, () => <String>{}).add(f.id);
    _byComposite[_key(f.userId, f.targetType, f.targetId)] = f.id;
  }

  void _removeIndexes(Favorite f) {
    _byId.remove(f.id);
    _byUser[f.userId]?.remove(f.id);
    _byComposite.remove(_key(f.userId, f.targetType, f.targetId));
  }

  DateTime _now(DateTime? n) => n ?? DateTime.now();

  List<Favorite> _selectUser({
    required String userId,
    FavoriteTargetType? targetType,
    bool onlyActive = true,
  }) {
    final ids = _byUser[userId];
    if (ids == null || ids.isEmpty) return const [];

    Iterable<Favorite> it = ids
        .map((id) => _byId[id])
        .whereNotNull();

    if (onlyActive) it = it.where((f) => f.isActive);
    if (targetType != null) it = it.where((f) => f.targetType == targetType);

    final list = it.toList()
      ..sort((a, b) {
        // Newest first by createdAt, fallback to id.
        final ac = a.createdAt?.millisecondsSinceEpoch ?? 0;
        final bc = b.createdAt?.millisecondsSinceEpoch ?? 0;
        final cmp = bc.compareTo(ac);
        return cmp != 0 ? cmp : b.id.compareTo(a.id);
      });

    return list;
  }

  // ---- FavoriteRepository --------------------------------------------------

  @override
  Future<Favorite?> getById(String id) async => _byId[id];

  @override
  Future<bool> isFavorited({
    required String userId,
    required FavoriteTargetType targetType,
    required String targetId,
    bool onlyActive = true,
  }) async {
    final id = _byComposite[_key(userId, targetType, targetId)];
    if (id == null) return false;
    final fav = _byId[id];
    if (fav == null) return false;
    return onlyActive ? fav.isActive : true;
  }

  @override
  Future<FavoriteSearchPage> listForUser({
    required String userId,
    FavoriteTargetType? targetType,
    bool onlyActive = true,
    int limit = 50,
    String? cursor,
  }) async {
    final start = int.tryParse(cursor ?? '0') ?? 0;
    final all = _selectUser(
      userId: userId,
      targetType: targetType,
      onlyActive: onlyActive,
    );
    final page = all.skip(start).take(limit).toList();
    final next = (start + page.length) < all.length ? '${start + limit}' : null;
    return FavoriteSearchPage(items: page, nextCursor: next);
  }

  @override
  Stream<List<Favorite>> watchForUser({
    required String userId,
    FavoriteTargetType? targetType,
    bool onlyActive = true,
  }) async* {
    // initial
    yield _selectUser(
      userId: userId,
      targetType: targetType,
      onlyActive: onlyActive,
    );

    await for (final changedUserId in _changes.stream) {
      if (changedUserId != userId) continue;
      yield _selectUser(
        userId: userId,
        targetType: targetType,
        onlyActive: onlyActive,
      );
    }
  }

  @override
  Future<String> create(Favorite favorite) async {
    if (_byId.containsKey(favorite.id)) {
      throw StateError('Favorite with id ${favorite.id} already exists');
    }
    // If an existing composite exists, prefer updating that record instead of duplication.
    final composite = _key(favorite.userId, favorite.targetType, favorite.targetId);
    final existingId = _byComposite[composite];
    if (existingId != null) {
      // Merge by updating the existing record to avoid duplicates.
      final existing = _byId[existingId]!;
      final merged = existing.copyWith(
        isActive: true,
        titleSnapshot: favorite.titleSnapshot ?? existing.titleSnapshot,
        imageUrlSnapshot: favorite.imageUrlSnapshot ?? existing.imageUrlSnapshot,
        vendorIdSnapshot: favorite.vendorIdSnapshot ?? existing.vendorIdSnapshot,
        updatedAt: _now(null),
      );
      _byId[existing.id] = merged;
      _changes.add(existing.userId);
      return existing.id;
    }

    _insertIndexes(favorite);
    _changes.add(favorite.userId);
    return favorite.id;
  }

  @override
  Future<void> update(Favorite favorite) async {
    final current = _byId[favorite.id];
    if (current == null) {
      // Upsert semantics: insert indexes if new.
      _insertIndexes(favorite);
      _changes.add(favorite.userId);
      return;
    }

    // If user/target keys changed (rare), reindex.
    final oldKey = _key(current.userId, current.targetType, current.targetId);
    final newKey = _key(favorite.userId, favorite.targetType, favorite.targetId);
    if (oldKey != newKey) {
      _removeIndexes(current);
      _insertIndexes(favorite);
    } else {
      _byId[favorite.id] = favorite;
    }
    _changes.add(favorite.userId);
  }

  @override
  Future<void> deactivate(String favoriteId) async {
    final f = _byId[favoriteId];
    if (f == null) return;
    final updated = f.copyWith(isActive: false, updatedAt: _now(null));
    _byId[favoriteId] = updated;
    _changes.add(f.userId);
  }

  @override
  Future<void> deactivateByTarget({
    required String userId,
    required FavoriteTargetType targetType,
    required String targetId,
  }) async {
    final id = _byComposite[_key(userId, targetType, targetId)];
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
    final key = _key(userId, targetType, targetId);
    final existingId = _byComposite[key];

    if (existingId == null) {
      // Create a new active favorite; caller must supply IDs—typically via a UUID factory upstream.
      final newId = '${userId}_${targetType.name}_$targetId'; // you can swap this for a UUID
      final fav = Favorite(
        id: newId,
        userId: userId,
        targetType: targetType,
        targetId: targetId,
        titleSnapshot: titleSnapshot,
        imageUrlSnapshot: imageUrlSnapshot,
        vendorIdSnapshot: vendorIdSnapshot,
        isActive: true,
        createdAt: n,
        updatedAt: n,
      );
      _insertIndexes(fav);
      _changes.add(userId);
      return true; // now favorited
    }

    final current = _byId[existingId]!;
    final toggled = current.copyWith(
      isActive: !current.isActive,
      // If turning on, refresh snapshots if provided.
      titleSnapshot: titleSnapshot ?? current.titleSnapshot,
      imageUrlSnapshot: imageUrlSnapshot ?? current.imageUrlSnapshot,
      vendorIdSnapshot: vendorIdSnapshot ?? current.vendorIdSnapshot,
      updatedAt: n,
    );
    _byId[existingId] = toggled;
    _changes.add(userId);
    return toggled.isActive;
  }
}
