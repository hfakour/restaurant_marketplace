import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  if (sl.isRegistered<AuthRepository>()) return;

  // 1) Firebase SDKs اول رجیستر شوند
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);

  // 2) DataSource فقط یکبار
  sl.registerLazySingleton<AuthRemoteDataSource>(
        () => AuthRemoteDataSource(sl<FirebaseAuth>(), sl<FirebaseFirestore>()),
  );

  // 3) Repository — با fallbackهای داخل خود کلاس
  sl.registerLazySingleton<AuthRepository>(
        () => AuthRepositoryImpl(
      sl<AuthRemoteDataSource>(),
      // اگر بخواهی مپِر سفارشی تزریق کنی، این کامنت را باز کن:
      // userMapper: mappers.authAccountFromFirebaseUser,
      // errorMapper: errors.mapFirebaseAuthException,
    ),
  );

  // 4) UseCases
  sl.registerFactory<LoginWithEmailUseCase>(() => LoginWithEmailUseCase(sl<AuthRepository>()));
  sl.registerFactory<RegisterWithEmailUseCase>(() => RegisterWithEmailUseCase(sl<AuthRepository>()));
  sl.registerFactory<ResetPasswordUseCase>(() => ResetPasswordUseCase(sl<AuthRepository>()));
  sl.registerFactory<SendEmailVerificationUseCase>(() => SendEmailVerificationUseCase(sl<AuthRepository>()));

  // 5) Blocs
  sl.registerFactory<AuthBloc>(() => AuthBloc(sl<AuthRepository>()));
  sl.registerFactory<LoginBloc>(() => LoginBloc(sl<LoginWithEmailUseCase>()));
  sl.registerFactory<SignUpBloc>(() => SignUpBloc(sl<RegisterWithEmailUseCase>()));
}
