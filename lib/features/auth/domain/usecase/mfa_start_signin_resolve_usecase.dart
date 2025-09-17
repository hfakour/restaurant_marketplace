import 'package:restaurant_marketplace/features/auth/domain/repositories/auth_repository.dart';
import 'package:restaurant_marketplace/features/auth/domain/entities/auth_failures.dart';

class StartMfaSignInResolveUseCase {
  final AuthRepository _repo;
  StartMfaSignInResolveUseCase(this._repo);

  Future<StartMfaSignInResolveResult> call({
    required Object resolver,
    required String factorUid,
  }) async {
    try {
      final verificationId =
      await _repo.mfaStartSignInResolve(resolver, factorUid: factorUid);
      return StartMfaSignInResolveResult.success(verificationId);
    } on AuthFailure catch (f) {
      return StartMfaSignInResolveResult.failure(f);
    }
  }
}

/// Result type (success/failure). Never throws.
class StartMfaSignInResolveResult {
  final String? verificationId;
  final AuthFailure? failure;

  const StartMfaSignInResolveResult._({this.verificationId, this.failure});

  factory StartMfaSignInResolveResult.success(String verificationId) =>
      StartMfaSignInResolveResult._(verificationId: verificationId);

  factory StartMfaSignInResolveResult.failure(AuthFailure failure) =>
      StartMfaSignInResolveResult._(failure: failure);

  bool get isSuccess => verificationId != null;
  bool get isFailure => failure != null;
}
