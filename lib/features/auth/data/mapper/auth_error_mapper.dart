// auth/data/mapper/auth_error_mapper.dart
import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/entities/auth_failures.dart';

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
      return const AuthFailure.tooManyRequests(retryAfterSeconds: null);

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
