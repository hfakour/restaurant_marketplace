import 'package:restaurant_marketplace/features/auth/domain/entities/auth_failures.dart';
import 'package:restaurant_marketplace/features/auth/domain/repositories/auth_repository.dart';

class SignOutUseCase {
  final AuthRepository _repo;
  SignOutUseCase(this._repo);

  Future<SignOutResult> call() async {
    try {
      await _repo.signOut();
      return const SignOutResult.success();
    } on AuthFailure catch (f) {
      return SignOutResult.failure(f);
    } catch (err) {
      return SignOutResult.failure(AuthFailure.unknown(err.toString()));
    }
  }
}

/// Result wrapper so this use case never throws.
class SignOutResult {
  final bool ok;
  final AuthFailure? failure;

  const SignOutResult._(this.ok, this.failure);

  const SignOutResult.success() : this._(true, null);
  const SignOutResult.failure(AuthFailure f) : this._(false, f);

  bool get isSuccess => ok;
  bool get isFailure => !ok;
}
