// presentation/bloc/login/login_event.dart
part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
  @override
  List<Object?> get props => [];
}

class LoginSubmitted extends LoginEvent {
  const LoginSubmitted({required this.email, required this.password});
  final String email;
  final String password;

  @override
  List<Object?> get props => [email, password];
}

// رویداد داخلی برای تیک خوردن شمارنده‌ی ریت‌لیمیت
class _CooldownTicked extends LoginEvent {
  const _CooldownTicked();
}
