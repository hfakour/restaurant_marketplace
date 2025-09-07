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
import '../widgets/address_summary_list.dart';
import '../widgets/wallet_summary_card.dart';
import '../widgets/payment_methods_list.dart';

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
              // Show a skeleton while loading or before the first data has arrived.
              ProfileLoading() || ProfileInitial() => const _ProfileSkeleton(),
              // Show an error message with a retry button when loading fails.
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
              // Render the main profile UI once data is available.
              ProfileLoaded(:final profile) => _ProfileBody(user: profile),
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
    final roles = user.roles.isEmpty
        ? 'Customer'
        : user.roles.map((e) => e.name).join(' • ');
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
              titlePadding: const EdgeInsetsDirectional.only(start: 16, bottom: 12),
              title: Row(
                children: [
                  _NetworkCircleAvatar(
                    url: user.avatarUrl,
                    initial: user.firstName.isNotEmpty ? user.firstName[0] : '?',
                    radius: 18,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      name.isEmpty ? 'Your profile' : name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
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
                    subtitle: roles,
                    action: TextButton.icon(
                      onPressed: () => context.read<ProfileBloc>().add(const ChangeName(firstName: 'Avery', lastName: 'Stone')),
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
                  SectionCard(
                    title: 'Addresses',
                    subtitle: 'Default is first',
                    child: AddressSummaryList(
                      addressRefs: user.addressRefs,
                      onSelect: (id) => context.read<ProfileBloc>().add(MakeDefaultAddress(id)),
                      onManage: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Open addresses manager')),
                        );
                      },
                    ),
                  ),
                  // Wallet
                  SectionCard(
                    title: 'Wallet',
                    child: WalletSummaryCard(
                      walletRef: user.walletRef,
                      onLink: () => context.read<ProfileBloc>().add(const ConnectWallet('wallet_demo')),
                      onUnlink: () => context.read<ProfileBloc>().add(const DisconnectWallet()),
                    ),
                  ),
                  // Payment methods
                  SectionCard(
                    title: 'Payment methods',
                    subtitle: 'Default is first',
                    child: PaymentMethodsList(
                      methods: user.paymentMethodRefs,
                      onMakeDefault: (pmId) => context.read<ProfileBloc>().add(MakeDefaultPaymentMethod(pmId)),
                      onManage: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Open payment methods')),
                        );
                      },
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
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [scheme.primaryContainer, scheme.secondaryContainer],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 8),
      child: Row(
        children: [
          _NetworkCircleAvatar(
            url: user.avatarUrl,
            initial: user.firstName.isNotEmpty ? user.firstName[0] : '?',
            radius: 36,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: DefaultTextStyle(
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onPrimaryContainer),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${user.firstName} ${user.lastName}'.trim()),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.email, size: 14, color: Theme.of(context).colorScheme.onPrimaryContainer),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          user.email,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Icon(Icons.phone, size: 14, color: Theme.of(context).colorScheme.onPrimaryContainer),
                      const SizedBox(width: 6),
                      Text(user.contactNumber),
                    ],
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
    // In Flutter 3.18+, surfaceVariant is deprecated. Use surfaceContainerHighest
    // instead and adjust its alpha with withValues() for a semi‑transparent
    // skeleton colour. The withValues method avoids precision loss compared
    // to the deprecated withOpacity().
    final scheme = Theme.of(context).colorScheme;
    final baseColor = scheme.surfaceContainerHighest;
    final color = baseColor.withValues(alpha: 0.5);
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
