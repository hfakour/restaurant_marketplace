import 'package:freezed_annotation/freezed_annotation.dart';
part 'auth_signup_state.freezed.dart';

@freezed
class AuthSignUpState with _$AuthSignUpState {
  const factory AuthSignUpState.idle() = _Idle;
  const factory AuthSignUpState.submitting() = _Submitting;
  const factory AuthSignUpState.success() = _Success;
  const factory AuthSignUpState.error(String message) = _Error;
}
