import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/auth/auth_bloc.dart';

/// Page for entering the SMS code during multi-factor authentication (MFA).
///
/// Once the user selects a factor, [AuthBloc] transitions to the
/// [AuthViewStatus.mfaCodeSent] state and provides the [mfaVerificationId]
/// and [mfaResolver]. This page collects the one-time code and dispatches
/// [MfaCodeSubmitted] when submitted. It also allows cancellation of the
/// MFA flow via [MfaCancelRequested].
class MfaCodePage extends StatefulWidget {
  const MfaCodePage({super.key});
  @override
  State<MfaCodePage> createState() => _MfaCodePageState();
}

class _MfaCodePageState extends State<MfaCodePage> {
  final _form = GlobalKey<FormState>();
  final _codeController = TextEditingController();
  bool _busy = false;

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  void _submit(AuthBloc bloc, Object resolver, String verificationId) {
    if (!(_form.currentState?.validate() ?? false)) return;
    setState(() => _busy = true);
    bloc.add(MfaCodeSubmitted(
      resolver: resolver,
      verificationId: verificationId,
      smsCode: _codeController.text.trim(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Enter MFA Code')),
      body: BlocConsumer<AuthBloc, AuthState>(
        listenWhen: (prev, curr) => prev.status != curr.status || prev.error != curr.error,
        listener: (context, state) {
          // Reset busy flag when the status changes from submitting.
          if (_busy && state.status != AuthViewStatus.checkingEmailVerification) {
            setState(() => _busy = false);
          }
          if (state.error != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error!)),
            );
          }
        },
        builder: (context, state) {
          if (state.status != AuthViewStatus.mfaCodeSent) {
            return const Center(child: Text('No MFA code requested.'));
          }
          final resolver = state.mfaResolver;
          final verificationId = state.mfaVerificationId;
          if (resolver == null || verificationId == null) {
            return const Center(child: Text('Invalid MFA session.'));
          }
          final bloc = context.read<AuthBloc>();
          return Padding(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _form,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Enter the SMS code sent to your phone',
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: _codeController,
                    decoration: const InputDecoration(labelText: 'Verification code'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      final s = (value ?? '').trim();
                      if (s.isEmpty) return 'Code is required';
                      return null;
                    },
                    enabled: !_busy,
                  ),
                    const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: _busy
                          ? null
                          : () => _submit(bloc, resolver, verificationId),
                      child: _busy
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Text('Verify'),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: _busy
                        ? null
                        : () => context
                            .read<AuthBloc>()
                            .add(const MfaCancelRequested()),
                    child: const Text('Cancel'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}