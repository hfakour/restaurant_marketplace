// domain/repositories/order_repository.dart
import '../entities/order.dart';

/// Contract for reading/writing Order aggregates.
abstract class OrderRepository {
  /// Fetch a single order by ID.
  Future<Order?> getById(String id);

  /// List orders for a user (optionally filtered by status).
  /// Use [nextCursor] to paginate subsequent pages.
  Future<OrderSearchPage> listForUser({
    required String userId,
    OrderStatus? status,
    int limit = 20,
    String? cursor,
  });

  /// Global search across orders (admin/ops screens).
  /// Filter by [status], and/or createdAt range inclusive.
  Future<OrderSearchPage> search({
    OrderStatus? status,
    DateTime? createdFrom,
    DateTime? createdTo,
    int limit = 20,
    String? cursor,
  });

  /// Live stream of a user's orders (optionally by status).
  Stream<List<Order>> watchForUser({
    required String userId,
    OrderStatus? status,
  });

  /// Create a new order. Returns its ID (caller may pre-generate).
  Future<String> create(Order order);

  /// Update any mutable fields (payment, fulfillment, totals, etc.).
  Future<void> update(Order order);

  /// Convenience: set [status] and maintain canonical timestamps.
  /// - When setting:
  ///   - cancelled  -> sets cancelledAt (if null)
  ///   - delivered  -> sets updatedAt
  ///   - completed  -> sets completedAt (if null)
  /// Returns the updated order or null if not found.
  Future<Order?> setStatus(String orderId, OrderStatus status, {DateTime? now});
}

/// Simple page result with opaque cursor (stringified index).
class OrderSearchPage {
  final List<Order> items;
  final String? nextCursor;
  const OrderSearchPage({required this.items, this.nextCursor});
}
