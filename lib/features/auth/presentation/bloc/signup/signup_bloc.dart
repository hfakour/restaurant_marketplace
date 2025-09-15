// auth/presentation/bloc/signup/signup_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:restaurant_marketplace/features/auth/domain/extensions/auth_failure_ext.dart';
import '../../../domain/entities/auth_failures.dart';
import '../../../domain/usecase/register_with_email.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc(this._register) : super(const SignUpState.idle()) {
    on<SignUpSubmitted>(_onSubmit);
  }

  final RegisterWithEmailUseCase _register;

  Future<void> _onSubmit(SignUpSubmitted e, Emitter<SignUpState> emit) async {
    emit(const SignUpState.submitting());
    try {
      await _register(
        firstName: e.firstName,
        lastName: e.lastName,
        phoneNumber: e.phone,
        email: e.email,
        password: e.password,
      );
      emit(const SignUpState.success());
    } on AuthFailure catch (f) {
      emit(SignUpState.failure(f.humanMessage));
    } catch (_) {
      emit(const SignUpState.failure('Could not create your account.'));
    }
  }
}
