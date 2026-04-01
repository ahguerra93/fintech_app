import 'package:fintech_app/features/profile/data/datasources/profile_datasource.dart';
import 'package:fintech_app/features/profile/domain/models/profile_data.dart';
import 'package:fintech_app/features/profile/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileDataSource dataSource;

  ProfileRepositoryImpl({required this.dataSource});

  @override
  Future<ProfileData> fetchProfileData() async {
    return await dataSource.fetchProfileData();
  }
}
