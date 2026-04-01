import 'package:fintech_app/features/cards/domain/models/card_model.dart';
import 'package:fintech_app/features/cards/domain/models/recent_transaction_model.dart';
import 'package:fintech_app/features/home/domain/models/home_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeLoading()) {
    on<FetchHomeData>(_onFetchHomeData);
  }

  Future<void> _onFetchHomeData(FetchHomeData event, Emitter<HomeState> emit) async {
    emit(const HomeLoading());
    try {
      // TODO: Replace with actual repository call
      await Future.delayed(const Duration(seconds: 1));

      final dummyCards = [
        const CardModel(cardNumber: '**** 1234', type: CardType.credit, balance: 5000.00),
        const CardModel(cardNumber: '**** 5678', type: CardType.debit, balance: 12500.00),
      ];

      final dummyTransactions = [
        RecentTransactionModel(
          id: '1',
          title: 'Starbucks',
          amount: 5.50,
          date: DateTime.now().subtract(const Duration(days: 1)),
          category: 'Coffee',
        ),
        RecentTransactionModel(
          id: '2',
          title: 'Amazon',
          amount: 45.00,
          date: DateTime.now().subtract(const Duration(days: 2)),
          category: 'Shopping',
        ),
      ];

      final homeData = HomeData(balance: 25000.00, cards: dummyCards, recentTransactions: dummyTransactions);

      emit(HomeSuccess(homeData));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}
