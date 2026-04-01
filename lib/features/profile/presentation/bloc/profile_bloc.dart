import 'package:fintech_app/di/di.dart';
import 'package:fintech_app/features/profile/domain/models/profile_data.dart';
import 'package:fintech_app/features/profile/domain/usecases/fetch_profile_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final FetchProfileDataUseCase _fetchProfileDataUseCase;
  ProfileBloc() : _fetchProfileDataUseCase = getIt<FetchProfileDataUseCase>(), super(const ProfileLoading()) {
    on<FetchProfileData>(_onFetchProfileData);
  }

  Future<void> _onFetchProfileData(FetchProfileData event, Emitter<ProfileState> emit) async {
    emit(const ProfileLoading());
    try {
      final profileData = await _fetchProfileDataUseCase();
      emit(ProfileSuccess(profileData));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
}
