// auth/presentation/bloc/auth/auth_bloc.dart
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/auth_account.dart';
import '../../../domain/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this._repo) : super(const AuthState.loading()) {
    on<_AuthStreamRequested>(_onStreamRequested);
    on<_AuthAccountChanged>(_onAccountChanged);
    on<AuthSignOutRequested>(_onSignOutRequested);

    add(const _AuthStreamRequested());
  }

  final AuthRepository _repo;
  StreamSubscription<AuthAccount?>? _sub;

  Future<void> _onStreamRequested(
      _AuthStreamRequested event,
      Emitter<AuthState> emit,
      ) async {
    await _sub?.cancel();
    _sub = _repo.authState().listen(
          (account) => add(_AuthAccountChanged(account)),
      onError: (e, _) => emit(AuthState.error(e.toString())),
    );
  }

  void _onAccountChanged(
      _AuthAccountChanged event,
      Emitter<AuthState> emit,
      ) {
    if (event.account == null) {
      emit(const AuthState.unauthenticated());
    } else {
      emit(AuthState.authenticated(event.account!));
    }
  }

  Future<void> _onSignOutRequested(
      AuthSignOutRequested event,
      Emitter<AuthState> emit,
      ) async {
    await _repo.signOut();
  }

  @override
  Future<void> close() async {
    await _sub?.cancel();
    return super.close();
  }
}
