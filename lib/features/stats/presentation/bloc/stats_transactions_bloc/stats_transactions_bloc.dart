import 'package:fintech_app/di/di.dart';
import 'package:fintech_app/features/stats/domain/models/stats_transaction_model.dart';
import 'package:fintech_app/features/stats/domain/usecases/fetch_stats_transactions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'stats_transactions_event.dart';
part 'stats_transactions_state.dart';

class StatsTransactionsBloc extends Bloc<StatsTransactionsEvent, StatsTransactionsState> {
  final FetchStatsTransactionsUseCase _fetchStatsTransactionsUseCase;
  StatsTransactionsBloc()
    : _fetchStatsTransactionsUseCase = getIt<FetchStatsTransactionsUseCase>(),
      super(const StatsTransactionsLoading()) {
    on<FetchStatsTransactions>(_onFetchStatsTransactions);
  }

  Future<void> _onFetchStatsTransactions(FetchStatsTransactions event, Emitter<StatsTransactionsState> emit) async {
    emit(const StatsTransactionsLoading());
    try {
      final transactions = await _fetchStatsTransactionsUseCase();
      emit(StatsTransactionsSuccess(transactions));
    } catch (e) {
      emit(StatsTransactionsError(e.toString()));
    }
  }
}
