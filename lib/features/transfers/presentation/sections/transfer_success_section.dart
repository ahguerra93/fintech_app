import 'package:fintech_app/common/app_formatters.dart';
import 'package:flutter/material.dart';

class TransferSuccessSection extends StatelessWidget {
  const TransferSuccessSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          color: theme.colorScheme.onPrimary,
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: theme.primaryColor,
        elevation: 0,
      ),
      backgroundColor: theme.primaryColor,
      body: Center(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Transfer Successful!',
                style: theme.textTheme.headlineMedium?.copyWith(color: theme.colorScheme.onPrimary),
              ),
              const SizedBox(height: 16.0),
              Icon(Icons.check_circle_rounded, color: theme.colorScheme.secondary, size: 120),
              const SizedBox(height: 32),
              Text(
                '\$${AppFormatters.amount(1200)}',
                style: theme.textTheme.displayMedium?.copyWith(
                  color: theme.colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                'Transfered to:',
                style: theme.textTheme.titleSmall?.copyWith(
                  color: theme.colorScheme.onPrimary,
                  fontWeight: FontWeight.w300,
                ),
              ),
              Column(
                children: [
                  Text(
                    'Alice Smith',
                    style: theme.textTheme.headlineLarge?.copyWith(color: theme.colorScheme.onPrimary),
                  ),
                  Text('**** 1234', style: theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.onPrimary)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
