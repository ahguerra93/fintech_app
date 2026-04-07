part of 'home_bloc.dart';

@immutable
sealed class HomeState {
  const HomeState();
}

final class HomeLoading extends HomeState {
  final bool initial;
  const HomeLoading({this.initial = false});
}

final class HomeSuccess extends HomeState {
  final HomeData data;
  const HomeSuccess(this.data);
}

final class HomeError extends HomeState {
  final String message;
  const HomeError(this.message);
}
