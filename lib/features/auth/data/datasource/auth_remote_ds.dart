import 'auth_remote_account_ops.dart';
import 'auth_remote_email_ops.dart';
import 'auth_remote_mfa_ops.dart';
import 'auth_remote_profile_ops.dart';
import 'auth_remote_reauth_ops.dart';
import 'core/auth_remote_core.dart';

class AuthRemoteDataSource extends AuthRemoteCore
    with
        AuthRemoteEmailOps,
        AuthRemoteAccountOps,
        AuthRemoteReauthOps,
        AuthRemoteMfaOps,
        AuthRemoteProfileOps {
  AuthRemoteDataSource(
      super.auth,
      super.firestore, {
        super.defaultAcs,
      });
}
