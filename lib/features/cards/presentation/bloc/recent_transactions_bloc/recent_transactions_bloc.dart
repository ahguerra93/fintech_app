import 'package:fintech_app/features/cards/domain/models/recent_transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'recent_transactions_event.dart';
part 'recent_transactions_state.dart';

class RecentTransactionsBloc extends Bloc<RecentTransactionsEvent, RecentTransactionsState> {
  RecentTransactionsBloc() : super(const RecentTransactionsLoading()) {
    on<FetchRecentTransactions>(_onFetchRecentTransactions);
  }

  Future<void> _onFetchRecentTransactions(FetchRecentTransactions event, Emitter<RecentTransactionsState> emit) async {
    emit(const RecentTransactionsLoading());
    try {
      // TODO: Replace with actual repository call
      await Future.delayed(const Duration(seconds: 1));
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
      emit(RecentTransactionsSuccess(dummyTransactions));
    } catch (e) {
      emit(RecentTransactionsError(e.toString()));
    }
  }
}
