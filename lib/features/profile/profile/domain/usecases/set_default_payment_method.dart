import '../entities/user_profile.dart';
import '../repositories/profile_repository.dart';

class SetDefaultPaymentMethod {
  final ProfileRepository _repo;
  SetDefaultPaymentMethod(this._repo);
  Future<UserProfile> call(String paymentMethodId)
  => _repo.setDefaultPaymentMethod(paymentMethodId);
}
