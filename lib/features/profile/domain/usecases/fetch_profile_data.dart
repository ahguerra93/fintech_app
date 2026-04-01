import 'package:fintech_app/features/profile/domain/models/profile_data.dart';
import 'package:fintech_app/features/profile/domain/repositories/profile_repository.dart';

class FetchProfileDataUseCase {
  final ProfileRepository repository;

  FetchProfileDataUseCase({required this.repository});

  Future<ProfileData> call() async {
    return await repository.fetchProfileData();
  }
}
