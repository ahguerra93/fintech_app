import 'package:fintech_app/features/home/data/datasources/home_datasource.dart';
import 'package:fintech_app/features/home/domain/models/home_data.dart';
import 'package:fintech_app/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeDataSource dataSource;

  HomeRepositoryImpl({required this.dataSource});

  @override
  Future<HomeData> fetchHomeData() async {
    return await dataSource.fetchHomeData();
  }
}
