// auth/presentation/bloc/signup/signup_state.dart
part of 'signup_bloc.dart';

enum SignUpStatus { idle, submitting, success, failure, cooldown }

class SignUpState extends Equatable {
  const SignUpState._({
    required this.status,
    this.error,
    this.cooldownSeconds,
  });

  const SignUpState.idle() : this._(status: SignUpStatus.idle);

  const SignUpState.submitting() : this._(status: SignUpStatus.submitting);

  const SignUpState.success() : this._(status: SignUpStatus.success);

  const SignUpState.failure(String message)
      : this._(status: SignUpStatus.failure, error: message);

  /// اگر [cooldownSeconds] مقدار داشته باشد، UI می‌تواند شمارشگر نشان دهد
  /// و دکمه ثبت‌نام را تا اتمام شمارش غیرفعال کند.
  const SignUpState.cooldown({int? cooldownSeconds, String? message})
      : this._(
    status: SignUpStatus.cooldown,
    cooldownSeconds: cooldownSeconds,
    error: message,
  );

  final SignUpStatus status;
  final String? error;
  final int? cooldownSeconds;

  SignUpState copyWith({
    SignUpStatus? status,
    String? error,
    bool clearError = false,
    int? cooldownSeconds,
    bool clearCooldown = false,
  }) {
    return SignUpState._(
      status: status ?? this.status,
      error: clearError ? null : (error ?? this.error),
      cooldownSeconds:
      clearCooldown ? null : (cooldownSeconds ?? this.cooldownSeconds),
    );
  }

  @override
  List<Object?> get props => [status, error, cooldownSeconds];
}
