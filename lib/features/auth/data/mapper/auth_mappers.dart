import 'package:firebase_auth/firebase_auth.dart' as fb show User;

import '../../domain/entities/auth_account.dart';
import '../../domain/entities/auth_provider.dart';

Set<AuthProvider> _providersFromUser(fb.User user) {
  final p = <AuthProvider>{};
  for (final i in user.providerData) {
    switch (i.providerId) {
      case 'password':
        p.add(AuthProvider.password);
        break;
      case 'google.com':
        p.add(AuthProvider.google);
        break;
      case 'apple.com':
        p.add(AuthProvider.apple);
        break;
      case 'phone':
        p.add(AuthProvider.phone);
        break;
      case 'anonymous':
        p.add(AuthProvider.anonymous);
        break;
      default:
        break;
    }
  }
  if (user.isAnonymous) p.add(AuthProvider.anonymous);
  return p;
}

AuthAccount authAccountFromFirebaseUser(fb.User u) {
  final raw = (u.displayName ?? '').trim();
  String? firstName;
  String? lastName;

  if (raw.isNotEmpty) {
    final parts = raw.split(RegExp(r'\\s+'));
    firstName = parts.isNotEmpty ? parts.first : null;
    lastName = parts.length > 1 ? parts.sublist(1).join(' ') : null;
  }

  return AuthAccount(
    id: u.uid,
    email: u.email,
    firstName: firstName,
    lastName: lastName,
    avatarUrl: u.photoURL,
    isEmailVerified: u.emailVerified,
    isPhoneVerified: u.phoneNumber != null,
    providers: _providersFromUser(u),
    profileId: u.uid,
    createdAt: u.metadata.creationTime?.toUtc(),
    updatedAt: DateTime.now().toUtc(),
    lastLoginAt: u.metadata.lastSignInTime?.toUtc(),
  );
}
