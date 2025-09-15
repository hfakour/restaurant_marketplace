import '../repositories/auth_repository.dart';

class ReauthenticateWithPassword {
  final AuthRepository repo;
  ReauthenticateWithPassword(this.repo);
  Future<void> call({required String email, required String password}) =>
      repo.reauthenticateWithPassword(email, password);
}
