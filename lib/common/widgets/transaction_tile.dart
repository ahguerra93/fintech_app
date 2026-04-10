import 'package:flutter/material.dart';

class TransactionTile extends StatelessWidget {
  final String title;
  final double amount;
  final DateTime date;
  final String category;
  const TransactionTile({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      leading: CircleAvatar(child: Icon(Icons.attach_money)),
      title: Text(title, style: theme.textTheme.bodyLarge),
      onTap: () {},
      subtitle: Text('$category • ${_formatDate(date)}'),
      trailing: Text(
        '\$${amount.toStringAsFixed(2)}',
        style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }

  String _formatDate(DateTime date) {
    // Simple date formatting, can be replaced with intl if needed
    final now = DateTime.now();
    if (date.year == now.year && date.month == now.month && date.day == now.day) {
      return 'Today ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    }
    return '${date.month}/${date.day}/${date.year}';
  }
}
