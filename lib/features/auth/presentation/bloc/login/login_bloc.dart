// presentation/bloc/login/login_bloc.dart
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:restaurant_marketplace/features/auth/domain/extensions/auth_failure_ext.dart';
import '../../../domain/usecase/login_with_email.dart';
import '../../../domain/entities/auth_failures.dart';

// Inject AuthBloc to dispatch MFA handoff event
import '../auth/auth_bloc.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(this._login, this._authBloc) : super(const LoginState.idle()) {
    on<LoginSubmitted>(_onSubmit);
    on<_CooldownTicked>(_onCooldownTicked);
  }

  final LoginWithEmailUseCase _login;
  final AuthBloc _authBloc;

  Timer? _cooldownTimer;
  int? _cooldownRemaining; // ثانیه‌های باقیمانده

  Future<void> _onSubmit(LoginSubmitted e, Emitter<LoginState> emit) async {
    // اگر در حالت cooldown هستیم و هنوز زمان باقی‌ست، تلاش جدید را نپذیر
    if (state.status == LoginStatus.cooldown &&
        (state.cooldownSeconds ?? 0) > 0) {
      return;
    }

    // هر تلاش جدید → تایمر قبلی را قطع کن
    _cancelCooldown();

    emit(const LoginState.submitting());
    try {
      final result = await _login(email: e.email, password: e.password);

      // MFA handoff: اگر به MFA نیاز است، جریان را به AuthBloc بده
      if (result.requiresMfa) {
        _authBloc.add(
          MfaRequiredDiscovered(
            resolver: result.resolver!,
            factorUids: result.factorUids,
          ),
        );
        // UI را در حالت خنثی نگه دار تا AuthBloc جریان را ادامه دهد
        emit(const LoginState.idle());
        return;
      }

      if (result.isSuccess) {
        emit(const LoginState.success());
        // AuthBloc via authState() مسئول روتینگ کلی اپ است
        return;
      }

      if (result.isFailure) {
        emit(LoginState.failure(result.failure!.humanMessage));
        return;
      }
    } on AuthFailure catch (f) {
      if (f is TooManyRequests) {
        final secs = f.retryAfterSeconds;
        if (secs != null && secs > 0) {
          _startCooldown(secs, emit, message: f.humanMessage);
        } else {
          // اگر مدت مشخص نیست، تنها پیام را نمایش بده و به UI اجازه بده تصمیم بگیرد
          emit(
            LoginState.cooldown(cooldownSeconds: null, message: f.humanMessage),
          );
        }
      } else {
        emit(LoginState.failure(f.humanMessage));
      }
    } catch (_) {
      emit(const LoginState.failure('Unable to sign in. Please try again.'));
    }
  }

  void _startCooldown(
    int seconds,
    Emitter<LoginState> emit, {
    String? message,
  }) {
    _cancelCooldown();
    _cooldownRemaining = seconds;
    emit(
      LoginState.cooldown(
        cooldownSeconds: _cooldownRemaining,
        message: message,
      ),
    );

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
    Emitter<LoginState> emit,
  ) async {
    final remain = _cooldownRemaining;
    if (remain == null) return;

    final next = remain - 1;
    if (next <= 0) {
      _cancelCooldown();
      emit(const LoginState.idle());
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
