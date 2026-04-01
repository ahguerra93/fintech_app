import 'package:fintech_app/features/home/presentation/widgets/balance_widget.dart';
import 'package:fintech_app/features/home/presentation/widgets/card_section.dart';
import 'package:fintech_app/features/home/presentation/widgets/home_actions.dart';
import 'package:fintech_app/features/home/presentation/widgets/home_appbar.dart';
import 'package:fintech_app/features/home/presentation/widgets/recent_payments_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fintech_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:fintech_app/features/home/domain/models/home_data.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeBloc()..add(const FetchHomeData()),
      child: Scaffold(
        appBar: const HomeAppBar(userName: 'Kimberly'),
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is HomeSuccess) {
              final HomeData data = state.data;
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 32.0),
                  child: Column(
                    spacing: 16.0,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: BalanceWidget(balance: data.balance),
                      ),
                      Padding(padding: const EdgeInsets.symmetric(horizontal: 16.0), child: HomeActions()),
                      CardSection(cards: data.cards),
                      RecentPaymentsSection(transactions: data.recentTransactions),
                    ],
                  ),
                ),
              );
            } else if (state is HomeError) {
              return Center(child: Text('Error: ${state.message}'));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
