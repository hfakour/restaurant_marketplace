import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'data/datasources/profile_local_ds.dart';
import 'data/repositories/profile_repository_impl.dart';
import 'domain/repositories/profile_repository.dart';
import 'domain/usecases/get_profile.dart';
import 'domain/usecases/update_name.dart';
import 'domain/usecases/set_default_address.dart';
import 'domain/usecases/set_default_payment_method.dart';
import 'domain/usecases/link_wallet.dart';
import 'domain/usecases/unlink_wallet.dart';

part 'profile_providers.g.dart';

@riverpod
ProfileLocalDataSource profileLocalDs(ProfileLocalDsRef ref) =>
    ProfileLocalDataSource();

@riverpod
ProfileRepository profileRepository(ProfileRepositoryRef ref) =>
    ProfileRepositoryImpl(ref.watch(profileLocalDsProvider));

@riverpod
GetProfile getProfile(GetProfileRef ref) =>
    GetProfile(ref.watch(profileRepositoryProvider));

@riverpod
UpdateName updateName(UpdateNameRef ref) =>
    UpdateName(ref.watch(profileRepositoryProvider));

@riverpod
SetDefaultAddress setDefaultAddress(SetDefaultAddressRef ref) =>
    SetDefaultAddress(ref.watch(profileRepositoryProvider));

@riverpod
SetDefaultPaymentMethod setDefaultPaymentMethod(SetDefaultPaymentMethodRef ref) =>
    SetDefaultPaymentMethod(ref.watch(profileRepositoryProvider));

@riverpod
LinkWallet linkWallet(LinkWalletRef ref) =>
    LinkWallet(ref.watch(profileRepositoryProvider));

@riverpod
UnlinkWallet unlinkWallet(UnlinkWalletRef ref) =>
    UnlinkWallet(ref.watch(profileRepositoryProvider));
