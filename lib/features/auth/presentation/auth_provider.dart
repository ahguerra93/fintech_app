import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fintech_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';

class AuthProvider extends StatelessWidget {
  final Widget child;
  const AuthProvider({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(create: (_) => AuthBloc(), child: child);
  }
}
