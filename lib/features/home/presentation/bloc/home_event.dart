part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {
  const HomeEvent();
}

final class FetchHomeData extends HomeEvent {
  const FetchHomeData();
}
