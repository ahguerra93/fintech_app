import 'package:fintech_app/common/app_dimens.dart';
import 'package:fintech_app/common/widgets/section_title.dart';
import 'package:fintech_app/common/widgets/transaction_tile.dart';
import 'package:fintech_app/common/widgets/empty_state.dart';
import 'package:fintech_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:flutter/material.dart';

import 'package:fintech_app/features/cards/domain/models/recent_transaction_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class RecentPaymentsSection extends StatelessWidget {
  const RecentPaymentsSection({super.key});

  static final List<RecentTransactionModel> _loadingTransactions = List.filled(
    3,
    RecentTransactionModel(title: 'Loading', amount: 10000, date: DateTime.now(), category: 'Loading', id: ''),
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      key: const Key('recent_payments_section'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(
          key: const Key('recent_payments_title'),
          title: 'Recent Payments',
          subtitle: 'View All',
          onTap: () {},
        ),
        SizedBox(height: AppDimens.spacingMd),
        BlocBuilder<HomeBloc, HomeState>(
          buildWhen: (previous, current) =>
              (previous is HomeLoading) != (current is HomeLoading) &&
              (previous is! HomeError && current is! HomeError),
          builder: (context, state) {
            final loading = state is HomeLoading;
            final transactions = switch (state) {
              HomeSuccess(:final data) => data.recentTransactions,
              _ => _loadingTransactions,
            };

            return Skeletonizer(
              enabled: loading,
              enableSwitchAnimation: true,
              child: RepaintBoundary(
                child: transactions.isEmpty
                    ? EmptyStateWidget(message: 'No recent payments')
                    : ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: transactions.length,
                        itemBuilder: (context, index) {
                          final tx = transactions[index];
                          return TransactionTile(
                            title: tx.title,
                            amount: tx.amount,
                            date: tx.date,
                            category: tx.category,
                          );
                        },
                      ),
              ),
            );
          },
        ),
      ],
    );
  }
}
