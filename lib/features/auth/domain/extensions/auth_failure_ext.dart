import '../entities/auth_failures.dart';

extension AuthFailureX on AuthFailure {
  /// Human-readable message for UI. Uses `maybeWhen` so it stays forward-compatible
  /// if new failure variants are added to the sealed union.
  String get humanMessage => maybeWhen(
    // Credentials & validation
    wrongPassword: () => 'Incorrect password.',
    invalidCredentials: () => 'Email or password is incorrect.',
    invalidEmail: () => 'Email format is invalid.',
    weakPassword: () => 'Password is too weak. Please choose a stronger one.',
    emailAlreadyInUse: () => 'This email is already in use.',

    // User/account state
    userNotFound: () => 'No account found with these details.',
    userDisabled: () => 'Your account has been disabled.',
    emailNotVerified: () => 'Your email is not verified. Please check your inbox.',
    reauthRequired: () => 'Please reauthenticate to continue.',

    // Session & tokens
    tokenExpired: () => 'Your session has expired. Please sign in again.',
    sessionExpired: () => 'Your session has expired. Please sign in again.',

    // Network / server
    networkIssue: () => 'No internet connection. Please try again.',
    networkTimeout: () => 'The request timed out. Please try again.',
    serverIssue: (code) =>
    'Server error${code != null ? ' ($code)' : ''}. Please try again later.',
    tooManyRequests: (seconds) => seconds != null
        ? 'Too many attempts. Please wait $seconds seconds and try again.'
        : 'Too many attempts. Please try again later.',

    // Provider / MFA / phone
    providerAlreadyLinked: () => 'This sign-in method is already linked to your account.',
    invalidOtp: () => 'The verification code is invalid.',
    invalidPhone: () => 'The phone number is invalid.',

    // Fallback
    unknown: (msg) => msg ?? 'An unknown error occurred.',
    orElse: () => 'An unknown error occurred.',
  );
}
