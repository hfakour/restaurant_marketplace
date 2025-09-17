import 'package:firebase_auth/firebase_auth.dart' as fa;

import 'core/auth_remote_core.dart';

mixin AuthRemoteEmailOps on AuthRemoteCore {
  Future<fa.UserCredential> createEmailUser({
    required String email, required String password,
  }) => auth.createUserWithEmailAndPassword(email: email.trim(), password: password);

  Future<fa.UserCredential> loginWithEmail({
    required String email, required String password,
  }) => auth.signInWithEmailAndPassword(email: email.trim(), password: password);

  Future<fa.UserCredential> loginAnonymous() => auth.signInAnonymously();

  Future<void> sendEmailVerification(fa.User user) => sendVerificationEmail(user);


  Future<void> sendEmailVerificationWithSettings(
      fa.User user, fa.ActionCodeSettings acs,
      ) => user.sendEmailVerification(acs);

  Future<void> sendPasswordResetEmail(String email) {
    final acs = defaultAcs;
    return acs != null
        ? auth.sendPasswordResetEmail(email: email.trim(), actionCodeSettings: acs)
        : auth.sendPasswordResetEmail(email: email.trim());
  }

  Future<void> sendPasswordResetEmailWithSettings(
      String email, fa.ActionCodeSettings acs,
      ) => auth.sendPasswordResetEmail(email: email.trim(), actionCodeSettings: acs);
}
