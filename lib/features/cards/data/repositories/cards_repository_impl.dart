import 'package:fintech_app/features/cards/data/datasources/cards_datasource.dart';
import 'package:fintech_app/features/cards/domain/models/card_model.dart';
import 'package:fintech_app/features/cards/domain/models/recent_transaction_model.dart';
import 'package:fintech_app/features/cards/domain/repositories/cards_repository.dart';

class CardsRepositoryImpl implements CardsRepository {
  final CardsDataSource dataSource;

  CardsRepositoryImpl({required this.dataSource});

  @override
  Future<List<CardModel>> fetchCards() async {
    return await dataSource.fetchCards();
  }

  @override
  Future<List<RecentTransactionModel>> fetchRecentTransactions() async {
    return await dataSource.fetchRecentTransactions();
  }
}
