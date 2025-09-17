// features/auth/application/usecases/login_with_email_usecase.dart
import 'package:restaurant_marketplace/features/auth/domain/entities/auth_account.dart';
import 'package:restaurant_marketplace/features/auth/domain/entities/auth_failures.dart';
import 'package:restaurant_marketplace/features/auth/domain/repositories/auth_repository.dart';

/// Use case wrapper for login with email/password.
/// - Stays provider/SDK agnostic (no firebase imports).
/// - Surfaces three outcomes: success, failure, or MFA required.
class LoginWithEmailUseCase {
  final AuthRepository _repo;
  LoginWithEmailUseCase(this._repo);

  Future<LoginWithEmailResult> call({
    required String email,
    required String password,
  }) async {
    // Basic hygiene to avoid noisy SDK errors
    final e = email.trim();
    final p = password; // keep password verbatim

    if (e.isEmpty || p.isEmpty) {
      return LoginWithEmailResult.failure(const AuthFailure.invalidCredentials());
    }

    try {
      final account = await _repo.loginWithEmail(email: e, password: p);
      return LoginWithEmailResult.success(account);
    } on AuthFailure catch (f) {
      // Domain-mapped error from the repository (preferred path)
      return LoginWithEmailResult.failure(f);
    } catch (err, _) {
      // Repository bubbles MFA as a provider-specific exception (opaque `Object`).
      // We must NOT import provider types here; use dynamic to read what we need.
      final mfa = _tryExtractMfa(err);
      if (mfa != null) {
        return LoginWithEmailResult.mfaRequired(
          resolver: mfa.resolver,
          factorUids: mfa.factorUids,
        );
      }
      // Unknown non-domain error: surface as unknown to UI.
      return LoginWithEmailResult.failure(AuthFailure.unknown(err.toString()));
    }
  }

  /// Try to extract MFA details from an opaque provider exception (e.g. FirebaseAuthMultiFactorException).
  /// Returns `null` if not an MFA exception or structure is unexpected.
  _MfaInfo? _tryExtractMfa(Object err) {
    try {
      final dyn = err as dynamic;
      final resolver = dyn.resolver; // opaque object; repository will use it later
      if (resolver == null) return null;

      // resolver.hints: a list of factor infos; we only need UIDs as strings
      final hints = (resolver.hints as List<dynamic>? ?? const []);
      final factorUids = <String>[
        for (final h in hints)
          if ((h as dynamic).uid != null) (h as dynamic).uid as String,
      ];
      if (factorUids.isEmpty) return _MfaInfo(resolver, const []);
      return _MfaInfo(resolver, factorUids);
    } catch (_) {
      return null; // not an MFA exception we recognize
    }
  }
}

/// Result type for login
class LoginWithEmailResult {
  final AuthAccount? account;
  final AuthFailure? failure;
  final Object? resolver; // opaque provider resolver for MFA
  final List<String> factorUids;

  const LoginWithEmailResult._({
    this.account,
    this.failure,
    this.resolver,
    this.factorUids = const [],
  });

  factory LoginWithEmailResult.success(AuthAccount account) =>
      LoginWithEmailResult._(account: account);

  factory LoginWithEmailResult.failure(AuthFailure failure) =>
      LoginWithEmailResult._(failure: failure);

  factory LoginWithEmailResult.mfaRequired({
    required Object resolver,
    required List<String> factorUids,
  }) =>
      LoginWithEmailResult._(resolver: resolver, factorUids: factorUids);

  bool get isSuccess => account != null;
  bool get isFailure => failure != null;
  bool get requiresMfa => resolver != null;
}

class _MfaInfo {
  final Object resolver;
  final List<String> factorUids;
  _MfaInfo(this.resolver, this.factorUids);
}
