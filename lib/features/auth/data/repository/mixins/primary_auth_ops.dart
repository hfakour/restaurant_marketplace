import 'package:firebase_auth/firebase_auth.dart';

import '../../../domain/entities/auth_account.dart';
import '../../../domain/entities/auth_failures.dart';
import '../auth_repository_helpers.dart';
import '../core/_auth_repo_core.dart';

mixin PrimaryAuthOps on AuthRepoCore  {
  Future<AuthAccount> registerWithEmail({
    required String firstName,
    required String lastName,
    required String phoneNumber,
    String? email,
    required String password,
  }) async {
    // If no email, bootstrap an anonymous account and profile.
    if (email == null || email.trim().isEmpty) {
      final cred = await remote.loginAnonymous();
      final u = cred.user!;
      final dn = fullName(firstName, lastName);
      if (dn.isNotEmpty) {
        await remote.updateDisplayName(user: u, displayName: dn);
      }
      await _ensureProfile(
        uid: u.uid,
        firstName: firstName,
        lastName: lastName,
        phoneNumber: phoneNumber,
        email: null,
      );
      return mapUser(u);
    }

    // Enforce password strength early for proper UX.
    if (!isPasswordStrong(password)) {
      throw const AuthFailure.weakPassword();
    }

    final cred = await remote.createEmailUser(
      email: email.trim(),
      password: password,
    );

    await cred.user?.reload();
    final u = cred.user!;

    final dn = fullName(firstName, lastName);
    if (dn.isNotEmpty) {
      await remote.updateDisplayName(user: u, displayName: dn);
    }

    await remote.sendEmailVerification(u);

    await _ensureProfile(
      uid: u.uid,
      firstName: firstName,
      lastName: lastName,
      phoneNumber: phoneNumber,
      email: email.trim(),
    );

    return mapUser(u);
  }

  Future<AuthAccount> loginWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final cred = await remote.loginWithEmail(email: email, password: password);
      final user = cred.user!;
      await user.reload();

      if (!user.emailVerified) {
        // Nudge verification, keep account secure.
        await remote.sendEmailVerification(user);
        await remote.signOut();
        throw const AuthFailure.emailNotVerified();
      }

      return mapUser(user);
    } on FirebaseAuthMultiFactorException catch (_) {
      // Bubble MFA to the use case; UI will continue with resolver.
      rethrow;
    } on FirebaseAuthException catch (e) {
      throw mapError(e);
    }
  }

  Future<AuthAccount> loginAnonymous({
    required String firstName,
    required String lastName,
    required String phoneNumber,
  }) async {
    final cred = await remote.loginAnonymous();
    final u = cred.user!;
    final dn = fullName(firstName, lastName);
    if (dn.isNotEmpty) {
      await remote.updateDisplayName(user: u, displayName: dn);
    }
    await _ensureProfile(
      uid: u.uid,
      firstName: firstName,
      lastName: lastName,
      phoneNumber: phoneNumber,
      email: null,
    );
    return mapUser(u);
  }

  Future<void> linkEmailPassword({
    required String email,
    required String password,
  }) =>
      sensitive(
            () => remote.linkEmailPassword(email: email, password: password),
        mapError,
      );

  Future<void> resetPassword({required String email}) {
    return remote.sendPasswordResetEmail(email);
  }

  Future<void> sendEmailVerification() async {
    final user = remote.currentUser;
    if (user == null) throw const AuthFailure.sessionExpired();
    await remote.sendEmailVerification(user);
  }

  // Minimal profile upsert (keeps noise low); timestamps are set in the data source.
  Future<void> _ensureProfile({
    required String uid,
    required String firstName,
    required String lastName,
    required String phoneNumber,
    String? email,
  }) async {
    final data = <String, dynamic>{
      'id': uid,
      'firstName': firstName,
      'lastName': lastName,
      'contactNumber': phoneNumber,
      if (email != null) 'email': email,
      'isEmailVerified': email != null,
      'isPhoneVerified': false,
    };
    await remote.upsertProfile(uid, data);
  }
}
