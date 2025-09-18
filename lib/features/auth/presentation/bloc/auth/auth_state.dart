// auth/presentation/bloc/auth/auth_state.dart
part of 'auth_bloc.dart';

/// High-level view states for the Auth screen/flows.
/// Keep this UI-oriented and derive from domain where needed.
enum AuthViewStatus {
  loading,
  unauthenticated,
  authenticated,
  error,

  // --- Email verification flow ---
  sendingEmailVerification,
  emailVerificationSent,
  checkingEmailVerification,

  // --- MFA flow ---
  mfaRequired, // user must pick a factor (or single factor auto-selected)
  mfaCodeSent, // SMS sent; waiting for user to enter the code

  // --- Rate limit / too many requests ---
  rateLimited,
}

/// Sensitive operations that may require reauthentication before continuing.
/// Keep in sync with the bloc handlers that schedule a pending op.
enum PendingSensitiveOp {
  updateEmail,
  updatePassword,
  deleteAccount,
  linkEmailPassword,
}

class AuthState extends Equatable {
  const AuthState._({
    // Core
    required this.status,
    this.account,
    this.error,

    // Reauth + pending retry
    this.pendingOp,
    this.pendingNewEmail,
    this.pendingNewPassword,
    this.pendingLinkEmail,
    this.pendingLinkPassword,

    // Rate limit
    this.retryAfterSeconds,

    // MFA
    this.mfaResolver,
    this.mfaFactorUids = const <String>[],
    this.mfaVerificationId,
  });

  // ---- Base constructors ----
  const AuthState.loading() : this._(status: AuthViewStatus.loading);

  const AuthState.unauthenticated()
      : this._(status: AuthViewStatus.unauthenticated);

  const AuthState.authenticated(AuthAccount a)
      : this._(status: AuthViewStatus.authenticated, account: a);

  const AuthState.error(String message)
      : this._(status: AuthViewStatus.error, error: message);

  // ---- Email verification flow ----
  const AuthState.sendingEmailVerification({AuthAccount? account})
      : this._(
    status: AuthViewStatus.sendingEmailVerification,
    account: account,
  );

  const AuthState.emailVerificationSent({AuthAccount? account})
      : this._(
    status: AuthViewStatus.emailVerificationSent,
    account: account,
  );

  const AuthState.checkingEmailVerification({AuthAccount? account})
      : this._(
    status: AuthViewStatus.checkingEmailVerification,
    account: account,
  );

  // ---- MFA flow ----
  /// Indicates MFA is required; UI may show a factor picker (if multiple).
  const AuthState.mfaRequired({
    required Object resolver,
    required List<String> factorUids,
  }) : this._(
    status: AuthViewStatus.mfaRequired,
    mfaResolver: resolver,
    mfaFactorUids: factorUids,
  );

  /// SMS sent; UI should collect the code from the user.
  const AuthState.mfaCodeSent({
    required Object resolver,
    required String verificationId,
  }) : this._(
    status: AuthViewStatus.mfaCodeSent,
    mfaResolver: resolver,
    mfaVerificationId: verificationId,
  );

  // ---- Rate limit ----
  const AuthState.rateLimited({
    AuthAccount? account,
    int? retryAfterSeconds,
  }) : this._(
    status: AuthViewStatus.rateLimited,
    account: account,
    retryAfterSeconds: retryAfterSeconds,
  );

  // ---- Data ----
  final AuthAccount? account;
  final AuthViewStatus status;
  final String? error;

  // Reauth + Retry
  final PendingSensitiveOp? pendingOp;
  final String? pendingNewEmail;
  final String? pendingNewPassword;
  final String? pendingLinkEmail;
  final String? pendingLinkPassword;

  // Rate limit
  final int? retryAfterSeconds;

  // MFA (opaque provider data is kept out of higher layers)
  final Object? mfaResolver;
  final List<String> mfaFactorUids; // non-null for simpler UI handling
  final String? mfaVerificationId;

  /// Convenience flags for UI
  bool get isAuthenticated => status == AuthViewStatus.authenticated;
  bool get isUnauthenticated => status == AuthViewStatus.unauthenticated;

  AuthState copyWith({
    // Core
    AuthAccount? account,
    bool clearAccount = false,
    AuthViewStatus? status,
    String? error,
    bool clearError = false,

    // Reauth + Retry
    PendingSensitiveOp? pendingOp,
    bool clearPendingOp = false,
    String? pendingNewEmail,
    bool clearPendingNewEmail = false,
    String? pendingNewPassword,
    bool clearPendingNewPassword = false,
    String? pendingLinkEmail,
    bool clearPendingLinkEmail = false,
    String? pendingLinkPassword,
    bool clearPendingLinkPassword = false,

    // Rate limit
    int? retryAfterSeconds,
    bool clearRetryAfter = false,

    // MFA
    Object? mfaResolver,
    bool clearMfaResolver = false,
    List<String>? mfaFactorUids,
    bool clearMfaFactorUids = false,
    String? mfaVerificationId,
    bool clearMfaVerificationId = false,
  }) {
    return AuthState._(
      status: status ?? this.status,
      account: clearAccount ? null : (account ?? this.account),
      error: clearError ? null : (error ?? this.error),

      // Pending op
      pendingOp: clearPendingOp ? null : (pendingOp ?? this.pendingOp),
      pendingNewEmail:
      clearPendingNewEmail ? null : (pendingNewEmail ?? this.pendingNewEmail),
      pendingNewPassword: clearPendingNewPassword
          ? null
          : (pendingNewPassword ?? this.pendingNewPassword),
      pendingLinkEmail:
      clearPendingLinkEmail ? null : (pendingLinkEmail ?? this.pendingLinkEmail),
      pendingLinkPassword: clearPendingLinkPassword
          ? null
          : (pendingLinkPassword ?? this.pendingLinkPassword),

      // Rate limit
      retryAfterSeconds:
      clearRetryAfter ? null : (retryAfterSeconds ?? this.retryAfterSeconds),

      // MFA
      mfaResolver: clearMfaResolver ? null : (mfaResolver ?? this.mfaResolver),
      mfaFactorUids: clearMfaFactorUids
          ? const <String>[]
          : (mfaFactorUids ?? this.mfaFactorUids),
      mfaVerificationId: clearMfaVerificationId
          ? null
          : (mfaVerificationId ?? this.mfaVerificationId),
    );
  }

  @override
  List<Object?> get props => [
    account,
    status,
    error,
    pendingOp,
    pendingNewEmail,
    pendingNewPassword,
    pendingLinkEmail,
    pendingLinkPassword,
    retryAfterSeconds,
    mfaResolver,
    // Use list equality by value (Equatable handles List by reference; this is OK if you create new lists on changes)
    mfaFactorUids,
    mfaVerificationId,
  ];
}
