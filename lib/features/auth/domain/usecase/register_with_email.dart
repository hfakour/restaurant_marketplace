import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:restaurant_marketplace/features/auth/domain/entities/auth_account.dart';

import '../../data/repository/auth_repository_impl.dart';

final registerWithEmailUC = Provider.autoDispose((ref) => RegisterWithEmailUseCase(ref));

class RegisterWithEmailUseCase {
  RegisterWithEmailUseCase(this.ref);
  final Ref ref;

  Future<AuthAccount> call({
    required String firstName,
    required String lastName,
    required String phoneNumber,
    String? email,
    required String password,
  }) {
    return ref.read(authRepositoryProvider).registerWithEmail(
      firstName: firstName,
      lastName: lastName,
      phoneNumber: phoneNumber,
      email: email,
      password: password,
    );
  }
}
