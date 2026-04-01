import 'package:fintech_app/features/cards/domain/models/card_model.dart';
import 'package:fintech_app/features/cards/domain/models/recent_transaction_model.dart';

abstract class CardsRepository {
  Future<List<CardModel>> fetchCards();
  Future<List<RecentTransactionModel>> fetchRecentTransactions();
}
