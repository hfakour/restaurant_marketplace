// auth/data/mapper/auth_error_mapper.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import '../../domain/entities/auth_failures.dart';

// Use dart:developer for lightweight logging. In production you may plug
// into a more robust logging solution, but developer.log allows us to
// record messages without pulling in additional dependencies. It is
// intentionally kept here rather than in the mapper function below so
// the rest of the code remains unchanged when logging is disabled.
import 'dart:developer' as developer;

/// Attempts to guess a "Retry-After" seconds value from an error message
/// if the SDK does not provide a header.
int? _parseRetryAfterSeconds(String? message) {
  if (message == null) return null;

  final sec = RegExp(r'(\d+)\s*(?:seconds?|secs?|s)\b', caseSensitive: false)
      .firstMatch(message);
  if (sec != null) return int.tryParse(sec.group(1) ?? '');

  final min = RegExp(r'(\d+)\s*(?:minutes?|mins?|m)\b', caseSensitive: false)
      .firstMatch(message);
  if (min != null) {
    final v = int.tryParse(min.group(1) ?? '');
    if (v != null) return v * 60;
  }

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
  // Invalid credentials / login problems
    case 'wrong-password':
      return const AuthFailure.wrongPassword();

    case 'invalid-credential':
      return const AuthFailure.invalidCredentials();

    case 'user-not-found':
      return const AuthFailure.userNotFound();

    case 'user-mismatch':
      return const AuthFailure.invalidCredentials();

    case 'user-disabled':
      return const AuthFailure.userDisabled();

    case 'too-many-requests':
      return AuthFailure.tooManyRequests(
        retryAfterSeconds: _parseRetryAfterSeconds(e.message),
      );

    case 'invalid-email':
      return const AuthFailure.invalidEmail();

    case 'email-already-in-use':
      return const AuthFailure.emailAlreadyInUse();

    case 'weak-password':
      return const AuthFailure.weakPassword();

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
    // Log unhandled error codes for future mapping (no PII).
      developer.log(
        'Unhandled FirebaseAuthException code: ${e.code}',
        name: 'AuthErrorMapper',
      );

      final info = e.message == null ? const <Object>[] : <Object>[e.message!];
      FirebaseCrashlytics.instance.recordError(
        e,
        StackTrace.current,
        reason: 'Unhandled FirebaseAuthException code: ${e.code}',
        information: info,
      );

      return AuthFailure.unknown(e.message ?? 'Unknown authentication error');
  }
}
