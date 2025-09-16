// presentation/bloc/login/login_state.dart
part of 'login_bloc.dart';

enum LoginStatus { idle, submitting, success, failure, cooldown }

class LoginState extends Equatable {
  const LoginState._({
    required this.status,
    this.message,
    this.cooldownSeconds,
  });

  const LoginState.idle() : this._(status: LoginStatus.idle);

  const LoginState.submitting() : this._(status: LoginStatus.submitting);

  const LoginState.success() : this._(status: LoginStatus.success);

  const LoginState.failure(String msg)
      : this._(status: LoginStatus.failure, message: msg);

  /// اگر [cooldownSeconds] مقدار داشته باشد، UI می‌تواند تایمر نشان دهد
  /// و دکمه‌ی ورود را تا اتمام شمارش غیرفعال کند.
  const LoginState.cooldown({int? cooldownSeconds, String? message})
      : this._(
    status: LoginStatus.cooldown,
    cooldownSeconds: cooldownSeconds,
    message: message,
  );

  final LoginStatus status;
  final String? message;
  final int? cooldownSeconds;

  LoginState copyWith({
    LoginStatus? status,
    String? message,
    bool clearMessage = false,
    int? cooldownSeconds,
    bool clearCooldown = false,
  }) {
    return LoginState._(
      status: status ?? this.status,
      message: clearMessage ? null : (message ?? this.message),
      cooldownSeconds:
      clearCooldown ? null : (cooldownSeconds ?? this.cooldownSeconds),
    );
  }

  @override
  List<Object?> get props => [status, message, cooldownSeconds];
}
