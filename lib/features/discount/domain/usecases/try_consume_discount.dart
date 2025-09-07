import '../repositories/discount_repository.dart';

class TryConsumeDiscountParams {
  final String discountId;
  final String userId;
  final DateTime? now;
  const TryConsumeDiscountParams({
    required this.discountId,
    required this.userId,
    this.now,
  });
}

class TryConsumeDiscount {
  final DiscountRepository _repo;
  const TryConsumeDiscount(this._repo);

  /// Returns true if redemption succeeded (limits/date window respected).
  Future<bool> call(TryConsumeDiscountParams params) {
    return _repo.tryConsumeRedemption(
      discountId: params.discountId,
      userId: params.userId,
      now: params.now,
    );
  }
}
