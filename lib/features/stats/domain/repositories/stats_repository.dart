import 'package:fintech_app/features/stats/domain/models/graph_data_model.dart';
import 'package:fintech_app/features/stats/domain/models/stats_transaction_model.dart';

abstract class StatsRepository {
  Future<GraphDataModel> fetchGraphData();
  Future<List<StatsTransactionModel>> fetchStatsTransactions();
}
