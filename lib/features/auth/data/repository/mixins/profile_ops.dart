import '../../../../profile/domain/entities/user_profile.dart';
import '../core/_auth_repo_core.dart';

mixin ProfileOps on AuthRepoCore  {
  /// Create or fetch a profile to keep the auth → profile flow unified.
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

    final data = await remote.getProfile(uid);
    if (data == null) {
      // Minimal fallback if the data source did not return a document.
      return UserProfile(
        id: uid,
        firstName: firstName,
        lastName: lastName,
        contactNumber: phoneNumber,
        email: email,
      );
    }

    // Map loosely-typed Map → strongly-typed domain entity.
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
      roleMetadata: (data['roleMetadata'] as Map<String, dynamic>?) ?? const {},
      isEmailVerified: (data['isEmailVerified'] as bool?) ?? false,
      isPhoneVerified: (data['isPhoneVerified'] as bool?) ?? false,
      // If your DS returns Timestamp, convert it in a dedicated profile mapper.
      createdAt:
      data['createdAt'] is DateTime ? data['createdAt'] as DateTime? : null,
      updatedAt:
      data['updatedAt'] is DateTime ? data['updatedAt'] as DateTime? : null,
    );
  }

  Future<void> _ensureProfile({
    required String uid,
    required String firstName,
    required String lastName,
    required String phoneNumber,
    String? email,
  }) async {
    final data = <String, dynamic>{
      'id': uid,
      'firstName': firstName,
      'lastName': lastName,
      'contactNumber': phoneNumber,
      if (email != null) 'email': email,
      'isEmailVerified': email != null,
      'isPhoneVerified': false,
    };
    await remote.upsertProfile(uid, data);
  }
}
