import 'package:fintech_app/di/di.dart';
import 'package:fintech_app/features/home/domain/models/home_data.dart';
import 'package:fintech_app/features/home/domain/usecases/fetch_home_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final FetchHomeDataUseCase _fetchHomeDataUseCase;
  HomeBloc() : _fetchHomeDataUseCase = getIt<FetchHomeDataUseCase>(), super(const HomeLoading()) {
    on<FetchHomeData>(_onFetchHomeData);
  }

  Future<void> _onFetchHomeData(FetchHomeData event, Emitter<HomeState> emit) async {
    emit(const HomeLoading());
    try {
      final homeData = await _fetchHomeDataUseCase();
      emit(HomeSuccess(homeData));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}

// ...existing code...
