import 'package:fintech_app/app_colors.dart';
import 'package:fintech_app/common/app_dimens.dart';
import 'package:fintech_app/common/app_formatters.dart';
import 'package:fintech_app/common/widgets/error_screen.dart';
import 'package:fintech_app/common/widgets/section_title.dart';
import 'package:fintech_app/common/widgets/transaction_tile.dart';
import 'package:fintech_app/config/routing/router.dart';
import 'package:fintech_app/features/dev_tools/presentation/cubit/devtools_cubit.dart';
import 'package:fintech_app/features/stats/presentation/widgets/stats_bar_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fintech_app/features/stats/presentation/bloc/graph_data_bloc/graph_data_bloc.dart';
import 'package:fintech_app/features/stats/presentation/bloc/stats_transactions_bloc/stats_transactions_bloc.dart';
import 'package:fintech_app/features/stats/domain/models/graph_data_model.dart';
import 'package:fintech_app/features/stats/domain/models/stats_transaction_model.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

class StatsPage extends StatelessWidget {
  const StatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => GraphDataBloc(context.read<DevToolsCubit>())..add(const FetchGraphData())),
        BlocProvider(
          create: (context) =>
              StatsTransactionsBloc(context.read<DevToolsCubit>())..add(const FetchStatsTransactions()),
        ),
      ],
      child: const StatsPageWidget(),
    );
  }
}

class StatsPageWidget extends StatefulWidget {
  const StatsPageWidget({super.key});

  @override
  State<StatsPageWidget> createState() => _StatsPageWidgetState();
}

class _StatsPageWidgetState extends State<StatsPageWidget> {
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

    if (newLocation == AppRoutes.stats) {
      context.read<GraphDataBloc>().add(const FetchGraphData());
      context.read<StatsTransactionsBloc>().add(const FetchStatsTransactions());
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
      appBar: AppBar(title: DropdownTitle(), elevation: AppDimens.elevationNone),
      body: BlocBuilder<GraphDataBloc, GraphDataState>(
        buildWhen: (previous, current) => (previous is GraphDataError) != (current is GraphDataError),
        builder: (context, state) {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 350),
            child: switch (state) {
              GraphDataError(:final message) => ErrorScreen(
                key: const ValueKey('stats_error'),
                message: message,
                onRetry: () {
                  context.read<GraphDataBloc>().add(const FetchGraphData());
                  context.read<StatsTransactionsBloc>().add(const FetchStatsTransactions());
                },
              ),
              _ => Container(
                key: const ValueKey('stats_content'),
                height: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: AppDimens.spacingMd),
                child: SingleChildScrollView(
                  child: Column(
                    spacing: AppDimens.spacingMd,
                    children: [const _GraphSection(), const AdditionalInfoBox(), const _TransactionsSection()],
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

class _GraphSection extends StatelessWidget {
  const _GraphSection();

  static final GraphDataModel _dummyGraphData = GraphDataModel(
    labels: List.filled(7, 'Loading'),
    values: List.filled(7, 500.0),
  );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GraphDataBloc, GraphDataState>(
      buildWhen: (previous, current) =>
          (previous is GraphDataLoading) != (current is GraphDataLoading) &&
          (previous is! GraphDataError && current is! GraphDataError),
      builder: (context, state) {
        final loading = state is GraphDataLoading;
        final graphData = loading ? _dummyGraphData : (state as GraphDataSuccess).data;

        return Skeletonizer(
          enabled: loading,
          enableSwitchAnimation: true,
          child: ChartContainer(graphData: graphData),
        );
      },
    );
  }
}

class _TransactionsSection extends StatelessWidget {
  const _TransactionsSection();

  static final List<StatsTransactionModel> _dummyTransactions = List.filled(
    3,
    StatsTransactionModel(title: 'Loading', amount: 100.0, date: DateTime.now(), category: 'Loading', id: ''),
  );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatsTransactionsBloc, StatsTransactionsState>(
      buildWhen: (previous, current) =>
          (previous is StatsTransactionsLoading) != (current is StatsTransactionsLoading) &&
          (previous is! StatsTransactionsError && current is! StatsTransactionsError),
      builder: (context, state) {
        final transactions = switch (state) {
          StatsTransactionsLoading() => _dummyTransactions,
          StatsTransactionsSuccess s => s.transactions,
          _ => const <StatsTransactionModel>[],
        };
        final loading = state is StatsTransactionsLoading;
        return Skeletonizer(
          enabled: loading,
          enableSwitchAnimation: true,
          child: TransactionListSection(transactions: transactions),
        );
      },
    );
  }
}
