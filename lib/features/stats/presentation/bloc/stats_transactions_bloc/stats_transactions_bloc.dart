import 'package:fintech_app/di/di.dart';
import 'package:fintech_app/features/stats/domain/models/stats_transaction_model.dart';
import 'package:fintech_app/features/stats/domain/models/time_range.dart';
import 'package:fintech_app/features/stats/domain/usecases/fetch_stats_transactions.dart';
import 'package:fintech_app/features/dev_tools/presentation/cubit/devtools_cubit.dart';
import 'package:fintech_app/features/dev_tools/presentation/cubit/devtools_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'stats_transactions_event.dart';
part 'stats_transactions_state.dart';

class StatsTransactionsBloc extends Bloc<StatsTransactionsEvent, StatsTransactionsState> {
  final FetchStatsTransactionsUseCase _fetchStatsTransactionsUseCase;
  final DevToolsCubit _devToolsCubit;

  StatsTransactionsBloc(this._devToolsCubit)
    : _fetchStatsTransactionsUseCase = getIt<FetchStatsTransactionsUseCase>(),
      super(const StatsTransactionsLoading()) {
    on<FetchStatsTransactions>(_onFetchStatsTransactions);
  }

  Future<void> _onFetchStatsTransactions(FetchStatsTransactions event, Emitter<StatsTransactionsState> emit) async {
    emit(const StatsTransactionsLoading());
    try {
      final responseType = _devToolsCubit.state.responseType;
      if (responseType == ResponseType.error) {
        await Future.delayed(const Duration(seconds: 1));
        throw Exception('Simulated error');
      }
      if (responseType == ResponseType.empty) {
        return emit(const StatsTransactionsEmpty());
      }
      final transactions = await _fetchStatsTransactionsUseCase(event.timeRange);
      emit(StatsTransactionsSuccess(transactions));
    } catch (e) {
      emit(StatsTransactionsError(e.toString()));
    }
  }
}
