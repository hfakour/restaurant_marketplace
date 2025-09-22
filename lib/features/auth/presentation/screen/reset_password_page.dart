import 'package:flutter/material.dart';
import 'package:restaurant_marketplace/features/auth/domain/extensions/auth_failure_ext.dart';
import 'package:restaurant_marketplace/injection.dart';
import '../../domain/usecase/reset_password.dart';

/// A simple page that allows users to request a password reset email.
///
/// This page does not use a Bloc because the flow is straightforward: the
/// underlying [ResetPasswordUseCase] never throws and returns a result
/// wrapper. It displays inline feedback and disables controls while the
/// request is in flight.
class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _form = GlobalKey<FormState>();
  final _email = TextEditingController();
  bool _busy = false;
  String? _feedback;

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!(_form.currentState?.validate() ?? false)) return;
    setState(() {
      _busy = true;
      _feedback = null;
    });
    final useCase = getIt<ResetPasswordUseCase>();
    final result = await useCase.call(email: _email.text.trim());
    if (!mounted) return;
    if (result.isSuccess) {
      setState(() {
        _busy = false;
        _feedback = 'If the email exists, a reset link has been sent.';
      });
    } else {
      setState(() {
        _busy = false;
        _feedback = result.failure?.humanMessage ?? 'Failed to send reset email.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reset Password')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _form,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Reset your password',
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
                      final emailRegExp = RegExp(r'^[^@]+@[^@]+\.[^@]+\$');
                      if (!emailRegExp.hasMatch(s)) return 'Enter a valid email';
                      return null;
                    },
                    enabled: !_busy,
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: _busy ? null : _submit,
                      child: _busy
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Text('Send reset link'),
                    ),
                  ),
                  const SizedBox(height: 12),
                  if (_feedback != null)
                    Text(
                      _feedback!,
                      style: TextStyle(color: Theme.of(context).colorScheme.primary),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}