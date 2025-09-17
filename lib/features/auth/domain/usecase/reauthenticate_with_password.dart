import 'package:restaurant_marketplace/features/auth/domain/entities/auth_failures.dart';
import 'package:restaurant_marketplace/features/auth/domain/repositories/auth_repository.dart';

class ReauthenticateWithPasswordUseCase {
  final AuthRepository _repo;
  ReauthenticateWithPasswordUseCase(this._repo);

  Future<ReauthenticateWithPasswordResult> call({
    required String email,
    required String password,
  }) async {
    final e = email.trim();
    if (e.isEmpty || password.isEmpty) {
      return const ReauthenticateWithPasswordResult.failure(
        AuthFailure.invalidCredentials(),
      );
    }

    try {
      await _repo.reauthenticateWithPassword(e, password);
      return const ReauthenticateWithPasswordResult.success();
    } on AuthFailure catch (f) {
      return ReauthenticateWithPasswordResult.failure(f);
    } catch (err) {
      return ReauthenticateWithPasswordResult.failure(
        AuthFailure.unknown(err.toString()),
      );
    }
  }
}

/// Result wrapper so the use case never throws.
class ReauthenticateWithPasswordResult {
  final bool ok;
  final AuthFailure? failure;

  const ReauthenticateWithPasswordResult._(this.ok, this.failure);

  const ReauthenticateWithPasswordResult.success()
      : this._(true, null);

  const ReauthenticateWithPasswordResult.failure(AuthFailure f)
      : this._(false, f);

  bool get isSuccess => ok;
  bool get isFailure => !ok;
}
