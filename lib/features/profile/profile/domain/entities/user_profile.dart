// domain/entities/user_profile.dart
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../address/domain/entities/refs/address_ref.dart';
import '../../../../reservations/domain/entities/refs/reservation_ref.dart';
import '../../../../wallet/domain/entities/refs/payment_method_ref.dart';
import '../../../../wallet/domain/entities/refs/wallet_ref.dart';

part 'user_profile.freezed.dart';

enum UserRole { customer, restaurantOwner, deliveryPerson }

@freezed
class UserProfile with _$UserProfile {
  const factory UserProfile({
    required String id,
    @Default(<UserRole>{}) Set<UserRole> roles,

    // Identity
    required String firstName,
    required String lastName,
    required String email,
    required String contactNumber,

    // Media
    String? avatarUrl,

    // Cross-feature refs
    @Default(<AddressRef>[]) List<AddressRef> addressRefs,
    WalletRef? walletRef,
    @Default(<ReservationRef>[]) List<ReservationRef> reservationRefs,
    @Default(<PaymentMethodRef>[]) List<PaymentMethodRef> paymentMethodRefs,

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
