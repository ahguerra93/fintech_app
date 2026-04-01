import 'package:fintech_app/di/di.dart';
import 'package:fintech_app/features/stats/domain/models/graph_data_model.dart';
import 'package:fintech_app/features/stats/domain/usecases/fetch_graph_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'graph_data_event.dart';
part 'graph_data_state.dart';

class GraphDataBloc extends Bloc<GraphDataEvent, GraphDataState> {
  final FetchGraphDataUseCase _fetchGraphDataUseCase;
  GraphDataBloc() : _fetchGraphDataUseCase = getIt<FetchGraphDataUseCase>(), super(const GraphDataLoading()) {
    on<FetchGraphData>(_onFetchGraphData);
  }

  Future<void> _onFetchGraphData(FetchGraphData event, Emitter<GraphDataState> emit) async {
    emit(const GraphDataLoading());
    try {
      final graphData = await _fetchGraphDataUseCase();
      emit(GraphDataSuccess(graphData));
    } catch (e) {
      emit(GraphDataError(e.toString()));
    }
  }
}
