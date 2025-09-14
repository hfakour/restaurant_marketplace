// features/auth/data/datasources/auth_remote_ds.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthRemoteDataSource {
  AuthRemoteDataSource(this._auth, this._db);
  final FirebaseAuth _auth;
  final FirebaseFirestore _db;

  Stream<User?> onAuthState() => _auth.authStateChanges();

  Future<UserCredential> createEmailUser({
    required String email,
    required String password,
  }) => _auth.createUserWithEmailAndPassword(email: email, password: password);

  Future<UserCredential> loginEmail({
    required String email,
    required String password,
  }) => _auth.signInWithEmailAndPassword(email: email, password: password);

  Future<UserCredential> loginAnonymous() => _auth.signInAnonymously();

  Future<void> sendEmailVerification(User user) async {
    if (!user.emailVerified) await user.sendEmailVerification();
  }

  Future<void> linkEmailPassword({
    required String email,
    required String password,
  }) async {
    final user = _auth.currentUser;
    if (user == null) throw FirebaseAuthException(code: 'no-current-user');
    final cred = EmailAuthProvider.credential(email: email, password: password);
    await user.linkWithCredential(cred);
    await user.sendEmailVerification();
  }

  Future<void> signOut() => _auth.signOut();

  // --- Firestore: user_profiles/{uid} ---
  DocumentReference<Map<String, dynamic>> _profileDoc(String uid) =>
      _db.collection('user_profiles').doc(uid);

  Future<void> upsertProfile({
    required String uid,
    required Map<String, dynamic> payload,
  }) async {
    await _profileDoc(uid).set(payload, SetOptions(merge: true));
  }

  Future<Map<String, dynamic>?> getProfile(String uid) async {
    final snap = await _profileDoc(uid).get();
    return snap.data();
  }
}
