// auth/data/mapper/auth_mappers.dart
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
      default:
        break;
    }
  }
  if (user.isAnonymous) p.add(AuthProvider.anonymous);
  return p;
}

/// Splits a full display name into [first, last] using whitespace.
/// If only one token exists, returns [first] only.
List<String> _splitName(String raw) {
  final parts = raw.split(RegExp(r'\s+')).where((s) => s.isNotEmpty).toList();
  if (parts.isEmpty) return const [];
  if (parts.length == 1) return [parts.first];
  return [parts.first, parts.sublist(1).join(' ')];
}

AuthAccount authAccountFromFirebaseUser(fb.User u) {
  final raw = (u.displayName ?? '').trim();
  String? firstName;
  String? lastName;

  if (raw.isNotEmpty) {
    final nameParts = _splitName(raw);
    if (nameParts.isNotEmpty) {
      firstName = nameParts[0];
      if (nameParts.length > 1 && nameParts[1].isNotEmpty) {
        lastName = nameParts[1];
      }
    }
  }

  return AuthAccount(
    id: u.uid,
    email: u.email,
    firstName: firstName,
    lastName: lastName,
    avatarUrl: u.photoURL,
    isEmailVerified: u.emailVerified,
    // NOTE: presence of phoneNumber does not guarantee verification state.
    // If you need ground truth, store a domain flag in Firestore (profile).
    isPhoneVerified: u.phoneNumber != null,
    providers: _providersFromUser(u),
    profileId: u.uid,
    createdAt: u.metadata.creationTime?.toUtc(),
    // Keep updatedAt null; let Firestore be the source of truth (server timestamps).
    updatedAt: null,
    lastLoginAt: u.metadata.lastSignInTime?.toUtc(),
  );
}
