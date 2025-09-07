import '../entities/discount.dart';
import '../repositories/discount_repository.dart';

class SearchDiscountsParams {
  final bool onlyActive;
  final DateTime? now;
  final int limit;
  final String? cursor;
  const SearchDiscountsParams({
    this.onlyActive = true,
    this.now,
    this.limit = 20,
    this.cursor,
  });
}

class SearchDiscounts {
  final DiscountRepository _repo;
  const SearchDiscounts(this._repo);

  Future<DiscountSearchPage> call(SearchDiscountsParams params) {
    return _repo.search(
      onlyActive: params.onlyActive,
      now: params.now,
      limit: params.limit,
      cursor: params.cursor,
    );
  }
}
