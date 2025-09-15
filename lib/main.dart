import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_marketplace/firebase_options.dart';
import 'app.dart';
import 'injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  await configureDependencies();
  runApp(const ProviderScope(child: MyApp()));
}
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//
//   // DEV ONLY: force sign-out (and delete anon user) so AuthGate shows SignUp
//   final auth = FirebaseAuth.instance;
//   final u = auth.currentUser;
//   if (u != null) {
//     if (u.isAnonymous) {
//       await u.delete(); // no reauth needed for anon
//     } else {
//       await auth.signOut();
//     }
//   }
//
//   runApp(const ProviderScope(child: MyApp()));
// }