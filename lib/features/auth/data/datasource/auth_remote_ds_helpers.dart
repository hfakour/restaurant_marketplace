// auth_remote_ds_helpers.dart
//
// Helper utilities used by AuthRemoteDataSource.
// This file is intentionally separated to keep the main data source file focused
// on behavior while helpers (extensions, constants) live here.
//
// NOTE: Keep this file in the same folder as auth_remote_ds.dart so the import
// path in the main file does not need to change.

import 'package:firebase_auth/firebase_auth.dart' as fa;

/// Firestore collection names used by the auth module.
class FsPaths {
  static const profiles = 'user_profiles';
}

/// Extension helpers for FirebaseAuth to provide a single place to require a
/// "fresh" user (reload first, then return the current user or throw).
extension FirebaseAuthRequireFresh on fa.FirebaseAuth {
  /// Ensures there's a non-null authenticated user and reloads it to refresh
  /// emailVerified/claims etc. Throws a FirebaseAuthException with code
  /// 'user-not-logged-in' when there's no authenticated user.
  Future<fa.User> requireFreshUser() async {
    final u = currentUser;
    if (u == null) {
      throw fa.FirebaseAuthException(
        code: 'user-not-logged-in',
        message: 'No authenticated user',
      );
    }

    // Reload to make sure claims / emailVerified / provider data are refreshed.
    await u.reload();

    final fresh = currentUser;
    if (fresh == null) {
      throw fa.FirebaseAuthException(
        code: 'user-not-logged-in',
        message: 'No authenticated user after reload',
      );
    }
    return fresh;
  }
}

