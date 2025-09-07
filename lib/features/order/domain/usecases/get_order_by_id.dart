import '../entities/order.dart';
import '../repositories/order_repository.dart';

class GetOrderById {
  final OrderRepository _repo;
  const GetOrderById(this._repo);

  Future<Order?> call(String id) => _repo.getById(id);
}
