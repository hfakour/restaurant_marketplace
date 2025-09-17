import 'package:restaurant_marketplace/features/auth/domain/entities/auth_failures.dart';
import 'package:restaurant_marketplace/features/auth/domain/repositories/auth_repository.dart';

class StartMfaSignInResolveUseCase {
  final AuthRepository _repo;
  StartMfaSignInResolveUseCase(this._repo);

  Future<StartMfaSignInResolveResult> call({
    required Object resolver,
    required String factorUid,
  }) async {
    final uid = factorUid.trim();
    if (uid.isEmpty) {
      // If you have a dedicated failure, e.g., invalidMfaFactor, use that.
      return const StartMfaSignInResolveResult.failure(AuthFailure.invalidOtp());
    }

    try {
      final verificationId =
      await _repo.mfaStartSignInResolve(resolver, factorUid: uid);
      return StartMfaSignInResolveResult.success(verificationId);
    } on AuthFailure catch (f) {
      return StartMfaSignInResolveResult.failure(f);
    } catch (e) {
      // Any unexpected provider exception becomes a domain failure.
      return StartMfaSignInResolveResult.failure(AuthFailure.unknown(e.toString()));
    }
  }
}

/// Result type (success/failure). Never throws.
class StartMfaSignInResolveResult {
  final String? verificationId;
  final AuthFailure? failure;

  const StartMfaSignInResolveResult._({this.verificationId, this.failure});

  const StartMfaSignInResolveResult.success(String verificationId)
      : this._(verificationId: verificationId);

  const StartMfaSignInResolveResult.failure(AuthFailure failure)
      : this._(failure: failure);

  bool get isSuccess => verificationId != null;
  bool get isFailure => failure != null;
}
