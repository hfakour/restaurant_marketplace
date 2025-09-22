import 'package:email_validator/email_validator.dart';  // Email validator package
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/login/login_bloc.dart';

/// A sign in page for existing users.
///
/// This widget exposes a simple form for email and password entry and
/// dispatches a [LoginSubmitted] event to the injected [LoginBloc] when the
/// user taps the sign in button. The UI listens to [LoginState] changes to
/// provide feedback such as disabling controls while a submission is in
/// progress, showing error messages on failures, and respecting rate limits.
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _form = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _pwd = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _pwd.dispose();
    super.dispose();
  }

  /// Validate inputs and dispatch a [LoginSubmitted] event.
  void _submit(BuildContext context) {
    if (!(_form.currentState?.validate() ?? false)) return;
    context.read<LoginBloc>().add(LoginSubmitted(
      email: _email.text.trim(),
      password: _pwd.text,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: BlocConsumer<LoginBloc, LoginState>(
              listenWhen: (previous, current) =>
              previous.status != current.status || previous.message != current.message,
              listener: (context, state) {
                // Display server-provided error messages when available.
                if ((state.status == LoginStatus.failure || state.status == LoginStatus.cooldown) &&
                    state.message != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message!)),
                  );
                }

                // Navigate on success
                if (state.status == LoginStatus.success) {
                  Navigator.of(context).pushReplacementNamed('/home');
                }
              },
              builder: (context, state) {
                final busy = state.status == LoginStatus.submitting;
                final onCooldown = state.status == LoginStatus.cooldown;
                final secs = state.cooldownSeconds;
                return Form(
                  key: _form,
                  autovalidateMode: AutovalidateMode.onUserInteraction,  // Validate on user interaction
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Welcome back',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 24),
                      TextFormField(
                        controller: _email,
                        decoration: const InputDecoration(labelText: 'Email'),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          final s = (value ?? '').trim();
                          if (s.isEmpty) return 'Email is required';
                          if (!EmailValidator.validate(s)) return 'Enter a valid email';
                          return null;
                        },
                        enabled: !busy && !onCooldown,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _pwd,
                        decoration: const InputDecoration(labelText: 'Password'),
                        obscureText: true,
                        validator: (value) {
                          final s = value ?? '';
                          if (s.length < 8) return 'Password must be at least 8 characters';
                          return null;
                        },
                        enabled: !busy && !onCooldown,
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                          onPressed: (busy || onCooldown) ? null : () => _submit(context),
                          child: busy
                              ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                              : const Text('Sign in'),
                        ),
                      ),
                      // Show rate-limit countdown if provided.
                      if (onCooldown && secs != null) ...[
                        const SizedBox(height: 12),
                        Text(
                          'Please wait $secs seconds before retrying.',
                          style: TextStyle(color: Theme.of(context).colorScheme.error),
                        ),
                      ],
                      // Show failure message inline if provided.
                      if (state.status == LoginStatus.failure && state.message != null) ...[
                        const SizedBox(height: 12),
                        Text(
                          state.message!,
                          style: TextStyle(color: Theme.of(context).colorScheme.error),
                        ),
                      ],
                      const SizedBox(height: 12),
                      TextButton(
                        onPressed:
                        (busy || onCooldown) ? null : () => Navigator.of(context).pushNamed('/signup'),
                        child: const Text('Create an account'),
                      ),
                      TextButton(
                        onPressed: (busy || onCooldown)
                            ? null
                            : () => Navigator.of(context).pushNamed('/reset-password'),
                        child: const Text('Forgot password?'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
