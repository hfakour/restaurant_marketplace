// auth/di/auth_module.dart
import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

// DATA
import '../data/datasource/auth_remote_ds.dart';
import '../data/repository/auth_repository_impl.dart';

// DOMAIN
import '../domain/repositories/auth_repository.dart';
import '../domain/usecase/login_with_email.dart';
import '../domain/usecase/register_with_email.dart';
import '../domain/usecase/reset_password.dart';
import '../domain/usecase/send_email_verification.dart';

// PRESENTATION
import '../presentation/bloc/auth/auth_bloc.dart';
import '../presentation/bloc/login/login_bloc.dart';
import '../presentation/bloc/signup/signup_bloc.dart';

// (اختیاری) اگر می‌خواهی مپِرها را صراحتاً تزریق کنی:
// import '../data/mapper/auth_mappers.dart' as mappers;
// import '../data/mapper/auth_error_mapper.dart' as errors;

void registerAuthModule(GetIt sl) {
  // توصیهٔ مهم: قبل از رجیستر ماژول‌های Auth در اپ میزبان انجام بده:
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();

  // اگر Firebase.initializeApp() فراخوانی نشده باشد، این assertion کمک می‌کند زودتر متوجه شویم.
  assert(
  Firebase.apps.isNotEmpty,
  'Firebase.initializeApp() must be called before registerAuthModule()',
  );

  if (sl.isRegistered<AuthRepository>()) return;

  // 1) Firebase SDKs
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);

  // 2) DataSource
  sl.registerLazySingleton<AuthRemoteDataSource>(
        () => AuthRemoteDataSource(sl<FirebaseAuth>(), sl<FirebaseFirestore>()),
  );

  // 3) Repository — با fallbackهای داخل خود کلاس
  sl.registerLazySingleton<AuthRepository>(
        () => AuthRepositoryImpl(
      sl<AuthRemoteDataSource>(),
      // در صورت نیاز به مپِر سفارشی:
      // userMapper: mappers.authAccountFromFirebaseUser,
      // errorMapper: errors.mapFirebaseAuthException,
    ),
  );

  // 4) UseCases
  sl.registerFactory<LoginWithEmailUseCase>(
        () => LoginWithEmailUseCase(sl<AuthRepository>()),
  );
  sl.registerFactory<RegisterWithEmailUseCase>(
        () => RegisterWithEmailUseCase(sl<AuthRepository>()),
  );
  sl.registerFactory<ResetPasswordUseCase>(
        () => ResetPasswordUseCase(sl<AuthRepository>()),
  );
  sl.registerFactory<SendEmailVerificationUseCase>(
        () => SendEmailVerificationUseCase(sl<AuthRepository>()),
  );

  // 5) Blocs
  //
  // اگر طول‌عمر اپلیکیشنی برای AuthBloc می‌خواهی (یک استریم مشترک برای کل اپ)،
  // آن را singleton ثبت کن. حتماً dispose هم بده تا روی reset() آزاد شود.
  sl.registerSingleton<AuthBloc>(
    AuthBloc(sl<AuthRepository>()),
    dispose: (b) => b.close(),
  );

  // LoginBloc نیاز دارد AuthBloc را برای handoff رویداد MFA دریافت کند.
  sl.registerFactory<LoginBloc>(
        () => LoginBloc(
      sl<LoginWithEmailUseCase>(),
      sl<AuthBloc>(), // inject AuthBloc for MfaRequiredDiscovered dispatch
    ),
  );

  // SignUpBloc (در صورت افزودن cooldown نیازی به وابستگی اضافه ندارد)
  sl.registerFactory<SignUpBloc>(
        () => SignUpBloc(sl<RegisterWithEmailUseCase>()),
  );
}
