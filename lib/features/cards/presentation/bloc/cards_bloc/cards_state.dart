part of 'cards_bloc.dart';

@immutable
sealed class CardsState {
  const CardsState();
}

final class CardsLoading extends CardsState {
  const CardsLoading();
}

final class CardsSuccess extends CardsState {
  final List<CardModel> cards;
  const CardsSuccess(this.cards);
}

final class CardsError extends CardsState {
  final String message;
  const CardsError(this.message);
}
