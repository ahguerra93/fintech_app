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
      values: [1000, 1500, 1200, 1800, 2000, 1600, 1900],
      labels: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
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
