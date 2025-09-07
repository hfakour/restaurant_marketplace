import '../../domain/entities/user_profile.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_local_ds.dart';
import '../mappers/user_profile_mapper.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileLocalDataSource local;
  ProfileRepositoryImpl(this.local);

  @override
  Future<UserProfile> getMe() async => (await local.fetchMe()).toDomain();

  @override
  Future<UserProfile> updateName({
    required String firstName,
    required String lastName,
  }) async => (await local.updateName(firstName: firstName, lastName: lastName)).toDomain();

  @override
  Future<UserProfile> setDefaultAddress(String addressId) async =>
      (await local.setDefaultAddress(addressId)).toDomain();

  @override
  Future<UserProfile> setDefaultPaymentMethod(String paymentMethodId) async =>
      (await local.setDefaultPaymentMethod(paymentMethodId)).toDomain();

  @override
  Future<UserProfile> linkWallet(String walletId) async =>
      (await local.linkWallet(walletId)).toDomain();

  @override
  Future<UserProfile> unlinkWallet() async =>
      (await local.unlinkWallet()).toDomain();
}
