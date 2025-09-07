// domain/entities/user_profile.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:restaurant_marketplace/core/domain_refs/domain_refs.dart';

part 'user_profile.freezed.dart';

@freezed
class UserProfile with _$UserProfile {
  const factory UserProfile({
    required String id,

    // Identity
    required String firstName,
    required String lastName,
    String? email,
    required String contactNumber,

    // Media
    String? avatarUrl,

    // Cross-feature refs
    @Default(<AddressRef>[]) List<AddressRef> addressRefs,
    WalletRef? walletRef,
    @Default(<ReservationRef>[]) List<ReservationRef> reservationRefs,
    @Default(<PaymentMethodRef>[]) List<PaymentMethodRef> paymentMethodRefs,

    // NEW: Orders the user has placed (lightweight snapshots)
    @Default(<OrderRef>[]) List<OrderRef> orderRefs,

    // NEW: Things the user has favorited
    @Default(<FavoriteRef>[]) List<FavoriteRef> favoriteRefs,

    // NEW: Discounts/coupons associated to or last applied by the user
    // (e.g., per-user codes, recently used, or saved for checkout)
    @Default(<DiscountRef>[]) List<DiscountRef> discountRefs,

    // Verification flags
    @Default(false) bool isEmailVerified,
    @Default(false) bool isPhoneVerified,

    // Auditing
    DateTime? createdAt,
    DateTime? updatedAt,

    // Role-specific extra data (safe by design)
    @Default(<String, dynamic>{}) Map<String, dynamic> roleMetadata,
  }) = _UserProfile;
}
