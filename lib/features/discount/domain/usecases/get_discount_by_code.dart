import '../entities/discount.dart';
import '../repositories/discount_repository.dart';

class GetDiscountByCode {
  final DiscountRepository _repo;
  const GetDiscountByCode(this._repo);

  /// Case-insensitive lookup by code. Returns null if not found.
  Future<Discount?> call(String code, {bool onlyActive = true, DateTime? now}) {
    return _repo.getByCode(code, onlyActive: onlyActive, now: now);
  }
}
