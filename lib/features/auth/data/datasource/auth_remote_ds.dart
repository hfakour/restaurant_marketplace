import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRemoteDataSource {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  AuthRemoteDataSource(this._auth, this._firestore);

  // ------------------- AUTH -------------------

  Stream<User?> onAuthState() => _auth.authStateChanges();

  Future<UserCredential> createEmailUser({
    required String email,
    required String password,
  }) {
    return _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<UserCredential> loginEmail({
    required String email,
    required String password,
  }) {
    return _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<UserCredential> loginAnonymous() => _auth.signInAnonymously();

  Future<void> sendEmailVerification(User user) => user.sendEmailVerification();

  Future<void> signOut() => _auth.signOut();

  // NEW: set Firebase displayName from first + last
  Future<void> updateDisplayName({
    required User user,
    required String displayName,
  }) async {
    await user.updateDisplayName(displayName.trim());
    await user.reload();
  }

  // NEW: link email/password to the current (typically anonymous) user
  Future<void> linkEmailPassword({
    required String email,
    required String password,
  }) async {
    final user = _auth.currentUser;
    if (user == null) {
      throw FirebaseAuthException(code: 'no-current-user', message: 'No authenticated user to link.');
    }
    final cred = EmailAuthProvider.credential(email: email.trim(), password: password);
    await user.linkWithCredential(cred);
    await user.sendEmailVerification();
  }

  // ------------------- FIRESTORE -------------------

  DocumentReference<Map<String, dynamic>> _profileDoc(String uid) =>
      _firestore.collection('user_profiles').doc(uid);

  Future<void> upsertProfile(String uid, Map<String, dynamic> data) {
    return _profileDoc(uid).set(data, SetOptions(merge: true));
  }

  Future<Map<String, dynamic>?> getProfile(String uid) async {
    final snap = await _profileDoc(uid).get();
    return snap.data();
  }
}
