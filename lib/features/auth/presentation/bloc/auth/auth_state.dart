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
  ];
}
