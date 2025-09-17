import 'package:firebase_auth/firebase_auth.dart' as fa;
import 'core/auth_remote_core.dart';
import 'auth_remote_ds_helpers.dart';

mixin AuthRemoteReauthOps on AuthRemoteCore {
  Future<void> reauthWithPassword(String email, String password) async {
    final user = await auth.requireFreshUser();
    final cred = fa.EmailAuthProvider.credential(email: email.trim(), password: password);
    await user.reauthenticateWithCredential(cred);
  }

  Future<void> reauthWithCredential(fa.AuthCredential cred) async {
    final user = await auth.requireFreshUser();
    await user.reauthenticateWithCredential(cred);
  }
}
