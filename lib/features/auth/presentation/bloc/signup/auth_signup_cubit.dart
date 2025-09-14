import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecase/register_with_email.dart';
import 'auth_signup_state.dart';

class AuthSignUpCubit extends Cubit<AuthSignUpState> {
  AuthSignUpCubit(this._register) : super(const AuthSignUpState.idle());
  final RegisterWithEmailUseCase _register;

  Future<void> submit({
    required String firstName,
    required String lastName,
    required String phone,
    String? email,
    required String password,
  }) async {
    emit(const AuthSignUpState.submitting());
    try {
      await _register.call(
        firstName: firstName,
        lastName: lastName,
        phoneNumber: phone,
        email: email,
        password: password,
      );
      emit(const AuthSignUpState.success());
    } catch (e) {
      emit(const AuthSignUpState.error('Could not create your account.'));
    }
  }
}
