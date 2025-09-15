import 'package:freezed_annotation/freezed_annotation.dart';

part 'address_ref.freezed.dart';


@freezed
class AddressRef with _$AddressRef {
  const factory AddressRef({
    required String addressId,
    String? labelSnapshot,
    @Default(false) bool isDefault,
  }) = _AddressRef;
}
