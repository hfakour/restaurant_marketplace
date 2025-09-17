// features/auth/application/usecases/login_with_email_usecase.dart
import 'package:firebase_auth/firebase_auth.dart' as fa; // only used to catch MFA exception + read hints
import 'package:restaurant_marketplace/features/auth/domain/entities/auth_account.dart';
import 'package:restaurant_marketplace/features/auth/domain/entities/auth_failures.dart';
import 'package:restaurant_marketplace/features/auth/domain/repositories/auth_repository.dart';

class LoginWithEmailUseCase {
  final AuthRepository _repo;
  LoginWithEmailUseCase(this._repo);

  Future<LoginWithEmailResult> call({
    required String email,
    required String password,
  }) async {
    try {
      final account = await _repo.loginWithEmail(email: email, password: password);
      return LoginWithEmailResult.success(account);
    } on fa.FirebaseAuthMultiFactorException catch (e) {
      // Extract factor UIDs (don’t expose Firebase types to layers above)
      final factorUids = e.resolver.hints
          .whereType<fa.PhoneMultiFactorInfo>()
          .map((h) => h.uid)
          .toList();

      return LoginWithEmailResult.mfaRequired(
        resolver: e.resolver, // keep opaque as Object
        factorUids: factorUids,
      );
    } on AuthFailure catch (f) {
      return LoginWithEmailResult.failure(f);
    }
  }
}

/// Simple sealed-like result
class LoginWithEmailResult {
  final AuthAccount? account;
  final AuthFailure? failure;
  final Object? resolver;           // opaque handle for MFA
  final List<String>? factorUids;   // available factors (UIDs)

  const LoginWithEmailResult._({
    this.account,
    this.failure,
    this.resolver,
    this.factorUids,
  });

  factory LoginWithEmailResult.success(AuthAccount account) =>
      LoginWithEmailResult._(account: account);

  factory LoginWithEmailResult.failure(AuthFailure failure) =>
      LoginWithEmailResult._(failure: failure);

  factory LoginWithEmailResult.mfaRequired({
    required Object resolver,
    required List<String> factorUids,
  }) =>
      LoginWithEmailResult._(
        resolver: resolver,
        factorUids: factorUids,
      );

  bool get isSuccess => account != null;
  bool get isFailure => failure != null;
  bool get requiresMfa => resolver != null;
}
