import 'package:freezed_annotation/freezed_annotation.dart';

part 'menu_ref.freezed.dart';

@freezed
class MenuRef with _$MenuRef {
  const factory MenuRef({
    required String menuId,
    String? titleSnapshot,        // e.g., "Lunch Menu"
    String? coverUrlSnapshot,     // optional image
    @Default(false) bool isActive,
  }) = _MenuRef;
}
