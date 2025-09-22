import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/auth/auth_bloc.dart';

/// Page shown after a user signs up or requests email verification.
///
/// This page allows the user to resend a verification email and to check
/// whether their email has been verified. Upon successful verification
/// the [AuthGate] will automatically navigate to the authenticated shell.
class VerifyEmailPage extends StatelessWidget {
  const VerifyEmailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verify Email')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: BlocConsumer<AuthBloc, AuthState>(
              listenWhen: (prev, curr) => prev.error != curr.error,
              listener: (context, state) {
                if (state.error != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.error!)),
                  );
                }
              },
              builder: (context, state) {
                final busy = state.status == AuthViewStatus.sendingEmailVerification ||
                    state.status == AuthViewStatus.checkingEmailVerification;
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Please verify your email',
                      style: Theme.of(context).textTheme.headlineSmall,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'We have sent a verification link to your email address.\n'
                      'Please open it and follow the instructions.\n'
                      'After verifying, return to the app and tap "I verified my email".',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: busy
                            ? null
                            : () => context
                                .read<AuthBloc>()
                                .add(const SendEmailVerificationRequested()),
                        child: busy && state.status == AuthViewStatus.sendingEmailVerification
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              )
                            : const Text('Resend verification email'),
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: busy
                            ? null
                            : () => context
                                .read<AuthBloc>()
                                .add(const CheckEmailVerificationRequested()),
                        child: busy && state.status == AuthViewStatus.checkingEmailVerification
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              )
                            : const Text('I verified my email'),
                      ),
                    ),
                    const SizedBox(height: 24),
                    TextButton(
                      onPressed: busy
                          ? null
                          : () => context
                              .read<AuthBloc>()
                              .add(const SignOutRequested()),
                      child: const Text('Sign out'),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}