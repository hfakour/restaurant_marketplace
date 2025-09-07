import '../entities/order.dart';
import '../repositories/order_repository.dart';

class SetOrderStatusParams {
  final String orderId;
  final OrderStatus status;
  final DateTime? now;

  const SetOrderStatusParams({
    required this.orderId,
    required this.status,
    this.now,
  });
}

class SetOrderStatus {
  final OrderRepository _repo;
  const SetOrderStatus(this._repo);

  /// Returns the updated order (or null if not found).
  Future<Order?> call(SetOrderStatusParams p) =>
      _repo.setStatus(p.orderId, p.status, now: p.now);
}
