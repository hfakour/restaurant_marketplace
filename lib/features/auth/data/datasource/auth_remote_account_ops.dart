import 'package:firebase_auth/firebase_auth.dart' as fa;
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import 'auth_remote_ds_helpers.dart';
import 'core/auth_remote_core.dart';

mixin AuthRemoteAccountOps on AuthRemoteCore {
  Future<void> signOut() => auth.signOut();

  Future<void> updateDisplayName({required fa.User user, required String displayName}) async {
    await user.updateDisplayName(displayName.trim());
    await user.reload();
  }

  Future<void> linkEmailPassword({required String email, required String password}) async {
    final user = await auth.requireFreshUser();
    final cred = fa.EmailAuthProvider.credential(email: email.trim(), password: password);
    await user.linkWithCredential(cred);

    if (user.email != null && !user.emailVerified) {
      try { await sendVerificationEmail(user); } catch (_) {}
    }
    await user.reload();
  }

  Future<void> updateEmail(String newEmail) async {
    final trimmed = newEmail.trim();
    final fa.User user = await auth.requireFreshUser();
    final dynamic dynUser = user as dynamic;

    try {
      await dynUser.verifyBeforeUpdateEmail(trimmed);
    } on NoSuchMethodError {
      try { await dynUser.updateEmail(trimmed); }
      on NoSuchMethodError {
        throw fa.FirebaseAuthException(
          code: 'unsupported-operation',
          message: 'verifyBeforeUpdateEmail/updateEmail not available; check firebase_auth version.',
        );
      }
    } on fa.FirebaseAuthException { rethrow; }
    catch (e, st) {
      FirebaseCrashlytics.instance.recordError(e, st, reason: 'updateEmail unexpected');
      throw fa.FirebaseAuthException(code: 'unknown', message: 'Failed to update email: $e');
    }

    try {
      final refreshed = auth.currentUser;
      if (refreshed != null && !refreshed.emailVerified) { await sendVerificationEmail(refreshed); }
    } catch (_) {}

    try { await user.reload(); } catch (_) {}
  }

  Future<void> updatePassword(String newPassword) async {
    final user = await auth.requireFreshUser();
    await user.updatePassword(newPassword);
    await user.reload();
  }

  Future<void> deleteAccount() async {
    final user = await auth.requireFreshUser();
    await user.delete();
  }
}
