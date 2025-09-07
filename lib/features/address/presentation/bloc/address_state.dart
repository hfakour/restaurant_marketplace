part of 'address_bloc.dart';

/// Base class for all address states.
sealed class AddressState extends Equatable {
  const AddressState();
  @override
  List<Object?> get props => [];
}

/// Initial state before anything happens.
class AddressInitial extends AddressState {
  const AddressInitial();
}

/// Loading state while addresses are being fetched or mutated.
class AddressLoading extends AddressState {
  const AddressLoading();
}

/// Loaded state with current list of addresses.
class AddressLoaded extends AddressState {
  const AddressLoaded(this.addresses);

  final List<Address> addresses;

  @override
  List<Object?> get props => [addresses];
}

/// Error state with message.
class AddressError extends AddressState {
  const AddressError(this.message);
  final String message;
  @override
  List<Object?> get props => [message];
}