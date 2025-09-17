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
/// ما عمداً فقط داده‌های پایه رو ذخیره می‌کنیم؛ ریفرنس‌های پیچیده (آدرس، سفارش، ...) توسط فیچر خودشون مدیریت می‌شن.
Map<String, dynamic> userProfileToFirestore(UserProfile p) => {
  'id': p.id,
  'firstName': p.firstName,
  'lastName': p.lastName,
  'contactNumber': p.contactNumber,
  'email': p.email,
  'avatarUrl': p.avatarUrl,
  // Write empty arrays for cross-feature refs — managed later by each feature
  'addressRefs': <Map<String, dynamic>>[],
  'walletRef': null,
  'reservationRefs': <Map<String, dynamic>>[],
  'paymentMethodRefs': <Map<String, dynamic>>[],
  'orderRefs': <Map<String, dynamic>>[],
  'favoriteRefs': <Map<String, dynamic>>[],
  'discountRefs': <Map<String, dynamic>>[],
  'isEmailVerified': p.isEmailVerified,
  'isPhoneVerified': p.isPhoneVerified,
  // هنگام نوشتن می‌تونی DateTime بذاری؛ Firestore خودش به Timestamp تبدیل می‌کنه.
  'createdAt': p.createdAt,
  'updatedAt': p.updatedAt,
  'roleMetadata': p.roleMetadata,
};

/// Minimal read mapping; returns the entity with typed empty lists so callers
/// don’t have to null-check. Feature modules can rehydrate refs later.
UserProfile firestoreToUserProfile(Map<String, dynamic> json) => UserProfile(
  id: json['id'] as String,
  // These fields are required on the domain entity. Firestore documents may
  // omit them if an upstream write was incomplete or legacy data exists.
  // Safely fall back to empty strings to avoid runtime casts on null.
  firstName: json['firstName'] as String? ?? '',
  lastName: json['lastName'] as String? ?? '',
  contactNumber: json['contactNumber'] as String? ?? '',
  email: json['email'] as String?,
  avatarUrl: json['avatarUrl'] as String?,
  // Typed empty lists for safety
  addressRefs: const <AddressRef>[],
  walletRef: null,
  reservationRefs: const <ReservationRef>[],
  paymentMethodRefs: const <PaymentMethodRef>[],
  orderRefs: const <OrderRef>[],
  favoriteRefs: const <FavoriteRef>[],
  discountRefs: const <DiscountRef>[],
  isEmailVerified: (json['isEmailVerified'] as bool?) ?? false,
  isPhoneVerified: (json['isPhoneVerified'] as bool?) ?? false,
  // ✅ هندل کردن Timestamp یا DateTime
  createdAt: json['createdAt'] is fs.Timestamp
      ? (json['createdAt'] as fs.Timestamp).toDate()
      : json['createdAt'] is DateTime
      ? json['createdAt'] as DateTime?
      : null,
  updatedAt: json['updatedAt'] is fs.Timestamp
      ? (json['updatedAt'] as fs.Timestamp).toDate()
      : json['updatedAt'] is DateTime
      ? json['updatedAt'] as DateTime?
      : null,
  roleMetadata: (json['roleMetadata'] as Map<String, dynamic>?) ?? const {},
);
