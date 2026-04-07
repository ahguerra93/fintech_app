import 'package:fintech_app/di/di.dart';
import 'package:fintech_app/features/dev_tools/presentation/cubit/devtools_cubit.dart';
import 'package:fintech_app/features/dev_tools/presentation/cubit/devtools_state.dart';
import 'package:fintech_app/features/home/domain/models/home_data.dart';
import 'package:fintech_app/features/home/domain/usecases/fetch_home_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final FetchHomeDataUseCase _fetchHomeDataUseCase;
  final DevToolsCubit _devToolsCubit;

  HomeBloc(this._devToolsCubit) : _fetchHomeDataUseCase = getIt<FetchHomeDataUseCase>(), super(const HomeLoading()) {
    on<FetchHomeData>(_onFetchHomeData);
  }

  Future<void> _onFetchHomeData(FetchHomeData event, Emitter<HomeState> emit) async {
    emit(const HomeLoading());
    try {
      final responseType = _devToolsCubit.state.responseType;
      if (responseType == ResponseType.error) throw Exception('Simulated error');
      if (responseType == ResponseType.empty) {
        return emit(HomeSuccess(HomeData(balance: 0, cards: [], recentTransactions: [])));
      }
      final homeData = await _fetchHomeDataUseCase();
      emit(HomeSuccess(homeData));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}
