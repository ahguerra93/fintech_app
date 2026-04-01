import 'package:fintech_app/features/cards/domain/models/card_model.dart';
import 'package:fintech_app/features/cards/domain/repositories/cards_repository.dart';

class FetchCardsUseCase {
  final CardsRepository repository;

  FetchCardsUseCase({required this.repository});

  Future<List<CardModel>> call() async {
    return await repository.fetchCards();
  }
}
