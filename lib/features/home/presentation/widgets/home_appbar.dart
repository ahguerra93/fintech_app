import 'package:fintech_app/app_colors.dart';
import 'package:fintech_app/common/app_dimens.dart';
import 'package:fintech_app/config/routing/router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key, required this.userName});

  final String userName;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeExt = theme.extension<AppColorTheme>()!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.spacingMd),
      child: AppBar(
        leading: _ProfileIcon(),
        title: Text.rich(
          TextSpan(
            style: theme.textTheme.titleMedium,
            children: [
              const TextSpan(text: 'Hi '),
              TextSpan(
                text: userName,
                style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
              ),
              const TextSpan(text: '!'),
            ],
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications_outlined, color: themeExt.textPrimary),
          ),
        ],
      ),
    );
  }
}

class _ProfileIcon extends StatelessWidget {
  const _ProfileIcon();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = theme.colorScheme.primary;
    return InkWell(
      onTap: () {
        context.go(AppRoutes.profile);
      },

      borderRadius: BorderRadius.circular(AppDimens.radiusFull),
      child: CircleAvatar(
        radius: 50,
        backgroundColor: color.withValues(alpha: 0.1),
        child: Icon(Icons.person, color: color),
      ),
    );
  }
}
