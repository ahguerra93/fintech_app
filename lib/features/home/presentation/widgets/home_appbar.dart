import 'package:fintech_app/app_colors.dart';
import 'package:flutter/material.dart';

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
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: AppBar(
        leading: CircleAvatar(
          backgroundColor: themeExt.mutedSurfaceAccent,
          child: Icon(Icons.person, color: themeExt.textPrimary),
        ),
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
