import 'package:fintech_app/features/home/domain/models/home_data.dart';
import 'package:fintech_app/features/home/domain/repositories/home_repository.dart';

class FetchHomeDataUseCase {
  final HomeRepository repository;

  FetchHomeDataUseCase({required this.repository});

  Future<HomeData> call() async {
    return await repository.fetchHomeData();
  }
}
