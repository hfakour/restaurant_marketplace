// lib/core/domain_refs/profile_ref.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_ref.freezed.dart';

/// Lightweight reference to a user profile.
/// Keep this decoupled from domain enums (e.g., UserRole) to avoid cross-deps.
@freezed
class UserProfileRef with _$UserProfileRef {
  const factory UserProfileRef({
    required String userId,
    String? displayName,
    String? avatarUrl,
    String? contactNumber,
  }) = _UserProfileRef;
}
