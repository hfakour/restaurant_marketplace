import 'package:restaurant_marketplace/features/auth/domain/entities/auth_failures.dart';
import 'package:restaurant_marketplace/features/auth/domain/repositories/auth_repository.dart';

class SendEmailVerificationUseCase {
  final AuthRepository _repo;
  SendEmailVerificationUseCase(this._repo);

  Future<SendEmailVerificationResult> call() async {
    try {
      await _repo.sendEmailVerification();
      return const SendEmailVerificationResult.success();
    } on AuthFailure catch (f) {
      return SendEmailVerificationResult.failure(f);
    } catch (err) {
      return SendEmailVerificationResult.failure(
        AuthFailure.unknown(err.toString()),
      );
    }
  }
}

/// Result wrapper so this use case never throws.
class SendEmailVerificationResult {
  final bool ok;
  final AuthFailure? failure;

  const SendEmailVerificationResult._(this.ok, this.failure);

  const SendEmailVerificationResult.success() : this._(true, null);
  const SendEmailVerificationResult.failure(AuthFailure f)
      : this._(false, f);

  bool get isSuccess => ok;
  bool get isFailure => !ok;
}
