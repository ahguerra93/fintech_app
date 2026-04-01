part of 'stats_transactions_bloc.dart';

@immutable
sealed class StatsTransactionsState {
  const StatsTransactionsState();
}

final class StatsTransactionsLoading extends StatsTransactionsState {
  const StatsTransactionsLoading();
}

final class StatsTransactionsSuccess extends StatsTransactionsState {
  final List<StatsTransactionModel> transactions;

  const StatsTransactionsSuccess(this.transactions);
}

final class StatsTransactionsError extends StatsTransactionsState {
  final String message;

  const StatsTransactionsError(this.message);
}
