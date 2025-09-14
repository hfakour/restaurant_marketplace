import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/usecase/login_with_email.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});
  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _form = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _pwd = TextEditingController();
  bool _busy = false;
  String? _error;

  @override
  void dispose() { _email.dispose(); _pwd.dispose(); super.dispose(); }

  Future<void> _submit() async {
    if (!(_form.currentState?.validate() ?? false)) return;
    setState(() { _busy = true; _error = null; });
    try {
      await ref.read(loginWithEmailUC).call(email: _email.text.trim(), password: _pwd.text);
      // AuthGate will switch to DemoPage.
    } catch (_) {
      setState(() => _error = 'Invalid email or password.');
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  String? _vEmail(String? v) {
    final s = v?.trim() ?? '';
    if (s.isEmpty) return 'Email required';
    final r = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
    if (!r.hasMatch(s)) return 'Enter a valid email';
    return null;
  }

  String? _vPwd(String? v) => (v ?? '').length < 8 ? 'At least 8 characters' : null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign in')),
      body: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Form(
              key: _form,
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                if (_error != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Text(_error!, style: TextStyle(color: Theme.of(context).colorScheme.error)),
                  ),
                TextFormField(
                  controller: _email,
                  decoration: const InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                  validator: _vEmail,
                  enabled: !_busy,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _pwd,
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  validator: _vPwd,
                  enabled: !_busy,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: _busy ? null : _submit,
                    child: _busy ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                        : const Text('Sign in'),
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
