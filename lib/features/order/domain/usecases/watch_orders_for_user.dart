import '../entities/order.dart';
import '../repositories/order_repository.dart';

class WatchOrdersForUserParams {
  final String userId;
  final OrderStatus? status;

  const WatchOrdersForUserParams({
    required this.userId,
    this.status,
  });
}

class WatchOrdersForUser {
  final OrderRepository _repo;
  const WatchOrdersForUser(this._repo);

  Stream<List<Order>> call(WatchOrdersForUserParams p) =>
      _repo.watchForUser(
        userId: p.userId,
        status: p.status,
      );
}
