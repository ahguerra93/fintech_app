import 'package:fintech_app/app_colors.dart';
import 'package:fintech_app/common/app_dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fintech_app/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:fintech_app/features/profile/domain/models/profile_data.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc()..add(const FetchProfileData()),
      child: const ProfilePageWidget(),
    );
  }
}

class ProfilePageWidget extends StatelessWidget {
  const ProfilePageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        final theme = Theme.of(context);
        final themeExt = Theme.of(context).extension<AppColorTheme>()!;
        final sectionSpacing = AppDimens.spacingMd;
        if (state is ProfileLoading) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        } else if (state is ProfileSuccess) {
          final ProfileData data = state.data;
          final userName = data.name;
          final userEmail = data.email;
          final accountId = data.accountId;
          return Scaffold(
            appBar: AppBar(
              title: Text('Profile', style: theme.textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold)),
              centerTitle: true,
              elevation: 0,
              backgroundColor: theme.colorScheme.surface,
            ),
            body: ListView(
              padding: const EdgeInsets.all(AppDimens.spacingXl),
              children: [
                // User Info
                Container(
                  padding: const EdgeInsets.symmetric(vertical: AppDimens.spacingMd, horizontal: AppDimens.spacingLg),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(AppDimens.radiusXl),
                  ),
                  child: Row(
                    spacing: 16.0,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: AppDimens.iconLg,
                        backgroundColor: themeExt.primary,
                        child: Text(
                          userName.split(' ').map((e) => e[0]).take(2).join(),
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.onPrimary,
                          ),
                        ),
                      ),
                      Flexible(
                        child: Column(
                          children: [
                            const SizedBox(height: AppDimens.spacingLg),
                            Text(userName, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                            const SizedBox(height: AppDimens.spacingSm),
                            Text(userEmail, style: theme.textTheme.bodyMedium?.copyWith(color: theme.hintColor)),
                            const SizedBox(height: AppDimens.spacingSm),
                            Text(accountId, style: theme.textTheme.bodySmall?.copyWith(letterSpacing: 2)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: sectionSpacing),

                // Account Settings
                Container(
                  padding: const EdgeInsets.symmetric(vertical: AppDimens.spacingLg, horizontal: AppDimens.spacingLg),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(AppDimens.radiusXl),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Account Settings',
                        style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: AppDimens.spacingMd),
                      _ProfileNavTile(icon: Icons.person, label: 'Personal information', onTap: () {}),
                      _ProfileNavTile(icon: Icons.link, label: 'Linked accounts', onTap: () {}),
                      _ProfileNavTile(icon: Icons.notifications, label: 'Notifications', onTap: () {}),
                      _ProfileNavTile(icon: Icons.lock, label: 'Security', onTap: () {}),
                    ],
                  ),
                ),
                SizedBox(height: sectionSpacing),

                // Preferences
                Container(
                  padding: const EdgeInsets.symmetric(vertical: AppDimens.spacingLg, horizontal: AppDimens.spacingLg),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(AppDimens.radiusXl),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Preferences', style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
                      const SizedBox(height: AppDimens.spacingMd),
                      _ProfileNavTile(icon: Icons.dark_mode, label: 'Dark mode', onTap: () {}),
                      _ProfileNavTile(icon: Icons.language, label: 'Language', onTap: () {}),
                    ],
                  ),
                ),
                SizedBox(height: sectionSpacing),

                // Footer actions
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.support_agent),
                  label: const Text('Contact Support'),
                  style: TextButton.styleFrom(alignment: Alignment.centerLeft),
                ),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(alignment: Alignment.centerLeft),
                  child: const Text('Terms & Privacy'),
                ),
                const SizedBox(height: AppDimens.spacingSm),
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(minimumSize: const Size.fromHeight(48)),
                  child: const Text('Log Out'),
                ),
              ],
            ),
          );
        } else if (state is ProfileError) {
          return Scaffold(body: Center(child: Text('Error: ${state.message}')));
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class _ProfileNavTile extends StatelessWidget {
  const _ProfileNavTile({required this.icon, required this.label, required this.onTap});
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: theme.colorScheme.primary, size: AppDimens.iconLg),
      title: Text(label, style: theme.textTheme.bodyLarge),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
