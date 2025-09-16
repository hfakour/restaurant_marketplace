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

import 'package:cloud_firestore/cloud_firestore.dart' as fs;
import 'package:firebase_auth/firebase_auth.dart' as fa;

import 'auth_remote_ds_helpers.dart';

class AuthRemoteDataSource {
  final fa.FirebaseAuth _auth;
  final fs.FirebaseFirestore _firestore;

  AuthRemoteDataSource(this._auth, this._firestore);

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
  Future<void> sendEmailVerification(fa.User user) => user.sendEmailVerification();

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
    // SDK does not always auto-send so we do this explicitly.
    if (user.email != null && !user.emailVerified) {
      try {
        await user.sendEmailVerification();
      } catch (_) {
        // Intentionally swallow any sendEmailVerification exceptions here --
        // repository / UI can try again or show an appropriate message.
      }
    }

    // Reload to ensure latest profile/claims
    await user.reload();
  }

  /// Send password reset email to [email].
  Future<void> sendPasswordResetEmail(String email) =>
      _auth.sendPasswordResetEmail(email: email.trim());

  // ------------------- REAUTH -------------------

  /// Reauthenticate using email/password against the currently signed-in user.
  Future<void> reauthWithPassword(String email, String password) async {
    final user = await _auth.requireFreshUser();
    final cred =
    fa.EmailAuthProvider.credential(email: email.trim(), password: password);
    await user.reauthenticateWithCredential(cred);
  }

  /// Reauthenticate using any generic credential (OAuth providers, etc).
  Future<void> reauthWithCredential(fa.AuthCredential cred) async {
    final user = await _auth.requireFreshUser();
    await user.reauthenticateWithCredential(cred);
  }

  // ------------------- SENSITIVE OPS -------------------

  /// Update email using verifyBeforeUpdateEmail when available.
  ///
  /// This will send a verification email to the new address and, after the user
  /// confirms the change, the server will apply the update. We reload afterwards.
// make sure at top of file:
// import 'package:firebase_auth/firebase_auth.dart' as fa;
  /// Update the current user's email to [newEmail].
  /// - Uses a fresh/reloaded user via `_auth.requireFreshUser()` (helper).
  /// - Calls `updateEmail` (available in firebase_auth v6).
  /// - On `requires-recent-login` (or other FirebaseAuthException codes) rethrows
  ///   the FirebaseAuthException so repository/error-mapper can handle it.
  /// - After success, attempts to send a verification email and reloads user.
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
      // Try calling verifyBeforeUpdateEmail dynamically.
      // If it doesn't exist, this will throw a NoSuchMethodError which we catch below.
      await dynUser.verifyBeforeUpdateEmail(trimmed);
    } on NoSuchMethodError {
      // 2) Fallback: try updateEmail (older SDKs).
      try {
        await dynUser.updateEmail(trimmed);
      } on NoSuchMethodError {
        // Neither method exists on the runtime User object — likely wrong SDK.
        throw fa.FirebaseAuthException(
          code: 'unsupported-operation',
          message:
          'Neither verifyBeforeUpdateEmail nor updateEmail is available on the Firebase User. Check firebase_auth version.',
        );
      }
    } on fa.FirebaseAuthException {
      // Re-throw FirebaseAuthException so upstream repo/error-mapper can interpret codes
      // like 'requires-recent-login', 'invalid-email', etc.
      rethrow;
    } catch (e) {
      // Wrap unknown errors for consistent upstream mapping.
      throw fa.FirebaseAuthException(
        code: 'unknown',
        message: 'Failed to update email: ${e?.toString() ?? 'unknown error'}',
      );
    }

    // 3) After a successful call, attempt to send verification email (best practice).
    //    If verifyBeforeUpdateEmail was used, the SDK may already have sent the link;
    //    but calling sendEmailVerification is safe to attempt if needed.
    try {
      final refreshed = _auth.currentUser;
      if (refreshed != null && !refreshed.emailVerified) {
        await refreshed.sendEmailVerification();
      }
    } catch (_) {
      // Swallow sendEmailVerification errors — UI/repo can surface retry option.
    }

    // 4) Reload to ensure the user object is fresh for callers/listeners.
    try {
      await user.reload();
    } catch (_) {
      // ignore reload failures here; authState stream will reflect eventual state.
    }
  }


  /// Update password for the current user. Caller must handle reauth on failure.
  Future<void> updatePassword(String newPassword) async {
    final user = await _auth.requireFreshUser();
    await user.updatePassword(newPassword);
    // It's good practice to reload so token/claims are fresh.
    await user.reload();
  }

  /// Delete current user account. Caller must handle reauth if SDK throws.
  Future<void> deleteAccount() async {
    final user = await _auth.requireFreshUser();
    await user.delete();
  }

  // ------------------- FIRESTORE -------------------

  /// Upsert user profile with transaction safety.
  ///
  /// - Uses 'id' key in document to be consistent with domain models.
  /// - 'createdAt' only set when document is created.
  /// - 'updatedAt' is always set to server timestamp.
  Future<void> upsertProfile(String uid, Map<String, dynamic> data) async {
    await _firestore.runTransaction((tx) async {
      final ref = profileDoc(_firestore, uid);
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
