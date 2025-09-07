import 'package:flutter/material.dart';
import 'package:restaurant_marketplace/core/domain_refs/payment_method_ref.dart';

class PaymentMethodsList extends StatelessWidget {
  const PaymentMethodsList({
    super.key,
    required this.methods,
    this.onMakeDefault,
    this.onManage,
  });

  final List<PaymentMethodRef> methods;
  final ValueChanged<String>? onMakeDefault;
  final VoidCallback? onManage;

  @override
  Widget build(BuildContext context) {
    if (methods.isEmpty) {
      return _Empty(
        icon: Icons.credit_card,
        title: 'No payment methods',
        subtitle: 'Add a card or payment method',
        actionLabel: 'Manage',
        onAction: onManage,
      );
    }

    return Column(
      children: [
        for (var i = 0; i < methods.length; i++)
          _MethodTile(
            method: methods[i],
            isDefault: i == 0, // first item = default
            onMakeDefault: () =>
                onMakeDefault?.call(methods[i].paymentMethodId),
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

class _MethodTile extends StatelessWidget {
  const _MethodTile({
    required this.method,
    required this.isDefault,
    required this.onMakeDefault,
  });

  final PaymentMethodRef method;
  final bool isDefault;
  final VoidCallback onMakeDefault;

  @override
  Widget build(BuildContext context) {
    final brand = method.brand ?? 'Card';
    final last4 = method.last4 ?? '••••';
    return ListTile(
      leading: CircleAvatar(child: Text(brand.characters.first.toUpperCase())),
      title: Text('$brand •••• $last4'),
      subtitle: Text('#${method.paymentMethodId}'),
      trailing: isDefault
          ? const Chip(label: Text('Default'))
          : OutlinedButton(
        onPressed: onMakeDefault,
        child: const Text('Make default'),
      ),
    );
  }
}

class _Empty extends StatelessWidget {
  const _Empty({
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
                Text(
                  subtitle,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
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
