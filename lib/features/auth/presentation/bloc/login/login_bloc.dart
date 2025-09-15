// presentation/bloc/login/login_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:restaurant_marketplace/features/auth/domain/extensions/auth_failure_ext.dart';
import '../../../domain/usecase/login_with_email.dart';
import '../../../domain/entities/auth_failures.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(this._login) : super(const LoginState.idle()) {
    on<LoginSubmitted>(_onSubmit);
  }

  final LoginWithEmailUseCase _login;

  Future<void> _onSubmit(LoginSubmitted e, Emitter<LoginState> emit) async {
    emit(const LoginState.submitting());
    try {
      await _login(email: e.email, password: e.password);
      emit(const LoginState.success());
      // AuthBloc will update overall app state via authState() stream.
    } on AuthFailure catch (f) {
      emit(LoginState.failure(f.humanMessage));
    } catch (_) {
      emit(const LoginState.failure('Unable to sign in. Please try again.'));
    }
  }
}
