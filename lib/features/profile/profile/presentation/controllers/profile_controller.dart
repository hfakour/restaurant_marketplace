import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/user_profile.dart';
import '../../profile_providers.dart';

part 'profile_controller.g.dart';

@riverpod
class ProfileController extends _$ProfileController {
  @override
  FutureOr<UserProfile> build() => ref.read(getProfileProvider)();

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => ref.read(getProfileProvider)());
  }

  Future<void> changeName({required String firstName, required String lastName}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
          () => ref.read(updateNameProvider)(firstName: firstName, lastName: lastName),
    );
  }

  Future<void> makeDefaultAddress(String addressId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
          () => ref.read(setDefaultAddressProvider)(addressId),
    );
  }

  Future<void> makeDefaultPaymentMethod(String pmId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
          () => ref.read(setDefaultPaymentMethodProvider)(pmId),
    );
  }

  Future<void> connectWallet(String walletId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
          () => ref.read(linkWalletProvider)(walletId),
    );
  }

  Future<void> disconnectWallet() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
          () => ref.read(unlinkWalletProvider)(),
    );
  }
}
