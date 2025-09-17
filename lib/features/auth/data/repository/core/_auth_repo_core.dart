import 'package:firebase_auth/firebase_auth.dart';

import '../../../domain/entities/auth_account.dart';
import '../../../domain/entities/auth_failures.dart';
import '../../datasource/auth_remote_ds.dart';
import '../../mapper/auth_error_mapper.dart';
import '../../mapper/auth_mappers.dart';

class AuthRepoCore {
  AuthRepoCore(
      this.remote, {
        AuthAccount Function(User)? userMapper,
        AuthFailure Function(FirebaseAuthException)? errorMapper,
      })  : mapUser = userMapper ?? authAccountFromFirebaseUser,
        mapError = errorMapper ?? mapFirebaseAuthException;

  final AuthRemoteDataSource remote;
  final AuthAccount Function(User) mapUser;
  final AuthFailure Function(FirebaseAuthException) mapError;
}
