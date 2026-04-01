import 'package:fintech_app/features/cards/domain/models/card_model.dart';
import 'package:fintech_app/features/cards/domain/models/recent_transaction_model.dart';

abstract class CardsDataSource {
  Future<List<CardModel>> fetchCards();
  Future<List<RecentTransactionModel>> fetchRecentTransactions();
}

class CardsDataSourceImpl implements CardsDataSource {
  @override
  Future<List<CardModel>> fetchCards() async {
    // TODO: Replace with actual API call
    await Future.delayed(const Duration(seconds: 1));
    return [
      const CardModel(cardNumber: '**** 1234', type: CardType.credit, balance: 5000.00),
      const CardModel(cardNumber: '**** 5678', type: CardType.debit, balance: 12500.00),
    ];
  }

  @override
  Future<List<RecentTransactionModel>> fetchRecentTransactions() async {
    // TODO: Replace with actual API call
    await Future.delayed(const Duration(seconds: 1));
    return [
      RecentTransactionModel(
        id: '1',
        title: 'Starbucks',
        amount: 5.50,
        date: DateTime.now().subtract(const Duration(days: 1)),
        category: 'Coffee',
      ),
      RecentTransactionModel(
        id: '2',
        title: 'Amazon',
        amount: 45.00,
        date: DateTime.now().subtract(const Duration(days: 2)),
        category: 'Shopping',
      ),
    ];
  }
}
