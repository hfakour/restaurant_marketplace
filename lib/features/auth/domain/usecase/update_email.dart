import 'package:restaurant_marketplace/features/auth/domain/entities/auth_failures.dart';
import 'package:restaurant_marketplace/features/auth/domain/repositories/auth_repository.dart';

class UpdateEmailUseCase {
  final AuthRepository _repo;
  UpdateEmailUseCase(this._repo);

  Future<UpdateEmailResult> call(String newEmail) async {
    final e = newEmail.trim();
    if (e.isEmpty) {
      return const UpdateEmailResult.failure(AuthFailure.invalidEmail());
    }

    try {
      await _repo.updateEmail(e);
      return const UpdateEmailResult.success();
    } on AuthFailure catch (f) {
      return UpdateEmailResult.failure(f);
    } catch (err) {
      return UpdateEmailResult.failure(
        AuthFailure.unknown(err.toString()),
      );
    }
  }
}

/// Result wrapper so this use case never throws.
class UpdateEmailResult {
  final bool ok;
  final AuthFailure? failure;

  const UpdateEmailResult._(this.ok, this.failure);

  const UpdateEmailResult.success() : this._(true, null);
  const UpdateEmailResult.failure(AuthFailure f) : this._(false, f);

  bool get isSuccess => ok;
  bool get isFailure => !ok;
}
