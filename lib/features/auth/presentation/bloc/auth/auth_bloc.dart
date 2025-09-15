// auth/presentation/bloc/auth/auth_bloc.dart
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/auth_account.dart';
import '../../../domain/repositories/auth_repository.dart';
import '../../../domain/entities/auth_failures.dart'; // برای تشخیص ReauthRequired

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this._repo) : super(const AuthState.loading()) {
    // استریم وضعیت ورود/خروج
    on<_AuthStreamRequested>(_onStreamRequested);
    on<_AuthAccountChanged>(_onAccountChanged);
    on<AuthSignOutRequested>(_onSignOutRequested);

    // ایمیل وریفیکیشن
    on<SendEmailVerification>(onSendEmailVerification);
    on<ReloadAndCheck>(onReloadAndCheck);

    // --- Sensitive ops: updateEmail/password/delete/link ---
    on<UpdateEmailRequested>(_onUpdateEmailRequested);
    on<UpdatePasswordRequested>(_onUpdatePasswordRequested);
    on<DeleteAccountRequested>(_onDeleteAccountRequested);
    on<LinkEmailPasswordRequested>(_onLinkEmailPasswordRequested);

    // Reauth + Retry
    on<ReauthenticateWithPasswordRequested>(_onReauthenticateWithPasswordRequested);
    on<ReauthenticateWithProviderRequested>(_onReauthenticateWithProviderRequested);

    // مدیریت خطا/صف
    on<ClearAuthError>((e, emit) => emit(state.copyWith(clearError: true)));
    on<ClearPendingSensitiveOp>((e, emit) => emit(state.copyWith(
      clearPendingOp: true,
      clearPendingNewEmail: true,
      clearPendingNewPassword: true,
      clearPendingLinkEmail: true,
      clearPendingLinkPassword: true,
    )));

    add(const _AuthStreamRequested());
  }

  final AuthRepository _repo;
  StreamSubscription<AuthAccount?>? _sub;

  // -------- Stream wiring --------
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

  // -------- Email Verification --------
  Future<void> onSendEmailVerification(
      SendEmailVerification event,
      Emitter<AuthState> emit,
      ) async {
    emit(AuthState.sendingEmailVerification(account: state.account));
    try {
      if (_repo.currentUser == null) {
        emit(const AuthState.unauthenticated());
        return;
      }

      final isVerified = await _repo.reloadAndEmailVerified();
      if (!isVerified) {
        await _repo.sendEmailVerification();
      }

      emit(AuthState.emailVerificationSent(account: state.account));
    } catch (e) {
      emit(AuthState.error(e.toString()));
    }
  }

  Future<void> onReloadAndCheck(
      ReloadAndCheck event,
      Emitter<AuthState> emit,
      ) async {
    emit(AuthState.checkingEmailVerification(account: state.account));
    try {
      final verified = await _repo.reloadAndEmailVerified();
      if (verified) {
        final acc = await _repo.currentAccount();
        emit(AuthState.authenticated(acc));
      } else {
        // فقط همین استیت را بده تا AuthGate به /verify-email بره
        emit(AuthState.emailVerificationSent(account: state.account));
        return;
      }
    } catch (e) {
      emit(AuthState.error(e.toString()));
    }
  }

  // -------- Sensitive Ops --------
  Future<void> _onUpdateEmailRequested(
      UpdateEmailRequested event,
      Emitter<AuthState> emit,
      ) async {
    try {
      await _repo.updateEmail(event.newEmail.trim());
      // verifyBeforeUpdateEmail → ایمیل وریفای ارسال می‌شود
      emit(AuthState.emailVerificationSent(account: state.account));
    } on AuthFailure catch (f) {
      if (f is ReauthRequired) {
        // اپ را برای Reauth آماده کن
        emit(state.copyWith(
          pendingOp: PendingSensitiveOp.updateEmail,
          pendingNewEmail: event.newEmail.trim(),
          clearError: true,
        ));
        return;
      }
      // سایر خطاها را در همان استیت فعلی نشان بده (بدون تریگر AuthGate)
      emit(state.copyWith(error: f.toString()));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  Future<void> _onUpdatePasswordRequested(
      UpdatePasswordRequested event,
      Emitter<AuthState> emit,
      ) async {
    try {
      await _repo.updatePassword(event.newPassword);
      // می‌تونی اکانت را تازه‌سازی کنی (اختیاری)
      final acc = _repo.currentUser ?? await _repo.currentAccount();
      emit(AuthState.authenticated(acc));
    } on AuthFailure catch (f) {
      if (f is ReauthRequired) {
        emit(state.copyWith(
          pendingOp: PendingSensitiveOp.updatePassword,
          pendingNewPassword: event.newPassword,
          clearError: true,
        ));
        return;
      }
      emit(state.copyWith(error: f.toString()));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  Future<void> _onDeleteAccountRequested(
      DeleteAccountRequested event,
      Emitter<AuthState> emit,
      ) async {
    try {
      await _repo.deleteAccount();
      // تغییر وضعیت به unauthenticated از طریق استریم اتفاق می‌افتد
    } on AuthFailure catch (f) {
      if (f is ReauthRequired) {
        emit(state.copyWith(
          pendingOp: PendingSensitiveOp.deleteAccount,
          clearError: true,
        ));
        return;
      }
      emit(state.copyWith(error: f.toString()));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  Future<void> _onLinkEmailPasswordRequested(
      LinkEmailPasswordRequested event,
      Emitter<AuthState> emit,
      ) async {
    try {
      await _repo.linkEmailPassword(
        email: event.email.trim(),
        password: event.password,
      );
      // دیتاسورس بعد از لینک، ایمیل وریفای را ارسال می‌کند
      emit(AuthState.emailVerificationSent(account: state.account));
    } on AuthFailure catch (f) {
      if (f is ReauthRequired) {
        emit(state.copyWith(
          pendingOp: PendingSensitiveOp.linkEmailPassword,
          pendingLinkEmail: event.email.trim(),
          pendingLinkPassword: event.password,
          clearError: true,
        ));
        return;
      }
      emit(state.copyWith(error: f.toString()));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  // -------- Reauth + Retry (Password / Provider) --------

  Future<void> _onReauthenticateWithPasswordRequested(
      ReauthenticateWithPasswordRequested event,
      Emitter<AuthState> emit,
      ) async {
    try {
      await _repo.reauthenticateWithPassword(event.email.trim(), event.password);
      await _retryPendingOp(emit);
    } on AuthFailure catch (f) {
      emit(state.copyWith(error: f.toString()));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  Future<void> _onReauthenticateWithProviderRequested(
      ReauthenticateWithProviderRequested event,
      Emitter<AuthState> emit,
      ) async {
    try {
      await _repo.reauthenticateWithProvider(
        providerId: event.providerId,
        idToken: event.idToken,
        accessToken: event.accessToken,
        rawNonce: event.rawNonce,
        authCode: event.authCode,
      );
      await _retryPendingOp(emit);
    } on AuthFailure catch (f) {
      emit(state.copyWith(error: f.toString()));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  // Helper مشترک برای Retry کردن عملیات حساس پس از Reauth موفق
  Future<void> _retryPendingOp(Emitter<AuthState> emit) async {
    switch (state.pendingOp) {
      case PendingSensitiveOp.updateEmail:
        final newEmail = state.pendingNewEmail;
        if (newEmail != null) {
          await _repo.updateEmail(newEmail.trim());
          emit(AuthState.emailVerificationSent(account: state.account));
        }
        break;

      case PendingSensitiveOp.updatePassword:
        final newPass = state.pendingNewPassword;
        if (newPass != null) {
          await _repo.updatePassword(newPass);
          final acc = _repo.currentUser ?? await _repo.currentAccount();
          emit(AuthState.authenticated(acc));
        }
        break;

      case PendingSensitiveOp.deleteAccount:
        await _repo.deleteAccount();
        // استریم، unauthenticated را منتشر می‌کند
        break;

      case PendingSensitiveOp.linkEmailPassword:
        final linkEmail = state.pendingLinkEmail;
        final linkPass = state.pendingLinkPassword;
        if (linkEmail != null && linkPass != null) {
          await _repo.linkEmailPassword(email: linkEmail.trim(), password: linkPass);
          emit(AuthState.emailVerificationSent(account: state.account));
        }
        break;

      case null:
        break;
    }

    // پاک‌سازی صف
    emit(state.copyWith(
      clearPendingOp: true,
      clearPendingNewEmail: true,
      clearPendingNewPassword: true,
      clearPendingLinkEmail: true,
      clearPendingLinkPassword: true,
      clearError: true,
    ));
  }

  @override
  Future<void> close() async {
    await _sub?.cancel();
    return super.close();
  }
}
