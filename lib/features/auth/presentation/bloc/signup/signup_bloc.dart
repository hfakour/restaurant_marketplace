// auth/presentation/bloc/signup/signup_bloc.dart
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:restaurant_marketplace/features/auth/domain/extensions/auth_failure_ext.dart';
import '../../../domain/entities/auth_failures.dart';
import '../../../domain/usecase/register_with_email.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc(this._register) : super(const SignUpState.idle()) {
    on<SignUpSubmitted>(_onSubmit);
    on<_CooldownTicked>(_onCooldownTicked);
  }

  final RegisterWithEmailUseCase _register;

  Timer? _cooldownTimer;
  int? _cooldownRemaining;

  Future<void> _onSubmit(SignUpSubmitted e, Emitter<SignUpState> emit) async {
    // Ignore new attempts if still in cooldown
    if (state.status == SignUpStatus.cooldown &&
        (state.cooldownSeconds ?? 0) > 0) {
      return;
    }

    _cancelCooldown();
    emit(const SignUpState.submitting());
    try {
      await _register(
        firstName: e.firstName,
        lastName: e.lastName,
        phoneNumber: e.phone,
        email: e.email,
        password: e.password,
      );
      emit(const SignUpState.success());
    } on AuthFailure catch (f) {
      if (f is TooManyRequests) {
        final secs = f.retryAfterSeconds;
        if (secs != null && secs > 0) {
          _startCooldown(secs, emit, message: f.humanMessage);
        } else {
          emit(SignUpState.cooldown(message: f.humanMessage));
        }
      } else {
        emit(SignUpState.failure(f.humanMessage));
      }
    } catch (_) {
      emit(const SignUpState.failure('Could not create your account.'));
    }
  }

  void _startCooldown(int seconds, Emitter<SignUpState> emit, {String? message}) {
    _cancelCooldown();
    _cooldownRemaining = seconds;
    emit(SignUpState.cooldown(cooldownSeconds: _cooldownRemaining, message: message));

    _cooldownTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      add(const _CooldownTicked());
    });
  }

  void _cancelCooldown() {
    _cooldownTimer?.cancel();
    _cooldownTimer = null;
    _cooldownRemaining = null;
  }

  Future<void> _onCooldownTicked(
      _CooldownTicked event,
      Emitter<SignUpState> emit,
      ) async {
    final remain = _cooldownRemaining;
    if (remain == null) return;

    final next = remain - 1;
    if (next <= 0) {
      _cancelCooldown();
      emit(const SignUpState.idle());
    } else {
      _cooldownRemaining = next;
      emit(state.copyWith(cooldownSeconds: next));
    }
  }

  @override
  Future<void> close() {
    _cancelCooldown();
    return super.close();
  }
}
