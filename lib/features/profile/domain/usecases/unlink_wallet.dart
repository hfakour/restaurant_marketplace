import '../entities/user_profile.dart';
import '../repositories/profile_repository.dart';

class UnlinkWallet {
  final ProfileRepository _repo;
  UnlinkWallet(this._repo);
  Future<UserProfile> call() => _repo.unlinkWallet();
}
