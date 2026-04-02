import 'package:fintech_app/app_colors.dart';
import 'package:fintech_app/common/app_assets.dart';
import 'package:fintech_app/common/app_dimens.dart';
import 'package:fintech_app/config/routing/router.dart';
import 'package:fintech_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController textEditingController = TextEditingController(text: 'user@email.com');
    final TextEditingController passwordController = TextEditingController(text: '1234');
    final theme = Theme.of(context);
    final themeExt = theme.extension<AppColorTheme>()!;
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Center(
                child: Container(
                  width: double.maxFinite,
                  color: themeExt.mutedSurfaceAccent,
                  padding: const EdgeInsets.symmetric(vertical: AppDimens.spacingMd),
                  child: SafeArea(child: Image.asset(AppAssets.logoFinal, fit: BoxFit.contain)),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(AppDimens.spacingXxl),

                child: BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is Authorized) {
                      context.go(AppRoutes.home);
                    }
                  },
                  builder: (context, state) {
                    final isLoading = state is AuthLoading;
                    final isError = state is AuthError;
                    return SingleChildScrollView(
                      child: Column(
                        spacing: AppDimens.spacingXl,
                        children: [
                          Text('Hello', style: theme.textTheme.displayLarge),
                          Text(
                            'Welcome to Fintech App, where you manage your finances effortlessly.',
                            style: theme.textTheme.titleSmall?.copyWith(color: themeExt.textSecondary),
                          ),
                          TextFormField(
                            controller: textEditingController,
                            decoration: const InputDecoration(labelText: 'Email'),
                          ),
                          TextFormField(
                            controller: passwordController,
                            decoration: const InputDecoration(labelText: 'Password'),
                            obscureText: true,
                          ),
                          if (isError)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Text((state).message, style: TextStyle(color: theme.colorScheme.error)),
                            ),
                          ElevatedButton(
                            onPressed: isLoading
                                ? null
                                : () {
                                    context.read<AuthBloc>().add(
                                      LoginRequested(textEditingController.text, passwordController.text),
                                    );
                                  },
                            child: isLoading ? const CircularProgressIndicator() : const Text('Login'),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
