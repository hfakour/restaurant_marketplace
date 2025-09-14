import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repository/auth_repository_impl.dart';
import '../../domain/entities/auth_account.dart';

final authAccountProvider = StreamProvider<AuthAccount?>((ref) {
  return ref.read(authRepositoryProvider).authState();
});

/// Expose current profile ID for features (Reservations, etc.)
final currentProfileIdProvider = Provider<String?>((ref) {
  final a = ref.watch(authAccountProvider).valueOrNull;
  return a?.profileId;
});
