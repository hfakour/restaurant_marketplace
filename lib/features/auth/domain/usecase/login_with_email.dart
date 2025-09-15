import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:restaurant_marketplace/features/auth/domain/entities/auth_account.dart';

import '../../data/repository/auth_repository_impl.dart';

final loginWithEmailUC = Provider.autoDispose((ref) => LoginWithEmailUseCase(ref));

class LoginWithEmailUseCase {
  LoginWithEmailUseCase(this.ref);
  final Ref ref;

  Future<AuthAccount> call({
    required String email,
    required String password,
  }) {
    return ref.read(authRepositoryProvider).loginWithEmail(
      email: email,
      password: password,
    );
  }
}
