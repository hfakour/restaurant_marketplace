import '../repositories/auth_repository.dart';

class ResetPasswordUseCase {
  ResetPasswordUseCase(this._repo);
  final AuthRepository _repo;
  Future<void> call({required String email}) => _repo.resetPassword(email: email);
}
