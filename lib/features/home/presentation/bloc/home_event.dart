part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {
  const HomeEvent();
}

final class FetchHomeData extends HomeEvent {
  final bool initial;
  const FetchHomeData({this.initial = false});
}
