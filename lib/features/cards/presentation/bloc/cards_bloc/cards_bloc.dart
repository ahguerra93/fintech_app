import 'package:fintech_app/features/cards/domain/models/card_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'cards_event.dart';
part 'cards_state.dart';

class CardsBloc extends Bloc<CardsEvent, CardsState> {
  CardsBloc() : super(const CardsLoading()) {
    on<FetchCards>(_onFetchCards);
  }

  Future<void> _onFetchCards(FetchCards event, Emitter<CardsState> emit) async {
    emit(const CardsLoading());
    try {
      // TODO: Replace with actual repository call
      await Future.delayed(const Duration(seconds: 1));
      final dummyCards = [
        const CardModel(cardNumber: '**** 1234', type: CardType.credit, balance: 5000.00),
        const CardModel(cardNumber: '**** 5678', type: CardType.debit, balance: 12500.00),
      ];
      emit(CardsSuccess(dummyCards));
    } catch (e) {
      emit(CardsError(e.toString()));
    }
  }
}
