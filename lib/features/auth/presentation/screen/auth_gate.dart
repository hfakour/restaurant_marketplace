import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:restaurant_marketplace/app.dart';
import 'signup_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // Loading state
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // Signed-in -> show your main app
        final user = snapshot.data;
        if (user != null) {
          return const DemoPage();
        }

        // Not signed-in -> show SignUp first
        return const SignUpPage();
      },
    );
  }
}
