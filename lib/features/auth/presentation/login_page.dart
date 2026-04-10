import 'package:fintech_app/app_colors.dart';
import 'package:fintech_app/common/app_assets.dart';
import 'package:fintech_app/common/app_dimens.dart';
import 'package:fintech_app/common/widgets/app_labeled_field.dart';
import 'package:fintech_app/common/widgets/app_outlined_button.dart';
import 'package:fintech_app/common/widgets/app_primary_button.dart';
import 'package:fintech_app/config/routing/router.dart';
import 'package:fintech_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController(text: 'user@email.com');
    final TextEditingController passwordController = TextEditingController(text: '1234');
    final theme = Theme.of(context);
    final themeExt = theme.extension<AppColorTheme>()!;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: themeExt.primary,
        body: SafeArea(
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is Authorized) {
                context.go(AppRoutes.home);
              }
            },
            builder: (context, state) {
              final isLoading = state is AuthLoading;
              final isError = state is AuthError;

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppDimens.spacingXl),
                child: Column(
                  children: [
                    Expanded(
                      child: Center(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CircleAvatar(
                                radius: 56,
                                backgroundColor: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(AppDimens.spacingMd),
                                  child: Image.asset(
                                    AppAssets.logoOutlined,
                                    color: themeExt.primary,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              const SizedBox(height: AppDimens.spacingLg),
                              Text('Welcome Back', style: theme.textTheme.displayLarge?.copyWith(color: Colors.white)),
                              const SizedBox(height: AppDimens.spacingSm),
                              Text(
                                'Sign in to continue managing your finances',
                                style: theme.textTheme.bodyLarge?.copyWith(color: Colors.white.withValues(alpha: 0.85)),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: AppDimens.spacingXxl),
                              AppLabeledField(
                                label: 'Email',
                                controller: emailController,
                                keyboardType: TextInputType.emailAddress,
                                style: TextStyle(color: themeExt.textPrimary),
                                suffixIcon: Icon(Icons.info_outline, color: themeExt.textSecondary),
                              ),
                              const SizedBox(height: AppDimens.spacingMd),
                              AppLabeledField(
                                label: 'Password',
                                controller: passwordController,
                                obscureText: true,
                                style: TextStyle(color: themeExt.textPrimary),
                              ),
                              if (isError) ...[
                                const SizedBox(height: AppDimens.spacingMd),
                                Text(
                                  (state).message,
                                  style: TextStyle(color: theme.colorScheme.error),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: AppDimens.spacingXl),
                    AppPrimaryButton(
                      label: 'Sign In',
                      isLoading: isLoading,
                      backgroundColor: themeExt.primaryDark,
                      onPressed: () {
                        context.read<AuthBloc>().add(LoginRequested(emailController.text, passwordController.text));
                      },
                    ),
                    const SizedBox(height: AppDimens.spacingMd),
                    AppOutlinedButton(
                      label: 'Create Account',
                      onPressed: () {},
                      borderColor: Colors.white,
                      textColor: Colors.white,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
