import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fintech_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';

class AuthProviders extends StatelessWidget {
  final Widget child;
  const AuthProviders({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) => AuthBloc(), child: child);
  }
}
