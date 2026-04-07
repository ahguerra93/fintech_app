import 'package:fintech_app/app_colors.dart';
import 'package:fintech_app/common/app_dimens.dart';
import 'package:fintech_app/common/widgets/error_screen.dart';
import 'package:fintech_app/config/routing/router.dart';
import 'package:fintech_app/features/dev_tools/presentation/cubit/devtools_cubit.dart';
import 'package:fintech_app/features/dev_tools/presentation/cubit/devtools_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fintech_app/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc(context.read<DevToolsCubit>())..add(const FetchProfileData()),
      child: const ProfilePageWidget(),
    );
  }
}

class ProfilePageWidget extends StatefulWidget {
  const ProfilePageWidget({super.key});

  @override
  State<ProfilePageWidget> createState() => _ProfilePageWidgetState();
}

class _ProfilePageWidgetState extends State<ProfilePageWidget> {
  GoRouterDelegate? _delegate;
  late String _currentLocation;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final delegate = GoRouter.of(context).routerDelegate;
    if (identical(_delegate, delegate)) {
      return;
    }

    _delegate?.removeListener(_routeChanged);
    _delegate = delegate;
    _currentLocation = delegate.currentConfiguration.uri.path;
    delegate.addListener(_routeChanged);
  }

  void _routeChanged() {
    final delegate = _delegate;
    if (!mounted || delegate == null) {
      return;
    }

    final newLocation = delegate.currentConfiguration.uri.path;
    if (newLocation == _currentLocation) {
      return;
    }

    if (newLocation == AppRoutes.profile) {
      context.read<ProfileBloc>().add(const FetchProfileData());
    }

    _currentLocation = newLocation;
  }

  @override
  void dispose() {
    _delegate?.removeListener(_routeChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final sectionSpacing = AppDimens.spacingMd;

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
          const _UserInfoSection(),
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
                Text('Account Settings', style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
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
          // Developer Tools
          Container(
            padding: const EdgeInsets.symmetric(vertical: AppDimens.spacingLg, horizontal: AppDimens.spacingLg),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(AppDimens.radiusXl),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Developer Tools', style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: AppDimens.spacingMd),
                BlocBuilder<DevToolsCubit, DevToolsState>(
                  builder: (context, state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.bug_report, color: theme.colorScheme.primary, size: AppDimens.iconLg),
                            const SizedBox(width: AppDimens.spacingMd),
                            Text('Response Type', style: theme.textTheme.bodyLarge),
                          ],
                        ),
                        const SizedBox(height: AppDimens.spacingMd),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: AppDimens.spacingMd),
                          decoration: BoxDecoration(
                            border: Border.all(color: theme.colorScheme.primary),
                            borderRadius: BorderRadius.circular(AppDimens.radiusMd),
                          ),
                          child: DropdownButton<ResponseType>(
                            value: state.responseType,
                            isExpanded: true,
                            underline: const SizedBox(),
                            icon: Icon(Icons.arrow_drop_down, color: theme.colorScheme.primary),
                            items: ResponseType.values
                                .map(
                                  (type) => DropdownMenuItem(
                                    value: type,
                                    child: Text(
                                      type.name,
                                      style: theme.textTheme.bodyLarge?.copyWith(
                                        color: theme.colorScheme.primary,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                            onChanged: (ResponseType? newValue) {
                              if (newValue != null) {
                                context.read<DevToolsCubit>().setResponseType(newValue);
                              }
                            },
                          ),
                        ),
                      ],
                    );
                  },
                ),
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

class _UserInfoSection extends StatelessWidget {
  const _UserInfoSection();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      buildWhen: (previous, current) =>
          (previous is ProfileLoading) != (current is ProfileLoading) ||
          (previous is ProfileError) != (current is ProfileError),
      builder: (context, state) {
        final theme = Theme.of(context);
        final themeExt = Theme.of(context).extension<AppColorTheme>()!;
        final loading = state is ProfileLoading;
        final isError = state is ProfileError;

        return AnimatedCrossFade(
          duration: const Duration(milliseconds: 350),
          crossFadeState: isError ? CrossFadeState.showFirst : CrossFadeState.showSecond,
          firstChild: isError
              ? ErrorScreen(
                  message: (state as ProfileError).message,
                  onRetry: () => context.read<ProfileBloc>().add(const FetchProfileData()),
                )
              : const SizedBox.shrink(),
          secondChild: isError
              ? const SizedBox.shrink()
              : _UserInfoContent(loading: loading, themeExt: themeExt, state: state),
        );
      },
    );
  }
}

class _UserInfoContent extends StatelessWidget {
  const _UserInfoContent({required this.loading, required this.themeExt, required this.state});

  final bool loading;
  final AppColorTheme themeExt;
  final ProfileState state;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final dummyName = 'Loading User';
    final dummyEmail = 'user@example.com';
    final dummyAccountId = 'ACC123456';

    final userName = loading ? dummyName : (state as ProfileSuccess).data.name;
    final userEmail = loading ? dummyEmail : (state as ProfileSuccess).data.email;
    final accountId = loading ? dummyAccountId : (state as ProfileSuccess).data.accountId;

    return Skeletonizer(
      enabled: loading,
      enableSwitchAnimation: true,
      child: Container(
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
    );
  }
}
