// lib/injection.dart
import 'package:get_it/get_it.dart';
import 'features/auth/di/auth_module.dart';

final GetIt getIt = GetIt.instance;

/// Single place the app calls to wire all feature modules.
/// Add other feature modules here as your app grows.
Future<void> configureDependencies() async {
  // Order matters only if modules depend on each other.
  print('[MAIN] DI wired. About to runApp.');
  registerAuthModule(getIt);
  print('[MAIN] DI wired. About to runApp.');
  // registerPaymentsModule(getIt);
  // registerRestaurantsModule(getIt);
}
