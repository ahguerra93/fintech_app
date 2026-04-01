import 'package:fintech_app/features/profile/domain/models/profile_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(const ProfileLoading()) {
    on<FetchProfileData>(_onFetchProfileData);
  }

  Future<void> _onFetchProfileData(FetchProfileData event, Emitter<ProfileState> emit) async {
    emit(const ProfileLoading());
    try {
      // TODO: Replace with actual repository call
      await Future.delayed(const Duration(seconds: 1));
      const dummyData = ProfileData(name: 'Andres Heredia', email: 'andres@email.com', accountId: '**** 1234');
      emit(ProfileSuccess(dummyData));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
}
