class RecentTransactionModel {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final String category;

  const RecentTransactionModel({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  });

  RecentTransactionModel copyWith({String? id, String? title, double? amount, DateTime? date, String? category}) {
    return RecentTransactionModel(
      id: id ?? this.id,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      category: category ?? this.category,
    );
  }
}
