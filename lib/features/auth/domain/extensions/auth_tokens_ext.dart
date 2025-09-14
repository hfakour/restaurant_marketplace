import '../entities/auth_tokens.dart';

extension AuthTokensX on AuthTokens {
  bool get isAccessExpired =>
      accessTokenExpiry != null &&
          DateTime.now().isAfter(accessTokenExpiry!.toUtc());

  String get authorizationHeader => 'Bearer $accessToken';
}
