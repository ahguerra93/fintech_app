import 'package:get_it/get_it.dart';
import 'package:fintech_app/features/transfers/data/datasources/transfer_datasource.dart';
import 'package:fintech_app/features/transfers/data/repositories/transfer_repository_impl.dart';
import 'package:fintech_app/features/transfers/domain/repositories/transfer_repository.dart';
import 'package:fintech_app/features/transfers/domain/usecases/transfer.dart';

void initTransferDependencies(GetIt getIt) {
  getIt.registerLazySingleton<TransferDataSource>(() => TransferDataSourceImpl());
  getIt.registerLazySingleton<TransferRepository>(() => TransferRepositoryImpl(dataSource: getIt()));
  getIt.registerFactory(() => TransferUseCase(repository: getIt()));
}
