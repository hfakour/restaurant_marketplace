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

  // ✅ دو مپِر تزریقی/پیش‌فرض
  final AuthAccount Function(User) _userMapper;
  final AuthFailure Function(FirebaseAuthException) _errorMapper;

  String _fullName(String first, String last) =>
      [first.trim(), last.trim()].where((s) => s.isNotEmpty).join(' ');

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
    String? email,
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

      // ✅ enforce: فقط کاربرهای ایمیل-وریفای اجازه ورود دارند
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
  }) {
    return _remote.linkEmailPassword(email: email, password: password);
  }

  @override
  Future<void> resetPassword({required String email}) {
    return _remote.sendPasswordResetEmail(email);
  }

  // ✅ اضافه‌شده: ارسال ایمیل وریفای از طریق کاربر فعلی دیتاسورس
  @override
  Future<void> sendEmailVerification() async {
    final user = _remote.currentUser;
    if (user == null) {
      throw const AuthFailure.unknown('No authenticated user to verify.');
    }
    await _remote.sendEmailVerification(user);
  }

  // ✅ اضافه‌شده‌ها مطابق درخواستی که دادی

  @override
  Future<void> reauthenticateWithPassword(String email, String password) async {
    try {
      await _remote.reauthWithPassword(email, password);
    } on FirebaseAuthException catch (e) {
      throw _errorMapper(e);
    }
  }

  @override
  Future<void> updateEmail(String newEmail) async {
    try {
      await _remote.updateEmail(newEmail);
    } on FirebaseAuthException catch (e) {
      throw _errorMapper(e);
    }
  }

  @override
  Future<void> updatePassword(String newPassword) async {
    try {
      await _remote.updatePassword(newPassword);
    } on FirebaseAuthException catch (e) {
      throw _errorMapper(e);
    }
  }

  @override
  Future<void> deleteAccount() async {
    try {
      await _remote.deleteAccount();
    } on FirebaseAuthException catch (e) {
      throw _errorMapper(e);
    }
  }

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
      createdAt: data['createdAt'] is DateTime ? data['createdAt'] as DateTime? : null,
      updatedAt: data['updatedAt'] is DateTime ? data['updatedAt'] as DateTime? : null,
    );
  }

  @override
  Future<void> signOut() => _remote.signOut();

  Future<void> _ensureProfile({
    required String uid,
    required String firstName,
    required String lastName,
    required String phoneNumber,
    String? email,
  }) async {
    final now = DateTime.now().toUtc(); // DataSource روی سرور override می‌کند
    final data = {
      'id': uid,
      'firstName': firstName,
      'lastName': lastName,
      'contactNumber': phoneNumber,
      'email': email,
      'isEmailVerified': email != null,
      'isPhoneVerified': false,
      'createdAt': now,
      'updatedAt': now,
      'avatarUrl': null,
      'addressRefs': <Map<String, dynamic>>[],
      'walletRef': null,
      'reservationRefs': <Map<String, dynamic>>[],
      'paymentMethodRefs': <Map<String, dynamic>>[],
      'orderRefs': <Map<String, dynamic>>[],
      'favoriteRefs': <Map<String, dynamic>>[],
      'discountRefs': <Map<String, dynamic>>[],
      'roleMetadata': <String, dynamic>{},
    };
    await _remote.upsertProfile(uid, data);
  }
}
