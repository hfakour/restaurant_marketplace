import 'package:restaurant_marketplace/features/auth/domain/entities/auth_failures.dart';
import 'package:restaurant_marketplace/features/auth/domain/repositories/auth_repository.dart';

class UpdatePasswordUseCase {
  final AuthRepository _repo;
  UpdatePasswordUseCase(this._repo);

  Future<UpdatePasswordResult> call(String newPassword) async {
    final pwd = newPassword; // keep verbatim; repo enforces full rules

    // Minimal hygiene: empty or very short input fails fast for better UX.
    if (pwd.isEmpty) {
      return const UpdatePasswordResult.failure(AuthFailure.weakPassword());
    }
    if (pwd.length < 8) {
      // Optional: mirror your repo’s threshold to avoid obvious round-trips.
      return const UpdatePasswordResult.failure(AuthFailure.weakPassword());
    }

    try {
      await _repo.updatePassword(pwd);
      return const UpdatePasswordResult.success();
    } on AuthFailure catch (f) {
      return UpdatePasswordResult.failure(f);
    } catch (err) {
      return UpdatePasswordResult.failure(AuthFailure.unknown(err.toString()));
    }
  }
}

/// Result wrapper so this use case never throws.
class UpdatePasswordResult {
  final bool ok;
  final AuthFailure? failure;

  const UpdatePasswordResult._(this.ok, this.failure);

  const UpdatePasswordResult.success() : this._(true, null);
  const UpdatePasswordResult.failure(AuthFailure f) : this._(false, f);

  bool get isSuccess => ok;
  bool get isFailure => !ok;
}
