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

List<String> _splitName(String raw) {
  // استفاده‌ی صحیح از \s برای همه فاصله‌ها (space/tab/newline/…)
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
    isPhoneVerified: u.phoneNumber != null,
    providers: _providersFromUser(u),
    profileId: u.uid,
    createdAt: u.metadata.creationTime?.toUtc(),
    // نکته: برای جلوگیری از ناهمگنی با serverTimestamp فایراستوری،
    // اینجا updatedAt را ست نمی‌کنیم (null). آن را از منبع معتبر (Firestore) بخوان.
    updatedAt: null,
    lastLoginAt: u.metadata.lastSignInTime?.toUtc(),
  );
}
