// features/auth/domain/entities/auth_entities.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_entities.freezed.dart';

enum AuthStatus { unauthenticated, authenticating, authenticated, refreshing }
enum AuthProvider { password, google, apple, phone, anonymous }

@freezed
class AuthTokens with _$AuthTokens {
  const factory AuthTokens({
    required String accessToken,
    String? refreshToken,
    DateTime? accessTokenExpiry,
  }) = _AuthTokens;

  const AuthTokens._();
  bool get isAccessExpired =>
      accessTokenExpiry != null && DateTime.now().isAfter(accessTokenExpiry!.toUtc());
  String get authorizationHeader => 'Bearer $accessToken';
}

@freezed
class AuthAccount with _$AuthAccount {
  const factory AuthAccount({
    required String id,                 // Firebase UID
    String? email,                      // may be null for anonymous
    String? displayName,
    String? avatarUrl,
    @Default(false) bool isEmailVerified,
    @Default(false) bool isPhoneVerified,
    @Default(<AuthProvider>{}) Set<AuthProvider> providers,
    required String profileId,          // = UserProfile.id (we use uid)
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? lastLoginAt,
    @Default(<String, dynamic>{}) Map<String, dynamic> providerMetadata,
  }) = _AuthAccount;
}

@freezed
class AuthSession with _$AuthSession {
  const factory AuthSession({
    required AuthAccount account,
    required AuthTokens tokens,
    @Default(AuthStatus.authenticated) AuthStatus status,
  }) = _AuthSession;

  const AuthSession._();
  bool get isAuthenticated => status == AuthStatus.authenticated;
  bool get needsRefresh => tokens.isAccessExpired == true || status == AuthStatus.refreshing;
}
