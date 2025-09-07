import '../entities/user_profile.dart';

abstract class ProfileRepository {
  Future<UserProfile> getMe();

  /// Update the user's first & last name (reflects your entity).
  Future<UserProfile> updateName({
    required String firstName,
    required String lastName,
  });

  Future<UserProfile> setDefaultAddress(String addressId);
  Future<UserProfile> setDefaultPaymentMethod(String paymentMethodId);
  Future<UserProfile> linkWallet(String walletId);
  Future<UserProfile> unlinkWallet();
}
