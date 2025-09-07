import '../entities/address.dart';
import '../repositories/address_repository.dart';

/// Use case to update an existing address.
class UpdateAddress {
  final AddressRepository _repo;
  UpdateAddress(this._repo);

  Future<Address> call(Address address) {
    return _repo.updateAddress(address);
  }
}