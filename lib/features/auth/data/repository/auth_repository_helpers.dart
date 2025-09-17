import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/entities/auth_failures.dart';

/// Build a display name from first/last name with trimming and single spacing.
String fullName(String first, String last) =>
    [first.trim(), last.trim()].where((s) => s.isNotEmpty).join(' ');

/// Wrap a sensitive Firebase operation:
/// - Maps common reauth/session expiry codes to domain failures
/// - Falls back to the provided [errorMapper] for everything else
Future<T> sensitive<T>(
    Future<T> Function() op,
    AuthFailure Function(FirebaseAuthException) errorMapper,
    ) async {
  try {
    return await op();
  } on FirebaseAuthException catch (e) {
    if (e.code == 'requires-recent-login') {
      throw const AuthFailure.reauthRequired();
    }
    if (e.code == 'user-token-expired') {
      throw const AuthFailure.sessionExpired();
    }
    throw errorMapper(e);
  }
}

/// Basic password strength gate to fail fast before hitting the SDK.
/// Rules:
/// - at least 8 characters
/// - contains a letter
/// - contains a digit
/// - contains a special character
bool isPasswordStrong(String password) {
  final hasMinLength = password.length >= 8;
  final hasLetter = RegExp(r'[A-Za-z]').hasMatch(password);
  final hasDigit = RegExp(r'\d').hasMatch(password);
  final hasSpecial = RegExp(r'[!@#\$%^&*(),.?":{}|<>]').hasMatch(password);
  return hasMinLength && hasLetter && hasDigit && hasSpecial;
}
