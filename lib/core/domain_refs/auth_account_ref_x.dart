import 'package:restaurant_marketplace/core/domain_refs/auth_refs.dart';
import '../../features/auth/domain/entities/auth_account.dart';

extension AuthAccountRefX on AuthAccount {
  AuthAccountRef get ref => AuthAccountRef(id);
}
