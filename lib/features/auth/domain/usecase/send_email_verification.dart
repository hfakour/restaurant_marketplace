import '../repositories/auth_repository.dart';

class SendEmailVerificationUseCase {
  SendEmailVerificationUseCase(this._repo);
  final AuthRepository _repo;
  Future<void> call() => _repo.sendEmailVerification();
}
