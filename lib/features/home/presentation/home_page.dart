import 'package:fintech_app/common/widgets/error_screen.dart';
import 'package:fintech_app/config/routing/router.dart';
import 'package:fintech_app/features/dev_tools/presentation/cubit/devtools_cubit.dart';
import 'package:fintech_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:fintech_app/features/home/presentation/widgets/balance_widget.dart';
import 'package:fintech_app/features/home/presentation/widgets/card_section.dart';
import 'package:fintech_app/features/home/presentation/widgets/home_actions.dart';
import 'package:fintech_app/features/home/presentation/widgets/home_appbar.dart';
import 'package:fintech_app/features/home/presentation/widgets/recent_payments_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(context.read<DevToolsCubit>())..add(FetchHomeData()),
      child: const HomePageWidget(),
    );
  }
}

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({super.key});

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
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

    if (newLocation == AppRoutes.home) {
      context.read<HomeBloc>().add(FetchHomeData());
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
    return Scaffold(
      appBar: const HomeAppBar(userName: 'Kimberly'),
      body: BlocBuilder<HomeBloc, HomeState>(
        buildWhen: (previous, current) => (previous is HomeError) != (current is HomeError),
        builder: (context, state) {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 350),
            child: switch (state) {
              HomeError(:final message) => ErrorScreen(
                key: const ValueKey('error_home_content'),
                message: message,
                onRetry: () => context.read<HomeBloc>().add(FetchHomeData()),
              ),
              _ => SingleChildScrollView(
                key: const ValueKey('home_content'),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 32.0),
                  child: Column(
                    spacing: 16.0,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: RepaintBoundary(child: BalanceWidget()),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: RepaintBoundary(child: HomeActions()),
                      ),
                      RepaintBoundary(child: CardSection()),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: RepaintBoundary(child: RecentPaymentsSection()),
                      ),
                    ],
                  ),
                ),
              ),
            },
          );
        },
      ),
    );
  }
}
