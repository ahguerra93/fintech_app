import 'package:get_it/get_it.dart';
import 'package:fintech_app/features/profile/data/datasources/profile_datasource.dart';
import 'package:fintech_app/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:fintech_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:fintech_app/features/profile/domain/usecases/fetch_profile_data.dart';

void initProfileDependencies(GetIt getIt) {
  // DataSource
  getIt.registerLazySingleton<ProfileDataSource>(() => ProfileDataSourceImpl());

  // Repository
  getIt.registerLazySingleton<ProfileRepository>(() => ProfileRepositoryImpl(dataSource: getIt()));

  // Use Case
  getIt.registerFactory(() => FetchProfileDataUseCase(repository: getIt()));
}
