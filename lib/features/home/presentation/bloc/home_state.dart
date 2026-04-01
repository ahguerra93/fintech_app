part of 'home_bloc.dart';

@immutable
sealed class HomeState {
  const HomeState();
}

final class HomeLoading extends HomeState {
  const HomeLoading();
}

final class HomeSuccess extends HomeState {
  final HomeData data;
  const HomeSuccess(this.data);
}

final class HomeError extends HomeState {
  final String message;
  const HomeError(this.message);
}
