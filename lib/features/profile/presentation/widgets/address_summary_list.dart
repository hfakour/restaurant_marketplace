import 'package:flutter/material.dart';
import 'package:restaurant_marketplace/core/domain_refs/address_ref.dart';

class AddressSummaryList extends StatelessWidget {
  const AddressSummaryList({
    super.key,
    required this.addressRefs,
    this.onSelect,
    this.onManage,
  });

  final List<AddressRef> addressRefs;
  final ValueChanged<String>? onSelect;
  final VoidCallback? onManage;

  @override
  Widget build(BuildContext context) {
    if (addressRefs.isEmpty) {
      return _EmptyState(
        icon: Icons.location_on_outlined,
        title: 'No addresses',
        subtitle: 'Add your delivery addresses',
        actionLabel: 'Manage',
        onAction: onManage,
      );
    }

    return Column(
      children: [
        for (var i = 0; i < addressRefs.length; i++)
          _AddressTile(
            ref: addressRefs[i],
            isDefault: i == 0, // our local DS uses “first is default”
            onTap: () => onSelect?.call(addressRefs[i].addressId),
          ),
        if (onManage != null)
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(onPressed: onManage, child: const Text('Manage')),
          ),
      ],
    );
  }
}

class _AddressTile extends StatelessWidget {
  const _AddressTile({
    required this.ref,
    required this.isDefault,
    this.onTap,
  });

  final AddressRef ref;
  final bool isDefault;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final label = ref.labelSnapshot ?? 'Address';
    return ListTile(
      onTap: onTap,
      leading: CircleAvatar(
        child: Icon(isDefault ? Icons.push_pin : Icons.location_on),
      ),
      title: Text(label),
      subtitle: Text('#${ref.addressId}'),
      trailing: isDefault
          ? Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: theme.colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          'Default',
          style: theme.textTheme.labelSmall?.copyWith(
            color: theme.colorScheme.onPrimaryContainer,
          ),
        ),
      )
          : null,
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.actionLabel,
    this.onAction,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final String actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.colorScheme.outlineVariant),
      ),
      child: Row(
        children: [
          Icon(icon, color: theme.colorScheme.onSurfaceVariant),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: theme.textTheme.bodyMedium),
                Text(subtitle, style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                )),
              ],
            ),
          ),
          if (onAction != null)
            TextButton(onPressed: onAction, child: Text(actionLabel)),
        ],
      ),
    );
  }
}
