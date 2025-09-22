// features/auth/presentation/screen/auth_gate.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app.dart';
import '../../../../injection.dart';
import '../../presentation/screen/mfa_code_page.dart';
import '../../presentation/screen/mfa_factors_page.dart';
import '../../presentation/screen/verify_email_page.dart';
import '../bloc/auth/auth_bloc.dart';
import '../bloc/login/login_bloc.dart';
import '../screen/login_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      buildWhen: (p, c) =>
          p.status != c.status || p.account?.id != c.account?.id,
      builder: (context, state) {
        switch (state.status) {
          case AuthViewStatus.loading:
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );

          case AuthViewStatus.unauthenticated:
          case AuthViewStatus.error:
            // Provide LoginBloc locally
            return BlocProvider(
              create: (_) => getIt<LoginBloc>(),
              child: const LoginPage(),
            );

          case AuthViewStatus.authenticated:
            return const DemoPage();

          case AuthViewStatus.mfaRequired:
            return const MfaFactorsPage();

          case AuthViewStatus.mfaCodeSent:
            return const MfaCodePage();

          case AuthViewStatus.sendingEmailVerification:
          case AuthViewStatus.emailVerificationSent:
          case AuthViewStatus.checkingEmailVerification:
            return const VerifyEmailPage();

          case AuthViewStatus.rateLimited:
            // Show a minimal info + keep user on login/profile depending on account
            final msg = state.retryAfterSeconds != null
                ? 'Too many attempts. Please wait ${state.retryAfterSeconds} seconds.'
                : 'Too many attempts. Please try again soon.';
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CircularProgressIndicator(),
                    const SizedBox(height: 12),
                    Text(msg),
                  ],
                ),
              ),
            );
        }
      },
    );
  }
}
