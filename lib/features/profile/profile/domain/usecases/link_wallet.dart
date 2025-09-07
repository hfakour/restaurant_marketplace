import '../entities/user_profile.dart';
import '../repositories/profile_repository.dart';

class LinkWallet {
  final ProfileRepository _repo;
  LinkWallet(this._repo);
  Future<UserProfile> call(String walletId) => _repo.linkWallet(walletId);
}
