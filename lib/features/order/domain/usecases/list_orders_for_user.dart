import '../entities/order.dart';
import '../repositories/order_repository.dart';

class ListOrdersForUserParams {
  final String userId;
  final OrderStatus? status;
  final int limit;
  final String? cursor;

  const ListOrdersForUserParams({
    required this.userId,
    this.status,
    this.limit = 20,
    this.cursor,
  });
}

class ListOrdersForUser {
  final OrderRepository _repo;
  const ListOrdersForUser(this._repo);

  Future<OrderSearchPage> call(ListOrdersForUserParams p) =>
      _repo.listForUser(
        userId: p.userId,
        status: p.status,
        limit: p.limit,
        cursor: p.cursor,
      );
}
