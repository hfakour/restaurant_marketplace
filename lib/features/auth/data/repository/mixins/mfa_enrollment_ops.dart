import '../auth_repository_helpers.dart';
import '../core/_auth_repo_core.dart';

mixin MfaEnrollmentOps on AuthRepoCore  {
  Future<String> mfaStartPhoneEnrollment(String phoneNumber) =>
      sensitive(() => remote.mfaStartPhoneEnrollment(phoneNumber), mapError);

  Future<void> mfaFinalizeEnrollment({
    required String verificationId,
    required String smsCode,
    String? displayName,
  }) =>
      sensitive(
            () => remote.mfaFinalizeEnrollment(
          verificationId: verificationId,
          smsCode: smsCode,
          displayName: displayName,
        ),
        mapError,
      );

  Future<void> mfaUnenrollByUid(String factorUid) =>
      sensitive(() => remote.mfaUnenrollByUid(factorUid), mapError);
}
