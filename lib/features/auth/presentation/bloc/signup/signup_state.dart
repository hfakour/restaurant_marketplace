// auth/presentation/bloc/signup/signup_state.dart
part of 'signup_bloc.dart';

class SignUpState extends Equatable {
  const SignUpState._(this.status, {this.error});
  const SignUpState.idle() : this._(SignUpStatus.idle);
  const SignUpState.submitting() : this._(SignUpStatus.submitting);
  const SignUpState.success() : this._(SignUpStatus.success);
  const SignUpState.failure(String message)
      : this._(SignUpStatus.failure, error: message);

  final SignUpStatus status;
  final String? error;

  @override
  List<Object?> get props => [status, error];
}

enum SignUpStatus { idle, submitting, success, failure }
