import 'package:dio/dio.dart';
import '../models/user_profile_dto.dart';

class ProfileRemoteDataSource {
  final Dio dio;
  ProfileRemoteDataSource(this.dio);

  Future<UserProfileDto> fetchMe() async {
    final res = await dio.get('/v1/profile/me');
    return UserProfileDto.fromJson(res.data as Map<String, dynamic>);
  }

  Future<UserProfileDto> patchDisplayName(String displayName) async {
    final res = await dio.patch('/v1/profile/me', data: {
      'display_name': displayName,
    });
    return UserProfileDto.fromJson(res.data as Map<String, dynamic>);
  }

  Future<UserProfileDto> patchDefaultAddress(String addressId) async {
    final res = await dio.patch('/v1/profile/me/default-address', data: {
      'address_id': addressId,
    });
    return UserProfileDto.fromJson(res.data as Map<String, dynamic>);
  }

  Future<UserProfileDto> patchDefaultPaymentMethod(String paymentMethodId) async {
    final res = await dio.patch('/v1/profile/me/default-payment-method', data: {
      'payment_method_id': paymentMethodId,
    });
    return UserProfileDto.fromJson(res.data as Map<String, dynamic>);
  }

  Future<UserProfileDto> linkWallet(String walletId) async {
    final res = await dio.post('/v1/profile/me/wallet', data: {
      'wallet_id': walletId,
    });
    return UserProfileDto.fromJson(res.data as Map<String, dynamic>);
  }

  Future<UserProfileDto> unlinkWallet() async {
    final res = await dio.delete('/v1/profile/me/wallet');
    return UserProfileDto.fromJson(res.data as Map<String, dynamic>);
  }
}
