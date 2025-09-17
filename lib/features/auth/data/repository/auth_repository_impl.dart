import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/entities/auth_account.dart';
import '../../domain/entities/auth_failures.dart';
import '../../domain/repositories/auth_repository.dart';
import 'core/_auth_repo_core.dart';
import 'mixins/mfa_enrollment_ops.dart';
import 'mixins/mfa_signin_ops.dart';
import 'mixins/primary_auth_ops.dart';
import 'mixins/profile_ops.dart';
import 'mixins/reauth_ops.dart';
import 'mixins/session_ops.dart';

/// Concrete repository implementation composed from focused mixins.
/// This keeps each concern testable and the file sizes small.
class AuthRepositoryImpl extends AuthRepoCore
    with
        SessionOps,
        PrimaryAuthOps,
        ReauthOps,
        MfaEnrollmentOps,
        MfaSigninOps,
        ProfileOps
    implements AuthRepository {
  AuthRepositoryImpl(
      super.remote, {
        super.userMapper,
        super.errorMapper,
      });
}


/// Exact function signatures expected by [AuthRepoCore].
typedef AuthAccountMapper = AuthAccount Function(User);
typedef AuthErrorMapper   = AuthFailure Function(FirebaseAuthException);
