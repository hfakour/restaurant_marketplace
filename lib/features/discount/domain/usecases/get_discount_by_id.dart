import '../entities/discount.dart';
import '../repositories/discount_repository.dart';

class GetDiscountById {
  final DiscountRepository _repo;
  const GetDiscountById(this._repo);

  /// Returns null if not found, or filtered out by [onlyActive].
  Future<Discount?> call(String id, {bool onlyActive = false, DateTime? now}) {
    return _repo.getById(id, onlyActive: onlyActive, now: now);
  }
}
