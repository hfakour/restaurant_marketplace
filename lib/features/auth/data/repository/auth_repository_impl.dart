import 'package:firebase_auth/firebase_auth.dart';
import '../../../profile/domain/entities/user_profile.dart';
import '../../domain/entities/auth_failures.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/entities/auth_account.dart';
import '../datasource/auth_remote_ds.dart';
import '../mapper/auth_mappers.dart';            // authAccountFromFirebaseUser
import '../mapper/auth_error_mapper.dart';       // mapFirebaseAuthException
import 'auth_repository_helpers.dart';           // fullName, sensitive, isPasswordStrong

// ---- Concrete repo implementation ----
class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(
      this._remote, {
        AuthAccount Function(User)? userMapper,
        AuthFailure Function(FirebaseAuthException)? errorMapper,
      })  : _userMapper = userMapper ?? authAccountFromFirebaseUser,
        _errorMapper = errorMapper ?? mapFirebaseAuthException;

  final AuthRemoteDataSource _remote;

  // مپرهای تزریقی/پیش‌فرض
  final AuthAccount Function(User) _userMapper;
  final AuthFailure Function(FirebaseAuthException) _errorMapper;

  // ======================= جدیدها (هم‌راستا با AuthRepository) =======================

  /// آخرین کاربر موجود (ممکن است null باشد). از ریموت می‌خوانیم و مپ می‌کنیم.
  @override
  AuthAccount? get currentUser {
    final u = _remote.currentUser;
    return u == null ? null : _userMapper(u);
  }

  /// نسخه‌ی تازه‌ی کاربر فعلی (با ریلود).
  /// UX: به‌جای Unknown، Failure مشخص‌تر برای تصمیم‌گیری UI برمی‌گردانیم.
  @override
  Future<AuthAccount> currentAccount() async {
    final u = _remote.currentUser;
    if (u == null) {
      throw const AuthFailure.sessionExpired();
    }
    try {
      await u.reload(); // همگام‌سازی با سرور
      final fresh = _remote.currentUser;
      if (fresh == null) {
        throw const AuthFailure.sessionExpired();
      }
      return _userMapper(fresh);
    } on FirebaseAuthException catch (e) {
      throw _errorMapper(e);
    }
  }

  /// ریلود کاربر فعلی و برگرداندن وضعیت وریفای ایمیل
  @override
  Future<bool> reloadAndEmailVerified() async {
    final u = _remote.currentUser;
    if (u == null) return false;
    try {
      await u.reload();
      final refreshed = _remote.currentUser;
      return refreshed?.emailVerified ?? false;
    } on FirebaseAuthException catch (e) {
      throw _errorMapper(e);
    }
  }

  // ---------------------- MFA (Phone as second factor) ----------------------

  @override
  Future<String> mfaStartPhoneEnrollment(String phoneNumber) =>
      sensitive(() => _remote.mfaStartPhoneEnrollment(phoneNumber), _errorMapper);

  @override
  Future<void> mfaFinalizeEnrollment({
    required String verificationId,
    required String smsCode,
    String? displayName,
  }) =>
      sensitive(
            () => _remote.mfaFinalizeEnrollment(
          verificationId: verificationId,
          smsCode: smsCode,
          displayName: displayName,
        ),
        _errorMapper,
      );

  @override
  Future<void> mfaUnenrollByUid(String factorUid) =>
      sensitive(() => _remote.mfaUnenrollByUid(factorUid), _errorMapper);

  // ---------------------- MFA Sign-In Challenge ----------------------

  @override
  Future<String> mfaStartSignInResolve(
      Object resolver, {
        required String factorUid,
      }) =>
      sensitive(
            () => _remote.mfaStartSignInResolve(resolver, factorUid: factorUid),
        _errorMapper,
      );

  @override
  Future<AuthAccount> mfaFinalizeSignIn({
    required Object resolver,
    required String verificationId,
    required String smsCode,
  }) =>
      sensitive(() async {
        final cred = await _remote.mfaFinalizeSignIn(
          resolver: resolver,
          verificationId: verificationId,
          smsCode: smsCode,
        );
        final user = cred.user!;
        await user.reload();
        return _userMapper(user);
      }, _errorMapper);

  // ======================= قبلی‌ها =======================

  @override
  Stream<AuthAccount?> authState() {
    return _remote.onAuthState().map(
          (u) => u == null ? null : _userMapper(u),
    );
  }

  @override
  Future<AuthAccount> registerWithEmail({
    required String firstName,
    required String lastName,
    required String phoneNumber,
    String? email, // optional
    required String password,
  }) async {
    if (email == null || email.trim().isEmpty) {
      final cred = await _remote.loginAnonymous();
      final u = cred.user!;
      final dn = fullName(firstName, lastName);
      if (dn.isNotEmpty) {
        await _remote.updateDisplayName(user: u, displayName: dn);
      }
      await _ensureProfile(
        uid: u.uid,
        firstName: firstName,
        lastName: lastName,
        phoneNumber: phoneNumber,
        email: null,
      );
      return _userMapper(u);
    }

    // Enforce password strength for email/password registration
    if (!isPasswordStrong(password)) {
      throw const AuthFailure.weakPassword();
    }

    final cred = await _remote.createEmailUser(
      email: email.trim(),
      password: password,
    );
    await cred.user?.reload();
    final u = cred.user!;
    final dn = fullName(firstName, lastName);
    if (dn.isNotEmpty) {
      await _remote.updateDisplayName(user: u, displayName: dn);
    }
    await _remote.sendEmailVerification(u);
    await _ensureProfile(
      uid: u.uid,
      firstName: firstName,
      lastName: lastName,
      phoneNumber: phoneNumber,
      email: email.trim(),
    );
    return _userMapper(u);
  }

  @override
  Future<AuthAccount> loginWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final cred = await _remote.loginWithEmail(email: email, password: password);
      final user = cred.user!;
      await user.reload();

      if (!user.emailVerified) {
        await _remote.sendEmailVerification(user);
        await _remote.signOut();
        throw const AuthFailure.emailNotVerified();
      }

      return _userMapper(user);
    } on FirebaseAuthMultiFactorException catch (_) {
      // IMPORTANT: bubble MFA to the use case
      rethrow;
    } on FirebaseAuthException catch (e) {
      throw _errorMapper(e);
    }
  }


  @override
  Future<AuthAccount> loginAnonymous({
    required String firstName,
    required String lastName,
    required String phoneNumber,
  }) async {
    final cred = await _remote.loginAnonymous();
    final u = cred.user!;
    final dn = fullName(firstName, lastName);
    if (dn.isNotEmpty) {
      await _remote.updateDisplayName(user: u, displayName: dn);
    }
    await _ensureProfile(
      uid: u.uid,
      firstName: firstName,
      lastName: lastName,
      phoneNumber: phoneNumber,
      email: null,
    );
    return _userMapper(u);
  }

  @override
  Future<void> linkEmailPassword({
    required String email,
    required String password,
  }) =>
      sensitive(
            () => _remote.linkEmailPassword(email: email, password: password),
        _errorMapper,
      );

  @override
  Future<void> resetPassword({required String email}) {
    return _remote.sendPasswordResetEmail(email);
  }

  // ارسال ایمیل وریفای با کاربر فعلی دیتاسورس
  @override
  Future<void> sendEmailVerification() async {
    final user = _remote.currentUser;
    if (user == null) {
      throw const AuthFailure.sessionExpired();
    }
    await _remote.sendEmailVerification(user);
  }

  @override
  Future<void> reauthenticateWithPassword(String email, String password) async {
    try {
      await _remote.reauthWithPassword(email, password);
    } on FirebaseAuthException catch (e) {
      throw _errorMapper(e);
    }
  }

  /// ری‌اُث با Provider/OAuth (Google/Apple/Facebook/…)
  @override
  Future<void> reauthenticateWithProvider({
    required String providerId,
    String? idToken,
    String? accessToken,
    String? rawNonce,
    String? authCode, // بسته به SDK/فلو ممکن است استفاده نشود
  }) async {
    try {
      late AuthCredential cred;

      switch (providerId) {
        case 'google.com':
          cred = GoogleAuthProvider.credential(
            idToken: idToken,
            accessToken: accessToken,
          );
          break;

        case 'facebook.com':
          cred = FacebookAuthProvider.credential(accessToken!);
          break;

        case 'apple.com':
          final provider = OAuthProvider('apple.com');
          cred = provider.credential(
            idToken: idToken,
            accessToken: accessToken,
            rawNonce: rawNonce,
            // authorizationCode در برخی نسخه‌های SDK پشتیبانی می‌شود:
            // authorizationCode: authCode,
          );
          break;

        default:
          final provider = OAuthProvider(providerId);
          cred = provider.credential(
            idToken: idToken,
            accessToken: accessToken,
            rawNonce: rawNonce,
          );
          break;
      }

      await _remote.reauthWithCredential(cred);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        throw const AuthFailure.reauthRequired();
      }
      if (e.code == 'user-token-expired') {
        throw const AuthFailure.sessionExpired();
      }
      throw _errorMapper(e);
    }
  }

  @override
  Future<void> updateEmail(String newEmail) =>
      sensitive(() => _remote.updateEmail(newEmail), _errorMapper);

  @override
  Future<void> updatePassword(String newPassword) =>
      sensitive(() async {
        if (!isPasswordStrong(newPassword)) {
          throw const AuthFailure.weakPassword();
        }
        return _remote.updatePassword(newPassword);
      }, _errorMapper);

  @override
  Future<void> deleteAccount() =>
      sensitive(() => _remote.deleteAccount(), _errorMapper);

  @override
  Future<UserProfile> ensureUserProfile({
    required String uid,
    required String firstName,
    required String lastName,
    required String phoneNumber,
    String? email,
  }) async {
    await _ensureProfile(
      uid: uid,
      firstName: firstName,
      lastName: lastName,
      phoneNumber: phoneNumber,
      email: email,
    );
    final data = await _remote.getProfile(uid);
    if (data == null) {
      return UserProfile(
        id: uid,
        firstName: firstName,
        lastName: lastName,
        contactNumber: phoneNumber,
        email: email,
      );
    }
    return UserProfile(
      id: (data['id'] ?? uid) as String,
      firstName: (data['firstName'] ?? firstName) as String,
      lastName: (data['lastName'] ?? lastName) as String,
      contactNumber: (data['contactNumber'] ?? phoneNumber) as String,
      email: data['email'] as String?,
      avatarUrl: data['avatarUrl'] as String?,
      addressRefs: const [],
      walletRef: null,
      reservationRefs: const [],
      paymentMethodRefs: const [],
      orderRefs: const [],
      favoriteRefs: const [],
      discountRefs: const [],
      roleMetadata: (data['roleMetadata'] as Map<String, dynamic>?) ?? const {},
      isEmailVerified: (data['isEmailVerified'] as bool?) ?? false,
      isPhoneVerified: (data['isPhoneVerified'] as bool?) ?? false,
      // createdAt/updatedAt اگر Timestamp باشد، در mapper پروفایل تبدیل کن
      createdAt: data['createdAt'] is DateTime ? data['createdAt'] as DateTime? : null,
      updatedAt: data['updatedAt'] is DateTime ? data['updatedAt'] as DateTime? : null,
    );
  }

  @override
  Future<void> signOut() => _remote.signOut();

  /// مینیمال‌نویسی پروفایل (بدون آرایه‌های خالی)؛
  /// زمان‌ها در DataSource با serverTimestamp ست می‌شوند.
  Future<void> _ensureProfile({
    required String uid,
    required String firstName,
    required String lastName,
    required String phoneNumber,
    String? email,
  }) async {
    final data = <String, dynamic>{
      'id': uid,
      'firstName': firstName,
      'lastName': lastName,
      'contactNumber': phoneNumber,
      if (email != null) 'email': email,
      // فلگ‌ها تنها در صورت نیاز
      'isEmailVerified': email != null,
      'isPhoneVerified': false,
      // هیچ آرایه/شیء پیش‌فرض دیگری نمی‌نویسیم تا نویز و ریسک overwrite کم شود
    };
    await _remote.upsertProfile(uid, data);
  }
}
