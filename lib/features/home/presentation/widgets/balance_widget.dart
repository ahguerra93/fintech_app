import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BalanceWidget extends StatelessWidget {
  const BalanceWidget({super.key, this.balance = 222852.00});

  final double balance;

  static final _amountFormat = NumberFormat('#,##0.00', 'en_US');
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('Your Balance', style: Theme.of(context).textTheme.titleMedium),

        Text.rich(
          TextSpan(
            style: Theme.of(context).textTheme.headlineMedium,
            children: [
              TextSpan(text: '\$ ', style: Theme.of(context).textTheme.titleLarge),
              TextSpan(
                text: _amountFormat.format(balance),
                style: Theme.of(context).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
