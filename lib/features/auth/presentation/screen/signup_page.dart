import 'package:email_validator/email_validator.dart'; // Import email validator
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/signup/signup_bloc.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _form = GlobalKey<FormState>();
  final _first = TextEditingController();
  final _last = TextEditingController();
  final _phone = TextEditingController();
  final _email = TextEditingController(); // optional if your domain allows null
  final _pwd = TextEditingController();

  @override
  void dispose() {
    _first.dispose();
    _last.dispose();
    _phone.dispose();
    _email.dispose();
    _pwd.dispose();
    super.dispose();
  }

  void _submit(BuildContext context) {
    if (!(_form.currentState?.validate() ?? false)) return;
    context.read<SignUpBloc>().add(SignUpSubmitted(
      firstName: _first.text.trim(),
      lastName: _last.text.trim(),
      phone: _phone.text.trim(),
      email: _email.text.trim().isEmpty ? null : _email.text.trim(),
      password: _pwd.text,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: BlocConsumer<SignUpBloc, SignUpState>(
              listenWhen: (p, c) => p.status != c.status,
              listener: (context, state) {
                if (state.status == SignUpStatus.success) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Account created! You are now signed in.')),
                  );
                  Navigator.of(context).pop(); // go back; AuthGate will open the app shell
                } else if (state.status == SignUpStatus.failure && state.error != null) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error!)));
                }
              },
              builder: (context, state) {
                final busy = state.status == SignUpStatus.submitting;
                return Form(
                  key: _form,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Create your account', style: Theme.of(context).textTheme.headlineSmall),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _first,
                              decoration: const InputDecoration(labelText: 'First name'),
                              validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
                              enabled: !busy,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: TextFormField(
                              controller: _last,
                              decoration: const InputDecoration(labelText: 'Last name'),
                              validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
                              enabled: !busy,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _phone,
                        decoration: const InputDecoration(labelText: 'Phone number'),
                        keyboardType: TextInputType.phone,
                        validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
                        enabled: !busy,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _email,
                        decoration: const InputDecoration(labelText: 'Email (optional)'),
                        keyboardType: TextInputType.emailAddress,
                        validator: (v) {
                          final s = (v ?? '').trim();
                          if (s.isEmpty) return null; // optional
                          if (!EmailValidator.validate(s)) return 'Enter a valid email'; // Using email_validator package
                          return null;
                        },
                        enabled: !busy,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _pwd,
                        decoration: const InputDecoration(labelText: 'Password'),
                        obscureText: true,
                        validator: (v) => (v ?? '').length < 8 ? 'At least 8 characters' : null,
                        enabled: !busy,
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                          onPressed: busy ? null : () => _submit(context),
                          child: busy
                              ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                              : const Text('Create account'),
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextButton(
                        onPressed: busy ? null : () => Navigator.of(context).pop(),
                        child: const Text('Already have an account? Sign in'),
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
