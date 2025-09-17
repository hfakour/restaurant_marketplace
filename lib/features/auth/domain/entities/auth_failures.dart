// lib/features/auth/domain/entities/auth_failures.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_failures.freezed.dart';

@freezed
class AuthFailure with _$AuthFailure {
  // Credentials & validation
  const factory AuthFailure.invalidCredentials() = InvalidCredentials;
  const factory AuthFailure.wrongPassword() = WrongPassword;
  const factory AuthFailure.userNotFound() = UserNotFound;
  const factory AuthFailure.invalidEmail() = InvalidEmail;
  const factory AuthFailure.weakPassword() = WeakPassword;
  const factory AuthFailure.emailAlreadyInUse() = EmailAlreadyInUse;

  // User/account state
  const factory AuthFailure.userDisabled() = UserDisabled;
  const factory AuthFailure.emailNotVerified() = EmailNotVerified;
  const factory AuthFailure.reauthRequired() = ReauthRequired;

  // Session & tokens
  const factory AuthFailure.tokenExpired() = TokenExpired;
  const factory AuthFailure.sessionExpired() = SessionExpired;

  // Network / server
  const factory AuthFailure.networkIssue() = NetworkIssue;
  const factory AuthFailure.networkTimeout() = NetworkTimeout;
  const factory AuthFailure.serverIssue({int? statusCode}) = ServerIssue;
  const factory AuthFailure.tooManyRequests({int? retryAfterSeconds}) = TooManyRequests;

  // Provider / MFA / phone
  const factory AuthFailure.providerAlreadyLinked() = ProviderAlreadyLinked;
  const factory AuthFailure.invalidOtp() = InvalidOtp;
  const factory AuthFailure.invalidPhone() = InvalidPhone;

  // Fallback
  const factory AuthFailure.unknown([String? message]) = UnknownAuthFailure;
}
