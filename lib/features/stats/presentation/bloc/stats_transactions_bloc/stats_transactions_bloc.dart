import 'package:bloc/bloc.dart';
import 'package:fintech_app/features/stats/domain/models/stats_transaction_model.dart';
import 'package:meta/meta.dart';

part 'stats_transactions_event.dart';
part 'stats_transactions_state.dart';

class StatsTransactionsBloc extends Bloc<StatsTransactionsEvent, StatsTransactionsState> {
  StatsTransactionsBloc() : super(const StatsTransactionsLoading()) {
    on<FetchStatsTransactions>(_onFetchStatsTransactions);
  }

  Future<void> _onFetchStatsTransactions(FetchStatsTransactions event, Emitter<StatsTransactionsState> emit) async {
    emit(const StatsTransactionsLoading());
    try {
      // TODO: Replace with actual repository call
      await Future.delayed(const Duration(seconds: 1));
      final dummyTransactions = [
        StatsTransactionModel(
          id: '1',
          title: 'Starbucks',
          amount: 5.50,
          date: DateTime.now().subtract(const Duration(days: 1)),
          category: 'Coffee',
        ),
        StatsTransactionModel(
          id: '2',
          title: 'Amazon',
          amount: 45.00,
          date: DateTime.now().subtract(const Duration(days: 2)),
          category: 'Shopping',
        ),
        StatsTransactionModel(
          id: '3',
          title: 'Uber',
          amount: 15.00,
          date: DateTime.now().subtract(const Duration(days: 3)),
          category: 'Transport',
        ),
      ];
      emit(StatsTransactionsSuccess(dummyTransactions));
    } catch (e) {
      emit(StatsTransactionsError(e.toString()));
    }
  }
}
