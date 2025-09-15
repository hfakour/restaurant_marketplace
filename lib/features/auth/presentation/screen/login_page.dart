import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/login/login_bloc.dart';

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

  void _submit(BuildContext context) {
    if (!(_form.currentState?.validate() ?? false)) return;
    context.read<LoginBloc>().add(LoginSubmitted(_email.text.trim(), _pwd.text));
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
              listenWhen: (p, c) => p.status != c.status,
              listener: (context, state) {
                if (state.status == LoginStatus.failure && state.error != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.error!)),
                  );
                }
              },
              builder: (context, state) {
                final busy = state.status == LoginStatus.submitting;
                return Form(
                  key: _form,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Welcome back', style: Theme.of(context).textTheme.headlineSmall),
                      const SizedBox(height: 24),
                      TextFormField(
                        controller: _email,
                        decoration: const InputDecoration(labelText: 'Email'),
                        keyboardType: TextInputType.emailAddress,
                        validator: (v) {
                          final s = (v ?? '').trim();
                          if (s.isEmpty) return 'Email is required';
                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+$').hasMatch(s)) return 'Enter a valid email';
                          return null;
                        },
                        enabled: !busy,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _pwd,
                        decoration: const InputDecoration(labelText: 'Password'),
                        obscureText: true,
                        validator: (v) {
                          final s = v ?? '';
                          if (s.length < 8) return 'Password must be at least 8 characters';
                          return null;
                        },
                        enabled: !busy,
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                          onPressed: busy ? null : () => _submit(context),
                          child: busy
                              ? const SizedBox(
                              height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                              : const Text('Sign in'),
                        ),
                      ),
                      if (state.status == LoginStatus.failure && state.error != null) ...[
                        const SizedBox(height: 12),
                        Text(state.error!, style: TextStyle(color: Theme.of(context).colorScheme.error)),
                      ],
                      const SizedBox(height: 12),
                      TextButton(
                        onPressed: busy ? null : () => Navigator.of(context).pushNamed('/signup'),
                        child: const Text('Create an account'),
                      ),
                      TextButton(
                        onPressed: busy ? null : () => Navigator.of(context).pushNamed('/reset-password'),
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
