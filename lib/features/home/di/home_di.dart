import 'package:get_it/get_it.dart';
import 'package:fintech_app/features/home/data/datasources/home_datasource.dart';
import 'package:fintech_app/features/home/data/repositories/home_repository_impl.dart';
import 'package:fintech_app/features/home/domain/repositories/home_repository.dart';
import 'package:fintech_app/features/home/domain/usecases/fetch_home_data.dart';

void initHomeDependencies(GetIt getIt) {
  // DataSource
  getIt.registerLazySingleton<HomeDataSource>(() => HomeDataSourceImpl());

  // Repository
  getIt.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl(dataSource: getIt()));

  // Use Case
  getIt.registerFactory(() => FetchHomeDataUseCase(repository: getIt()));
}
