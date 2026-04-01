import 'package:fintech_app/features/cards/domain/models/card_model.dart';
import 'package:fintech_app/features/cards/domain/models/recent_transaction_model.dart';
import 'package:fintech_app/features/home/domain/models/home_data.dart';

abstract class HomeDataSource {
  Future<HomeData> fetchHomeData();
}

class HomeDataSourceImpl implements HomeDataSource {
  @override
  Future<HomeData> fetchHomeData() async {
    // TODO: Replace with actual API calls
    await Future.delayed(const Duration(seconds: 1));

    final dummyCards = [
      const CardModel(cardNumber: '**** 1234', type: CardType.credit, balance: 5000.00),
      const CardModel(cardNumber: '**** 5678', type: CardType.debit, balance: 12500.00),
    ];

    final dummyTransactions = [
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

    return HomeData(balance: 25000.00, cards: dummyCards, recentTransactions: dummyTransactions);
  }
}
