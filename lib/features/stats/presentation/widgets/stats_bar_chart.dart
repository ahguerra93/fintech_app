import 'package:fintech_app/app_colors.dart';
import 'package:fintech_app/common/app_dimens.dart';
import 'package:fintech_app/features/stats/domain/models/graph_data_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class StatsBarChart extends StatefulWidget {
  final GraphDataModel graphData;

  const StatsBarChart({required this.graphData, super.key});

  final Color leftBarColor = AppColors.primary;
  final Color rightBarColor = AppColors.primaryDark;

  @override
  State<StatefulWidget> createState() => StatsBarChartState();
}

class StatsBarChartState extends State<StatsBarChart> {
  final double width = 10;

  late List<BarChartGroupData> rawBarGroups;
  late List<BarChartGroupData> showingBarGroups;
  late double maxY;

  int touchedGroupIndex = -1;

  @override
  void initState() {
    super.initState();
    _initializeBarGroups();
  }

  void _initializeBarGroups() {
    // Calculate maxY based on actual data
    double maxValue = 0;
    for (final item in widget.graphData.items) {
      if (item.income > maxValue) maxValue = item.income;
      if (item.expense > maxValue) maxValue = item.expense;
    }
    maxY = maxValue > 0 ? maxValue * 1.1 : 20; // Add 10% padding, or default to 20

    // Create bar groups from graphData items
    final items = <BarChartGroupData>[];
    for (int i = 0; i < widget.graphData.items.length; i++) {
      final item = widget.graphData.items[i];
      items.add(makeGroupData(i, item.income, item.expense));
    }

    rawBarGroups = items;
    showingBarGroups = rawBarGroups;
  }

  @override
  Widget build(BuildContext context) {
    final themeExt = Theme.of(context).extension<AppColorTheme>()!;
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceBetween,
        maxY: maxY,
        barTouchData: BarTouchData(
          touchTooltipData: BarTouchTooltipData(
            getTooltipColor: (_) => themeExt.textSecondary,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              return BarTooltipItem(
                rod.toY.toStringAsFixed(2),
                TextStyle(color: themeExt.background, fontWeight: FontWeight.bold, fontSize: 13),
              );
            },
          ),
          touchCallback: (FlTouchEvent event, response) {
            setState(() {
              if (!event.isInterestedForInteractions || response == null || response.spot == null) {
                touchedGroupIndex = -1;
                return;
              }
              touchedGroupIndex = response.spot!.touchedBarGroupIndex;
            });
          },
        ),
        titlesData: FlTitlesData(
          show: true,
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            axisNameSize: AppDimens.spacingMd,
            sideTitles: SideTitles(showTitles: true, getTitlesWidget: bottomTitles, reservedSize: 20),
          ),
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(show: false),
        barGroups: showingBarGroups,
        gridData: const FlGridData(show: false),
      ),
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    final themeExt = Theme.of(context).extension<AppColorTheme>()!;
    final index = value.toInt();
    final label = index < widget.graphData.items.length ? widget.graphData.items[index].label : '';

    final Widget text = Text(
      label,
      style: TextStyle(color: themeExt.textSecondary, fontWeight: FontWeight.bold, fontSize: 14),
    );

    return SideTitleWidget(meta: meta, space: AppDimens.spacingXs, child: text);
  }

  BarChartGroupData makeGroupData(int x, double income, double expense) {
    return BarChartGroupData(
      barsSpace: AppDimens.spacingXs,
      x: x,
      barRods: [
        BarChartRodData(toY: income, color: widget.leftBarColor, width: width),
        BarChartRodData(toY: expense, color: widget.rightBarColor, width: width),
      ],
    );
  }
}
