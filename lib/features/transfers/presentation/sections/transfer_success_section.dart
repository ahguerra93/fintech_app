import 'package:fintech_app/common/app_dimens.dart';
import 'package:fintech_app/common/app_formatters.dart';
import 'package:fintech_app/features/transfers/domain/models/transfer_model.dart';
import 'package:flutter/material.dart';

class TransferSuccessSection extends StatelessWidget {
  const TransferSuccessSection({super.key, required this.data});

  final TransferModel data;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final recipient = data.selectedRecipient;
    final initials = recipient != null && recipient.name.isNotEmpty
        ? recipient.name.trim().split(' ').map((w) => w[0]).take(2).join().toUpperCase()
        : '?';
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
              const SizedBox(height: AppDimens.spacingMd),
              Icon(Icons.check_circle_rounded, color: theme.colorScheme.secondary, size: 120),
              const SizedBox(height: AppDimens.spacingXl),
              Text(
                '\$${AppFormatters.amount(data.amount)}',
                style: theme.textTheme.displayMedium?.copyWith(
                  color: theme.colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: AppDimens.spacingMd),
              Text(
                'Transferred to:',
                style: theme.textTheme.titleSmall?.copyWith(
                  color: theme.colorScheme.onPrimary,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(height: AppDimens.spacingSm),
              Container(
                margin: const EdgeInsets.symmetric(vertical: AppDimens.spacingMd, horizontal: AppDimens.spacingXl),
                padding: const EdgeInsets.all(AppDimens.spacingMd),
                decoration: BoxDecoration(
                  // color: theme.colorScheme.secondary,
                  borderRadius: BorderRadius.circular(AppDimens.radiusLg),
                  border: Border.all(color: theme.colorScheme.onPrimary, width: 2),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 16.0,
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: theme.colorScheme.secondary,
                      child: Text(
                        initials,
                        style: theme.textTheme.titleLarge?.copyWith(color: theme.colorScheme.onPrimary),
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          recipient?.name ?? '',
                          style: theme.textTheme.headlineLarge?.copyWith(color: theme.colorScheme.onPrimary),
                        ),
                        Text(
                          recipient?.cardNumber ?? '',
                          style: theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.onPrimary),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
