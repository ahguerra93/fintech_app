import 'package:fintech_app/common/app_assets.dart';
import 'package:fintech_app/common/app_dimens.dart';
import 'package:fintech_app/common/app_formatters.dart';
import 'package:fintech_app/features/transfers/presentation/bloc/transfer_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransferConfirmationSection extends StatelessWidget {
  const TransferConfirmationSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bloc = context.read<TransferBloc>();
    final data = bloc.data;
    final recipient = data.selectedRecipient;

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: theme.colorScheme.onPrimary, onPressed: () => bloc.add(PressedBack())),
        backgroundColor: theme.primaryColor,
        foregroundColor: theme.colorScheme.onPrimary,
      ),
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
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    spacing: AppDimens.spacingMd,
                    children: [
                      Text(
                        'Confirm Transfer',
                        style: theme.textTheme.headlineMedium?.copyWith(color: theme.colorScheme.onPrimary),
                      ),
                      Container(
                        padding: EdgeInsets.all(AppDimens.spacingSm),
                        decoration: BoxDecoration(
                          border: Border.all(color: theme.colorScheme.onPrimary, width: 2),
                          shape: BoxShape.circle,
                        ),
                        child: Image.asset(AppAssets.logoOutlined, height: AppDimens.iconXl),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppDimens.spacingXl),
                  Text('Send:', style: theme.textTheme.titleLarge?.copyWith(color: theme.colorScheme.onPrimary)),
                  Text(
                    '\$${AppFormatters.amount(data.amount)}',
                    style: theme.textTheme.displayMedium?.copyWith(
                      color: theme.colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: AppDimens.spacingXl),
                  Text('To:', style: theme.textTheme.titleLarge?.copyWith(color: theme.colorScheme.onPrimary)),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: AppDimens.spacingMd, horizontal: AppDimens.spacingXl),
                    padding: const EdgeInsets.all(AppDimens.spacingMd),
                    decoration: BoxDecoration(
                      // color: theme.colorScheme.secondary,
                      borderRadius: BorderRadius.circular(AppDimens.radiusLg),
                      border: Border.all(color: theme.colorScheme.onPrimary, width: 2),
                    ),
                    child: Row(
                      spacing: 16.0,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 38,
                          backgroundColor: theme.colorScheme.secondary,
                          child: Text(
                            recipient?.initials ?? '',
                            style: theme.textTheme.headlineMedium?.copyWith(color: theme.colorScheme.onPrimary),
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
            Container(
              padding: const EdgeInsets.only(
                top: AppDimens.spacingMd,
                right: AppDimens.spacingMd,
                left: AppDimens.spacingMd,
              ),
              decoration: BoxDecoration(
                color: theme.colorScheme.onPrimary,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              ),
              child: SafeArea(
                child: ElevatedButton(
                  onPressed: () => bloc.add(PressedConfirm()),
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
