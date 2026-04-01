import 'package:fintech_app/features/stats/domain/models/graph_data_model.dart';
import 'package:fintech_app/features/stats/domain/repositories/stats_repository.dart';

class FetchGraphDataUseCase {
  final StatsRepository repository;

  FetchGraphDataUseCase({required this.repository});

  Future<GraphDataModel> call() async {
    return await repository.fetchGraphData();
  }
}
