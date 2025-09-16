// auth/data/mapper/auth_error_mapper.dart
import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/entities/auth_failures.dart';

/// تلاش می‌کند مقدار «Retry-After» را از پیام خطا حدس بزند (اگر SDK هدر ندهد).
/// الگوهای رایج:
/// - "Try again in 60 seconds"
/// - "Retry after 2 minutes"
/// - "Please wait 1h"
int? _parseRetryAfterSeconds(String? message) {
  if (message == null) return null;

  // seconds
  final sec = RegExp(r'(\d+)\s*(?:seconds?|secs?|s)\b', caseSensitive: false)
      .firstMatch(message);
  if (sec != null) return int.tryParse(sec.group(1) ?? '');

  // minutes
  final min = RegExp(r'(\d+)\s*(?:minutes?|mins?|m)\b', caseSensitive: false)
      .firstMatch(message);
  if (min != null) {
    final v = int.tryParse(min.group(1) ?? '');
    if (v != null) return v * 60;
  }

  // hours
  final hr = RegExp(r'(\d+)\s*(?:hours?|hrs?|h)\b', caseSensitive: false)
      .firstMatch(message);
  if (hr != null) {
    final v = int.tryParse(hr.group(1) ?? '');
    if (v != null) return v * 3600;
  }

  return null;
}

AuthFailure mapFirebaseAuthException(FirebaseAuthException e) {
  switch (e.code) {
  // اعتبارنامه/ورود نامعتبر
    case 'invalid-credential':
    case 'invalid-login-credentials':
    case 'wrong-password':
    case 'user-not-found':
    case 'user-mismatch':
      return const AuthFailure.invalidCredentials();

    case 'user-disabled':
      return const AuthFailure.userDisabled();

    case 'too-many-requests':
    // اگر SDK زمان انتظار را در پیام قرار داده باشد، پارس می‌کنیم تا UI تایمر نشان دهد.
      return AuthFailure.tooManyRequests(
        retryAfterSeconds: _parseRetryAfterSeconds(e.message),
      );

    case 'invalid-email':
      return const AuthFailure.unknown('Invalid email address');

    case 'email-already-in-use':
      return const AuthFailure.emailAlreadyInUse();

    case 'weak-password':
      return const AuthFailure.unknown('Weak password');

    case 'operation-not-allowed':
      return const AuthFailure.serverIssue();

    case 'requires-recent-login':
      return const AuthFailure.reauthRequired();

    case 'account-exists-with-different-credential':
      return const AuthFailure.providerAlreadyLinked();

    case 'provider-already-linked':
    case 'credential-already-in-use':
      return const AuthFailure.providerAlreadyLinked();

    case 'invalid-verification-code':
    case 'invalid-verification-id':
      return const AuthFailure.invalidOtp();

    case 'user-token-expired':
    case 'id-token-expired':
      return const AuthFailure.sessionExpired();

    case 'network-request-failed':
      return const AuthFailure.networkIssue();

    default:
      return AuthFailure.unknown(e.message ?? 'Unknown error');
  }
}
