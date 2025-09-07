import '../entities/order.dart';
import '../repositories/order_repository.dart';

class SearchOrdersParams {
  final OrderStatus? status;
  final DateTime? createdFrom;
  final DateTime? createdTo;
  final int limit;
  final String? cursor;

  const SearchOrdersParams({
    this.status,
    this.createdFrom,
    this.createdTo,
    this.limit = 20,
    this.cursor,
  });
}

class SearchOrders {
  final OrderRepository _repo;
  const SearchOrders(this._repo);

  Future<OrderSearchPage> call(SearchOrdersParams p) =>
      _repo.search(
        status: p.status,
        createdFrom: p.createdFrom,
        createdTo: p.createdTo,
        limit: p.limit,
        cursor: p.cursor,
      );
}
