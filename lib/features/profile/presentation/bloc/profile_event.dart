part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent {
  const ProfileEvent();
}

final class FetchProfileData extends ProfileEvent {
  const FetchProfileData();
}
