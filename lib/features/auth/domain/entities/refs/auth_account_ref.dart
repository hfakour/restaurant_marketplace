import '../auth_account.dart';
import './auth_refs.dart';

extension AuthAccountRefX on AuthAccount {
  AuthAccountRef get ref => AuthAccountRef(id);
}
