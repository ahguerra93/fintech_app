import 'package:fintech_app/features/cards/domain/models/card_model.dart';
import 'package:fintech_app/features/cards/domain/models/recent_transaction_model.dart';

class HomeData {
  final String firstName;
  final double balance;
  final List<CardModel> cards;
  final List<RecentTransactionModel> recentTransactions;

  const HomeData({
    required this.firstName,
    required this.balance,
    required this.cards,
    required this.recentTransactions,
  });

  HomeData copyWith({
    String? firstName,
    double? balance,
    List<CardModel>? cards,
    List<RecentTransactionModel>? recentTransactions,
  }) {
    return HomeData(
      firstName: firstName ?? this.firstName,
      balance: balance ?? this.balance,
      cards: cards ?? this.cards,
      recentTransactions: recentTransactions ?? this.recentTransactions,
    );
  }
}
