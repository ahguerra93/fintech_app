import 'package:fintech_app/common/widgets/section_title.dart';
import 'package:fintech_app/common/widgets/transaction_tile.dart';
import 'package:flutter/material.dart';

import 'package:fintech_app/features/cards/domain/models/recent_transaction_model.dart';

class RecentPaymentsSection extends StatelessWidget {
  final List<RecentTransactionModel> transactions;
  const RecentPaymentsSection({required this.transactions, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionTitle(title: 'Recent Payments', subtitle: 'View All', onTap: () {}),
          SizedBox(height: 16.0),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              final tx = transactions[index];
              return TransactionTile(title: tx.title, amount: tx.amount, date: tx.date, category: tx.category);
            },
          ),
        ],
      ),
    );
  }
}
