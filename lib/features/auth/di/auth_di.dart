import 'package:get_it/get_it.dart';
import 'package:fintech_app/features/auth/data/datasources/auth_datasource.dart';
import 'package:fintech_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:fintech_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:fintech_app/features/auth/domain/usecases/login.dart';

void initAuthDependencies(GetIt getIt) {
  getIt.registerLazySingleton<AuthDataSource>(() => AuthDataSourceImpl());
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(dataSource: getIt()));
  getIt.registerFactory(() => LoginUseCase(repository: getIt()));
}
