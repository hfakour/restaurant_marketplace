import '../../../domain/entities/auth_account.dart';
import '../auth_repository_helpers.dart';
import '../core/_auth_repo_core.dart';

mixin MfaSigninOps on AuthRepoCore  {
  Future<String> mfaStartSignInResolve(
      Object resolver, {
        required String factorUid,
      }) =>
      sensitive(
            () => remote.mfaStartSignInResolve(resolver, factorUid: factorUid),
        mapError,
      );

  Future<AuthAccount> mfaFinalizeSignIn({
    required Object resolver,
    required String verificationId,
    required String smsCode,
  }) =>
      sensitive(() async {
        final cred = await remote.mfaFinalizeSignIn(
          resolver: resolver,
          verificationId: verificationId,
          smsCode: smsCode,
        );
        final user = cred.user!;
        await user.reload();
        return mapUser(user);
      }, mapError);
}
