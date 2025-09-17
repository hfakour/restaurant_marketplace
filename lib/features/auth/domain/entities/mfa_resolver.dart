// features/auth/domain/entities/mfa_resolver.dart
class MfaResolverHandle {
  final Object raw;        // opaque handle (Firebase resolver lives here)
  final List<String> factorUids; // populated from hints at catch time
  const MfaResolverHandle({required this.raw, required this.factorUids});
}
