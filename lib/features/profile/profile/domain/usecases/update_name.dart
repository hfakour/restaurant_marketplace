import '../entities/user_profile.dart';
import '../repositories/profile_repository.dart';

class UpdateName {
  final ProfileRepository _repo;
  UpdateName(this._repo);
  Future<UserProfile> call({required String firstName, required String lastName}) =>
      _repo.updateName(firstName: firstName, lastName: lastName);
}
