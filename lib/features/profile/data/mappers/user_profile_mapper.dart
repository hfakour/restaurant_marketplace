// lib/features/profile/data/mappers/user_profile_mapper.dart
import '../../../address/domain/entities/refs/address_ref.dart';
import '../../../reservations/domain/entities/refs/reservation_ref.dart';
import '../../../wallet/domain/entities/refs/payment_method_ref.dart';
import '../../../wallet/domain/entities/refs/wallet_ref.dart';
import '../../domain/entities/user_profile.dart';
import '../models/user_profile_dto.dart';


extension UserProfileDtoMapper on UserProfileDto {
  UserProfile toDomain() {
    final created = createdAtIso != null ? DateTime.parse(createdAtIso!) : null;
    final updated = updatedAtIso != null ? DateTime.parse(updatedAtIso!) : null;

    return UserProfile(
      id: id,

      // identity
      firstName: firstName,
      lastName: lastName,
      email: email,
      contactNumber: contactNumber,
      avatarUrl: avatarUrl,

      // 🔧 Refs: use NAMED parameters (match your Ref classes)
      addressRefs: addressIds
          .map((e) => AddressRef(addressId: e)) // was AddressRef(e)
          .toList(),
      walletRef: walletId != null
          ? WalletRef(
        walletId: walletId!, // was WalletRef(walletId!, ...)
        // include snapshot fields only if your WalletRef supports them:
        // balanceSnapshot: walletBalanceSnapshot?.toDouble(),
        // currencyCode: walletCurrencyCode,
        // snapshotAt: walletSnapshotAtIso != null
        //     ? DateTime.parse(walletSnapshotAtIso!)
        //     : null,
      )
          : null,
      reservationRefs: reservationIds
          .map((e) => ReservationRef(reservationId: e)) // was ReservationRef(e)
          .toList(),
      paymentMethodRefs: paymentMethodIds
          .map((e) => PaymentMethodRef(paymentMethodId: e)) // was PaymentMethodRef(e)
          .toList(),

      // flags
      isEmailVerified: isEmailVerified,
      isPhoneVerified: isPhoneVerified,

      // auditing
      createdAt: created,
      updatedAt: updated,

      roleMetadata: roleMetadata,
    );
  }
}
