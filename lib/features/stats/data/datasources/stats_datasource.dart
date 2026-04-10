import 'package:fintech_app/features/stats/domain/models/graph_data_item.dart';
import 'package:fintech_app/features/stats/domain/models/graph_data_model.dart';
import 'package:fintech_app/features/stats/domain/models/stats_transaction_model.dart';

abstract class StatsDataSource {
  Future<GraphDataModel> fetchGraphData();
  Future<List<StatsTransactionModel>> fetchStatsTransactions();
}

class StatsDataSourceImpl implements StatsDataSource {
  @override
  Future<GraphDataModel> fetchGraphData() async {
    // TODO: Replace with actual API call
    await Future.delayed(const Duration(seconds: 1));
    return GraphDataModel(
      items: [
        const GraphDataItem(label: 'Mon', expense: 450.0, income: 1000.0),
        const GraphDataItem(label: 'Tue', expense: 320.0, income: 1500.0),
        const GraphDataItem(label: 'Wed', expense: 600.0, income: 1200.0),
        const GraphDataItem(label: 'Thu', expense: 500.0, income: 1800.0),
        const GraphDataItem(label: 'Fri', expense: 720.0, income: 2000.0),
        const GraphDataItem(label: 'Sat', expense: 380.0, income: 1600.0),
        const GraphDataItem(label: 'Sun', expense: 590.0, income: 1900.0),
      ],
    );
  }

  @override
  Future<List<StatsTransactionModel>> fetchStatsTransactions() async {
    // TODO: Replace with actual API call
    await Future.delayed(const Duration(seconds: 1));
    return [
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
    ];
  }
}
