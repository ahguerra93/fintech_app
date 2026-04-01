import 'package:fintech_app/features/cards/domain/models/recent_transaction_model.dart';
import 'package:fintech_app/features/cards/domain/repositories/cards_repository.dart';

class FetchRecentTransactionsUseCase {
  final CardsRepository repository;

  FetchRecentTransactionsUseCase({required this.repository});

  Future<List<RecentTransactionModel>> call() async {
    return await repository.fetchRecentTransactions();
  }
}
