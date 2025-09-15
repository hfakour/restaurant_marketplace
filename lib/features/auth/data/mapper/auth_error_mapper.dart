// auth/data/mapper/auth_error_mapper.dart
import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/entities/auth_failures.dart';

AuthFailure mapFirebaseAuthException(FirebaseAuthException e) {
  switch (e.code) {
    case 'invalid-credential':
    case 'wrong-password':
    case 'user-not-found':
      return const AuthFailure.invalidCredentials();
    case 'user-disabled':
      return const AuthFailure.userDisabled();
    case 'too-many-requests':
      return const AuthFailure.tooManyRequests(retryAfterSeconds: null);
    case 'invalid-email':
      return const AuthFailure.unknown('Invalid email address');
    case 'email-already-in-use':
      return const AuthFailure.unknown('Email already in use');
    case 'weak-password':
      return const AuthFailure.unknown('Weak password');
    case 'operation-not-allowed':
      return const AuthFailure.serverIssue();
    case 'requires-recent-login':
      return const AuthFailure.unknown('Reauthentication required');
    case 'account-exists-with-different-credential':
      return const AuthFailure.unknown('Account exists with different credential');
    case 'network-request-failed':
      return const AuthFailure.networkIssue();
    default:
      return AuthFailure.unknown(e.message ?? 'Unknown error');
  }
}
