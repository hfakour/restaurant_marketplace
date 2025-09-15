// features/auth/domain/repositories/auth_repository.dart
import 'package:restaurant_marketplace/features/profile/domain/entities/user_profile.dart';

import '../entities/auth_account.dart';

abstract class AuthRepository {
  Stream<AuthAccount?> authState(); // null when signed out

  Future<AuthAccount> registerWithEmail({
    required String firstName,
    required String lastName,
    required String phoneNumber,
    String? email, // optional
    required String password,
  });

  Future<AuthAccount> loginWithEmail({
    required String email,
    required String password,
  });

  Future<AuthAccount> loginAnonymous({
    required String firstName,
    required String lastName,
    required String phoneNumber,
  });

  Future<void> linkEmailPassword({
    required String email,
    required String password,
  });

  Future<void> signOut();

  /// Profile fetch/create handoff (so auth -> profile is seamless)
  Future<UserProfile> ensureUserProfile({
    required String uid,
    required String firstName,
    required String lastName,
    required String phoneNumber,
    String? email,
  });

  Future<void> resetPassword({required String email});
  Future<void> sendEmailVerification();

  Future<void> reauthenticateWithPassword(String email, String password);
  Future<void> updateEmail(String newEmail);
  Future<void> updatePassword(String newPassword);
  Future<void> deleteAccount();
}
