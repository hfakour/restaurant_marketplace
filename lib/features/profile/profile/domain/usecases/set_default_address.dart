import '../entities/user_profile.dart';
import '../repositories/profile_repository.dart';

class SetDefaultAddress {
  final ProfileRepository _repo;
  SetDefaultAddress(this._repo);
  Future<UserProfile> call(String addressId) => _repo.setDefaultAddress(addressId);
}
