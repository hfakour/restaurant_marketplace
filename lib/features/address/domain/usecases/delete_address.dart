import '../repositories/address_repository.dart';

/// Use case to remove an address.
class DeleteAddress {
  final AddressRepository _repo;
  DeleteAddress(this._repo);

  Future<void> call(String addressId) {
    return _repo.deleteAddress(addressId);
  }
}