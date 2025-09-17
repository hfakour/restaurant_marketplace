// features/auth/domain/repositories/auth_repository.dart
//
// Domain-level contract for authentication operations.
// -----------------------------------------------------------------------------
// Design goals (domain purity):
// 1) Firebase/Supabase/… types MUST NOT leak into domain. Only domain entities
//    (e.g., AuthAccount, UserProfile) and primitives appear here.
// 2) No Firestore paths/SDK details in signatures. Implementations handle that.
// 3) Callers may treat this as a stable “business” API. Switching providers
//    should not change this interface.
//
// Error model (current project style):
// - Methods may throw domain failures (e.g., AuthFailure.*) from implementations.
// - The domain layer itself does NOT define concrete exceptions here—only the
//   semantics. Keep thrown errors mapped to your AuthFailure taxonomy.
// - Callers that don’t want try/catch should use application/use-case wrappers
//   that convert exceptions to Result/Either; the interface remains unchanged.
//
// Threading/async:
// - All methods are async-safe. Streams complete on dispose of the underlying
//   implementation. Do not rely on stream “done” for sign-out; use events.
//
// Security & privacy:
// - Never expose tokens/SDK credentials here. Reauth flows use primitives only.
// - Never persist PII in logs; implementations should scrub logs.
//
// Versioning notes:
// - If you later migrate to a Result/Either style, you can do it in a v2
//   interface with adapters without breaking callers abruptly.

import 'package:restaurant_marketplace/features/profile/domain/entities/user_profile.dart';
import '../entities/auth_account.dart';

/// Domain-level contract for authentication operations.
/// Implementations (Firebase, Supabase, etc.) must provide all methods
/// and respect the documented contracts.
///
/// Notes for consumers:
/// - This interface never leaks SDK or DTO types.
/// - Methods may throw domain errors (AuthFailure.*).
/// - For exception-free flows, wrap these in UseCases/Facades that convert
///   to Result/Either.
abstract class AuthRepository {
  // ────────────────────────────────────────────────────────────────────────────
  // Session & State
  // ────────────────────────────────────────────────────────────────────────────

  /// Stream of authentication state.
  ///
  /// - Emits `null` when signed out.
  /// - Emits `AuthAccount` when signed in or after state changes.
  /// - Completes when the data layer/DI is disposed.
  ///
  /// Implementation should de-duplicate values to avoid redundant emissions.
  Stream<AuthAccount?> authState();

  /// Last cached user in memory (no I/O).
  ///
  /// May be `null` if:
  /// - Signed out, or
  /// - Initial state has not yet been loaded.
  ///
  /// For a guaranteed fresh value, call [currentAccount].
  AuthAccount? get currentUser;

  /// Returns a freshly loaded account from the underlying source (reload).
  ///
  /// Use this after operations that may have changed account data
  /// (e.g., update email, send verification, link provider).
  ///
  /// Throws:
  /// - `AuthFailure.sessionExpired` if no user is signed in.
  Future<AuthAccount> currentAccount();

  // ────────────────────────────────────────────────────────────────────────────
  // Primary Sign-up / Sign-in
  // ────────────────────────────────────────────────────────────────────────────

  /// Register a new account with email and password.
  ///
  /// Parameters:
  /// - [firstName], [lastName], [phoneNumber]: used for initial profile setup
  ///   or business rules.
  /// - [email] is optional.
  ///
  /// Returns:
  /// - Authenticated account after successful registration.
  ///
  /// Common failures:
  /// - Email already in use, weak password, invalid email,
  ///   rate-limited, network issues.
  Future<AuthAccount> registerWithEmail({
    required String firstName,
    required String lastName,
    required String phoneNumber,
    String? email,
    required String password,
  });

  /// Sign in with email and password.
  ///
  /// Common failures:
  /// - User not found, wrong password, user disabled,
  ///   too many requests.
  Future<AuthAccount> loginWithEmail({
    required String email,
    required String password,
  });

  /// Sign in anonymously with minimal user information.
  ///
  /// Useful for temporary accounts. Profile setup rules depend
  /// on the business requirements.
  Future<AuthAccount> loginAnonymous({
    required String firstName,
    required String lastName,
    required String phoneNumber,
  });

  /// Link email/password credentials to the current user
  /// (often anonymous → permanent).
  ///
  /// On success, the current account is upgraded.
  /// On conflict, throw `AuthFailure.credentialInUse` or equivalent.
  Future<void> linkEmailPassword({
    required String email,
    required String password,
  });

  /// Sign out from the current session.
  ///
  /// Implementations should atomically clear/reset sensitive state.
  Future<void> signOut();

  // ────────────────────────────────────────────────────────────────────────────
  // Profile Bootstrap (Auth → Profile “happy path”)
  // ────────────────────────────────────────────────────────────────────────────

  /// Create or fetch a user profile to unify auth → profile flow.
  ///
  /// Architectural note:
  /// - Better located in `ProfileRepository` or a dedicated UseCase,
  ///   but included here for simplicity of workflows.
  ///
  /// Contract:
  /// - If a profile exists, return it.
  /// - If not, create with provided base data and return it.
  Future<UserProfile> ensureUserProfile({
    required String uid,
    required String firstName,
    required String lastName,
    required String phoneNumber,
    String? email,
  });

  // ────────────────────────────────────────────────────────────────────────────
  // Password & Email Verification
  // ────────────────────────────────────────────────────────────────────────────

  /// Send a password reset email.
  ///
  /// UX note:
  /// - Always return a success message, even if the email is unregistered,
  ///   to prevent email enumeration.
  Future<void> resetPassword({required String email});

  /// Send a verification email to the current user.
  ///
  /// Throws:
  /// - `AuthFailure.unsupported` if the provider does not support this.
  Future<void> sendEmailVerification();

  /// Reload the current account and return email verification status.
  ///
  /// Returns:
  /// - `true` if email is now verified, otherwise `false`.
  ///
  /// Throws:
  /// - `AuthFailure.sessionExpired` if no valid session.
  Future<bool> reloadAndEmailVerified();

  // ────────────────────────────────────────────────────────────────────────────
  // Reauthentication (Sensitive Ops)
  // ────────────────────────────────────────────────────────────────────────────

  /// Reauthenticate with password for sensitive operations
  /// (update email/password, delete account).
  ///
  /// Throws:
  /// - `AuthFailure.reauthRequired` or `AuthFailure.invalidCredential`
  ///   if reauthentication fails.
  Future<void> reauthenticateWithPassword(String email, String password);

  /// Reauthenticate with an OAuth provider (Google, Apple, Facebook, etc.).
  ///
  /// Parameters:
  /// - [providerId] such as 'google.com', 'apple.com', 'facebook.com'.
  /// - Depending on the provider, pass [idToken] or [accessToken].
  /// - [rawNonce]/[authCode] as needed.
  ///
  /// Security:
  /// - Implementations must never log tokens.
  Future<void> reauthenticateWithProvider({
    required String providerId,
    String? idToken,
    String? accessToken,
    String? rawNonce,
    String? authCode,
  });

  // ────────────────────────────────────────────────────────────────────────────
  // MFA (Phone as Second Factor) — Enrollment
  // ────────────────────────────────────────────────────────────────────────────

  /// Start MFA enrollment by sending an SMS to [phoneNumber].
  ///
  /// Returns:
  /// - `verificationId` for finalization.
  ///
  /// Failures:
  /// - Rate limit, invalid phone number, network issues.
  Future<String> mfaStartPhoneEnrollment(String phoneNumber);

  /// Finalize MFA enrollment with [verificationId] and [smsCode].
  ///
  /// On success, a new second factor is added.
  /// [displayName] is optional for UI labeling.
  Future<void> mfaFinalizeEnrollment({
    required String verificationId,
    required String smsCode,
    String? displayName,
  });

  /// Unenroll/remove an MFA factor by its UID.
  ///
  /// Throws:
  /// - If factor does not exist or removal is not permitted.
  Future<void> mfaUnenrollByUid(String factorUid);

  // ────────────────────────────────────────────────────────────────────────────
  // MFA — Sign-In Challenge
  // ────────────────────────────────────────────────────────────────────────────

  /// Start responding to an MFA challenge during sign-in.
  ///
  /// Scenario:
  /// - When sign-in is paused due to MFA, the implementation provides
  ///   an opaque `resolver`.
  /// - With [factorUid], send an SMS and return `verificationId`.
  ///
  /// Architectural note:
  /// - `resolver` remains typed as [Object] to avoid SDK leakage.
  ///   Implementations must manage lifecycle (expiry, cleanup).
  Future<String> mfaStartSignInResolve(
      Object resolver, {
        required String factorUid,
      });

  /// Finalize MFA sign-in with [resolver], [verificationId], and [smsCode].
  ///
  /// On success, establishes a valid session and returns the account.
  /// On failure, throw the appropriate domain error.
  Future<AuthAccount> mfaFinalizeSignIn({
    required Object resolver,
    required String verificationId,
    required String smsCode,
  });

  // ────────────────────────────────────────────────────────────────────────────
  // Sensitive Account Ops
  // ────────────────────────────────────────────────────────────────────────────

  /// Update the current account’s email to [newEmail].
  ///
  /// May require reauthentication. Throw `AuthFailure.reauthRequired`
  /// if not reauthenticated.
  Future<void> updateEmail(String newEmail);

  /// Update the current account’s password to [newPassword].
  ///
  /// May require reauthentication depending on provider policies.
  Future<void> updatePassword(String newPassword);

  /// Permanently delete the current account.
  ///
  /// Must atomically clear sensitive data in backing stores.
  Future<void> deleteAccount();
}
