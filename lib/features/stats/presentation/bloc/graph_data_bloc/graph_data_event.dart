part of 'graph_data_bloc.dart';

@immutable
sealed class GraphDataEvent {
  const GraphDataEvent();
}

final class FetchGraphData extends GraphDataEvent {
  final TimeRange timeRange;
  const FetchGraphData({this.timeRange = TimeRange.week});
}
