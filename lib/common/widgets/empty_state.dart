import 'package:flutter/material.dart';

class EmptyStateWidget extends StatelessWidget {
  final String message;
  final Widget? icon;
  final VoidCallback? onActionPressed;
  final String? actionLabel;

  const EmptyStateWidget({required this.message, this.icon, this.onActionPressed, this.actionLabel, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 16.0,
          children: [
            if (icon != null) icon!,
            Text(message, style: theme.textTheme.bodyLarge?.copyWith(color: theme.hintColor)),
            if (actionLabel != null && onActionPressed != null)
              FilledButton(onPressed: onActionPressed, child: Text(actionLabel!)),
          ],
        ),
      ),
    );
  }
}
