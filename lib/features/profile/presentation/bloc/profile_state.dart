part of 'profile_bloc.dart';

@immutable
sealed class ProfileState {
  const ProfileState();
}

final class ProfileLoading extends ProfileState {
  final bool initial;
  const ProfileLoading({this.initial = false});
}

final class ProfileSuccess extends ProfileState {
  final ProfileData data;
  const ProfileSuccess(this.data);
}

final class ProfileError extends ProfileState {
  final String message;
  const ProfileError(this.message);
}
