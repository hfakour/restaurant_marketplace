import 'package:cloud_firestore/cloud_firestore.dart' as fs;
import 'package:firebase_auth/firebase_auth.dart' as fa;

class FsPaths {
  static const profiles = 'user_profiles';
}

class AuthRemoteDataSource {
  final fa.FirebaseAuth _auth;
  final fs.FirebaseFirestore _firestore;

  AuthRemoteDataSource(this._auth, this._firestore);

  // کاربر فعلی (ممکن است null باشد)
  fa.User? get currentUser => _auth.currentUser;

  // --- Helper: گرفتن user الزامی ---
  fa.User _requireUser() {
    final u = _auth.currentUser;
    if (u == null) {
      throw fa.FirebaseAuthException(
        code: 'user-not-logged-in',
        message: 'No authenticated user',
      );
    }
    return u;
  }

  // ------------------- AUTH -------------------

  /// استریم تغییرات کاربر (login/logout + profile/reload changes)
  Stream<fa.User?> onAuthState() => _auth.userChanges();

  Future<fa.UserCredential> createEmailUser({
    required String email,
    required String password,
  }) {
    final e = email.trim();
    return _auth.createUserWithEmailAndPassword(email: e, password: password);
  }

  Future<fa.UserCredential> loginWithEmail({
    required String email,
    required String password,
  }) {
    final e = email.trim();
    return _auth.signInWithEmailAndPassword(email: e, password: password);
  }

  // سازگاری با امضاهای قدیمی پروژه (اختیاری)
  Future<fa.UserCredential> loginEmail({
    required String email,
    required String password,
  }) =>
      loginWithEmail(email: email, password: password);

  Future<fa.UserCredential> registerWithEmail({
    required String email,
    required String password,
  }) =>
      createEmailUser(email: email, password: password);

  Future<fa.UserCredential> loginAnonymous() => _auth.signInAnonymously();

  Future<void> sendEmailVerification(fa.User user) => user.sendEmailVerification();

  Future<void> signOut() => _auth.signOut();

  Future<void> updateDisplayName({
    required fa.User user,
    required String displayName,
  }) async {
    await user.updateDisplayName(displayName.trim());
    await user.reload();
  }

  // لینک کردن ایمیل/پسورد روی یوزر فعلی (معمولاً anonymous)
  // نکته: فقط email را trim می‌کنیم؛ password را دست‌نمی‌زنیم (ممکن است space معتبر باشد).
  Future<void> linkEmailPassword({
    required String email,
    required String password,
  }) async {
    final user = _requireUser();
    final cred = fa.EmailAuthProvider.credential(
      email: email.trim(),
      password: password,
    );
    await user.linkWithCredential(cred);
    await user.sendEmailVerification();
  }

  // Password reset
  Future<void> sendPasswordResetEmail(String email) =>
      _auth.sendPasswordResetEmail(email: email.trim());

  // ------------------- REAUTH -------------------

  Future<void> reauthWithPassword(String email, String password) async {
    final user = _requireUser();
    final cred =
    fa.EmailAuthProvider.credential(email: email.trim(), password: password);
    await user.reauthenticateWithCredential(cred);
  }

  /// ری‌اُث با هر Provider/OAuth (google.com, apple.com, facebook.com, ...)
  Future<void> reauthWithCredential(fa.AuthCredential cred) async {
    final user = _requireUser();
    await user.reauthenticateWithCredential(cred);
  }

  // ------------------- SENSITIVE OPS -------------------

  // ✅ از verifyBeforeUpdateEmail استفاده می‌کنیم؛ بعد از تأیید لینک، با reload اعمال می‌شود
  Future<void> updateEmail(String newEmail) async {
    final user = _requireUser();
    await user.verifyBeforeUpdateEmail(newEmail.trim());
    await user.reload();
  }

  Future<void> updatePassword(String newPassword) async {
    final user = _requireUser();
    await user.updatePassword(newPassword);
  }

  Future<void> deleteAccount() async {
    final user = _requireUser();
    await user.delete();
  }

  // ------------------- FIRESTORE -------------------

  /// upsert پروفایل با اتمیسیتی و merge ایمن.
  /// - کلید id یکدست با مدل دامنه.
  /// - createdAt فقط در ایجاد اولیه ست می‌شود؛ در آپدیت‌ها دست‌نخورده می‌ماند.
  /// - updatedAt همیشه serverTimestamp می‌خورد.
  Future<void> upsertProfile(String uid, Map<String, dynamic> data) async {
    await _firestore.runTransaction((tx) async {
      final ref = _firestore.collection(FsPaths.profiles).doc(uid);
      final snap = await tx.get(ref);
      final now = fs.FieldValue.serverTimestamp();

      if (!snap.exists) {
        tx.set(
          ref,
          {
            // طرح‌واره یکدست با domain
            'id': uid,
            ...data,
            'createdAt': now,
            'updatedAt': now,
          },
          fs.SetOptions(merge: true),
        );
      } else {
        tx.set(
          ref,
          {
            // اگر data خودش id نداشت، همین‌جا اطمینان می‌دهیم یکدست باشد
            'id': uid,
            ...data,
            'updatedAt': now,
          },
          fs.SetOptions(merge: true),
        );
      }
    });
  }

  /// ساخت/به‌روزرسانی پروفایل با داده‌های پایه
  /// نکته: کلید «id» استفاده می‌شود (نه uid) تا با Mapper/Domain یکدست باشد.
  Future<void> ensureUserProfile(
      fa.User user, {
        Map<String, dynamic> extra = const {},
      }) async {
    final base = {
      'id': user.uid, // ← یکدست با مدل دامنه و مپرها
      'email': user.email,
      'displayName': user.displayName,
      'photoURL': user.photoURL,
    };
    await upsertProfile(user.uid, {...base, ...extra});
  }

  fs.DocumentReference<Map<String, dynamic>> _profileDoc(String uid) =>
      _firestore.collection(FsPaths.profiles).doc(uid);

  Future<Map<String, dynamic>?> getProfile(String uid) async {
    final snap = await _profileDoc(uid).get();
    return snap.data();
  }
}
