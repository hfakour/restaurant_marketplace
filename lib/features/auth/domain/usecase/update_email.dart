import '../repositories/auth_repository.dart';

class UpdateEmail {
  final AuthRepository repo;
  UpdateEmail(this.repo);
  Future<void> call(String newEmail) => repo.updateEmail(newEmail);
}
