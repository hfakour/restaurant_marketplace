import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart' as fa;
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import 'auth_remote_ds_helpers.dart';
import 'core/auth_remote_core.dart';

mixin AuthRemoteMfaOps on AuthRemoteCore {
  Future<String> mfaStartPhoneEnrollment(String phoneNumber) async {
    final user = await auth.requireFreshUser();
    final session = await user.multiFactor.getSession();
    final completer = Completer<String>();

    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      multiFactorSession: session,
      verificationCompleted: (_) {},
      verificationFailed: (fa.FirebaseAuthException e) => completer.completeError(e),
      codeSent: (String verificationId, int? _) => completer.complete(verificationId),
      codeAutoRetrievalTimeout: (_) {
        if (!completer.isCompleted) {
          completer.completeError(fa.FirebaseAuthException(
            code: 'timeout', message: 'SMS code auto-retrieval timeout',
          ));
        }
      },
    );

    return completer.future;
  }

  Future<void> mfaFinalizeEnrollment({
    required String verificationId,
    required String smsCode,
    String? displayName,
  }) async {
    final user = await auth.requireFreshUser();
    final cred = fa.PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);
    await user.multiFactor.enroll(fa.PhoneMultiFactorGenerator.getAssertion(cred), displayName: displayName);
  }

  Future<void> mfaUnenrollByUid(String factorUid) async {
    final user = await auth.requireFreshUser();
    await user.multiFactor.unenroll(factorUid: factorUid);
  }

  Future<String> mfaStartSignInResolve(Object resolver, {required String factorUid}) async {
    try {
      final r = resolver as fa.MultiFactorResolver;
      final phoneInfo = r.hints.whereType<fa.PhoneMultiFactorInfo>().firstWhere(
            (h) => h.uid == factorUid,
        orElse: () => throw fa.FirebaseAuthException(
          code: 'invalid-argument', message: 'MFA factor UID not found on resolver',
        ),
      );

      final completer = Completer<String>();
      await auth.verifyPhoneNumber(
        multiFactorSession: r.session,
        phoneNumber: phoneInfo.phoneNumber!,
        verificationCompleted: (_) {},
        verificationFailed: (fa.FirebaseAuthException e) => completer.completeError(e),
        codeSent: (String verificationId, int? _) => completer.complete(verificationId),
        codeAutoRetrievalTimeout: (_) {
          if (!completer.isCompleted) {
            completer.completeError(fa.FirebaseAuthException(
              code: 'timeout', message: 'SMS code auto-retrieval timeout',
            ));
          }
        },
      );
      return completer.future;
    } catch (e, st) {
      FirebaseCrashlytics.instance.recordError(e, st, reason: 'mfaStartSignInResolve error');
      rethrow;
    }
  }

  Future<fa.UserCredential> mfaFinalizeSignIn({
    required Object resolver,
    required String verificationId,
    required String smsCode,
  }) async {
    try {
      final r = resolver as fa.MultiFactorResolver;
      final cred = fa.PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);
      final assertion = fa.PhoneMultiFactorGenerator.getAssertion(cred);
      return r.resolveSignIn(assertion);
    } catch (e, st) {
      FirebaseCrashlytics.instance.recordError(e, st, reason: 'mfaFinalizeSignIn error');
      rethrow;
    }
  }
}
