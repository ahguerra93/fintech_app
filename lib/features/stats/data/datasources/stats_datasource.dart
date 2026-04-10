import 'package:fintech_app/features/stats/domain/models/graph_data_item.dart';
import 'package:fintech_app/features/stats/domain/models/graph_data_model.dart';
import 'package:fintech_app/features/stats/domain/models/stats_transaction_model.dart';
import 'package:fintech_app/features/stats/domain/models/time_range.dart';

abstract class StatsDataSource {
  Future<GraphDataModel> fetchGraphData(TimeRange timeRange);
  Future<List<StatsTransactionModel>> fetchStatsTransactions(TimeRange timeRange);
}

class StatsDataSourceImpl implements StatsDataSource {
  @override
  Future<GraphDataModel> fetchGraphData(TimeRange timeRange) async {
    // TODO: Replace with actual API call
    await Future.delayed(const Duration(seconds: 1));
    return switch (timeRange) {
      TimeRange.week => GraphDataModel(
        items: [
          const GraphDataItem(label: 'Mon', expense: 450.0, income: 1000.0),
          const GraphDataItem(label: 'Tue', expense: 320.0, income: 1500.0),
          const GraphDataItem(label: 'Wed', expense: 600.0, income: 1200.0),
          const GraphDataItem(label: 'Thu', expense: 500.0, income: 1800.0),
          const GraphDataItem(label: 'Fri', expense: 720.0, income: 2000.0),
          const GraphDataItem(label: 'Sat', expense: 380.0, income: 1600.0),
          const GraphDataItem(label: 'Sun', expense: 590.0, income: 1900.0),
        ],
      ),
      TimeRange.month => GraphDataModel(
        items: [
          const GraphDataItem(label: 'Wk 1', expense: 2100.0, income: 5500.0),
          const GraphDataItem(label: 'Wk 2', expense: 1800.0, income: 6200.0),
          const GraphDataItem(label: 'Wk 3', expense: 2400.0, income: 5800.0),
          const GraphDataItem(label: 'Wk 4', expense: 1950.0, income: 6500.0),
        ],
      ),
      TimeRange.year => GraphDataModel(
        items: [
          const GraphDataItem(label: 'Jan', expense: 8200.0, income: 22000.0),
          const GraphDataItem(label: 'Feb', expense: 7400.0, income: 21500.0),
          const GraphDataItem(label: 'Mar', expense: 9100.0, income: 23000.0),
          const GraphDataItem(label: 'Apr', expense: 8600.0, income: 24500.0),
          const GraphDataItem(label: 'May', expense: 7900.0, income: 22800.0),
          const GraphDataItem(label: 'Jun', expense: 9500.0, income: 25000.0),
          const GraphDataItem(label: 'Jul', expense: 8800.0, income: 23600.0),
          const GraphDataItem(label: 'Aug', expense: 9200.0, income: 24000.0),
          const GraphDataItem(label: 'Sep', expense: 8400.0, income: 22500.0),
          const GraphDataItem(label: 'Oct', expense: 9700.0, income: 26000.0),
          const GraphDataItem(label: 'Nov', expense: 10200.0, income: 27500.0),
          const GraphDataItem(label: 'Dec', expense: 11500.0, income: 30000.0),
        ],
      ),
    };
  }

  @override
  Future<List<StatsTransactionModel>> fetchStatsTransactions(TimeRange timeRange) async {
    // TODO: Replace with actual API call
    await Future.delayed(const Duration(seconds: 1));
    return switch (timeRange) {
      TimeRange.week => [
        StatsTransactionModel(
          id: '1',
          title: 'Starbucks',
          amount: 5.50,
          date: DateTime.now().subtract(const Duration(days: 1)),
          category: 'Coffee',
        ),
        StatsTransactionModel(
          id: '2',
          title: 'Amazon',
          amount: 45.00,
          date: DateTime.now().subtract(const Duration(days: 2)),
          category: 'Shopping',
        ),
        StatsTransactionModel(
          id: '3',
          title: 'Uber',
          amount: 15.00,
          date: DateTime.now().subtract(const Duration(days: 3)),
          category: 'Transport',
        ),
      ],
      TimeRange.month => [
        StatsTransactionModel(
          id: '4',
          title: 'Netflix',
          amount: 15.99,
          date: DateTime.now().subtract(const Duration(days: 5)),
          category: 'Entertainment',
        ),
        StatsTransactionModel(
          id: '5',
          title: 'Grocery Store',
          amount: 120.00,
          date: DateTime.now().subtract(const Duration(days: 10)),
          category: 'Groceries',
        ),
        StatsTransactionModel(
          id: '6',
          title: 'Electricity Bill',
          amount: 85.50,
          date: DateTime.now().subtract(const Duration(days: 15)),
          category: 'Utilities',
        ),
        StatsTransactionModel(
          id: '7',
          title: 'Gym Membership',
          amount: 40.00,
          date: DateTime.now().subtract(const Duration(days: 20)),
          category: 'Health',
        ),
      ],
      TimeRange.year => [
        StatsTransactionModel(
          id: '8',
          title: 'Annual Insurance',
          amount: 1200.00,
          date: DateTime.now().subtract(const Duration(days: 30)),
          category: 'Insurance',
        ),
        StatsTransactionModel(
          id: '9',
          title: 'Tax Return',
          amount: 3500.00,
          date: DateTime.now().subtract(const Duration(days: 90)),
          category: 'Tax',
        ),
        StatsTransactionModel(
          id: '10',
          title: 'Vacation',
          amount: 2400.00,
          date: DateTime.now().subtract(const Duration(days: 180)),
          category: 'Travel',
        ),
        StatsTransactionModel(
          id: '11',
          title: 'Home Repair',
          amount: 850.00,
          date: DateTime.now().subtract(const Duration(days: 270)),
          category: 'Home',
        ),
      ],
    };
  }
}
