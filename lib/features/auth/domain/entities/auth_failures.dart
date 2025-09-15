// lib/features/auth/domain/entities/auth_failures.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_failures.freezed.dart';

@freezed
class AuthFailure with _$AuthFailure {
  const factory AuthFailure.invalidCredentials() = InvalidCredentials;
  const factory AuthFailure.userDisabled() = UserDisabled;
  const factory AuthFailure.emailNotVerified() = EmailNotVerified;
  const factory AuthFailure.tokenExpired() = TokenExpired;
  const factory AuthFailure.networkIssue() = NetworkIssue;
  const factory AuthFailure.serverIssue({int? statusCode}) = ServerIssue;
  const factory AuthFailure.unknown([String? message]) = UnknownAuthFailure;

  // 👇 اضافه‌های جدید
  const factory AuthFailure.emailAlreadyInUse() = EmailAlreadyInUse;
  const factory AuthFailure.providerAlreadyLinked() = ProviderAlreadyLinked;
  const factory AuthFailure.invalidOtp() = InvalidOtp;
  const factory AuthFailure.reauthRequired() = ReauthRequired;
  const factory AuthFailure.sessionExpired() = SessionExpired;
  const factory AuthFailure.tooManyRequests({int? retryAfterSeconds}) = TooManyRequests;
}
