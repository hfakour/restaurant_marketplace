part of 'login_bloc.dart';

class LoginState extends Equatable {
  const LoginState._(this.status, {this.error});
  const LoginState.idle() : this._(LoginStatus.idle);
  const LoginState.submitting() : this._(LoginStatus.submitting);
  const LoginState.success() : this._(LoginStatus.success);
  const LoginState.failure(String message)
      : this._(LoginStatus.failure, error: message);

  final LoginStatus status;
  final String? error;

  @override
  List<Object?> get props => [status, error];
}

enum LoginStatus { idle, submitting, success, failure }
