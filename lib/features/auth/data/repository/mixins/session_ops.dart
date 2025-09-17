import 'package:firebase_auth/firebase_auth.dart';
import '../../../domain/entities/auth_account.dart';
import '../../../domain/entities/auth_failures.dart';
import '../core/_auth_repo_core.dart';

mixin SessionOps on AuthRepoCore  {
  /// Emits mapped auth state with de-duplication in the data source.
  Stream<AuthAccount?> authState() {
    return remote.onAuthState().map((u) => u == null ? null : mapUser(u));
  }

  /// Snapshot of the current user in memory (no I/O).
  AuthAccount? get currentUser {
    final u = remote.currentUser;
    return u == null ? null : mapUser(u);
  }

  /// Fresh account by reloading from the source. Throws domain failures.
  Future<AuthAccount> currentAccount() async {
    final u = remote.currentUser;
    if (u == null) throw const AuthFailure.sessionExpired();
    try {
      await u.reload();
      final fresh = remote.currentUser;
      if (fresh == null) throw const AuthFailure.sessionExpired();
      return mapUser(fresh);
    } on FirebaseAuthException catch (e) {
      throw mapError(e);
    }
  }

  /// Reload and return whether email is verified now.
  Future<bool> reloadAndEmailVerified() async {
    final u = remote.currentUser;
    if (u == null) return false;
    try {
      await u.reload();
      final refreshed = remote.currentUser;
      return refreshed?.emailVerified ?? false;
    } on FirebaseAuthException catch (e) {
      throw mapError(e);
    }
  }

  /// Sign out from the current session.
  Future<void> signOut() => remote.signOut();
}
