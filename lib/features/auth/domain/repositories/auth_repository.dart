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
  /// وقتی به داده‌ی به‌روز برای emit نیاز داریم از این استفاده می‌کنیم.
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

  /// عملیات حساس
  Future<void> updateEmail(String newEmail);
  Future<void> updatePassword(String newPassword);
  Future<void> deleteAccount();
}
