import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../profile/domain/entities/user_profile.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/entities/auth_account.dart';
import '../datasource/auth_remote_ds.dart';
import '../mapper/auth_mappers.dart';

// ---- Low-level providers (Firebase + datasource) ----
final firebaseAuthProvider = Provider<FirebaseAuth>((_) => FirebaseAuth.instance);
final firestoreProvider   = Provider<FirebaseFirestore>((_) => FirebaseFirestore.instance);

final authRemoteProvider = Provider<AuthRemoteDataSource>((ref) {
  return AuthRemoteDataSource(
    ref.read(firebaseAuthProvider),
    ref.read(firestoreProvider),
  );
});

// ---- The repository provider you want to read everywhere ----
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(ref.read(authRemoteProvider));
});

// ---- Concrete repo implementation ----
class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._remote);
  final AuthRemoteDataSource _remote;

  String _fullName(String first, String last) =>
      [first.trim(), last.trim()].where((s) => s.isNotEmpty).join(' ');

  @override
  Stream<AuthAccount?> authState() {
    return _remote.onAuthState().map((u) => u == null ? null : authAccountFromFirebaseUser(u));
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
      await _ensureProfile(uid: u.uid, firstName: firstName, lastName: lastName, phoneNumber: phoneNumber, email: null);
      return authAccountFromFirebaseUser(u);
    }

    final cred = await _remote.createEmailUser(email: email.trim(), password: password);
    final u = cred.user!;
    final dn = _fullName(firstName, lastName);
    if (dn.isNotEmpty) {
      await _remote.updateDisplayName(user: u, displayName: dn);
    }
    await _remote.sendEmailVerification(u);
    await _ensureProfile(uid: u.uid, firstName: firstName, lastName: lastName, phoneNumber: phoneNumber, email: email.trim());
    return authAccountFromFirebaseUser(u);
  }

  @override
  Future<AuthAccount> loginWithEmail({required String email, required String password}) async {
    final cred = await _remote.loginEmail(email: email, password: password);
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
    final dn = _fullName(firstName, lastName);
    if (dn.isNotEmpty) {
      await _remote.updateDisplayName(user: u, displayName: dn);
    }
    await _ensureProfile(uid: u.uid, firstName: firstName, lastName: lastName, phoneNumber: phoneNumber, email: null);
    return authAccountFromFirebaseUser(u);
  }

  @override
  Future<void> linkEmailPassword({required String email, required String password}) {
    return _remote.linkEmailPassword(email: email, password: password);
  }

  @override
  Future<UserProfile> ensureUserProfile({
    required String uid,
    required String firstName,
    required String lastName,
    required String phoneNumber,
    String? email,
  }) async {
    await _ensureProfile(uid: uid, firstName: firstName, lastName: lastName, phoneNumber: phoneNumber, email: email);
    final data = await _remote.getProfile(uid);
    if (data == null) {
      // minimal fallback (avoid pulling other feature refs here)
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
      isEmailVerified: (data['isEmailVerified'] as bool?) ?? false,
      isPhoneVerified: (data['isPhoneVerified'] as bool?) ?? false,
      createdAt: data['createdAt'] is DateTime ? data['createdAt'] as DateTime? : null,
      updatedAt: data['updatedAt'] is DateTime ? data['updatedAt'] as DateTime? : null,
      roleMetadata: (data['roleMetadata'] as Map<String, dynamic>?) ?? const {},
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
    final now = DateTime.now().toUtc();
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
