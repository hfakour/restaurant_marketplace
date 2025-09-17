// features/auth/domain/repositories/auth_repository.dart
import 'package:restaurant_marketplace/features/profile/domain/entities/user_profile.dart';
import '../entities/auth_account.dart';

/// قرارداد لایه دامنه برای عملیات احراز هویت.
/// پیاده‌سازی (مثلاً Firebase, Supabase, …) باید تمام متدها را فراهم کند.
abstract class AuthRepository {
  /// استریم وضعیت ورود. وقتی کاربر ساین‌اوت است null می‌فرستد.
  Stream<AuthAccount?> authState();

  /// آخرین کاربر کش‌شده در مموری (اگر وجود داشته باشد).
  /// ممکن است null باشد وقتی ساین‌اوت هستیم یا هنوز لود نشده.
  AuthAccount? get currentUser;

  /// دریافت نسخه‌ی تازه و مطمئن از اکانت فعلی از بک‌اند/SDK.
  ///
  /// ⚠️ نکته‌ی مهم: اگر کاربری لاگین نباشد، این متد **خطا می‌اندازد**
  /// (مثلاً `AuthFailure.sessionExpired`). بنابراین مصرف‌کننده باید:
  ///   1) قبل از صدا زدن، `currentUser` را چک کند (اگر null بود، صدا نزند)، یا
  ///   2) این متد را داخل try/catch فراخوانی کند و خطا را مدیریت نماید.
  ///
  /// زمانی از این متد استفاده کنید که به داده‌ی به‌روز برای `emit` نیاز دارید
  /// (مثلاً پس از انجام عملیاتی که نیازمند `reload` است).
  Future<AuthAccount> currentAccount();

  Future<AuthAccount> registerWithEmail({
    required String firstName,
    required String lastName,
    required String phoneNumber,
    String? email, // optional
    required String password,
  });

  Future<AuthAccount> loginWithEmail({
    required String email,
    required String password,
  });

  Future<AuthAccount> loginAnonymous({
    required String firstName,
    required String lastName,
    required String phoneNumber,
  });

  /// لینک کردن ایمیل/پسورد روی یوزر فعلی (معمولاً anonymous).
  Future<void> linkEmailPassword({
    required String email,
    required String password,
  });

  Future<void> signOut();

  /// ایجاد/واکشی پروفایل تا تجربه auth -> profile یکپارچه باشد.
  Future<UserProfile> ensureUserProfile({
    required String uid,
    required String firstName,
    required String lastName,
    required String phoneNumber,
    String? email,
  });

  Future<void> resetPassword({required String email});

  /// ارسال ایمیل وریفیکیشن به کاربر فعلی (اگر سرویس پشتیبانی کند).
  Future<void> sendEmailVerification();

  /// ریلود کاربر از منبع (مثلاً FirebaseAuth.reload) و برگرداندن وضعیت وریفای ایمیل.
  /// true یعنی ایمیل کاربر الان verified است.
  Future<bool> reloadAndEmailVerified();

  /// ری‌اُثنتیکیشن با پسورد (برای عملیات حساس).
  Future<void> reauthenticateWithPassword(String email, String password);

  /// ری‌اُثنتیکیشن با Provider/OAuth (Google/Apple/Facebook/…).
  /// [providerId] مثل 'google.com'، 'apple.com'، 'facebook.com' و ...
  /// بسته به Provider، یکی از [idToken] یا [accessToken] (و در صورت نیاز [rawNonce]/[authCode]) را پاس بده.
  Future<void> reauthenticateWithProvider({
    required String providerId,
    String? idToken,
    String? accessToken,
    String? rawNonce,
    String? authCode,
  });

  // ---------------------- MFA (Phone as second factor) ----------------------

  /// شروع ثبت‌نام عامل دوم (SMS). مقدار بازگشتی `verificationId` است که
  /// باید همراه با کد دریافتی کاربر به `mfaFinalizeEnrollment` پاس داده شود.
  Future<String> mfaStartPhoneEnrollment(String phoneNumber);

  /// نهایی‌سازی ثبت‌نام MFA با `verificationId` و `smsCode`.
  /// (اختیاری) می‌توان `displayName` برای عامل دوم ثبت کرد.
  Future<void> mfaFinalizeEnrollment({
    required String verificationId,
    required String smsCode,
    String? displayName,
  });

  /// لغو ثبت‌نام عامل دوم با UID عامل (از `enrolledFactors` به‌دست می‌آید).
  Future<void> mfaUnenrollByUid(String factorUid);

  // ---------------------- MFA Sign-In Challenge ----------------------

  /// وقتی login با استثناء MFA متوقف می‌شود، این متد با شیء رزولور (opaque)
  /// و UID عامل انتخاب‌شده، SMS را ارسال می‌کند و `verificationId` برمی‌گرداند.
  Future<String> mfaStartSignInResolve(
      Object resolver, {
        required String factorUid,
      });

  /// نهایی‌سازی ورود چندمرحله‌ای با `verificationId` و `smsCode`.
  /// رزولور همان شیء opaque از مرحله‌ی قبل است.
  Future<AuthAccount> mfaFinalizeSignIn({
    required Object resolver,
    required String verificationId,
    required String smsCode,
  });

  // ---------------------- Sensitive Ops ----------------------

  Future<void> updateEmail(String newEmail);
  Future<void> updatePassword(String newPassword);
  Future<void> deleteAccount();
}
