import '../entities/discount.dart';
import '../repositories/discount_repository.dart';

class WatchActiveDiscountsForUser {
  final DiscountRepository _repo;
  const WatchActiveDiscountsForUser(this._repo);

  Stream<List<Discount>> call(String userId, {DateTime? now}) {
    return _repo.watchActiveForUser(userId, now: now);
  }
}
