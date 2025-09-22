import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_marketplace/firebase_options.dart';
import 'app.dart';
import 'injection.dart';

void main() async {
  debugPrint = (msg, {wrapWidth}) => print(msg);

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  print('[MAIN] Firebase apps: ${Firebase.apps.map((a) => a.name).toList()}');
  print('[MAIN] FirebaseAuth currentUser: ${FirebaseAuth.instance.currentUser?.uid ?? 'null'}');
  await configureDependencies();
  runApp(const ProviderScope(child: MyApp()));
}

