// auth_remote_ds.dart
//
// Remote data source for authentication. This class is a thin wrapper around
// FirebaseAuth and Firestore and contains only backend calls. Business logic
// and domain mapping must NOT be added here — keep them in the repository/use-cases.
//
// This file intentionally imports helper utilities from
// 'auth_remote_ds_helpers.dart' which lives alongside this file. Keeping helpers
// separate reduces file size and improves readability while preserving the
// original public API.

import 'dart:async';
import 'dart:developer' as developer;

import 'package:cloud_firestore/cloud_firestore.dart' as fs;
import 'package:firebase_auth/firebase_auth.dart' as fa;
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import 'auth_remote_ds_helpers.dart';

class AuthRemoteDataSource {
  final fa.FirebaseAuth _auth;
  final fs.FirebaseFirestore _firestore;

  /// Optional default ActionCodeSettings used for email verification and
  /// password reset links when the caller does not provide one explicitly.
  /// Provide this via DI if you want custom redirect URLs / package IDs.
  final fa.ActionCodeSettings? _defaultAcs;

  AuthRemoteDataSource(
      this._auth,
      this._firestore, {
        fa.ActionCodeSettings? defaultAcs,
      }) : _defaultAcs = defaultAcs;

  // Current user (may be null).
  fa.User? get currentUser => _auth.currentUser;

  // ------------------- AUTH -------------------

  /// Stream of user changes. Uses userChanges() so that profile updates,
  /// email verification and token changes are emitted as well.
  Stream<fa.User?> onAuthState() => _auth.userChanges();

  /// Create a new user with email/password.
  /// - trims the email before calling the SDK.
  Future<fa.UserCredential> createEmailUser({
    required String email,
    required String password,
  }) {
    final e = email.trim();
    return _auth.createUserWithEmailAndPassword(email: e, password: password);
  }

  /// Sign in with email/password.
  Future<fa.UserCredential> loginWithEmail({
    required String email,
    required String password,
  }) {
    final e = email.trim();
    return _auth.signInWithEmailAndPassword(email: e, password: password);
  }

  /// Backwards-compatible alias (optional).
  Future<fa.UserCredential> loginEmail({
    required String email,
    required String password,
  }) =>
      loginWithEmail(email: email, password: password);

  Future<fa.UserCredential> registerWithEmail({
    required String email,
    required String password,
  }) =>
      createEmailUser(email: email, password: password);

  /// Anonymous sign-in.
  Future<fa.UserCredential> loginAnonymous() => _auth.signInAnonymously();

  /// Send email verification for the given [user].
  /// Uses [_defaultAcs] when available; keeps the original signature intact.
  Future<void> sendEmailVerification(fa.User user) {
    final acs = _defaultAcs;
    if (acs != null) {
      return user.sendEmailVerification(acs);
    }
    return user.sendEmailVerification();
  }

  /// Overload when you want to pass custom ActionCodeSettings explicitly.
  Future<void> sendEmailVerificationWithSettings(
      fa.User user,
      fa.ActionCodeSettings acs,
      ) =>
      user.sendEmailVerification(acs);

  /// Sign out current session.
  Future<void> signOut() => _auth.signOut();

  /// Update the display name for a given [user] and reload.
  Future<void> updateDisplayName({
    required fa.User user,
    required String displayName,
  }) async {
    await user.updateDisplayName(displayName.trim());
    await user.reload();
  }

  /// Link email/password credential to the currently authenticated user.
  ///
  /// Note:
  /// - email is trimmed; password is intentionally left intact because spaces
  ///   might be part of a valid password.
  /// - Throws FirebaseAuthException codes coming from the SDK (e.g.
  ///   'email-already-in-use', 'credential-already-in-use') which the repo's
  ///   error mapper should convert to domain failures.
  Future<void> linkEmailPassword({
    required String email,
    required String password,
  }) async {
    final user = await _auth.requireFreshUser();
    final cred = fa.EmailAuthProvider.credential(
      email: email.trim(),
      password: password,
    );
    await user.linkWithCredential(cred);

    // After linking, ensure an email verification is sent (if needed).
    if (user.email != null && !user.emailVerified) {
      try {
        final acs = _defaultAcs;
        if (acs != null) {
          await user.sendEmailVerification(acs);
        } else {
          await user.sendEmailVerification();
        }
      } catch (_) {
        // Intentionally swallow here; UI can offer retry.
      }
    }

    // Reload to ensure latest profile/claims
    await user.reload();
  }

  /// Send password reset email to [email]. Uses [_defaultAcs] if provided.
  Future<void> sendPasswordResetEmail(String email) {
    final e = email.trim();
    final acs = _defaultAcs;
    if (acs != null) {
      return _auth.sendPasswordResetEmail(
        email: e,
        actionCodeSettings: acs,
      );
    }
    return _auth.sendPasswordResetEmail(email: e);
  }

  /// Overload when you want to pass custom ActionCodeSettings explicitly.
  Future<void> sendPasswordResetEmailWithSettings(
      String email,
      fa.ActionCodeSettings acs,
      ) =>
      _auth.sendPasswordResetEmail(email: email.trim(), actionCodeSettings: acs);

  // ------------------- REAUTH -------------------

  /// Reauthenticate using email/password against the currently signed-in user.
  Future<void> reauthWithPassword(String email, String password) async {
    final user = await _auth.requireFreshUser();
    final cred = fa.EmailAuthProvider.credential(
      email: email.trim(),
      password: password,
    );
    await user.reauthenticateWithCredential(cred);
  }

  /// Reauthenticate using any generic credential (OAuth providers, etc).
  Future<void> reauthWithCredential(fa.AuthCredential cred) async {
    final user = await _auth.requireFreshUser();
    await user.reauthenticateWithCredential(cred);
  }

  // ------------------- SENSITIVE OPS -------------------

  /// Update the current user's email to [newEmail], with a compatibility shim
  /// that works across firebase_auth versions:
  /// - If `verifyBeforeUpdateEmail` exists (newer versions) we call it.
  /// - Otherwise we fall back to `updateEmail` if available.
  /// Errors from FirebaseAuth are re-thrown so the repository/error-mapper can map them.
  ///
  /// Note: This uses `dynamic` to avoid compile-time errors when a method is
  /// missing in different firebase_auth package versions.
  Future<void> updateEmail(String newEmail) async {
    final trimmed = newEmail.trim();

    // Ensure we have a fresh user (reload + null check). Assumes helper exists.
    final fa.User user = await _auth.requireFreshUser();

    final dynamic dynUser = user as dynamic;

    // 1) Prefer verifyBeforeUpdateEmail (newer Firebase SDKs / FlutterFire).
    try {
      await dynUser.verifyBeforeUpdateEmail(trimmed);
    } on NoSuchMethodError {
      // 2) Fallback: try updateEmail (older SDKs).
      try {
        await dynUser.updateEmail(trimmed);
      } on NoSuchMethodError {
        throw fa.FirebaseAuthException(
          code: 'unsupported-operation',
          message:
          'Neither verifyBeforeUpdateEmail nor updateEmail is available on the Firebase User. Check firebase_auth version.',
        );
      }
    } on fa.FirebaseAuthException {
      // Let the repository mapper handle specific codes like requires-recent-login.
      rethrow;
    } catch (e, stack) {
      // Record unexpected errors to Crashlytics and wrap in a FirebaseAuthException.
      FirebaseCrashlytics.instance.recordError(
        e,
        stack,
        reason: 'updateEmail unexpected error',
      );
      throw fa.FirebaseAuthException(
        code: 'unknown',
        message: 'Failed to update email: ${e.toString()}',
      );
    }

    // 3) After a successful call, attempt to send verification email (best practice).
    try {
      final refreshed = _auth.currentUser;
      if (refreshed != null && !refreshed.emailVerified) {
        final acs = _defaultAcs;
        if (acs != null) {
          await refreshed.sendEmailVerification(acs);
        } else {
          await refreshed.sendEmailVerification();
        }
      }
    } catch (_) {
      // Swallow sendEmailVerification errors — UI/repo can surface retry option.
    }

    // 4) Reload to ensure the user object is fresh for callers/listeners.
    try {
      await user.reload();
    } catch (_) {
      // ignore reload failures; authState stream will reflect eventual state.
    }
  }

  /// Update password for the current user. Caller must handle reauth on failure.
  Future<void> updatePassword(String newPassword) async {
    final user = await _auth.requireFreshUser();
    await user.updatePassword(newPassword);
    await user.reload();
  }

  /// Delete current user account. Caller must handle reauth if SDK throws.
  Future<void> deleteAccount() async {
    final user = await _auth.requireFreshUser();
    await user.delete();
  }

  // ------------------- MFA (Phone as second factor) -------------------

  /// Starts phone enrollment for MFA and resolves with the [verificationId]
  /// when the SMS code is sent. You must then call [mfaFinalizeEnrollment].
  Future<String> mfaStartPhoneEnrollment(String phoneNumber) async {
    final user = await _auth.requireFreshUser();
    final session = await user.multiFactor.getSession();

    final completer = Completer<String>();
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      multiFactorSession: session,
      verificationCompleted: (_) {
        // We don't auto-complete here; we rely on user entering the code.
      },
      verificationFailed: (fa.FirebaseAuthException e) {
        completer.completeError(e);
      },
      codeSent: (String verificationId, int? resendToken) {
        completer.complete(verificationId);
      },
      codeAutoRetrievalTimeout: (_) {},
    );

    return completer.future;
  }

  /// Finalizes MFA enrollment using the [verificationId] and [smsCode] from the
  /// SMS that was sent in [mfaStartPhoneEnrollment].
  Future<void> mfaFinalizeEnrollment({
    required String verificationId,
    required String smsCode,
    String? displayName,
  }) async {
    final user = await _auth.requireFreshUser();
    final credential = fa.PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );
    await user.multiFactor.enroll(
      fa.PhoneMultiFactorGenerator.getAssertion(credential),
      displayName: displayName,
    );
  }

  /// Unenroll a second factor by its UID (see `user.multiFactor.enrolledFactors`).
  Future<void> mfaUnenrollByUid(String factorUid) async {
    final user = await _auth.requireFreshUser();
    await user.multiFactor.unenroll(factorUid: factorUid);
  }

  // ------------------- MFA Sign-In Challenge -------------------

  /// When login throws FirebaseAuthMultiFactorException, pass its resolver here.
  /// Select the phone factor by [factorUid], send the SMS, and get the verificationId.
  Future<String> mfaStartSignInResolve(
      Object resolver, {
        required String factorUid,
      }) async {
    try {
      final r = resolver as fa.MultiFactorResolver;

      final phoneInfo = r.hints
          .whereType<fa.PhoneMultiFactorInfo>()
          .firstWhere(
            (h) => h.uid == factorUid,
        orElse: () => throw fa.FirebaseAuthException(
          code: 'invalid-argument',
          message: 'MFA factor UID not found on resolver',
        ),
      );

      final completer = Completer<String>();
      await _auth.verifyPhoneNumber(
        multiFactorSession: r.session,
        phoneNumber: phoneInfo.phoneNumber!,
        verificationCompleted: (_) {},
        verificationFailed: (fa.FirebaseAuthException e) {
          completer.completeError(e);
        },
        codeSent: (String verificationId, int? _) {
          completer.complete(verificationId);
        },
        codeAutoRetrievalTimeout: (_) {},
      );
      return completer.future;
    } catch (e, stack) {
      FirebaseCrashlytics.instance
          .recordError(e, stack, reason: 'mfaStartSignInResolve error');
      rethrow;
    }
  }

  /// Finalize MFA sign-in after user enters [smsCode] that matches [verificationId].
  Future<fa.UserCredential> mfaFinalizeSignIn({
    required Object resolver,
    required String verificationId,
    required String smsCode,
  }) async {
    try {
      final r = resolver as fa.MultiFactorResolver;
      final cred = fa.PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      final assertion = fa.PhoneMultiFactorGenerator.getAssertion(cred);
      return r.resolveSignIn(assertion);
    } catch (e, stack) {
      FirebaseCrashlytics.instance
          .recordError(e, stack, reason: 'mfaFinalizeSignIn error');
      rethrow;
    }
  }

  // ------------------- FIRESTORE -------------------

  /// Upsert user profile with transaction safety.
  ///
  /// - Uses 'id' key in document to be consistent with domain models.
  /// - 'createdAt' only set when document is created.
  /// - 'updatedAt' is always set to server timestamp.
  Future<void> upsertProfile(String uid, Map<String, dynamic> data) async {
    await _firestore.runTransaction((tx) async {
      // Use the private _profileDoc helper to avoid ambiguity with any top-level helper.
      final ref = _profileDoc(uid);
      final snap = await tx.get(ref);
      final now = fs.FieldValue.serverTimestamp();

      if (!snap.exists) {
        tx.set(
          ref,
          {
            'id': uid,
            ...data,
            'createdAt': now,
            'updatedAt': now,
          },
          fs.SetOptions(merge: true),
        );
      } else {
        tx.set(
          ref,
          {
            'id': uid,
            ...data,
            'updatedAt': now,
          },
          fs.SetOptions(merge: true),
        );
      }
    });
  }

  /// Ensure a minimal profile exists for the given user.
  /// Writes core fields and merges them with any [extra] provided.
  Future<void> ensureUserProfile(
      fa.User user, {
        Map<String, dynamic> extra = const {},
      }) async {
    final base = {
      'id': user.uid,
      'email': user.email,
      'displayName': user.displayName,
      'photoURL': user.photoURL,
    };
    await upsertProfile(user.uid, {...base, ...extra});
  }

  fs.DocumentReference<Map<String, dynamic>> _profileDoc(String uid) =>
      _firestore.collection(FsPaths.profiles).doc(uid);

  /// Public getter for profile document reference (kept for backwards compatibility).
  fs.DocumentReference<Map<String, dynamic>> profileDocPublic(String uid) =>
      _profileDoc(uid);

  /// Fetch a profile document map for [uid]. Returns null if not found.
  Future<Map<String, dynamic>?> getProfile(String uid) async {
    final snap = await _profileDoc(uid).get();
    return snap.data();
  }
}
