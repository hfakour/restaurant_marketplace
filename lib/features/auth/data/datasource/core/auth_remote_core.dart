import 'package:cloud_firestore/cloud_firestore.dart' as fs;
import 'package:firebase_auth/firebase_auth.dart' as fa;

class AuthRemoteCore {
  AuthRemoteCore(
      this.auth,
      this.firestore, {
        fa.ActionCodeSettings? defaultAcs,
      }) : _defaultAcs = defaultAcs;

  final fa.FirebaseAuth auth;
  final fs.FirebaseFirestore firestore;
  final fa.ActionCodeSettings? _defaultAcs;

  fa.User? get currentUser => auth.currentUser;

  /// Stream of user/claims/token updates.
  Stream<fa.User?> onAuthState() => auth.userChanges();

  /// Expose default ActionCodeSettings to mixins.
  fa.ActionCodeSettings? get defaultAcs => _defaultAcs;

  /// Helper available to all mixins: send a verification email honoring defaultAcs.
  Future<void> sendVerificationEmail(fa.User user) {
    final acs = _defaultAcs;
    return acs != null ? user.sendEmailVerification(acs) : user.sendEmailVerification();
  }
}
