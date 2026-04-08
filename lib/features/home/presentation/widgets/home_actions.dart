import 'package:fintech_app/app_colors.dart';
import 'package:fintech_app/common/app_dimens.dart';
import 'package:fintech_app/config/routing/router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeActions extends StatelessWidget {
  const HomeActions({super.key});

  @override
  Widget build(BuildContext context) {
    final themeExt = Theme.of(context).extension<AppColorTheme>()!;
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
        InkWell(
          onTap: () {
            context.push(AppRoutes.transaction);
          },
          borderRadius: BorderRadius.circular(AppDimens.radiusFull),
          child: CircleAvatar(
            radius: 40,
            backgroundColor: color.withValues(alpha: 0.1),
            child: SizedBox(child: Icon(icon, size: 50, color: color)),
          ),
        ),
        Text(label, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: themeExt.textPrimary)),
      ],
    );
  }
}
