import 'dart:math';
import '../models/user_profile_dto.dart';

/// Very simple in-memory store for demo/development.
class ProfileLocalDataSource {
  UserProfileDto _me = UserProfileDto(
    id: 'user_001',
    roles: const ['customer'],
    firstName: 'Ava',
    lastName: 'Smith',
    email: 'ava@example.com',
    contactNumber: '+1 555 123 4567',
    avatarUrl: null,
    addressIds: const ['addr_1', 'addr_2'],
    walletId: 'wallet_1',
    reservationIds: const ['res_1', 'res_2'],
    paymentMethodIds: const ['pm_1', 'pm_2'],
    isEmailVerified: true,
    isPhoneVerified: false,
    createdAtIso: DateTime.now().toUtc().toIso8601String(),
    updatedAtIso: DateTime.now().toUtc().toIso8601String(),
    roleMetadata: const {},
  );


  Future<UserProfileDto> fetchMe() async {
    await Future<void>.delayed(const Duration(milliseconds: 150));
    return _me;
  }

  Future<UserProfileDto> updateName({
    required String firstName,
    required String lastName,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 100));
    _me = _me.copyWith(
      firstName: firstName,
      lastName: lastName,
      updatedAtIso: DateTime.now().toUtc().toIso8601String(),
    );
    return _me;
  }

  Future<UserProfileDto> setDefaultAddress(String addressId) async {
    await Future<void>.delayed(const Duration(milliseconds: 80));
    // Make sure the address exists in list or add it
    if (!_me.addressIds.contains(addressId)) {
      _me = _me.copyWith(addressIds: [..._me.addressIds, addressId]);
    }
    // Move chosen address to front to signal "default"
    final ids = [..._me.addressIds]..remove(addressId)..insert(0, addressId);
    _me = _me.copyWith(
      addressIds: ids,
      updatedAtIso: DateTime.now().toUtc().toIso8601String(),
    );
    return _me;
  }

  Future<UserProfileDto> setDefaultPaymentMethod(String pmId) async {
    await Future<void>.delayed(const Duration(milliseconds: 80));
    if (!_me.paymentMethodIds.contains(pmId)) {
      _me = _me.copyWith(paymentMethodIds: [..._me.paymentMethodIds, pmId]);
    }
    final ids = [..._me.paymentMethodIds]..remove(pmId)..insert(0, pmId);
    _me = _me.copyWith(
      paymentMethodIds: ids,
      updatedAtIso: DateTime.now().toUtc().toIso8601String(),
    );
    return _me;
  }

  Future<UserProfileDto> linkWallet(String walletId) async {
    await Future<void>.delayed(const Duration(milliseconds: 80));
    _me = _me.copyWith(
      walletId: walletId,
      updatedAtIso: DateTime.now().toUtc().toIso8601String(),
    );
    return _me;
  }

  Future<UserProfileDto> unlinkWallet() async {
    await Future<void>.delayed(const Duration(milliseconds: 80));
    _me = _me.copyWith(
      walletId: null,
      updatedAtIso: DateTime.now().toUtc().toIso8601String(),
    );
    return _me;
  }
}
