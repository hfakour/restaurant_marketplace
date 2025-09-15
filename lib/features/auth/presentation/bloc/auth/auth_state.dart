// auth/presentation/bloc/auth/auth_state.dart
part of 'auth_bloc.dart';

enum AuthViewStatus { loading, unauthenticated, authenticated, error }

class AuthState extends Equatable {
  const AuthState._({this.account, required this.status, this.error});

  const AuthState.loading()         : this._(status: AuthViewStatus.loading);
  const AuthState.unauthenticated() : this._(status: AuthViewStatus.unauthenticated);
  const AuthState.authenticated(AuthAccount a)
      : this._(account: a, status: AuthViewStatus.authenticated);
  const AuthState.error(String m)   : this._(status: AuthViewStatus.error, error: m);

  final AuthAccount? account;
  final AuthViewStatus status;
  final String? error;

  @override
  List<Object?> get props => [account, status, error];
}
