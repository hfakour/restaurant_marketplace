import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_failures.freezed.dart';

@freezed
class AuthFailure with _$AuthFailure {
  const factory AuthFailure.invalidCredentials() = _InvalidCredentials;
  const factory AuthFailure.userDisabled() = _UserDisabled;
  const factory AuthFailure.emailNotVerified() = _EmailNotVerified;
  const factory AuthFailure.tokenExpired() = _TokenExpired;
  const factory AuthFailure.networkIssue() = _NetworkIssue;
  /// کد سرور اختیاری است (برای لاگ یا نمایش)
  const factory AuthFailure.serverIssue([String? code]) = _ServerIssue;
  const factory AuthFailure.reauthRequired() = _ReauthRequired;
  const factory AuthFailure.unknown([String? message]) = _Unknown;
  const factory AuthFailure.tooManyRequests({int? retryAfterSeconds}) = _TooManyRequests;
}
