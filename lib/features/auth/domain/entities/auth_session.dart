import 'package:freezed_annotation/freezed_annotation.dart';
import 'auth_status.dart';
import 'auth_account.dart';
import 'auth_tokens.dart';

part 'auth_session.freezed.dart';

@freezed
class AuthSession with _$AuthSession {
  const factory AuthSession({
    required AuthAccount account,
    required AuthTokens tokens,
    @Default(AuthStatus.authenticated) AuthStatus status,
  }) = _AuthSession;
}
