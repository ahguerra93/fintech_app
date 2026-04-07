part of 'stats_transactions_bloc.dart';

@immutable
sealed class StatsTransactionsEvent {
  const StatsTransactionsEvent();
}

final class FetchStatsTransactions extends StatsTransactionsEvent {
  const FetchStatsTransactions();
}
