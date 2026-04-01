import 'package:fintech_app/features/profile/domain/models/profile_data.dart';

abstract class ProfileDataSource {
  Future<ProfileData> fetchProfileData();
}

class ProfileDataSourceImpl implements ProfileDataSource {
  @override
  Future<ProfileData> fetchProfileData() async {
    // TODO: Replace with actual API call
    await Future.delayed(const Duration(seconds: 1));
    const dummyData = ProfileData(name: 'Andres Heredia', email: 'andres@email.com', accountId: '**** 1234');
    return dummyData;
  }
}
