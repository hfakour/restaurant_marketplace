import '../entities/address.dart';
import '../repositories/address_repository.dart';

/// Use case to retrieve all addresses for a user.
class GetAddresses {
  final AddressRepository _repo;
  GetAddresses(this._repo);

  Future<List<Address>> call(String userId) {
    return _repo.getAddresses(userId);
  }
}