import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/user_profile.dart';
import '../bloc/profile_bloc.dart';
import '../../data/datasources/profile_local_ds.dart';
import '../../data/repositories/profile_repository_impl.dart';
import '../../domain/usecases/get_profile.dart';
import '../../domain/usecases/update_name.dart';
import '../../domain/usecases/set_default_address.dart';
import '../../domain/usecases/set_default_payment_method.dart';
import '../../domain/usecases/link_wallet.dart';
import '../../domain/usecases/unlink_wallet.dart';
import '../widgets/section_card.dart';
import '../widgets/wallet_summary_card.dart';
// Imports for address management using BLoC.
import 'package:restaurant_marketplace/features/address/presentation/bloc/address_bloc.dart';
import 'package:restaurant_marketplace/features/address/domain/entities/address.dart';
import 'package:restaurant_marketplace/features/address/data/repositories/address_repository_impl.dart';
import 'package:restaurant_marketplace/features/address/domain/usecases/add_address.dart';
import 'package:restaurant_marketplace/features/address/domain/usecases/delete_address.dart';
import 'package:restaurant_marketplace/features/address/domain/usecases/get_addresses.dart';
import 'package:restaurant_marketplace/features/address/domain/usecases/update_address.dart';
import 'package:restaurant_marketplace/features/address/presentation/screens/address_list_screen.dart';
import '../../../wallet/presentation/screens/wallet_screen.dart';
// Payment methods list is no longer used directly; cards are managed via CardsScreen.
import 'cards_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        // Manually wire up dependencies that were previously provided by Riverpod.
        final localDs = ProfileLocalDataSource();
        final repo = ProfileRepositoryImpl(localDs);
        return ProfileBloc(
          getProfile: GetProfile(repo),
          updateName: UpdateName(repo),
          setDefaultAddress: SetDefaultAddress(repo),
          setDefaultPaymentMethod: SetDefaultPaymentMethod(repo),
          linkWallet: LinkWallet(repo),
          unlinkWallet: UnlinkWallet(repo),
        )..add(const FetchProfile());
      },
      child: Scaffold(
        body: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            // Use Dart 3 pattern matching with sealed classes to map states to UI.
            return switch (state) {
              ProfileLoading() || ProfileInitial() => const _ProfileSkeleton(),
              ProfileError(:final error) => Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'An error occurred while loading your profile:\n$error',
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 12),
                        FilledButton(
                          onPressed: () => context.read<ProfileBloc>().add(const FetchProfile()),
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  ),
                ),
              ProfileLoaded(:final profile) => _ProfileBody(user: profile),
              // Fallback to skeleton for any unforeseen states.
              _ => const _ProfileSkeleton(),
            };
          },
        ),
      ),
    );
  }
}

class _ProfileBody extends StatelessWidget {
  const _ProfileBody({required this.user});
  final UserProfile user;

  @override
  Widget build(BuildContext context) {
    final name = '${user.firstName} ${user.lastName}'.trim();

    // Wrap the scroll view with a RefreshIndicator to allow pull‑to‑refresh.
    return RefreshIndicator(
      onRefresh: () async {
        context.read<ProfileBloc>().add(const RefreshProfile());
        // Wait until the profile is reloaded; in a real app you might listen to
        // state changes instead of waiting a fixed time. Here we return immediately.
        return;
      },
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 160,
            flexibleSpace: FlexibleSpaceBar(
              background: _HeaderGradient(user: user),
              titlePadding: const EdgeInsetsDirectional.only(start: 16, bottom: 12, end: 16),
              // Show only the user's avatar aligned to the end when collapsed
              title: Align(
                alignment: AlignmentDirectional.centerEnd,
                child: _NetworkCircleAvatar(
                  url: user.avatarUrl,
                  initial: user.firstName.isNotEmpty ? user.firstName[0] : '?',
                  radius: 18,
                ),
              ),
            ),
          ),
          // Use a SliverList to lazily build sections rather than a Column in a SliverToBoxAdapter.
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  // Identity / contact
                  SectionCard(
                    title: 'Identity',
                    action: TextButton.icon(
                      onPressed: () {
                        // Show a bottom sheet form to edit the user's name.
                        showModalBottomSheet<void>(
                          context: context,
                          isScrollControlled: true,
                          builder: (context) {
                            final firstController = TextEditingController(text: user.firstName);
                            final lastController = TextEditingController(text: user.lastName);
                            return Padding(
                              padding: EdgeInsets.only(
                                bottom: MediaQuery.of(context).viewInsets.bottom,
                                left: 16,
                                right: 16,
                                top: 24,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Edit profile', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 12),
                                  TextField(
                                    controller: firstController,
                                    decoration: const InputDecoration(labelText: 'First name'),
                                  ),
                                  TextField(
                                    controller: lastController,
                                    decoration: const InputDecoration(labelText: 'Last name'),
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: ElevatedButton(
                                          onPressed: () {
                                            // Dispatch change name event
                                            context.read<ProfileBloc>().add(
                                                  ChangeName(
                                                    firstName: firstController.text.trim(),
                                                    lastName: lastController.text.trim(),
                                                  ),
                                                );
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('Save'),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: OutlinedButton(
                                          onPressed: () => Navigator.of(context).pop(),
                                          child: const Text('Cancel'),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      icon: const Icon(Icons.edit_outlined),
                      label: const Text('Edit'),
                    ),
                    child: Column(
                      children: [
                        _InfoRow(
                          icon: Icons.badge_outlined,
                          label: 'Full name',
                          value: name.isEmpty ? '—' : name,
                        ),
                        const SizedBox(height: 6),
                        _InfoRow(
                          icon: Icons.email_outlined,
                          label: 'Email',
                          value: user.email,
                          trailing: user.isEmailVerified
                              ? const _VerifiedChip()
                              : const _UnverifiedChip(),
                        ),
                        const SizedBox(height: 6),
                        _InfoRow(
                          icon: Icons.phone_outlined,
                          label: 'Phone',
                          value: user.contactNumber,
                          trailing: user.isPhoneVerified
                              ? const _VerifiedChip()
                              : const _UnverifiedChip(),
                        ),
                      ],
                    ),
                  ),
                  // Addresses
                  BlocProvider(
                    create: (ctx) {
                      // instantiate a repository scoped to the current user
                      final repo = AddressRepositoryImpl(userId: user.id);
                      return AddressBloc(
                        getAddresses: GetAddresses(repo),
                        addAddress: AddAddress(repo),
                        updateAddress: UpdateAddress(repo),
                        deleteAddress: DeleteAddress(repo),
                        userId: user.id,
                      )..add(const LoadAddresses());
                    },
                    child: BlocBuilder<AddressBloc, AddressState>(
                      builder: (ctx, addrState) {
                        // Determine subtitle and trailing action based on state
                        String subtitle;
                        Widget trailing;
                        if (addrState is AddressLoading || addrState is AddressInitial) {
                          subtitle = 'Loading addresses...';
                          trailing = const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          );
                        } else if (addrState is AddressLoaded) {
                          final addresses = addrState.addresses;
                          // Determine the default address.  If none are marked as default,
                          // fall back to the first entry when available.  Otherwise null.
                          Address? defaultAddr;
                          if (addresses.isNotEmpty) {
                            // Use firstWhere with a valid fallback to avoid returning null from
                            // an Address function.
                            defaultAddr = addresses.firstWhere(
                              (a) => a.isDefault,
                              orElse: () => addresses.first,
                            );
                          } else {
                            defaultAddr = null;
                          }
                          subtitle = defaultAddr != null
                              ? '${defaultAddr.street}, ${defaultAddr.city}'
                              : 'No addresses';
                          trailing = TextButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => BlocProvider.value(
                                    value: ctx.read<AddressBloc>(),
                                    child: const AddressListScreen(),
                                  ),
                                ),
                              );
                            },
                            child: const Text('Manage'),
                          );
                        } else if (addrState is AddressError) {
                          subtitle = 'Error loading addresses';
                          trailing = IconButton(
                            icon: const Icon(Icons.refresh),
                            onPressed: () => ctx.read<AddressBloc>().add(const LoadAddresses()),
                          );
                        } else {
                          subtitle = 'No addresses';
                          trailing = TextButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => BlocProvider.value(
                                    value: ctx.read<AddressBloc>(),
                                    child: const AddressListScreen(),
                                  ),
                                ),
                              );
                            },
                            child: const Text('Manage'),
                          );
                        }
                        return SectionCard(
                          title: 'Addresses',
                          subtitle: subtitle,
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(subtitle),
                            trailing: trailing,
                          ),
                        );
                      },
                    ),
                  ),
                  // Combined Payment section: wallet summary on top and default card below.
                  SectionCard(
                    title: 'Payment',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Wallet summary. Tapping opens the detailed wallet page if a wallet is connected.
                        InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: user.walletRef != null
                              ? () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(builder: (_) => const WalletScreen()),
                                  );
                                }
                              : null,
                          child: WalletSummaryCard(
                            walletRef: user.walletRef,
                            onLink: () => context.read<ProfileBloc>().add(const ConnectWallet('wallet_demo')),
                            onUnlink: () => context.read<ProfileBloc>().add(const DisconnectWallet()),
                          ),
                        ),
                        const SizedBox(height: 12),
                        // Default payment method display
                        Builder(
                          builder: (context) {
                            final methods = user.paymentMethodRefs;
                            if (methods.isEmpty) {
                              return ListTile(
                                leading: const Icon(Icons.credit_card),
                                title: const Text('No payment methods'),
                                subtitle: const Text('Add a card to pay'),
                              );
                            }
                            // Find the default method; fall back to first.
                            var defaultMethod = methods.firstWhere(
                              (m) => m.isDefault,
                              orElse: () => methods.first,
                            );
                            final brand = defaultMethod.brand ?? 'Card';
                            final last4 = defaultMethod.last4 ?? '••••';
                            return ListTile(
                              leading: CircleAvatar(child: Text(brand.characters.first.toUpperCase())),
                              title: Text('$brand •••• $last4'),
                              subtitle: const Text('Default payment method'),
                            );
                          },
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              // Navigate to the cards management screen. Pass along the existing
                              // ProfileBloc instance so that CardsScreen can access it via
                              // context.read<ProfileBloc>().  Without this, the provider for
                              // ProfileBloc would be missing on the new route and result in a
                              // ProviderNotFoundException.  We use BlocProvider.value to reuse
                              // the current bloc rather than creating a new one.
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => BlocProvider.value(
                                    value: context.read<ProfileBloc>(),
                                    child: CardsScreen(user: user),
                                  ),
                                ),
                              );
                            },
                            child: const Text('Manage'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderGradient extends StatelessWidget {
  const _HeaderGradient({required this.user});
  final UserProfile user;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    // Render only the user's avatar in the header.  The full contact details are
    // shown in the Identity section below.  Keeping the header minimal avoids
    // duplicating information and leaves room for the back button and other
    // system UI elements.  The avatar remains on the left in the expanded
    // state, and a smaller version appears on the right when collapsed via
    // the FlexibleSpaceBar configuration in the SliverAppBar above.
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [scheme.primaryContainer, scheme.secondaryContainer],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 8),
      child: Align(
        alignment: AlignmentDirectional.centerStart,
        child: _NetworkCircleAvatar(
          url: user.avatarUrl,
          initial: user.firstName.isNotEmpty ? user.firstName[0] : '?',
          radius: 36,
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
    this.trailing,
  });

  final IconData icon;
  final String label;
  final String value;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Icon(icon, size: 18, color: theme.colorScheme.onSurfaceVariant),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            '$label: $value',
            style: theme.textTheme.bodyMedium,
          ),
        ),
        if (trailing != null) trailing!,
      ],
    );
  }
}

class _VerifiedChip extends StatelessWidget {
  const _VerifiedChip();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Semantics(
      // Provide semantic label for assistive technologies.
      label: 'Verified',
      child: Tooltip(
        message: 'Verified',
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: scheme.primaryContainer,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            'Verified',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: scheme.onPrimaryContainer,
            ),
          ),
        ),
      ),
    );
  }
}

class _UnverifiedChip extends StatelessWidget {
  const _UnverifiedChip();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Semantics(
      // Expose semantic information for accessibility tools.
      label: 'Unverified',
      child: Tooltip(
        message: 'Unverified',
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: scheme.errorContainer,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            'Unverified',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: scheme.onErrorContainer,
            ),
          ),
        ),
      ),
    );
  }
}

/// Displays a skeleton layout mimicking the profile screen while data is loading.
///
/// The skeleton uses simple grey boxes to approximate the shape of the final
/// content, reducing perceived loading time and avoiding abrupt layout shifts.
class _ProfileSkeleton extends StatelessWidget {
  const _ProfileSkeleton();

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.5);
    final scheme = Theme.of(context).colorScheme;
    // Reuse the same gradient used in the actual header for visual consistency.
    final headerGradient = LinearGradient(
      colors: [scheme.primaryContainer, scheme.secondaryContainer],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
    Widget buildCardSkeleton({required bool hasSubtitle}) {
      return Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: scheme.outlineVariant),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title line
            Container(height: 16, width: 120, color: color),
            if (hasSubtitle) ...[
              const SizedBox(height: 8),
              Container(height: 12, width: 80, color: color),
            ],
            const SizedBox(height: 16),
            // Two lines representing content rows
            Container(height: 14, width: double.infinity, color: color),
            const SizedBox(height: 6),
            Container(height: 14, width: double.infinity, color: color),
            const SizedBox(height: 6),
            Container(height: 14, width: double.infinity, color: color),
          ],
        ),
      );
    }
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          expandedHeight: 160,
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              decoration: BoxDecoration(gradient: headerGradient),
              padding: const EdgeInsets.fromLTRB(16, 48, 16, 8),
              child: Row(
                children: [
                  // Avatar skeleton
                  Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                    ),
                  ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(height: 16, width: 120, color: color),
                          const SizedBox(height: 6),
                          Container(height: 12, width: 160, color: color),
                          const SizedBox(height: 4),
                          Container(height: 12, width: 100, color: color),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            // Keep a blank title to avoid overlap with skeleton
            titlePadding: const EdgeInsetsDirectional.only(start: 16, bottom: 12),
            title: null,
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              buildCardSkeleton(hasSubtitle: true), // Identity
              buildCardSkeleton(hasSubtitle: false), // Addresses
              buildCardSkeleton(hasSubtitle: false), // Wallet
              buildCardSkeleton(hasSubtitle: true), // Payment methods
            ]),
          ),
        ),
      ],
    );
  }
}

/// A CircleAvatar wrapper that fetches a remote image with caching and graceful fallbacks.
///
/// When [url] is provided the widget uses [Image.network] to fetch the image.
/// While the image is loading a circular progress indicator is shown. If the image fails
/// to load a fallback [CircleAvatar] with the provided [initial] is shown instead.
class _NetworkCircleAvatar extends StatelessWidget {
  const _NetworkCircleAvatar({
    required this.url,
    required this.initial,
    required this.radius,
  });

  final String? url;
  final String initial;
  final double radius;

  @override
  Widget build(BuildContext context) {
    // If no URL is provided just show the fallback avatar.
    if (url == null || url!.isEmpty) {
      return CircleAvatar(
        radius: radius,
        child: Text(initial),
      );
    }
    return ClipOval(
      child: Image.network(
        url!,
        width: radius * 2,
        height: radius * 2,
        fit: BoxFit.cover,
        // Display a fallback avatar if an error occurs.
        errorBuilder: (context, error, stackTrace) {
          return CircleAvatar(
            radius: radius,
            child: Text(initial),
          );
        },
        // While loading show a circular progress indicator scaled to the avatar.
        loadingBuilder: (context, child, progress) {
          if (progress == null) return child;
          return CircleAvatar(
            radius: radius,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              value: progress.expectedTotalBytes != null
                  ? progress.cumulativeBytesLoaded /
                      progress.expectedTotalBytes!
                  : null,
            ),
          );
        },
      ),
    );
  }
}
