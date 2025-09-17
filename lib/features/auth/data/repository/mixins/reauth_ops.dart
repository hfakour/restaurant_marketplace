import 'package:firebase_auth/firebase_auth.dart';

import '../../../domain/entities/auth_failures.dart';
import '../auth_repository_helpers.dart';
import '../core/_auth_repo_core.dart';

mixin ReauthOps on AuthRepoCore  {
  Future<void> reauthenticateWithPassword(String email, String password) async {
    try {
      await remote.reauthWithPassword(email, password);
    } on FirebaseAuthException catch (e) {
      throw mapError(e);
    }
  }

  Future<void> reauthenticateWithProvider({
    required String providerId,
    String? idToken,
    String? accessToken,
    String? rawNonce,
    String? authCode,
  }) async {
    try {
      late AuthCredential cred;

      switch (providerId) {
        case 'google.com':
          cred = GoogleAuthProvider.credential(
            idToken: idToken,
            accessToken: accessToken,
          );
          break;
        case 'facebook.com':
          cred = FacebookAuthProvider.credential(accessToken!);
          break;
        case 'apple.com':
          final provider = OAuthProvider('apple.com');
          cred = provider.credential(
            idToken: idToken,
            accessToken: accessToken,
            rawNonce: rawNonce,
            // Some SDKs also support: authorizationCode: authCode,
          );
          break;
        default:
          final provider = OAuthProvider(providerId);
          cred = provider.credential(
            idToken: idToken,
            accessToken: accessToken,
            rawNonce: rawNonce,
          );
          break;
      }

      await remote.reauthWithCredential(cred);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        throw const AuthFailure.reauthRequired();
      }
      if (e.code == 'user-token-expired') {
        throw const AuthFailure.sessionExpired();
      }
      throw mapError(e);
    }
  }

  Future<void> updateEmail(String newEmail) =>
      sensitive(() => remote.updateEmail(newEmail), mapError);

  Future<void> updatePassword(String newPassword) =>
      sensitive(() async {
        if (!isPasswordStrong(newPassword)) {
          throw const AuthFailure.weakPassword();
        }
        return remote.updatePassword(newPassword);
      }, mapError);

  Future<void> deleteAccount() =>
      sensitive(() => remote.deleteAccount(), mapError);
}
