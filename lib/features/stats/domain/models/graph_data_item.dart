class GraphDataItem {
  final String label;
  final double expense;
  final double income;

  const GraphDataItem({required this.label, required this.expense, required this.income});

  GraphDataItem copyWith({String? label, double? expense, double? income}) {
    return GraphDataItem(label: label ?? this.label, expense: expense ?? this.expense, income: income ?? this.income);
  }
}
