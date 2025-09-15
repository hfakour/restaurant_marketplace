import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:restaurant_marketplace/features/auth/domain/entities/auth_account.dart';

import '../../data/repository/auth_repository_impl.dart';

final authAccountProvider = StreamProvider<AuthAccount?>((ref) {
  return ref.read(authRepositoryProvider).authState();
});

final currentProfileIdProvider = Provider<String?>((ref) {
  final a = ref.watch(authAccountProvider).valueOrNull;
  return a?.profileId;
});
