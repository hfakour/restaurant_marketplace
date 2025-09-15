import './auth_refs.dart';
import '../auth_account.dart';

extension AuthAccountRefX on AuthAccount {
  AuthAccountRef get ref => AuthAccountRef(id);
}
