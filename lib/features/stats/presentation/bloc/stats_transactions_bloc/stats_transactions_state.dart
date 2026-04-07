part of 'stats_transactions_bloc.dart';

@immutable
sealed class StatsTransactionsState {
  const StatsTransactionsState();
}

final class StatsTransactionsLoading extends StatsTransactionsState {
  final bool initial;
  const StatsTransactionsLoading({this.initial = false});
}

final class StatsTransactionsSuccess extends StatsTransactionsState {
  final List<StatsTransactionModel> transactions;

  const StatsTransactionsSuccess(this.transactions);
}

final class StatsTransactionsError extends StatsTransactionsState {
  final String message;

  const StatsTransactionsError(this.message);
}

final class StatsTransactionsEmpty extends StatsTransactionsState {
  const StatsTransactionsEmpty();
}
