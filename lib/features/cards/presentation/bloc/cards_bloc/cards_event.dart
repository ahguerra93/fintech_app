part of 'cards_bloc.dart';

@immutable
sealed class CardsEvent {
  const CardsEvent();
}

final class FetchCards extends CardsEvent {
  final bool initial;
  const FetchCards({this.initial = false});
}
