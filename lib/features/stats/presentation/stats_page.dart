import 'package:fintech_app/app_colors.dart';
import 'package:fintech_app/common/app_dimens.dart';
import 'package:fintech_app/common/app_formatters.dart';
import 'package:fintech_app/common/widgets/section_title.dart';
import 'package:fintech_app/common/widgets/transaction_tile.dart';
import 'package:fintech_app/features/stats/presentation/widgets/stats_bar_chart.dart';
import 'package:flutter/material.dart';

class StatsPage extends StatelessWidget {
  const StatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: DropdownTitle(), elevation: AppDimens.elevationNone),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppDimens.spacingMd),
        child: SingleChildScrollView(
          child: Column(
            spacing: AppDimens.spacingMd,
            children: [ChartContainer(), AdditionalInfoBox(), TransactionListSection()],
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
  const ChartContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final themeExt = Theme.of(context).extension<AppColorTheme>()!;

    final size = MediaQuery.of(context).size;
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
              // Text('This Week', style: theme.textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold)),
              // SizedBox(height: 4.0),
              MoneyLabel(label: 'Income', value: 5000),
              MoneyLabel(label: 'Expenses', value: 3000),
              MoneyLabel(label: 'Net', value: 2000),
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
  const TransactionListSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: AppDimens.spacingMd,
      children: [
        SectionTitle(title: 'Transactions'),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: 5,
          itemBuilder: (context, index) {
            return TransactionTile();
          },
        ),
      ],
    );
  }
}
