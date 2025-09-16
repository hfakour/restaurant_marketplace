// features/auth/presentation/screen/auth_gate.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth/auth_bloc.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  String? _lastTargetRoute;
  bool _navScheduled = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (prev, curr) => prev.status != curr.status,
      listener: (context, state) {
        switch (state.status) {
          case AuthViewStatus.loading:
          case AuthViewStatus.sendingEmailVerification:
          case AuthViewStatus.checkingEmailVerification:
          // در حال پردازش → همون صفحه لودینگ بمونه
            break;

          case AuthViewStatus.unauthenticated:
            _navigateTo('/login', clearStack: true);
            break;

          case AuthViewStatus.error:
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error ?? 'Auth error')),
            );
            _navigateTo('/login', clearStack: true);
            break;

          case AuthViewStatus.emailVerificationSent:
          // کاربر باید ایمیلش را تأیید کند
            _navigateTo('/verify-email', clearStack: true);
            break;

          case AuthViewStatus.authenticated:
          // کاربر وریفای شده یا پس از چک پاس شده → برو خانه
            _navigateTo('/home', clearStack: true);
            break;

          case AuthViewStatus.rateLimited:
          // ریت‌لیمیت: جایی نرو—فقط پیام بده تا UI زمان بده/دکمه‌ها disable بشن
            final secs = state.retryAfterSeconds;
            final msg = secs != null
                ? 'تلاش‌های زیاد. لطفاً $secs ثانیه صبر کنید.'
                : 'تلاش‌های زیاد. لطفاً کمی بعد دوباره تلاش کنید.';
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
            break;
        }
      },
      child: const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
    );
  }

  void _navigateTo(String targetRoute, {bool clearStack = false}) {
    // Debounce: اگر همین مقصد اخیراً برنامه‌ریزی شده، رد شو
    if (_navScheduled && _lastTargetRoute == targetRoute) return;
    _navScheduled = true;
    _lastTargetRoute = targetRoute;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _navScheduled = false;
      if (!context.mounted) return;

      final current = ModalRoute.of(context)?.settings.name;
      if (current == targetRoute) return;

      if (clearStack) {
        Navigator.of(context).pushNamedAndRemoveUntil(targetRoute, (r) => false);
      } else {
        Navigator.of(context).pushReplacementNamed(targetRoute);
      }
    });
  }
}
