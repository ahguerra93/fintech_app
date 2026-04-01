import 'package:fintech_app/features/home/domain/models/home_data.dart';

abstract class HomeRepository {
  Future<HomeData> fetchHomeData();
}
