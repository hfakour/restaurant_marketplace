import '../entities/order.dart';
import '../repositories/order_repository.dart';

class CreateOrder {
  final OrderRepository _repo;
  const CreateOrder(this._repo);

  /// Returns created order ID.
  Future<String> call(Order order) => _repo.create(order);
}
