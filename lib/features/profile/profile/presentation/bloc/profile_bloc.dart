import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../domain/entities/user_profile.dart';
import '../../domain/usecases/get_profile.dart';
import '../../domain/usecases/update_name.dart';
import '../../domain/usecases/set_default_address.dart';
import '../../domain/usecases/set_default_payment_method.dart';
import '../../domain/usecases/link_wallet.dart';
import '../../domain/usecases/unlink_wallet.dart';

/// Events that can be dispatched to [ProfileBloc].
///
/// These are defined as a sealed class hierarchy so that Dart's pattern matching
/// can be used exhaustively when handling events. Using sealed classes allows
/// the analyzer to flag unhandled cases in switch expressions.
sealed class ProfileEvent {
  const ProfileEvent();
}

/// Fetches the profile from the repository. This is used for the initial load
/// as well as explicit refreshes.
class FetchProfile extends ProfileEvent {
  const FetchProfile();
}

/// Alias for [FetchProfile] to explicitly represent refresh actions. Both
/// events trigger the same behaviour.
class RefreshProfile extends ProfileEvent {
  const RefreshProfile();
}

/// Updates the user name.
class ChangeName extends ProfileEvent {
  const ChangeName({required this.firstName, required this.lastName});

  final String firstName;
  final String lastName;
}

/// Makes the provided address the default.
class MakeDefaultAddress extends ProfileEvent {
  const MakeDefaultAddress(this.addressId);
  final String addressId;
}

/// Makes the provided payment method the default.
class MakeDefaultPaymentMethod extends ProfileEvent {
  const MakeDefaultPaymentMethod(this.paymentMethodId);
  final String paymentMethodId;
}

/// Connects a wallet.
class ConnectWallet extends ProfileEvent {
  const ConnectWallet(this.walletId);
  final String walletId;
}

/// Disconnects the current wallet.
class DisconnectWallet extends ProfileEvent {
  const DisconnectWallet();
}

/// States emitted by [ProfileBloc].
///
/// By using a sealed class hierarchy for states, you can leverage Dart's
/// pattern matching to exhaustively handle all possible states. Each state
/// represents a distinct snapshot of the profile screen.
sealed class ProfileState {
  const ProfileState();
}

/// Initial state before any data has been loaded.
class ProfileInitial extends ProfileState {
  const ProfileInitial();
}

/// Indicates that a profile operation is in progress.
class ProfileLoading extends ProfileState {
  const ProfileLoading();
}

/// Indicates that a profile has been successfully loaded.
class ProfileLoaded extends ProfileState {
  const ProfileLoaded(this.profile);

  final UserProfile profile;
}

/// Indicates that an error occurred while loading or modifying the profile.
class ProfileError extends ProfileState {
  const ProfileError(this.error);

  final Object error;
}

/// A Bloc that orchestrates loading and modifying the user profile. It wraps
/// individual use cases and emits appropriate states based on their results.
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({
    required GetProfile getProfile,
    required UpdateName updateName,
    required SetDefaultAddress setDefaultAddress,
    required SetDefaultPaymentMethod setDefaultPaymentMethod,
    required LinkWallet linkWallet,
    required UnlinkWallet unlinkWallet,
  })  : _getProfile = getProfile,
        _updateName = updateName,
        _setDefaultAddress = setDefaultAddress,
        _setDefaultPaymentMethod = setDefaultPaymentMethod,
        _linkWallet = linkWallet,
        _unlinkWallet = unlinkWallet,
        super(const ProfileInitial()) {
    on<FetchProfile>(_onFetchProfile);
    on<RefreshProfile>(_onFetchProfile);
    on<ChangeName>(_onChangeName);
    on<MakeDefaultAddress>(_onMakeDefaultAddress);
    on<MakeDefaultPaymentMethod>(_onMakeDefaultPaymentMethod);
    on<ConnectWallet>(_onConnectWallet);
    on<DisconnectWallet>(_onDisconnectWallet);
  }

  final GetProfile _getProfile;
  final UpdateName _updateName;
  final SetDefaultAddress _setDefaultAddress;
  final SetDefaultPaymentMethod _setDefaultPaymentMethod;
  final LinkWallet _linkWallet;
  final UnlinkWallet _unlinkWallet;

  Future<void> _onFetchProfile(ProfileEvent event, Emitter<ProfileState> emit) async {
    emit(const ProfileLoading());
    try {
      final profile = await _getProfile();
      emit(ProfileLoaded(profile));
    } catch (e) {
      emit(ProfileError(e));
    }
  }

  Future<void> _onChangeName(ChangeName event, Emitter<ProfileState> emit) async {
    emit(const ProfileLoading());
    try {
      final profile = await _updateName(firstName: event.firstName, lastName: event.lastName);
      emit(ProfileLoaded(profile));
    } catch (e) {
      emit(ProfileError(e));
    }
  }

  Future<void> _onMakeDefaultAddress(MakeDefaultAddress event, Emitter<ProfileState> emit) async {
    emit(const ProfileLoading());
    try {
      final profile = await _setDefaultAddress(event.addressId);
      emit(ProfileLoaded(profile));
    } catch (e) {
      emit(ProfileError(e));
    }
  }

  Future<void> _onMakeDefaultPaymentMethod(MakeDefaultPaymentMethod event, Emitter<ProfileState> emit) async {
    emit(const ProfileLoading());
    try {
      final profile = await _setDefaultPaymentMethod(event.paymentMethodId);
      emit(ProfileLoaded(profile));
    } catch (e) {
      emit(ProfileError(e));
    }
  }

  Future<void> _onConnectWallet(ConnectWallet event, Emitter<ProfileState> emit) async {
    emit(const ProfileLoading());
    try {
      final profile = await _linkWallet(event.walletId);
      emit(ProfileLoaded(profile));
    } catch (e) {
      emit(ProfileError(e));
    }
  }

  Future<void> _onDisconnectWallet(DisconnectWallet event, Emitter<ProfileState> emit) async {
    emit(const ProfileLoading());
    try {
      final profile = await _unlinkWallet();
      emit(ProfileLoaded(profile));
    } catch (e) {
      emit(ProfileError(e));
    }
  }
}