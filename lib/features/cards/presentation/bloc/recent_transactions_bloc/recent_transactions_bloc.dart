import 'package:fintech_app/di/di.dart';
import 'package:fintech_app/features/cards/domain/models/recent_transaction_model.dart';
import 'package:fintech_app/features/cards/domain/usecases/fetch_recent_transactions.dart';
import 'package:fintech_app/features/dev_tools/presentation/cubit/devtools_cubit.dart';
import 'package:fintech_app/features/dev_tools/presentation/cubit/devtools_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'recent_transactions_event.dart';
part 'recent_transactions_state.dart';

class RecentTransactionsBloc extends Bloc<RecentTransactionsEvent, RecentTransactionsState> {
  final FetchRecentTransactionsUseCase _fetchRecentTransactionsUseCase;
  final DevToolsCubit _devToolsCubit;

  RecentTransactionsBloc(this._devToolsCubit)
    : _fetchRecentTransactionsUseCase = getIt<FetchRecentTransactionsUseCase>(),
      super(const RecentTransactionsLoading()) {
    on<FetchRecentTransactions>(_onFetchRecentTransactions);
  }

  Future<void> _onFetchRecentTransactions(FetchRecentTransactions event, Emitter<RecentTransactionsState> emit) async {
    emit(const RecentTransactionsLoading());
    try {
      final responseType = _devToolsCubit.state.responseType;
      if (responseType == ResponseType.error) {
        await Future.delayed(const Duration(seconds: 1));
        throw Exception('Simulated error');
      }
      if (responseType == ResponseType.empty) {
        return emit(const RecentTransactionsEmpty());
      }
      final transactions = await _fetchRecentTransactionsUseCase();
      emit(RecentTransactionsSuccess(transactions));
    } catch (e) {
      emit(RecentTransactionsError(e.toString()));
    }
  }
}
