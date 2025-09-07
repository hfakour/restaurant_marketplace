import '../entities/address.dart';
import '../repositories/address_repository.dart';

/// Use case to persist a new address.
class AddAddress {
  final AddressRepository _repo;
  AddAddress(this._repo);

  Future<Address> call(Address address) {
    return _repo.addAddress(address);
  }
}