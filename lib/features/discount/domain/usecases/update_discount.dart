import '../entities/discount.dart';
import '../repositories/discount_repository.dart';

class UpdateDiscount {
  final DiscountRepository _repo;
  const UpdateDiscount(this._repo);

  Future<void> call(Discount discount) => _repo.update(discount);
}
