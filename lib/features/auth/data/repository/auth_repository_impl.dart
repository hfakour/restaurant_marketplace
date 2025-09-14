// features/auth/data/repositories/auth_repository_impl.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/auth_account.dart';
import '../../domain/repositories/auth_repository.dart';

import 'package:restaurant_marketplace/features/profile/domain/entities/user_profile.dart';
import '../datasource/auth_remote_ds.dart';
import '../mapper/auth_mappers.dart';
import '../mapper/user_profile_mappers.dart';

final firebaseAuthProvider = Provider<FirebaseAuth>((_) => FirebaseAuth.instance);
final firestoreProvider = Provider<FirebaseFirestore>((_) => FirebaseFirestore.instance);

final authRemoteProvider = Provider<AuthRemoteDataSource>((ref) {
  return AuthRemoteDataSource(ref.read(firebaseAuthProvider), ref.read(firestoreProvider));
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(ref.read(authRemoteProvider));
});

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._remote);
  final AuthRemoteDataSource _remote;

  @override
  Stream<AuthAccount?> authState() =>
      _remote.onAuthState().map((u) => u == null ? null : authAccountFromFirebaseUser(u));

  @override
  Future<AuthAccount> registerWithEmail({
    required String firstName,
    required String lastName,
    required String phoneNumber,
    String? email,
    required String password,
  }) async {
    if (email == null || email.trim().isEmpty) {
      // fallback to anonymous if email omitted
      final cred = await _remote.loginAnonymous();
      final u = cred.user!;
      await _ensureProfile(uid: u.uid, firstName: firstName, lastName: lastName, phoneNumber: phoneNumber, email: null);
      return authAccountFromFirebaseUser(u);
    }

    final cred = await _remote.createEmailUser(email: email.trim(), password: password);
    final u = cred.user!;
    await _remote.sendEmailVerification(u);
    await _ensureProfile(uid: u.uid, firstName: firstName, lastName: lastName, phoneNumber: phoneNumber, email: email.trim());
    return authAccountFromFirebaseUser(u);
  }

  @override
  Future<AuthAccount> loginWithEmail({
    required String email,
    required String password,
  }) async {
    final cred = await _remote.loginEmail(email: email.trim(), password: password);
    return authAccountFromFirebaseUser(cred.user!);
  }

  @override
  Future<AuthAccount> loginAnonymous({
    required String firstName,
    required String lastName,
    required String phoneNumber,
  }) async {
    final cred = await _remote.loginAnonymous();
    final u = cred.user!;
    await _ensureProfile(uid: u.uid, firstName: firstName, lastName: lastName, phoneNumber: phoneNumber, email: null);
    return authAccountFromFirebaseUser(u);
  }

  @override
  Future<void> linkEmailPassword({required String email, required String password}) {
    return _remote.linkEmailPassword(email: email.trim(), password: password);
  }

  @override
  Future<void> signOut() => _remote.signOut();

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
      // Shouldn't happen right after ensure; return a minimal in-memory instance
      return UserProfile(
        id: uid,
        firstName: firstName,
        lastName: lastName,
        contactNumber: phoneNumber,
        email: email,
      );
    }
    return firestoreToUserProfile(data);
  }

  Future<void> _ensureProfile({
    required String uid,
    required String firstName,
    required String lastName,
    required String phoneNumber,
    String? email,
  }) {
    final payload = {
      'id': uid,
      'firstName': firstName.trim(),
      'lastName': lastName.trim(),
      'contactNumber': phoneNumber.trim(),
      'email': (email?.trim().isEmpty ?? true) ? null : email!.trim(),
      'avatarUrl': null,
      'addressRefs': <Map<String, dynamic>>[],
      'walletRef': null,
      'reservationRefs': <Map<String, dynamic>>[],
      'paymentMethodRefs': <Map<String, dynamic>>[],
      'orderRefs': <Map<String, dynamic>>[],
      'favoriteRefs': <Map<String, dynamic>>[],
      'discountRefs': <Map<String, dynamic>>[],
      'isEmailVerified': email != null,
      'isPhoneVerified': false,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
      'roleMetadata': <String, dynamic>{},
    };
    return _remote.upsertProfile(uid: uid, payload: payload);
  }
}
