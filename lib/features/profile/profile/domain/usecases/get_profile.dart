import '../entities/user_profile.dart';
import '../repositories/profile_repository.dart';

class GetProfile {
  final ProfileRepository _repo;
  GetProfile(this._repo);
  Future<UserProfile> call() => _repo.getMe();
}
