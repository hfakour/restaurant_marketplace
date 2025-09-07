// infrastructure/repositories/discount_repository_impl.dart
import 'dart:async';


import '../../domain/entities/discount.dart';
import '../../domain/repositories/discount_repository.dart';

/// In-memory implementation:
/// - Great for tests and early wiring
/// - Not concurrency-safe across isolates (acceptable for tests/dev)
class DiscountRepositoryInMemory implements DiscountRepository {
  final Map<String, Discount> _byId = {};
  final Map<String, Set<String>> _perUserRedemptions = {}; // discountId -> {userId}
  final _controller = StreamController<void>.broadcast();

  /// Optional code index (case-insensitive).
  final Map<String, String> _codeToId = {}; // lower(code) -> id

  DiscountRepositoryInMemory({Iterable<Discount>? seed}) {
    if (seed != null) {
      for (final d in seed) {
        _byId[d.id] = d;
        if ((d.code ?? '').isNotEmpty) {
          _codeToId[(d.code!).toLowerCase()] = d.id;
        }
      }
    }
  }

  DateTime _now(DateTime? now) => now ?? DateTime.now();

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
    final d = _byId[id];
    if (d == null) return null;
    if (onlyActive && !_activeAndValid(d, n)) return null;
    return d;
  }

  @override
  Future<Discount?> getByCode(String code, {bool onlyActive = true, DateTime? now}) async {
    final id = _codeToId[code.toLowerCase()];
    if (id == null) return null;
    return getById(id, onlyActive: onlyActive, now: now);
  }

  @override
  Future<DiscountSearchPage> search({
    bool onlyActive = true,
    DateTime? now,
    int limit = 20,
    String? cursor,
  }) async {
    final n = _now(now);
    final start = int.tryParse(cursor ?? '0') ?? 0;

    final list = _byId.values.toList()
      ..sort((a, b) {
        // Example sort: newest first by createdAt, fallback to id
        final ac = a.createdAt?.millisecondsSinceEpoch ?? 0;
        final bc = b.createdAt?.millisecondsSinceEpoch ?? 0;
        final cmp = bc.compareTo(ac);
        return cmp != 0 ? cmp : b.id.compareTo(a.id);
      });

    final filtered = onlyActive ? list.where((d) => _activeAndValid(d, n)) : list;
    final pageItems = filtered.skip(start).take(limit).toList();
    final next = pageItems.length < limit ? null : '${start + limit}';

    return DiscountSearchPage(items: pageItems, nextCursor: next);
  }

  @override
  Stream<List<Discount>> watchActiveForUser(String userId, {DateTime? now}) async* {
    // In-memory: we just emit on any change. A real impl would filter by user eligibility.
    final n = _now(now);

    List<Discount> snapshot() =>
        _byId.values.where((d) => _activeAndValid(d, n)).toList();

    // Emit initial.
    yield snapshot();

    await for (final _ in _controller.stream) {
      yield snapshot();
    }
  }

  @override
  Future<String> create(Discount discount) async {
    if (_byId.containsKey(discount.id)) {
      throw StateError('Discount with id ${discount.id} already exists');
    }
    _byId[discount.id] = discount;
    if ((discount.code ?? '').isNotEmpty) {
      _codeToId[(discount.code!).toLowerCase()] = discount.id;
    }
    _controller.add(null);
    return discount.id;
  }

  @override
  Future<void> update(Discount discount) async {
    if (!_byId.containsKey(discount.id)) {
      throw StateError('Discount with id ${discount.id} not found');
    }
    // Update code index if code changed.
    final old = _byId[discount.id]!;
    final oldCode = (old.code ?? '').toLowerCase();
    final newCode = (discount.code ?? '').toLowerCase();
    if (oldCode != newCode) {
      if (oldCode.isNotEmpty) _codeToId.remove(oldCode);
      if (newCode.isNotEmpty) _codeToId[newCode] = discount.id;
    }

    _byId[discount.id] = discount;
    _controller.add(null);
  }

  @override
  Future<void> deactivate(String discountId) async {
    final d = _byId[discountId];
    if (d == null) return;
    final updated = d.copyWith(isActive: false, updatedAt: DateTime.now());
    _byId[discountId] = updated;
    _controller.add(null);
  }

  @override
  Future<bool> tryConsumeRedemption({
    required String discountId,
    required String userId,
    DateTime? now,
  }) async {
    final n = _now(now);
    final d = _byId[discountId];
    if (d == null) return false;

    // Check active/window.
    if (!_activeAndValid(d, n)) return false;

    // Check global limit.
    if (d.maxGlobalRedemptions != null &&
        d.globalRedemptionsUsed >= d.maxGlobalRedemptions!) {
      return false;
    }

    // Check per-user limit.
    final users = _perUserRedemptions.putIfAbsent(discountId, () => <String>{});
    if (d.maxPerUser != null) {
      // We track unique users who have redeemed at least once.
      final timesUsedByUser = users.contains(userId) ? 1 : 0;
      if (timesUsedByUser >= d.maxPerUser!) return false;
    }

    // "Consume": increment counters and track user.
    final updated = d.copyWith(
      globalRedemptionsUsed: d.globalRedemptionsUsed + 1,
      updatedAt: n,
    );
    _byId[discountId] = updated;
    users.add(userId);

    _controller.add(null);
    return true;
  }

  /// Utility for tests, not part of the interface.
  Discount? findByCodeUnsafe(String code) =>
      _byId[_codeToId[code.toLowerCase()] ?? ''];
}
