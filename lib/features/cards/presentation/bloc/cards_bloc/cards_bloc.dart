import 'package:fintech_app/di/di.dart';
import 'package:fintech_app/features/cards/domain/models/card_model.dart';
import 'package:fintech_app/features/cards/domain/usecases/fetch_cards.dart';
import 'package:fintech_app/features/dev_tools/presentation/cubit/devtools_cubit.dart';
import 'package:fintech_app/features/dev_tools/presentation/cubit/devtools_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'cards_event.dart';
part 'cards_state.dart';

class CardsBloc extends Bloc<CardsEvent, CardsState> {
  final FetchCardsUseCase _fetchCardsUseCase;
  final DevToolsCubit _devToolsCubit;

  CardsBloc(this._devToolsCubit) : _fetchCardsUseCase = getIt<FetchCardsUseCase>(), super(const CardsLoading()) {
    on<FetchCards>(_onFetchCards);
  }

  Future<void> _onFetchCards(FetchCards event, Emitter<CardsState> emit) async {
    emit(const CardsLoading());
    try {
      final responseType = _devToolsCubit.state.responseType;
      if (responseType == ResponseType.error) {
        await Future.delayed(const Duration(seconds: 1));
        throw Exception('Simulated error');
      }
      if (responseType == ResponseType.empty) {
        return emit(const CardsSuccess([]));
      }
      final result = await _fetchCardsUseCase();
      emit(CardsSuccess(result));
    } catch (e) {
      emit(CardsError(e.toString()));
    }
  }
}
