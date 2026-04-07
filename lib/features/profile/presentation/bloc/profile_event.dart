part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent {
  const ProfileEvent();
}

final class FetchProfileData extends ProfileEvent {
  final bool initial;
  const FetchProfileData({this.initial = false});
}
