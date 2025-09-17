// auth/domain/usecase/register_with_email.dart
import 'package:restaurant_marketplace/features/auth/domain/entities/auth_account.dart';
import 'package:restaurant_marketplace/features/auth/domain/entities/auth_failures.dart';
import 'package:restaurant_marketplace/features/auth/domain/repositories/auth_repository.dart';

class RegisterWithEmailUseCase {
  RegisterWithEmailUseCase(this._repo);
  final AuthRepository _repo;

  Future<RegisterWithEmailResult> call({
    required String firstName,
    required String lastName,
    required String phoneNumber,
    String? email,
    required String password,
  }) async {
    final f = firstName.trim();
    final l = lastName.trim();
    final p = phoneNumber.trim();
    final e = email?.trim();

    // Basic hygiene before hitting the repo/SDK
    if (f.isEmpty || l.isEmpty || p.isEmpty) {
      return const RegisterWithEmailResult.failure(
        AuthFailure.invalidCredentials(), // you can introduce a dedicated failure if you prefer
      );
    }
    if (e != null && e.isNotEmpty && !_looksLikeEmail(e)) {
      return const RegisterWithEmailResult.failure(AuthFailure.invalidEmail());
    }
    if (password.isEmpty) {
      return const RegisterWithEmailResult.failure(AuthFailure.weakPassword());
    }

    try {
      final account = await _repo.registerWithEmail(
        firstName: f,
        lastName: l,
        phoneNumber: p,
        email: e?.isEmpty == true ? null : e,
        password: password, // keep exact; repo enforces strength anyway
      );
      return RegisterWithEmailResult.success(account);
    } on AuthFailure catch (af) {
      return RegisterWithEmailResult.failure(af);
    } catch (err) {
      return RegisterWithEmailResult.failure(AuthFailure.unknown(err.toString()));
    }
  }

  bool _looksLikeEmail(String e) {
    // Minimal, permissive email check; repo/SDK will enforce stricter rules.
    final re = RegExp(r"^[^@\s]+@[^@\s]+\.[^@\s]+$");
    return re.hasMatch(e);
  }
}

/// Result wrapper so UI never needs try/catch.
class RegisterWithEmailResult {
  final AuthAccount? account;
  final AuthFailure? failure;

  const RegisterWithEmailResult._({this.account, this.failure});

  factory RegisterWithEmailResult.success(AuthAccount account) =>
      RegisterWithEmailResult._(account: account);

  const factory RegisterWithEmailResult.failure(AuthFailure failure) =
  _RegisterWithEmailFailure;

  bool get isSuccess => account != null;
  bool get isFailure => failure != null;
}

class _RegisterWithEmailFailure extends RegisterWithEmailResult {
  const _RegisterWithEmailFailure(AuthFailure failure)
      : super._(failure: failure);
}
