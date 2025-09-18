// auth/presentation/bloc/auth/auth_event.dart
part of 'auth_bloc.dart';

/// Base class for all Auth events.
abstract class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object?> get props => [];
}

// ---------------- Internal wiring ----------------

/// Subscribe to the auth state stream.
class _AuthStreamRequested extends AuthEvent {
  const _AuthStreamRequested();
}

/// Emitted when the auth stream emits a new account.
class _AuthAccountChanged extends AuthEvent {
  const _AuthAccountChanged(this.account);
  final AuthAccount? account;

  @override
  List<Object?> get props => [account];
}

// ---------------- Primary Auth Ops ----------------

class SignOutRequested extends AuthEvent {
  const SignOutRequested();
}

// ---------------- Email Verification ----------------

class SendEmailVerificationRequested extends AuthEvent {
  const SendEmailVerificationRequested();
}

class CheckEmailVerificationRequested extends AuthEvent {
  const CheckEmailVerificationRequested();
}

// ---------------- Reauthentication ----------------

class ReauthenticateWithPasswordRequested extends AuthEvent {
  const ReauthenticateWithPasswordRequested({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  @override
  List<Object?> get props => [email, password];
}

// ---------------- Sensitive Operations ----------------

/// Schedule update email, possibly requiring reauth.
class UpdateEmailRequested extends AuthEvent {
  const UpdateEmailRequested(this.newEmail);
  final String newEmail;

  @override
  List<Object?> get props => [newEmail];
}

/// Schedule update password, possibly requiring reauth.
class UpdatePasswordRequested extends AuthEvent {
  const UpdatePasswordRequested(this.newPassword);
  final String newPassword;

  @override
  List<Object?> get props => [newPassword];
}

/// Schedule delete account, possibly requiring reauth.
class DeleteAccountRequested extends AuthEvent {
  const DeleteAccountRequested();
}

/// Schedule link email/password, possibly requiring reauth.
class LinkEmailPasswordRequested extends AuthEvent {
  const LinkEmailPasswordRequested(this.email, this.password);
  final String email;
  final String password;

  @override
  List<Object?> get props => [email, password];
}

// ---------------- MFA ----------------

/// User must resolve MFA: send SMS to chosen factor.
class MfaStartResolveRequested extends AuthEvent {
  const MfaStartResolveRequested({
    required this.resolver,
    required this.factorUid,
  });

  final Object resolver;
  final String factorUid;

  @override
  List<Object?> get props => [resolver, factorUid];
}

/// User submits SMS code for MFA.
class MfaCodeSubmitted extends AuthEvent {
  const MfaCodeSubmitted({
    required this.resolver,
    required this.verificationId,
    required this.smsCode,
  });

  final Object resolver;
  final String verificationId;
  final String smsCode;

  @override
  List<Object?> get props => [resolver, verificationId, smsCode];
}

/// Cancel MFA flow (back to idle/previous state).
class MfaCancelRequested extends AuthEvent {
  const MfaCancelRequested();
}

/// Raised by LoginBloc/use case when MFA is required.
/// AuthBloc will transition to `AuthState.mfaRequired`.
class MfaRequiredDiscovered extends AuthEvent {
  const MfaRequiredDiscovered({
    required this.resolver,
    required this.factorUids,
  });

  final Object resolver;
  final List<String> factorUids;

  @override
  List<Object?> get props => [resolver, factorUids];
}
