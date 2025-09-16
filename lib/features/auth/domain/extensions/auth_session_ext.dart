import '../entities/auth_session.dart';
import '../entities/auth_status.dart';

extension AuthSessionX on AuthSession {
  bool get isAuthenticated => status == AuthStatus.authenticated;
}
