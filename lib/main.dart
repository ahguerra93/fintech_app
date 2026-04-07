import 'package:fintech_app/app_theme.dart';
import 'package:fintech_app/config/routing/router.dart';
import 'package:fintech_app/di/di.dart';
import 'package:fintech_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:fintech_app/features/dev_tools/presentation/cubit/devtools_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initDependencies();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final RouterConfig<Object> router;

  @override
  void initState() {
    router = AppRouter.router;
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc()),
        BlocProvider(create: (context) => DevToolsCubit()),
      ],
      child: MaterialApp.router(
        title: 'Flutter Demo',
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        routerConfig: router,
      ),
    );
  }
}
