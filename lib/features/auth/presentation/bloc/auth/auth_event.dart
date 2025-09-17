// auth/presentation/bloc/auth/auth_event.dart
part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object?> get props => [];
}

// --- داخلی: راه‌اندازی و گوش‌دادن به استریم اکانت ---
class _AuthStreamRequested extends AuthEvent {
  const _AuthStreamRequested();
}

class _AuthAccountChanged extends AuthEvent {
  const _AuthAccountChanged(this.account);
  final AuthAccount? account;

  @override
  List<Object?> get props => [account];
}

// --- خروج ---
class AuthSignOutRequested extends AuthEvent {
  const AuthSignOutRequested();
}

// --- ایمیل وریفیکیشن ---
class SendEmailVerification extends AuthEvent {
  const SendEmailVerification();
}

class ReloadAndCheck extends AuthEvent {
  const ReloadAndCheck();
}

// --- عملیات حساس (Sensitive Ops) ---
class UpdateEmailRequested extends AuthEvent {
  const UpdateEmailRequested(this.newEmail);
  final String newEmail;

  @override
  List<Object?> get props => [newEmail];
}

class UpdatePasswordRequested extends AuthEvent {
  const UpdatePasswordRequested(this.newPassword);
  final String newPassword;

  @override
  List<Object?> get props => [newPassword];
}

class DeleteAccountRequested extends AuthEvent {
  const DeleteAccountRequested();
}

class LinkEmailPasswordRequested extends AuthEvent {
  const LinkEmailPasswordRequested(this.email, this.password);
  final String email;
  final String password;

  @override
  List<Object?> get props => [email, password];
}

// --- Reauth + Retry ---
class ReauthenticateWithPasswordRequested extends AuthEvent {
  const ReauthenticateWithPasswordRequested(this.email, this.password);
  final String email;
  final String password;

  @override
  List<Object?> get props => [email, password];
}

/// ری‌اُث با Provider/OAuth (google.com / apple.com / facebook.com / ...)
class ReauthenticateWithProviderRequested extends AuthEvent {
  const ReauthenticateWithProviderRequested({
    required this.providerId, // e.g. 'google.com', 'apple.com', 'facebook.com'
    this.idToken,
    this.accessToken,
    this.rawNonce,
    this.authCode,
  });

  final String providerId;
  final String? idToken;
  final String? accessToken;
  final String? rawNonce;
  final String? authCode;

  @override
  List<Object?> get props => [providerId, idToken, accessToken, rawNonce, authCode];
}

// --- مدیریت خطا/صف ---
class ClearAuthError extends AuthEvent {
  const ClearAuthError();
}

class ClearPendingSensitiveOp extends AuthEvent {
  const ClearPendingSensitiveOp();
}
// AuthEvent
class LoginWithEmailRequested extends AuthEvent {
  final String email;
  final String password;
  const LoginWithEmailRequested(this.email, this.password);
}

// MFA branch
class MfaFactorChosen extends AuthEvent {
  final Object resolver;        // opaque resolver from Login result
  final String factorUid;       // user-picked factor UID
  const MfaFactorChosen(this.resolver, this.factorUid);
}

class MfaCodeSubmitted extends AuthEvent {
  final Object resolver;
  final String verificationId;
  final String smsCode;
  const MfaCodeSubmitted({
    required this.resolver,
    required this.verificationId,
    required this.smsCode,
  });
}

class MfaCancelRequested extends AuthEvent {
  const MfaCancelRequested();
}
