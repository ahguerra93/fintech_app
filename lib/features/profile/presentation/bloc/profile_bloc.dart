import 'package:fintech_app/di/di.dart';
import 'package:fintech_app/features/profile/domain/models/profile_data.dart';
import 'package:fintech_app/features/profile/domain/usecases/fetch_profile_data.dart';
import 'package:fintech_app/features/dev_tools/presentation/cubit/devtools_cubit.dart';
import 'package:fintech_app/features/dev_tools/presentation/cubit/devtools_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final FetchProfileDataUseCase _fetchProfileDataUseCase;
  final DevToolsCubit _devToolsCubit;

  ProfileBloc(this._devToolsCubit)
    : _fetchProfileDataUseCase = getIt<FetchProfileDataUseCase>(),
      super(const ProfileLoading()) {
    on<FetchProfileData>(_onFetchProfileData);
  }

  Future<void> _onFetchProfileData(FetchProfileData event, Emitter<ProfileState> emit) async {
    emit(const ProfileLoading());
    try {
      final responseType = _devToolsCubit.state.responseType;
      if (responseType == ResponseType.error) {
        await Future.delayed(const Duration(seconds: 1));
        throw Exception('Simulated error');
      }
      if (responseType == ResponseType.empty) {
        return emit(ProfileSuccess(ProfileData(name: '', email: '', accountId: '')));
      }
      final profileData = await _fetchProfileDataUseCase();
      emit(ProfileSuccess(profileData));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
}
