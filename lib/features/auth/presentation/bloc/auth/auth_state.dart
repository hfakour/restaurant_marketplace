// auth/presentation/bloc/auth/auth_state.dart
part of 'auth_bloc.dart';

enum AuthViewStatus {
  loading,
  unauthenticated,
  authenticated,
  error,

  // --- email verification flow ---
  sendingEmailVerification,
  emailVerificationSent,
  checkingEmailVerification,

  // --- MFA flow ---
  mfaRequired,        // user must pick a factor (or single factor auto-selected)
  mfaCodeSent,        // SMS sent; waiting for user to enter code

  // --- rate limit / too many requests ---
  rateLimited,
}

/// عملیات حساس که ممکن است نیازمند Reauth باشد
enum PendingSensitiveOp { updateEmail, updatePassword, deleteAccount, linkEmailPassword }

class AuthState extends Equatable {
  const AuthState._({
    this.account,
    required this.status,
    this.error,

    // Reauth + Retry
    this.pendingOp,
    this.pendingNewEmail,
    this.pendingNewPassword,
    this.pendingLinkEmail,
    this.pendingLinkPassword,

    // Rate limit
    this.retryAfterSeconds,

    // --- MFA ---
    this.mfaResolver,
    this.mfaFactorUids,
    this.mfaVerificationId,
  });

  // پایه
  const AuthState.loading() : this._(status: AuthViewStatus.loading);
  const AuthState.unauthenticated() : this._(status: AuthViewStatus.unauthenticated);
  const AuthState.authenticated(AuthAccount a)
      : this._(account: a, status: AuthViewStatus.authenticated);
  const AuthState.error(String m) : this._(status: AuthViewStatus.error, error: m);

  // --- email verification flow ---
  const AuthState.sendingEmailVerification({AuthAccount? account})
      : this._(account: account, status: AuthViewStatus.sendingEmailVerification);
  const AuthState.emailVerificationSent({AuthAccount? account})
      : this._(account: account, status: AuthViewStatus.emailVerificationSent);
  const AuthState.checkingEmailVerification({AuthAccount? account})
      : this._(account: account, status: AuthViewStatus.checkingEmailVerification);

  // --- MFA flow ---
  /// نشان‌دهنده نیاز به MFA؛ UI می‌تواند factor انتخاب کند (اگر چندتا بود).
  const AuthState.mfaRequired({
    required Object resolver,
    required List<String> factorUids,
  }) : this._(
    status: AuthViewStatus.mfaRequired,
    mfaResolver: resolver,
    mfaFactorUids: factorUids,
  );

  /// SMS ارسال شده و UI فقط کد را از کاربر می‌گیرد.
  const AuthState.mfaCodeSent({
    required Object resolver,
    required String verificationId,
  }) : this._(
    status: AuthViewStatus.mfaCodeSent,
    mfaResolver: resolver,
    mfaVerificationId: verificationId,
  );

  // --- rate limit ---
  const AuthState.rateLimited({AuthAccount? account, int? retryAfterSeconds})
      : this._(
    account: account,
    status: AuthViewStatus.rateLimited,
    retryAfterSeconds: retryAfterSeconds,
  );

  // داده‌ها
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

  // --- MFA ---
  /// شیء opaque که از Firebase می‌آید اما به لایه‌های بالاتر لو نمی‌دهیم.
  final Object? mfaResolver;
  /// لیست UIDهای عامل‌های ثبت‌شده (وقتی mfaRequired هست).
  final List<String>? mfaFactorUids;
  /// verificationId آخرین SMS ارسال‌شده (وقتی mfaCodeSent هست).
  final String? mfaVerificationId;

  AuthState copyWith({
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

    // --- MFA ---
    Object? mfaResolver,
    bool clearMfaResolver = false,
    List<String>? mfaFactorUids,
    bool clearMfaFactorUids = false,
    String? mfaVerificationId,
    bool clearMfaVerificationId = false,
  }) {
    return AuthState._(
      account: clearAccount ? null : (account ?? this.account),
      status: status ?? this.status,
      error: clearError ? null : (error ?? this.error),

      pendingOp: clearPendingOp ? null : (pendingOp ?? this.pendingOp),
      pendingNewEmail:
      clearPendingNewEmail ? null : (pendingNewEmail ?? this.pendingNewEmail),
      pendingNewPassword:
      clearPendingNewPassword ? null : (pendingNewPassword ?? this.pendingNewPassword),
      pendingLinkEmail:
      clearPendingLinkEmail ? null : (pendingLinkEmail ?? this.pendingLinkEmail),
      pendingLinkPassword:
      clearPendingLinkPassword ? null : (pendingLinkPassword ?? this.pendingLinkPassword),

      retryAfterSeconds:
      clearRetryAfter ? null : (retryAfterSeconds ?? this.retryAfterSeconds),

      // --- MFA ---
      mfaResolver: clearMfaResolver ? null : (mfaResolver ?? this.mfaResolver),
      mfaFactorUids:
      clearMfaFactorUids ? null : (mfaFactorUids ?? this.mfaFactorUids),
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

    // --- MFA ---
    mfaResolver,
    mfaFactorUids,
    mfaVerificationId,
  ];
}
