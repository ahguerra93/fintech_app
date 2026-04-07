part of 'cards_bloc.dart';

@immutable
sealed class CardsState {
  const CardsState();
}

final class CardsLoading extends CardsState {
  final bool initial;
  const CardsLoading({this.initial = false});
}

final class CardsSuccess extends CardsState {
  final List<CardModel> cards;
  const CardsSuccess(this.cards);
}

final class CardsError extends CardsState {
  final String message;
  const CardsError(this.message);
}
