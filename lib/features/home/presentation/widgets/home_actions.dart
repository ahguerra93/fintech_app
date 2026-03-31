import 'package:fintech_app/app_colors.dart';
import 'package:flutter/material.dart';

class HomeActions extends StatelessWidget {
  const HomeActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _ActionWidget(label: 'Transfer', icon: Icons.upload_outlined),
        _ActionWidget(label: 'Request', icon: Icons.download_outlined),
      ],
    );
  }
}

class _ActionWidget extends StatelessWidget {
  const _ActionWidget({required this.label, required this.icon});
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final themeExt = Theme.of(context).extension<AppColorTheme>()!;
    final theme = Theme.of(context);
    final color = theme.colorScheme.primary;
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 8.0,
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: color.withValues(alpha: 0.1),
          child: SizedBox(child: Icon(icon, size: 50, color: color)),
        ),
        Text(label, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: themeExt.textPrimary)),
      ],
    );
  }
}
