part of 'stats_transactions_bloc.dart';

@immutable
sealed class StatsTransactionsEvent {
  const StatsTransactionsEvent();
}

final class FetchStatsTransactions extends StatsTransactionsEvent {
  final bool initial;
  const FetchStatsTransactions({this.initial = false});
}
