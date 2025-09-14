import 'package:freezed_annotation/freezed_annotation.dart';
import 'auth_provider.dart';

part 'auth_account.freezed.dart';

@freezed
class AuthAccount with _$AuthAccount {
  const factory AuthAccount({
    /// Firebase UID (stable id)
    required String id,

    /// May be null for anonymous/phone flows
    String? email,

    String? displayName,
    String? avatarUrl,

    @Default(false) bool isEmailVerified,
    @Default(false) bool isPhoneVerified,

    /// Linked providers (password/google/apple/phone/anonymous)
    @Default(<AuthProvider>{}) Set<AuthProvider> providers,

    /// 1:1 mapping to your UserProfile.id (we use UID)
    required String profileId,

    /// Auditing
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? lastLoginAt,

    /// Provider/backend-specific metadata (safe to store)
    @Default(<String, dynamic>{}) Map<String, dynamic> providerMetadata,
  }) = _AuthAccount;
}
