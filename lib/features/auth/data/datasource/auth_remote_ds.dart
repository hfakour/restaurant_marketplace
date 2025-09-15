import 'package:cloud_firestore/cloud_firestore.dart' as fs;
import 'package:firebase_auth/firebase_auth.dart' as fa;

class FsPaths {
  static const profiles = 'user_profiles';
}

class AuthRemoteDataSource {
  final fa.FirebaseAuth _auth;
  final fs.FirebaseFirestore _firestore;

  AuthRemoteDataSource(this._auth, this._firestore);

  // کاربر فعلی
  fa.User? get currentUser => _auth.currentUser;

  // ------------------- AUTH -------------------

  Stream<fa.User?> onAuthState() => _auth.idTokenChanges();

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
  Future<fa.UserCredential> loginEmail({required String email, required String password}) =>
      loginWithEmail(email: email, password: password);

  Future<fa.UserCredential> registerWithEmail({required String email, required String password}) =>
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
  Future<void> linkEmailPassword({
    required String email,
    required String password,
  }) async {
    final user = _auth.currentUser;
    if (user == null) {
      throw fa.FirebaseAuthException(
        code: 'user-not-logged-in',
        message: 'No authenticated user to link.',
      );
    }
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

  // ------------------- SENSITIVE OPS -------------------

  Future<void> reauthWithPassword(String email, String password) async {
    final user = _auth.currentUser;
    if (user == null) {
      throw fa.FirebaseAuthException(code: 'user-not-logged-in', message: 'No authenticated user');
    }
    final cred = fa.EmailAuthProvider.credential(email: email.trim(), password: password);
    await user.reauthenticateWithCredential(cred);
  }

  // ✅ به‌جای updateEmail از verifyBeforeUpdateEmail استفاده شد
  Future<void> updateEmail(String newEmail) async {
    final user = _auth.currentUser;
    if (user == null) {
      throw fa.FirebaseAuthException(code: 'user-not-logged-in', message: 'No authenticated user');
    }
    await user.verifyBeforeUpdateEmail(newEmail.trim());
    await user.reload(); // پس از تأیید لینک، ایمیل بروز می‌شود
  }

  Future<void> updatePassword(String newPassword) async {
    final user = _auth.currentUser;
    if (user == null) {
      throw fa.FirebaseAuthException(code: 'user-not-logged-in', message: 'No authenticated user');
    }
    await user.updatePassword(newPassword);
  }

  Future<void> deleteAccount() async {
    final user = _auth.currentUser;
    if (user == null) {
      throw fa.FirebaseAuthException(code: 'user-not-logged-in', message: 'No authenticated user');
    }
    await user.delete();
  }

  // ------------------- FIRESTORE -------------------

  Future<void> upsertProfile(String uid, Map<String, dynamic> data) async {
    await _firestore.runTransaction((tx) async {
      final ref = _firestore.collection(FsPaths.profiles).doc(uid);
      final snap = await tx.get(ref);
      final now = fs.FieldValue.serverTimestamp();
      if (!snap.exists) {
        tx.set(ref, {...data, 'createdAt': now, 'updatedAt': now});
      } else {
        tx.update(ref, {...data, 'updatedAt': now});
      }
    });
  }

  // ساخت/به‌روزرسانی پروفایل با داده‌های پیش‌فرض
  Future<void> ensureUserProfile(fa.User user, {Map<String, dynamic> extra = const {}}) async {
    final base = {
      'uid': user.uid,
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
