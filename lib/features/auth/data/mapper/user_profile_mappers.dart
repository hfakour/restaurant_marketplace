// lib/features/auth/data/mapper/user_profile_mappers.dart
import 'package:cloud_firestore/cloud_firestore.dart' as fs;
import 'package:restaurant_marketplace/features/profile/domain/entities/user_profile.dart';

import '../../../address/domain/entities/refs/address_ref.dart';
import '../../../discount/domain/entities/refs/discount_ref.dart';
import '../../../favorite/domain/entities/refs/favorite_ref.dart';
import '../../../order/domain/entities/refs/order_ref.dart';
import '../../../reservations/domain/entities/refs/reservation_ref.dart';
import '../../../wallet/domain/entities/refs/payment_method_ref.dart';

/// Minimal write payload for Firestore during auth/signup.
/// We intentionally keep this payload small; cross-feature references are owned by their features.
Map<String, dynamic> userProfileToFirestore(UserProfile p) => {
  'id': p.id,
  'firstName': p.firstName,
  'lastName': p.lastName,
  'contactNumber': p.contactNumber,
  'email': p.email,
  'avatarUrl': p.avatarUrl,
  // Cross-feature refs: initialize as empty; features will manage/rehydrate.
  'addressRefs': <Map<String, dynamic>>[],
  'walletRef': null,
  'reservationRefs': <Map<String, dynamic>>[],
  'paymentMethodRefs': <Map<String, dynamic>>[],
  'orderRefs': <Map<String, dynamic>>[],
  'favoriteRefs': <Map<String, dynamic>>[],
  'discountRefs': <Map<String, dynamic>>[],
  'isEmailVerified': p.isEmailVerified,
  'isPhoneVerified': p.isPhoneVerified,
  // Firestore will convert DateTime to Timestamp on write.
  'createdAt': p.createdAt,
  'updatedAt': p.updatedAt,
  'roleMetadata': p.roleMetadata,
};

/// Minimal read mapping; returns a fully-typed entity with safe defaults.
/// Feature modules can rehydrate strongly-typed refs later.
UserProfile firestoreToUserProfile(Map<String, dynamic> json) => UserProfile(
  id: json['id'] as String,
  firstName: json['firstName'] as String? ?? '',
  lastName: json['lastName'] as String? ?? '',
  contactNumber: json['contactNumber'] as String? ?? '',
  email: json['email'] as String?,
  avatarUrl: json['avatarUrl'] as String?,
  addressRefs: const <AddressRef>[],
  walletRef: null,
  reservationRefs: const <ReservationRef>[],
  paymentMethodRefs: const <PaymentMethodRef>[],
  orderRefs: const <OrderRef>[],
  favoriteRefs: const <FavoriteRef>[],
  discountRefs: const <DiscountRef>[],
  isEmailVerified: (json['isEmailVerified'] as bool?) ?? false,
  isPhoneVerified: (json['isPhoneVerified'] as bool?) ?? false,
  // Normalize to UTC to avoid mixed local/server timezones.
  createdAt: json['createdAt'] is fs.Timestamp
      ? (json['createdAt'] as fs.Timestamp).toDate().toUtc()
      : json['createdAt'] is DateTime
      ? (json['createdAt'] as DateTime).toUtc()
      : null,
  updatedAt: json['updatedAt'] is fs.Timestamp
      ? (json['updatedAt'] as fs.Timestamp).toDate().toUtc()
      : json['updatedAt'] is DateTime
      ? (json['updatedAt'] as DateTime).toUtc()
      : null,
  roleMetadata: (json['roleMetadata'] as Map<String, dynamic>?) ?? const {},
);
