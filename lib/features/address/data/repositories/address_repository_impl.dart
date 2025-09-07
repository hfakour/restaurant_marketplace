import '../../domain/entities/address.dart';
import '../../domain/repositories/address_repository.dart';

/// Simple in-memory implementation of [AddressRepository].
///
/// In a real app, this would talk to remote and local data sources to
/// synchronize addresses.  For now we keep everything in memory to
/// demonstrate the feature.
class AddressRepositoryImpl implements AddressRepository {
  AddressRepositoryImpl({required this.userId});

  final String userId;

  // backing store for addresses.  In a production implementation this
  // would be persisted and keyed by userId.
  final List<Address> _addresses = [];

  @override
  Future<List<Address>> getAddresses(String userId) async {
    // In a real implementation, we'd fetch from a remote data source or
    // database.  For now just return the in-memory list.
    return List<Address>.unmodifiable(_addresses);
  }

  @override
  Future<Address> addAddress(Address address) async {
    _addresses.add(address);
    return address;
  }

  @override
  Future<void> deleteAddress(String addressId) async {
    _addresses.removeWhere((a) => a.id == addressId);
  }

  @override
  Future<Address> updateAddress(Address address) async {
    final index = _addresses.indexWhere((a) => a.id == address.id);
    if (index != -1) {
      _addresses[index] = address;
    } else {
      _addresses.add(address);
    }
    return address;
  }
}