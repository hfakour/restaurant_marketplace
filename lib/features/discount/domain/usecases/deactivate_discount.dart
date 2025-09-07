import '../repositories/discount_repository.dart';

class DeactivateDiscount {
  final DiscountRepository _repo;
  const DeactivateDiscount(this._repo);

  Future<void> call(String discountId) => _repo.deactivate(discountId);
}
