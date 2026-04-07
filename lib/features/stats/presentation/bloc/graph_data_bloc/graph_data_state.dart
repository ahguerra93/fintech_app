part of 'graph_data_bloc.dart';

@immutable
sealed class GraphDataState {
  const GraphDataState();
}

final class GraphDataLoading extends GraphDataState {
  final bool initial;
  const GraphDataLoading({this.initial = false});
}

final class GraphDataSuccess extends GraphDataState {
  final GraphDataModel data;
  const GraphDataSuccess(this.data);
}

final class GraphDataError extends GraphDataState {
  final String message;
  const GraphDataError(this.message);
}
