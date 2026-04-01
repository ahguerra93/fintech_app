import 'package:bloc/bloc.dart';
import 'package:fintech_app/features/stats/domain/models/graph_data_model.dart';
import 'package:meta/meta.dart';

part 'graph_data_event.dart';
part 'graph_data_state.dart';

class GraphDataBloc extends Bloc<GraphDataEvent, GraphDataState> {
  GraphDataBloc() : super(const GraphDataLoading()) {
    on<FetchGraphData>(_onFetchGraphData);
  }

  Future<void> _onFetchGraphData(FetchGraphData event, Emitter<GraphDataState> emit) async {
    emit(const GraphDataLoading());
    try {
      // TODO: Replace with actual repository call
      await Future.delayed(const Duration(seconds: 1));
      final dummyData = GraphDataModel(
        values: [1000, 1500, 1200, 1800, 2000, 1600, 1900],
        labels: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
      );
      emit(GraphDataSuccess(dummyData));
    } catch (e) {
      emit(GraphDataError(e.toString()));
    }
  }
}
