import 'package:fintech_app/features/stats/domain/models/stats_transaction_model.dart';
import 'package:fintech_app/features/stats/domain/repositories/stats_repository.dart';

class FetchStatsTransactionsUseCase {
  final StatsRepository repository;

  FetchStatsTransactionsUseCase({required this.repository});

  Future<List<StatsTransactionModel>> call() async {
    return await repository.fetchStatsTransactions();
  }
}
