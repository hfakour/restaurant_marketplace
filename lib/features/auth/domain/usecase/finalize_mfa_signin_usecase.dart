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
    // Basic hygiene: trim and quick validation so we fail fast before hitting SDK.
    final vid = verificationId.trim();
    final code = smsCode.trim();

    if (vid.isEmpty || code.isEmpty) {
      return FinalizeMfaSignInResult.failure(const AuthFailure.invalidOtp());
    }
    // Most SMS codes are 6 digits; if your backend differs, relax/remove this.
    final looksNumeric = RegExp(r'^\d{6}$');
    if (!looksNumeric.hasMatch(code)) {
      // Don’t block weird-but-valid providers; mark as invalid OTP anyway.
      return FinalizeMfaSignInResult.failure(const AuthFailure.invalidOtp());
    }

    try {
      final account = await _repo.mfaFinalizeSignIn(
        resolver: resolver,
        verificationId: vid,
        smsCode: code,
      );
      return FinalizeMfaSignInResult.success(account);
    } on AuthFailure catch (f) {
      // Repo already mapped Firebase to domain; just forward it.
      return FinalizeMfaSignInResult.failure(f);
    } catch (e) {
      // Anything else (opaque provider exceptions, unexpected throws).
      return FinalizeMfaSignInResult.failure(AuthFailure.unknown(e.toString()));
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
