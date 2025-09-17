import 'package:restaurant_marketplace/features/auth/domain/entities/auth_failures.dart';
import 'package:restaurant_marketplace/features/auth/domain/repositories/auth_repository.dart';

class ResetPasswordUseCase {
  final AuthRepository _repo;
  ResetPasswordUseCase(this._repo);

  Future<ResetPasswordResult> call({required String email}) async {
    final e = email.trim();

    if (e.isEmpty) {
      return const ResetPasswordResult.failure(AuthFailure.invalidEmail());
    }

    try {
      await _repo.resetPassword(email: e);
      return const ResetPasswordResult.success();
    } on AuthFailure catch (f) {
      return ResetPasswordResult.failure(f);
    } catch (err) {
      return ResetPasswordResult.failure(AuthFailure.unknown(err.toString()));
    }
  }
}

/// Result wrapper so this use case never throws.
class ResetPasswordResult {
  final bool ok;
  final AuthFailure? failure;

  const ResetPasswordResult._(this.ok, this.failure);

  const ResetPasswordResult.success() : this._(true, null);
  const ResetPasswordResult.failure(AuthFailure f) : this._(false, f);

  bool get isSuccess => ok;
  bool get isFailure => !ok;
}
