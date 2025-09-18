// auth/presentation/bloc/auth/auth_bloc.dart
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:restaurant_marketplace/features/auth/domain/extensions/auth_failure_ext.dart';

import '../../../domain/entities/auth_account.dart';
import '../../../domain/entities/auth_failures.dart';
import '../../../domain/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this._repo) : super(const AuthState.loading()) {
    // Stream wiring
    on<_AuthStreamRequested>(_onStreamRequested);
    on<_AuthAccountChanged>(_onAccountChanged);

    // Handoff from LoginBloc when MFA is required
    on<MfaRequiredDiscovered>((e, emit) {
      emit(AuthState.mfaRequired(resolver: e.resolver, factorUids: e.factorUids));
    });

    // Primary
    on<SignOutRequested>(_onSignOut);

    // Email verification
    on<SendEmailVerificationRequested>(_onSendEmailVerification);
    on<CheckEmailVerificationRequested>(_onCheckEmailVerification);

    // Reauth
    on<ReauthenticateWithPasswordRequested>(_onReauthPassword);

    // Sensitive ops (may require reauth)
    on<UpdateEmailRequested>(_onUpdateEmail);
    on<UpdatePasswordRequested>(_onUpdatePassword);
    on<LinkEmailPasswordRequested>(_onLinkEmailPassword);
    on<DeleteAccountRequested>(_onDeleteAccount);

    // MFA
    on<MfaStartResolveRequested>(_onMfaStartResolve);
    on<MfaCodeSubmitted>(_onMfaCodeSubmitted);
    on<MfaCancelRequested>(_onMfaCancel);

    // Start listening to auth state
    add(const _AuthStreamRequested());
  }

  final AuthRepository _repo;
  StreamSubscription<AuthAccount?>? _sub;

  // ---------------- Stream ----------------

  Future<void> _onStreamRequested(
      _AuthStreamRequested event,
      Emitter<AuthState> emit,
      ) async {
    await _sub?.cancel();
    _sub = _repo.authState().listen((a) => add(_AuthAccountChanged(a)));
  }

  Future<void> _onAccountChanged(
      _AuthAccountChanged event,
      Emitter<AuthState> emit,
      ) async {
    final a = event.account;
    if (a == null) {
      emit(const AuthState.unauthenticated());
    } else {
      emit(AuthState.authenticated(a));
    }
  }

  // ---------------- Primary ----------------

  Future<void> _onSignOut(
      SignOutRequested event,
      Emitter<AuthState> emit,
      ) async {
    try {
      await _repo.signOut();
      emit(const AuthState.unauthenticated());
    } on AuthFailure catch (f) {
      emit(state.copyWith(status: AuthViewStatus.error, error: f.humanMessage));
    } catch (e) {
      emit(state.copyWith(status: AuthViewStatus.error, error: e.toString()));
    }
  }

  // ------------- Email verification -------------

  Future<void> _onSendEmailVerification(
      SendEmailVerificationRequested event,
      Emitter<AuthState> emit,
      ) async {
    emit(AuthState.sendingEmailVerification(account: state.account));
    try {
      await _repo.sendEmailVerification();
      emit(AuthState.emailVerificationSent(account: state.account));
    } on AuthFailure catch (f) {
      emit(state.copyWith(status: AuthViewStatus.error, error: f.humanMessage));
    } catch (e) {
      emit(state.copyWith(status: AuthViewStatus.error, error: e.toString()));
    }
  }

  Future<void> _onCheckEmailVerification(
      CheckEmailVerificationRequested event,
      Emitter<AuthState> emit,
      ) async {
    emit(AuthState.checkingEmailVerification(account: state.account));
    try {
      final verified = await _repo.reloadAndEmailVerified();
      if (verified) {
        // Try to refresh current account snapshot
        try {
          final fresh = await _repo.currentAccount();
          emit(AuthState.authenticated(fresh));
        } on AuthFailure {
          // fall back to previous account if refresh failed
          if (state.account != null) {
            emit(AuthState.authenticated(state.account!));
          } else {
            emit(const AuthState.unauthenticated());
          }
        }
      } else {
        // Still not verified; keep the user on unauth or previous state
        emit(AuthState.emailVerificationSent(account: state.account));
      }
    } on AuthFailure catch (f) {
      emit(state.copyWith(status: AuthViewStatus.error, error: f.humanMessage));
    } catch (e) {
      emit(state.copyWith(status: AuthViewStatus.error, error: e.toString()));
    }
  }

  // ---------------- Reauth ----------------

  Future<void> _onReauthPassword(
      ReauthenticateWithPasswordRequested event,
      Emitter<AuthState> emit,
      ) async {
    try {
      await _repo.reauthenticateWithPassword(event.email.trim(), event.password);
      await _retryPendingOp(emit);
    } on AuthFailure catch (f) {
      // GAP FIX: promote rate limit to dedicated view
      if (f is TooManyRequests) {
        emit(AuthState.rateLimited(
          account: state.account,
          retryAfterSeconds: f.retryAfterSeconds,
        ));
        return;
      }
      emit(state.copyWith(status: AuthViewStatus.error, error: f.humanMessage));
    } catch (e) {
      emit(state.copyWith(status: AuthViewStatus.error, error: e.toString()));
    }
  }

  // ------------- Sensitive operations -------------

  Future<void> _onUpdateEmail(
      UpdateEmailRequested event,
      Emitter<AuthState> emit,
      ) async {
    await _performSensitive(
      emit,
      op: () => _repo.updateEmail(event.newEmail.trim()),
      onReauthRequired: state.copyWith(
        pendingOp: PendingSensitiveOp.updateEmail,
        pendingNewEmail: event.newEmail.trim(),
        // show error for UX prompt
        status: AuthViewStatus.error,
        error: const AuthFailure.reauthRequired().humanMessage,
      ),
    );
  }

  Future<void> _onUpdatePassword(
      UpdatePasswordRequested event,
      Emitter<AuthState> emit,
      ) async {
    await _performSensitive(
      emit,
      op: () => _repo.updatePassword(event.newPassword),
      onReauthRequired: state.copyWith(
        pendingOp: PendingSensitiveOp.updatePassword,
        pendingNewPassword: event.newPassword,
        status: AuthViewStatus.error,
        error: const AuthFailure.reauthRequired().humanMessage,
      ),
    );
  }

  Future<void> _onLinkEmailPassword(
      LinkEmailPasswordRequested event,
      Emitter<AuthState> emit,
      ) async {
    await _performSensitive(
      emit,
      op: () => _repo.linkEmailPassword(
        email: event.email.trim(),
        password: event.password,
      ),
      onReauthRequired: state.copyWith(
        pendingOp: PendingSensitiveOp.linkEmailPassword,
        pendingLinkEmail: event.email.trim(),
        pendingLinkPassword: event.password,
        status: AuthViewStatus.error,
        error: const AuthFailure.reauthRequired().humanMessage,
      ),
    );
  }

  Future<void> _onDeleteAccount(
      DeleteAccountRequested event,
      Emitter<AuthState> emit,
      ) async {
    await _performSensitive(
      emit,
      op: _repo.deleteAccount,
      onReauthRequired: state.copyWith(
        pendingOp: PendingSensitiveOp.deleteAccount,
        status: AuthViewStatus.error,
        error: const AuthFailure.reauthRequired().humanMessage,
      ),
      onSuccess: () => emit(const AuthState.unauthenticated()),
    );
  }

  // ---------------- MFA ----------------

  Future<void> _onMfaStartResolve(
      MfaStartResolveRequested event,
      Emitter<AuthState> emit,
      ) async {
    try {
      final verificationId = await _repo.mfaStartSignInResolve(
        event.resolver,
        factorUid: event.factorUid.trim(),
      );
      emit(AuthState.mfaCodeSent(
        resolver: event.resolver,
        verificationId: verificationId,
      ));
    } on AuthFailure catch (f) {
      // Too many requests → rateLimit view for better UX
      if (f is TooManyRequests) {
        emit(AuthState.rateLimited(
          account: state.account,
          retryAfterSeconds: f.retryAfterSeconds,
        ));
        return;
      }
      emit(state.copyWith(status: AuthViewStatus.error, error: f.humanMessage));
    } catch (e) {
      emit(state.copyWith(status: AuthViewStatus.error, error: e.toString()));
    }
  }

  Future<void> _onMfaCodeSubmitted(
      MfaCodeSubmitted event,
      Emitter<AuthState> emit,
      ) async {
    try {
      final account = await _repo.mfaFinalizeSignIn(
        resolver: event.resolver,
        verificationId: event.verificationId.trim(),
        smsCode: event.smsCode.trim(),
      );
      emit(AuthState.authenticated(account));
    } on AuthFailure catch (f) {
      emit(state.copyWith(status: AuthViewStatus.error, error: f.humanMessage));
    } catch (e) {
      emit(state.copyWith(status: AuthViewStatus.error, error: e.toString()));
    }
  }

  Future<void> _onMfaCancel(
      MfaCancelRequested event,
      Emitter<AuthState> emit,
      ) async {
    emit(state.copyWith(
      clearMfaResolver: true,
      clearMfaFactorUids: true,
      clearMfaVerificationId: true,
      status: state.account == null
          ? AuthViewStatus.unauthenticated
          : AuthViewStatus.authenticated,
    ));
  }

  // ---------------- Helpers ----------------

  Future<void> _performSensitive(
      Emitter<AuthState> emit, {
        required Future<void> Function() op,
        AuthState? onReauthRequired,
        void Function()? onSuccess,
      }) async {
    try {
      await op();
      onSuccess?.call();

      // GAP FIX (optional, improves UX): refresh account snapshot after success
      try {
        final fresh = await _repo.currentAccount();
        emit(AuthState.authenticated(fresh));
      } catch (_) {
        // Ignore; stream may update shortly
      }

      // Clear any pending op data since it succeeded
      emit(state.copyWith(
        clearPendingOp: true,
        clearPendingNewEmail: true,
        clearPendingNewPassword: true,
        clearPendingLinkEmail: true,
        clearPendingLinkPassword: true,
        clearRetryAfter: true,
        clearError: true,
      ));
    } on AuthFailure catch (f) {
      if (f is ReauthRequired && onReauthRequired != null) {
        emit(onReauthRequired);
        return;
      }
      if (f is TooManyRequests) {
        emit(AuthState.rateLimited(
          account: state.account,
          retryAfterSeconds: f.retryAfterSeconds,
        ));
        return;
      }
      emit(state.copyWith(status: AuthViewStatus.error, error: f.humanMessage));
    } catch (e) {
      emit(state.copyWith(status: AuthViewStatus.error, error: e.toString()));
    }
  }

  Future<void> _retryPendingOp(Emitter<AuthState> emit) async {
    final pending = state.pendingOp;
    if (pending == null) return;

    try {
      switch (pending) {
      case PendingSensitiveOp.updateEmail:
      final email = state.pendingNewEmail;
      if (email != null) await _repo.updateEmail(email);
      break;
      case PendingSensitiveOp.updatePassword:
      final pwd = state.pendingNewPassword;
      if (pwd != null) await _repo.updatePassword(pwd);
      break;
      case PendingSensitiveOp.linkEmailPassword:
      final e = state.pendingLinkEmail;
      final p = state.pendingLinkPassword;
      if (e != null && p != null) {
      await _repo.linkEmailPassword(email: e, password: p);
      }
      break;
      case PendingSensitiveOp.deleteAccount:
      await _repo.deleteAccount();
      emit(const AuthState.unauthenticated());
      break;
      }

      emit(state.copyWith(
        clearPendingOp: true,
        clearPendingNewEmail: true,
        clearPendingNewPassword: true,
        clearPendingLinkEmail: true,
        clearPendingLinkPassword: true,
        clearRetryAfter: true,
        clearError: true,
      ));
    } on AuthFailure catch (f) {
      if (f is TooManyRequests) {
        emit(AuthState.rateLimited(
          account: state.account,
          retryAfterSeconds: f.retryAfterSeconds,
        ));
        return;
      }
      emit(state.copyWith(status: AuthViewStatus.error, error: f.humanMessage));
    } catch (e) {
      emit(state.copyWith(status: AuthViewStatus.error, error: e.toString()));
    }
  }

  @override
  Future<void> close() async {
    await _sub?.cancel();
    return super.close();
  }
}
