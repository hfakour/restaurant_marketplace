import 'package:restaurant_marketplace/features/auth/domain/repositories/auth_repository.dart';
import 'package:restaurant_marketplace/features/auth/domain/entities/auth_account.dart';
import 'package:restaurant_marketplace/features/auth/domain/entities/auth_failures.dart';

class FinalizeMfaSignInUseCase {
  final AuthRepository _repo;
  FinalizeMfaSignInUseCase(this._repo);

  Future<FinalizeMfaSignInResult> call({
    required Object resolver,
    required String verificationId,
    required String smsCode,
  }) async {
    try {
      final account = await _repo.mfaFinalizeSignIn(
        resolver: resolver,
        verificationId: verificationId,
        smsCode: smsCode,
      );
      return FinalizeMfaSignInResult.success(account);
    } on AuthFailure catch (f) {
      return FinalizeMfaSignInResult.failure(f);
    }
  }
}

/// Result type (success/failure). Never throws.
class FinalizeMfaSignInResult {
  final AuthAccount? account;
  final AuthFailure? failure;

  const FinalizeMfaSignInResult._({this.account, this.failure});

  factory FinalizeMfaSignInResult.success(AuthAccount account) =>
      FinalizeMfaSignInResult._(account: account);

  factory FinalizeMfaSignInResult.failure(AuthFailure failure) =>
      FinalizeMfaSignInResult._(failure: failure);

  bool get isSuccess => account != null;
  bool get isFailure => failure != null;
}
