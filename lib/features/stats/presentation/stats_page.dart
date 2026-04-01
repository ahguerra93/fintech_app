import 'package:fintech_app/app_colors.dart';
import 'package:fintech_app/common/app_dimens.dart';
import 'package:fintech_app/common/app_formatters.dart';
import 'package:fintech_app/common/widgets/section_title.dart';
import 'package:fintech_app/common/widgets/transaction_tile.dart';
import 'package:fintech_app/features/stats/presentation/widgets/stats_bar_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fintech_app/features/stats/presentation/bloc/graph_data_bloc/graph_data_bloc.dart';
import 'package:fintech_app/features/stats/presentation/bloc/stats_transactions_bloc/stats_transactions_bloc.dart';
import 'package:fintech_app/features/stats/domain/models/graph_data_model.dart';
import 'package:fintech_app/features/stats/domain/models/stats_transaction_model.dart';

class StatsPage extends StatelessWidget {
  const StatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => GraphDataBloc()..add(const FetchGraphData())),
        BlocProvider(create: (context) => StatsTransactionsBloc()..add(const FetchStatsTransactions())),
      ],
      child: const StatsPageWidget(),
    );
  }
}

class StatsPageWidget extends StatelessWidget {
  const StatsPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: DropdownTitle(), elevation: AppDimens.elevationNone),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppDimens.spacingMd),
        child: SingleChildScrollView(
          child: Column(
            spacing: AppDimens.spacingMd,
            children: [
              BlocBuilder<GraphDataBloc, GraphDataState>(
                builder: (context, state) {
                  if (state is GraphDataLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is GraphDataSuccess) {
                    final GraphDataModel data = state.data;
                    return ChartContainer(graphData: data);
                  } else if (state is GraphDataError) {
                    return Center(child: Text('Error: ${state.message}'));
                  }
                  return const SizedBox.shrink();
                },
              ),
              const AdditionalInfoBox(),
              BlocBuilder<StatsTransactionsBloc, StatsTransactionsState>(
                builder: (context, state) {
                  if (state is StatsTransactionsLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is StatsTransactionsSuccess) {
                    return TransactionListSection(transactions: state.transactions);
                  } else if (state is StatsTransactionsError) {
                    return Center(child: Text('Error: ${state.message}'));
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DropdownTitle extends StatelessWidget {
  const DropdownTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final TextStyle style = theme.textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold);
    return DropdownButton(
      underline: SizedBox.shrink(),
      items: [
        DropdownMenuItem(
          value: 'week',
          child: Text('This Week', style: style),
        ),
        DropdownMenuItem(
          value: 'month',
          child: Text('This Month', style: style),
        ),
        DropdownMenuItem(
          value: 'year',
          child: Text('This Year', style: style),
        ),
      ],
      value: 'week',
      onChanged: (value) {},
    );
  }
}

class ChartContainer extends StatelessWidget {
  final GraphDataModel graphData;
  const ChartContainer({required this.graphData, super.key});

  @override
  Widget build(BuildContext context) {
    final themeExt = Theme.of(context).extension<AppColorTheme>()!;
    final size = MediaQuery.of(context).size;
    // Dummy values for MoneyLabel, replace with real data if available
    return Container(
      decoration: BoxDecoration(
        color: themeExt.mutedSurfaceAccent,
        borderRadius: BorderRadius.circular(AppDimens.radiusXl),
      ),
      padding: const EdgeInsets.all(AppDimens.spacingLg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppDimens.spacingMd,
        children: [
          Column(
            spacing: AppDimens.spacingXs,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MoneyLabel(
                label: 'Income',
                value: graphData.values.isNotEmpty ? graphData.values.reduce((a, b) => a > b ? a : b) : 0,
              ),
              MoneyLabel(
                label: 'Expenses',
                value: graphData.values.isNotEmpty ? graphData.values.reduce((a, b) => a < b ? a : b) : 0,
              ),
              MoneyLabel(
                label: 'Net',
                value: graphData.values.isNotEmpty ? graphData.values.reduce((a, b) => a + b) : 0,
              ),
            ],
          ),
          SizedBox(height: size.height * 0.20, child: StatsBarChart()),
        ],
      ),
    );
  }
}

class MoneyLabel extends StatelessWidget {
  const MoneyLabel({required this.label, required this.value, super.key});
  final String label;
  final double value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text.rich(
      TextSpan(
        text: '$label: ',
        style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w400),
        children: [
          TextSpan(
            text: '\$${AppFormatters.amount(value)}',
            style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class AdditionalInfoBox extends StatelessWidget {
  const AdditionalInfoBox({super.key});

  @override
  Widget build(BuildContext context) {
    final themeExt = Theme.of(context).extension<AppColorTheme>()!;
    return Container(
      decoration: BoxDecoration(color: themeExt.primary, borderRadius: BorderRadius.circular(AppDimens.radiusMd)),
      padding: const EdgeInsets.symmetric(vertical: AppDimens.spacingSm, horizontal: AppDimens.spacingMd),
      child: Column(
        spacing: AppDimens.spacingSm,
        children: [
          Row(
            spacing: AppDimens.spacingSm,
            children: [
              Icon(Icons.trending_up, color: themeExt.background),
              Flexible(
                child: Text(
                  '30% more than last week',
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium!.copyWith(color: themeExt.background, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          Divider(),
          Row(
            spacing: AppDimens.spacingSm,
            children: [
              Icon(Icons.attach_money, color: themeExt.background),
              Flexible(
                child: Text(
                  'Biggest Expense was: \$${AppFormatters.amount(1000)} on Shopping (Amazon)',
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium!.copyWith(color: themeExt.background, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TransactionListSection extends StatelessWidget {
  final List<StatsTransactionModel> transactions;
  const TransactionListSection({required this.transactions, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: AppDimens.spacingMd,
      children: [
        SectionTitle(title: 'Transactions'),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: transactions.length,
          itemBuilder: (context, index) {
            final tx = transactions[index];
            return TransactionTile(title: tx.title, amount: tx.amount, date: tx.date, category: tx.category);
          },
        ),
      ],
    );
  }
}
