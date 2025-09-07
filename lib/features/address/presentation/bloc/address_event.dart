part of 'address_bloc.dart';

/// Base type for all address events.
sealed class AddressEvent extends Equatable {
  const AddressEvent();

  @override
  List<Object?> get props => [];
}

/// Event to trigger loading of addresses for the current user.
class LoadAddresses extends AddressEvent {
  const LoadAddresses();
}

/// Event to add a new address.
class AddAddressEvent extends AddressEvent {
  const AddAddressEvent(this.address);

  final Address address;

  @override
  List<Object?> get props => [address];
}

/// Event to update an existing address.
class UpdateAddressEvent extends AddressEvent {
  const UpdateAddressEvent(this.address);

  final Address address;

  @override
  List<Object?> get props => [address];
}

/// Event to delete an address by id.
class DeleteAddressEvent extends AddressEvent {
  const DeleteAddressEvent(this.addressId);

  final String addressId;

  @override
  List<Object?> get props => [addressId];
}

/// Event to mark an address as default.
class SetDefaultAddressEvent extends AddressEvent {
  const SetDefaultAddressEvent(this.addressId);

  final String addressId;

  @override
  List<Object?> get props => [addressId];
}