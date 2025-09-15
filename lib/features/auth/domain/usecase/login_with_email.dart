// auth/domain/usecase/login_with_email.dart
import '../repositories/auth_repository.dart';
import '../entities/auth_account.dart';

class LoginWithEmailUseCase {
  LoginWithEmailUseCase(this._repo);
  final AuthRepository _repo;

  Future<AuthAccount> call({
    required String email,
    required String password,
  }) {
    return _repo.loginWithEmail(email: email, password: password);
  }
}
