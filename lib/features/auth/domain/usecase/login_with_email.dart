import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repository/auth_repository_impl.dart';
import '../entities/auth_account.dart';
import '../repositories/auth_repository.dart';

final loginWithEmailUC =
Provider.autoDispose((ref) => LoginWithEmailUseCase(ref));

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
