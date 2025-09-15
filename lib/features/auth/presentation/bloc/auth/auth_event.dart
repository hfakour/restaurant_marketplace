// auth/presentation/bloc/auth/auth_event.dart
part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object?> get props => [];
}

class _AuthStreamRequested extends AuthEvent {
  const _AuthStreamRequested();
}

class _AuthAccountChanged extends AuthEvent {
  const _AuthAccountChanged(this.account);
  final AuthAccount? account;
}

class AuthSignOutRequested extends AuthEvent {
  const AuthSignOutRequested();
}
