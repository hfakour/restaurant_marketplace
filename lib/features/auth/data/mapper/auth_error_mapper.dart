// auth/data/mapper/auth_error_mapper.dart
import 'dart:developer' as developer;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import '../../domain/entities/auth_failures.dart';

/// Try to infer "retry-after" seconds from an error message when no header is present.
int? _parseRetryAfterSeconds(String? message) {
  if (message == null) return null;

  final sec = RegExp(r'(\d+)\s*(?:seconds?|secs?|s)\b', caseSensitive: false).firstMatch(message);
  if (sec != null) return int.tryParse(sec.group(1) ?? '');

  final min = RegExp(r'(\d+)\s*(?:minutes?|mins?|m)\b', caseSensitive: false).firstMatch(message);
  if (min != null) {
    final v = int.tryParse(min.group(1) ?? '');
    if (v != null) return v * 60;
  }

  final hr = RegExp(r'(\d+)\s*(?:hours?|hrs?|h)\b', caseSensitive: false).firstMatch(message);
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

  // Rate-limit / throttling
    case 'too-many-requests':
      return AuthFailure.tooManyRequests(retryAfterSeconds: _parseRetryAfterSeconds(e.message));

  // Email / password validation
    case 'invalid-email':
      return const AuthFailure.invalidEmail();
    case 'email-already-in-use':
      return const AuthFailure.emailAlreadyInUse();
    case 'weak-password':
      return const AuthFailure.weakPassword();

  // Provider / linking
    case 'operation-not-allowed':
      return const AuthFailure.serverIssue();
    case 'requires-recent-login':
      return const AuthFailure.reauthRequired();
    case 'account-exists-with-different-credential':
      return const AuthFailure.providerAlreadyLinked();
    case 'provider-already-linked':
    case 'credential-already-in-use':
      return const AuthFailure.providerAlreadyLinked();

  // Phone / OTP
    case 'invalid-verification-code':
    case 'invalid-verification-id':
      return const AuthFailure.invalidOtp();
    case 'invalid-phone-number':
      return const AuthFailure.invalidPhone();

  // Session / tokens
    case 'user-token-expired':
    case 'id-token-expired':
    case 'session-cookie-expired':
    case 'user-not-logged-in': // thrown by our helper in DS
      return const AuthFailure.sessionExpired();

  // Network / timeouts
    case 'network-request-failed':
      return const AuthFailure.networkIssue();
    case 'timeout':
    case 'deadline-exceeded':
      return const AuthFailure.networkTimeout();

    default:
    // Log unknown code without PII; surface to Crashlytics for triage.
      developer.log(
        'Unhandled FirebaseAuthException code: ${e.code}',
        name: 'AuthErrorMapper',
        error: e,
      );

      final info = <Object>[];
      if (e.message != null) info.add('message=${e.message}');
      FirebaseCrashlytics.instance.recordError(
        e,
        StackTrace.current,
        reason: 'Unhandled FirebaseAuthException code: ${e.code}',
        information: info,
      );

      return AuthFailure.unknown(e.message ?? 'Unknown authentication error');
  }
}
