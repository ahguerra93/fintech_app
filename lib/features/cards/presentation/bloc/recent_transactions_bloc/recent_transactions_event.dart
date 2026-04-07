part of 'recent_transactions_bloc.dart';

@immutable
sealed class RecentTransactionsEvent {
  const RecentTransactionsEvent();
}

final class FetchRecentTransactions extends RecentTransactionsEvent {
  final bool initial;
  const FetchRecentTransactions({this.initial = false});
}
