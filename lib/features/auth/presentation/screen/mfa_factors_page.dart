import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/auth/auth_bloc.dart';

/// Page to let the user choose a multi-factor authentication (MFA) factor.
///
/// When MFA is required during sign-in, [AuthBloc] transitions to the
/// [AuthViewStatus.mfaRequired] state and provides the available factor
/// identifiers and a resolver in the [AuthState]. This page lists all
/// available factors and dispatches a [MfaStartResolveRequested] event when
/// the user selects one. If MFA is not required, this page will show a
/// placeholder message.
class MfaFactorsPage extends StatelessWidget {
  const MfaFactorsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select MFA Factor')),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state.status != AuthViewStatus.mfaRequired) {
            return const Center(
              child: Text('MFA not required at this time.'),
            );
          }
          final factors = state.mfaFactorUids;
          final resolver = state.mfaResolver;
          if (factors.isEmpty || resolver == null) {
            return const Center(
              child: Text('No MFA factors available.'),
            );
          }
          return ListView.builder(
            itemCount: factors.length,
            itemBuilder: (context, index) {
              final uid = factors[index];
              return ListTile(
                title: Text('Factor ${index + 1}'),
                subtitle: Text(uid),
                onTap: () {
                  context.read<AuthBloc>().add(
                        MfaStartResolveRequested(resolver: resolver, factorUid: uid),
                      );
                },
              );
            },
          );
        },
      ),
    );
  }
}