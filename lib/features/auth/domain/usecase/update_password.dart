import '../repositories/auth_repository.dart';

class UpdatePassword {
  final AuthRepository repo;
  UpdatePassword(this.repo);
  Future<void> call(String newPassword) => repo.updatePassword(newPassword);
}
