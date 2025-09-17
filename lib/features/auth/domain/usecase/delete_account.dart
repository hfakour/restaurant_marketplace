import '../entities/auth_failures.dart';
import '../repositories/auth_repository.dart';

/// Deletes the currently authenticated account.
/// Surfaces domain failures explicitly instead of throwing.
class DeleteAccountUseCase {
  final AuthRepository _repo;
  DeleteAccountUseCase(this._repo);

  Future<DeleteAccountResult> call() async {
    try {
      await _repo.deleteAccount();
      return const DeleteAccountResult.success();
    } on AuthFailure catch (f) {
      return DeleteAccountResult.failure(f);
    } catch (e) {
      return DeleteAccountResult.failure(AuthFailure.unknown(e.toString()));
    }
  }
}

/// Result type for delete account
class DeleteAccountResult {
  final bool ok;
  final AuthFailure? failure;

  const DeleteAccountResult._({required this.ok, this.failure});

  const DeleteAccountResult.success() : this._(ok: true);
  const DeleteAccountResult.failure(AuthFailure f)
      : this._(ok: false, failure: f);

  bool get isSuccess => ok;
  bool get isFailure => !ok;
}
