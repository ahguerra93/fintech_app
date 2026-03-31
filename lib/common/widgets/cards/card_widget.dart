import 'package:fintech_app/common/app_formatters.dart';
import 'package:flutter/material.dart';

class CardBody extends StatelessWidget {
  final bool hidden;
  final double balance;
  final String cardNumber;
  final Color? foregroundColor;
  final bool watermark;
  const CardBody({
    this.hidden = false,
    required this.cardNumber,
    required this.balance,
    this.foregroundColor,
    this.watermark = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final onSurface = foregroundColor ?? Theme.of(context).colorScheme.onPrimary;
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Number',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: onSurface.withValues(alpha: 0.7)),
            ),
            Text(
              hidden ? '**** **** ****' : '**** **** **** ${cardNumber.substring(cardNumber.length - 4)}',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(color: onSurface, fontWeight: FontWeight.w700),
            ),
            Text(
              'Your Balance',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: onSurface.withValues(alpha: 0.7)),
            ),
            Text(
              hidden ? '****' : AppFormatters.amount(balance),
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: onSurface, fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ],
    );
  }
}
