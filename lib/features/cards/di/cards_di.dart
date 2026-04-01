import 'package:get_it/get_it.dart';
import 'package:fintech_app/features/cards/data/datasources/cards_datasource.dart';
import 'package:fintech_app/features/cards/data/repositories/cards_repository_impl.dart';
import 'package:fintech_app/features/cards/domain/repositories/cards_repository.dart';
import 'package:fintech_app/features/cards/domain/usecases/fetch_cards.dart';
import 'package:fintech_app/features/cards/domain/usecases/fetch_recent_transactions.dart';

void initCardsDependencies(GetIt getIt) {
  // DataSource
  getIt.registerLazySingleton<CardsDataSource>(() => CardsDataSourceImpl());

  // Repository
  getIt.registerLazySingleton<CardsRepository>(() => CardsRepositoryImpl(dataSource: getIt()));

  // Use Cases
  getIt.registerFactory(() => FetchCardsUseCase(repository: getIt()));
  getIt.registerFactory(() => FetchRecentTransactionsUseCase(repository: getIt()));
}
