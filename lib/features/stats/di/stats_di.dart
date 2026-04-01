import 'package:get_it/get_it.dart';
import 'package:fintech_app/features/stats/data/datasources/stats_datasource.dart';
import 'package:fintech_app/features/stats/data/repositories/stats_repository_impl.dart';
import 'package:fintech_app/features/stats/domain/repositories/stats_repository.dart';
import 'package:fintech_app/features/stats/domain/usecases/fetch_graph_data.dart';
import 'package:fintech_app/features/stats/domain/usecases/fetch_stats_transactions.dart';

void initStatsDependencies(GetIt getIt) {
  // DataSource
  getIt.registerLazySingleton<StatsDataSource>(() => StatsDataSourceImpl());

  // Repository
  getIt.registerLazySingleton<StatsRepository>(() => StatsRepositoryImpl(dataSource: getIt()));

  // Use Cases
  getIt.registerFactory(() => FetchGraphDataUseCase(repository: getIt()));
  getIt.registerFactory(() => FetchStatsTransactionsUseCase(repository: getIt()));
}
