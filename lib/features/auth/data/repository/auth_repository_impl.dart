import 'package:firebase_auth/firebase_auth.dart';
import '../../../profile/domain/entities/user_profile.dart';
import '../../domain/entities/auth_failures.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/entities/auth_account.dart';
import '../datasource/auth_remote_ds.dart';
import '../mapper/auth_mappers.dart';            // authAccountFromFirebaseUser
import '../mapper/auth_error_mapper.dart';       // mapFirebaseAuthException

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

  String _fullName(String first, String last) =>
      [first.trim(), last.trim()].where((s) => s.isNotEmpty).join(' ');

  // ======================= Helper: Sensitive Ops (Reauth + Retry pattern) =======================
  Future<T> _sensitive<T>(Future<T> Function() op) async {
    try {
      return await op();
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

  // ======================= جدیدها (هم‌راستا با AuthRepository) =======================

  /// آخرین کاربر موجود (ممکن است null باشد). از ریموت می‌خوانیم و مپ می‌کنیم.
  @override
  AuthAccount? get currentUser {
    final u = _remote.currentUser;
    return u == null ? null : _userMapper(u);
  }

  /// نسخه‌ی تازه‌ی کاربر فعلی (با ریلود)؛ اگر لاگین نیست، خطا می‌دهیم.
  @override
  Future<AuthAccount> currentAccount() async {
    final u = _remote.currentUser;
    if (u == null) {
      throw const AuthFailure.unknown('No authenticated user.');
    }
    try {
      await u.reload();
      final fresh = _remote.currentUser;
      if (fresh == null) {
        throw const AuthFailure.unknown('User signed out during refresh.');
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
      final dn = _fullName(firstName, lastName);
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

    final cred = await _remote.createEmailUser(
      email: email.trim(),
      password: password,
    );
    await cred.user?.reload();
    final u = cred.user!;
    final dn = _fullName(firstName, lastName);
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
      final cred = await _remote.loginWithEmail(
        email: email,
        password: password,
      );
      final user = cred.user!;
      await user.reload();

      // enforce: فقط کاربرهای ایمیل-وریفای اجازه ورود دارند
      if (!user.emailVerified) {
        await _remote.sendEmailVerification(user);
        await _remote.signOut();
        throw const AuthFailure.emailNotVerified();
      }

      return _userMapper(user);
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
    final dn = _fullName(firstName, lastName);
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
      _sensitive(() => _remote.linkEmailPassword(email: email, password: password));

  @override
  Future<void> resetPassword({required String email}) {
    return _remote.sendPasswordResetEmail(email);
  }

  // ارسال ایمیل وریفای با کاربر فعلی دیتاسورس
  @override
  Future<void> sendEmailVerification() async {
    final user = _remote.currentUser;
    if (user == null) {
      throw const AuthFailure.unknown('No authenticated user to verify.');
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
    String? authCode, // ممکنه برای برخی Providerها لازم نباشه
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
        // برای فیس‌بوک accessToken ضروریه
          cred = FacebookAuthProvider.credential(accessToken!);
          break;

        case 'apple.com':
        // Apple اغلب به rawNonce و idToken نیاز داره (authCode بعضی فلوها)
          final provider = OAuthProvider('apple.com');
          cred = provider.credential(
            idToken: idToken,
            accessToken: accessToken,
            rawNonce: rawNonce,
            // بعضی نسخه‌های SDK پارامتر authorizationCode رو ندارن؛
            // اگر پکیج/نسخه‌ات نداره، این پارامتر رو حذف کن.
            // authorizationCode: authCode, // در صورت پشتیبانی
          );
          break;

        default:
        // سایر Providerها (microsoft.com, yahoo.com, github.com, ...)
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
      _sensitive(() => _remote.updateEmail(newEmail));

  @override
  Future<void> updatePassword(String newPassword) =>
      _sensitive(() => _remote.updatePassword(newPassword));

  @override
  Future<void> deleteAccount() =>
      _sensitive(() => _remote.deleteAccount());

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
      // createdAt/updatedAt را اگر خواستی می‌تونی در Mapper تبدیل کنی (Timestamp -> DateTime)
      createdAt: data['createdAt'] is DateTime ? data['createdAt'] as DateTime? : null,
      updatedAt: data['updatedAt'] is DateTime ? data['updatedAt'] as DateTime? : null,
    );
  }

  @override
  Future<void> signOut() => _remote.signOut();

  /// فقط داده‌های دامنه را پاس می‌دهیم؛
  /// ثبت زمان به‌صورت serverTimestamp در DataSource انجام می‌شود.
  Future<void> _ensureProfile({
    required String uid,
    required String firstName,
    required String lastName,
    required String phoneNumber,
    String? email,
  }) async {
    final data = {
      'id': uid,
      'firstName': firstName,
      'lastName': lastName,
      'contactNumber': phoneNumber,
      'email': email,
      'isEmailVerified': email != null,
      'isPhoneVerified': false,
      'avatarUrl': null,
      'addressRefs': <Map<String, dynamic>>[],
      'walletRef': null,
      'reservationRefs': <Map<String, dynamic>>[],
      'paymentMethodRefs': <Map<String, dynamic>>[],
      'orderRefs': <Map<String, dynamic>>[],
      'favoriteRefs': <Map<String, dynamic>>[],
      'discountRefs': <Map<String, dynamic>>[],
      'roleMetadata': <String, dynamic>{},
      // createdAt/updatedAt عمداً اینجا ست نمی‌شود
    };
    await _remote.upsertProfile(uid, data);
  }
}
