part of 'recent_transactions_bloc.dart';

@immutable
sealed class RecentTransactionsState {
  const RecentTransactionsState();
}

final class RecentTransactionsLoading extends RecentTransactionsState {
  const RecentTransactionsLoading();
}

final class RecentTransactionsSuccess extends RecentTransactionsState {
  final List<RecentTransactionModel> transactions;
  const RecentTransactionsSuccess(this.transactions);
}

final class RecentTransactionsError extends RecentTransactionsState {
  final String message;
  const RecentTransactionsError(this.message);
}
