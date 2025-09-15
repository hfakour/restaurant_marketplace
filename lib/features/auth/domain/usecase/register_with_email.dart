// auth/domain/usecase/register_with_email.dart
import '../repositories/auth_repository.dart';
import '../entities/auth_account.dart';

class RegisterWithEmailUseCase {
  RegisterWithEmailUseCase(this._repo);
  final AuthRepository _repo;

  Future<AuthAccount> call({
    required String firstName,
    required String lastName,
    required String phoneNumber,
    String? email,
    required String password,
  }) {
    return _repo.registerWithEmail(
      firstName: firstName,
      lastName: lastName,
      phoneNumber: phoneNumber,
      email: email,
      password: password,
    );
  }
}
