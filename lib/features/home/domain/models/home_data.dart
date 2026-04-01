import 'package:fintech_app/features/cards/domain/models/card_model.dart';
import 'package:fintech_app/features/cards/domain/models/recent_transaction_model.dart';

class HomeData {
  final double balance;
  final List<CardModel> cards;
  final List<RecentTransactionModel> recentTransactions;

  const HomeData({required this.balance, required this.cards, required this.recentTransactions});

  HomeData copyWith({double? balance, List<CardModel>? cards, List<RecentTransactionModel>? recentTransactions}) {
    return HomeData(
      balance: balance ?? this.balance,
      cards: cards ?? this.cards,
      recentTransactions: recentTransactions ?? this.recentTransactions,
    );
  }
}
