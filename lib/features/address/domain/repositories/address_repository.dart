import '../entities/address.dart';

/// Contract for managing user addresses.
///
/// This repository defines the operations available to fetch and mutate
/// addresses associated with a user.  Implementations may choose to
/// persist data locally, remotely or both.  All methods return Futures
/// to support asynchronous data sources.
abstract class AddressRepository {
  /// Returns the list of addresses for the given user.
  Future<List<Address>> getAddresses(String userId);

  /// Persists a new address and returns the updated entities.
  Future<Address> addAddress(Address address);

  /// Updates an existing address and returns the updated entities.
  Future<Address> updateAddress(Address address);

  /// Deletes an address by its id.
  Future<void> deleteAddress(String addressId);
}