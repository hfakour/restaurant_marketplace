import '../entities/order.dart';
import '../repositories/order_repository.dart';

class UpdateOrder {
  final OrderRepository _repo;
  const UpdateOrder(this._repo);

  Future<void> call(Order order) => _repo.update(order);
}
