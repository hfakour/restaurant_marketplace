// features/auth/domain/extensions/auth_failure_x.dart
import '../entities/auth_failures.dart';

extension AuthFailureX on AuthFailure {
  String get humanMessage => when(
    invalidCredentials: () => 'ایمیل یا رمز عبور نادرست است.',
    userDisabled: () => 'حساب شما غیرفعال شده است.',
    tokenExpired: () => 'نشست شما منقضی شده است. دوباره وارد شوید.',
    networkIssue: () => 'اتصال اینترنت برقرار نیست. لطفاً دوباره تلاش کنید.',
    serverIssue: (code) =>
    'خطای سرور${code != null ? ' ($code)' : ''}. لطفاً بعداً تلاش کنید.',
    unknown: (msg) => msg ?? 'یک خطای نامشخص رخ داد.',
    emailNotVerified: () =>
    'ایمیل‌تان تأیید نشده. ایمیل تأیید را چک کنید.',
    reauthRequired: () =>
    'برای ادامه، لازم است دوباره وارد شوید.',
    tooManyRequests: (s) => s != null
        ? 'تعداد تلاش‌ها زیاد شد. لطفاً ${s} ثانیه صبر کنید.'
        : 'تعداد تلاش‌ها زیاد شد. لطفاً بعداً دوباره امتحان کنید.',

    // 👇 اضافه‌های جدید
    emailAlreadyInUse: () => 'این ایمیل قبلاً استفاده شده است.',
    providerAlreadyLinked: () =>
    'این روش ورود قبلاً به حساب شما متصل شده است.',
    invalidOtp: () => 'کد تأیید واردشده معتبر نیست.',
    sessionExpired: () =>
    'نشست شما منقضی شده است. لطفاً دوباره وارد شوید.',
  );
}
