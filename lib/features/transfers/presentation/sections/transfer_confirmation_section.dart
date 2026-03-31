import 'package:fintech_app/features/transfers/enum/transfer_stage.dart';
import 'package:flutter/material.dart';

class TransferConfirmationSection extends StatelessWidget {
  const TransferConfirmationSection({required this.onStageChange, super.key});

  final void Function(TransferStage) onStageChange;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(backgroundColor: theme.primaryColor, foregroundColor: theme.colorScheme.onPrimary),
      backgroundColor: theme.primaryColor,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          spacing: 16.0,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Send:', style: theme.textTheme.titleLarge?.copyWith(color: theme.colorScheme.onPrimary)),
                  Text(
                    '\$1,200.00',
                    style: theme.textTheme.displayMedium?.copyWith(
                      color: theme.colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 32.0),
                  Text('To:', style: theme.textTheme.titleLarge?.copyWith(color: theme.colorScheme.onPrimary)),
                  Row(
                    spacing: 16.0,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 38,
                        backgroundColor: theme.colorScheme.secondary,
                        child: Text(
                          'AS',
                          style: theme.textTheme.headlineMedium?.copyWith(color: theme.colorScheme.onPrimary),
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            'Alice Smith',
                            style: theme.textTheme.headlineLarge?.copyWith(color: theme.colorScheme.onPrimary),
                          ),
                          Text(
                            '**** 1234',
                            style: theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.onPrimary),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),

                  SizedBox(height: 16.0),
                ],
              ),
            ),

            Container(
              padding: EdgeInsets.only(top: 16.0, right: 16.0, left: 16.0),
              decoration: BoxDecoration(
                color: theme.colorScheme.onPrimary,
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              ),
              child: SafeArea(
                child: ElevatedButton(
                  onPressed: () => onStageChange(TransferStage.finished),
                  child: Center(
                    child: Text(
                      'Confirm',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onPrimary,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
