// features/auth/presentation/screen/auth_gate.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth/auth_bloc.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (p, c) => p.status != c.status,
      listener: (context, state) {
        if (state.status == AuthViewStatus.unauthenticated) {
          _replace(context, '/login');
        } else if (state.status == AuthViewStatus.authenticated) {
          _replace(context, '/home');
        } else if (state.status == AuthViewStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error ?? 'Auth error')),
          );
          _replace(context, '/login');
        }
      },
      child: const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
    );
  }

  void _replace(BuildContext ctx, String route) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final current = ModalRoute.of(ctx)?.settings.name;
      if (current != route) {
        Navigator.of(ctx).pushNamedAndRemoveUntil(route, (r) => false);
      }
    });
  }
}
