import '../entities/auth_session.dart';
import '../entities/auth_status.dart';
import 'auth_tokens_ext.dart';

extension AuthSessionX on AuthSession {
  bool get isAuthenticated => status == AuthStatus.authenticated;
  bool get needsRefresh => status == AuthStatus.refreshing || tokens.isAccessExpired;
}
