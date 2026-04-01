import 'package:fintech_app/features/stats/data/datasources/stats_datasource.dart';
import 'package:fintech_app/features/stats/domain/models/graph_data_model.dart';
import 'package:fintech_app/features/stats/domain/models/stats_transaction_model.dart';
import 'package:fintech_app/features/stats/domain/repositories/stats_repository.dart';

class StatsRepositoryImpl implements StatsRepository {
  final StatsDataSource dataSource;

  StatsRepositoryImpl({required this.dataSource});

  @override
  Future<GraphDataModel> fetchGraphData() async {
    return await dataSource.fetchGraphData();
  }

  @override
  Future<List<StatsTransactionModel>> fetchStatsTransactions() async {
    return await dataSource.fetchStatsTransactions();
  }
}
