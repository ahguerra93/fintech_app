import 'package:fintech_app/features/profile/domain/models/profile_data.dart';

abstract class ProfileRepository {
  Future<ProfileData> fetchProfileData();
}
