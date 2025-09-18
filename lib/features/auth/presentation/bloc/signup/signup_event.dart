// auth/presentation/bloc/signup/signup_event.dart
part of 'signup_bloc.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();
  @override
  List<Object?> get props => [];
}

class SignUpSubmitted extends SignUpEvent {
  const SignUpSubmitted({
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.password,
    this.email,
  });

  final String firstName;
  final String lastName;
  final String phone;
  final String password;
  final String? email;

  @override
  List<Object?> get props => [firstName, lastName, phone, password, email];
}

// رویداد داخلی برای تیک خوردن شمارنده‌ی ریت‌لیمیت
class _CooldownTicked extends SignUpEvent {
  const _CooldownTicked();
}
