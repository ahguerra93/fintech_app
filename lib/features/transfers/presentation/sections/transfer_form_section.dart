import 'package:fintech_app/common/app_dimens.dart';
import 'package:fintech_app/features/transfers/domain/models/transfer_model.dart';
import 'package:fintech_app/features/transfers/presentation/bloc/transfer_bloc.dart';
import 'package:flutter/material.dart';
import 'package:fintech_app/common/widgets/input/numeric_keyboard.dart';
import 'package:fintech_app/common/app_formatters.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransferFormSection extends StatelessWidget {
  const TransferFormSection({super.key});

  static const List<Recipient> _recipients = [
    Recipient(name: 'Alice Smith', cardNumber: '**** 1234'),
    Recipient(name: 'Bob Johnson', cardNumber: '**** 5678'),
    Recipient(name: 'Charlie Lee', cardNumber: '**** 9012'),
  ];

  String _formatAmount(String digits) {
    if (digits.isEmpty) return '\$0.00';
    final value = double.parse(digits) / 100.0;
    return '\$${AppFormatters.amount(value)}';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.sizeOf(context);
    final onPrimary = theme.colorScheme.onPrimary;
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: onPrimary),
        title: Text(
          'Transfer',
          style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: onPrimary),
        ),
        backgroundColor: theme.primaryColor,
      ),
      backgroundColor: theme.primaryColor,
      body: BlocBuilder<TransferBloc, TransferState>(
        builder: (context, state) {
          final data = context.read<TransferBloc>().data;
          final amountDigits = (state is TransferDataEntry) ? state.amountDigits : '';
          return Column(
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 32,
                        backgroundColor: theme.colorScheme.secondary,
                        child: Text(data.initials, style: theme.textTheme.headlineSmall?.copyWith(color: onPrimary)),
                      ),
                      const SizedBox(height: AppDimens.spacingMd),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppDimens.spacingLg,
                          vertical: AppDimens.spacingXs,
                        ),
                        decoration: BoxDecoration(
                          color: theme.scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(AppDimens.radiusXl),
                        ),
                        child: DropdownButton<Recipient>(
                          value: data.selectedRecipient,
                          underline: const SizedBox.shrink(),
                          isExpanded: true,
                          icon: Icon(Icons.arrow_drop_down, color: theme.colorScheme.primary),
                          items: _recipients.map((r) {
                            return DropdownMenuItem<Recipient>(
                              value: r,
                              child: Row(
                                children: [
                                  Text(r.name, style: theme.textTheme.bodyLarge),
                                  const SizedBox(width: AppDimens.spacingSm),
                                  Text(
                                    r.cardNumber,
                                    style: theme.textTheme.bodyMedium?.copyWith(color: theme.hintColor),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                          onChanged: (v) {
                            if (v != null) context.read<TransferBloc>().add(UpdateRecipient(v));
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Container(
                  width: size.width,
                  decoration: BoxDecoration(
                    color: theme.scaffoldBackgroundColor,
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: AppDimens.spacingLg),
                      Text(
                        _formatAmount(amountDigits),
                        style: theme.textTheme.displayMedium?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: AppDimens.spacingMd),
                      Expanded(
                        child: NumericKeyboard(
                          onKeyboardTap: (v) => context.read<TransferBloc>().add(AppendDigit(v)),
                          rightButtonFn: () => context.read<TransferBloc>().add(DeleteDigit()),
                          rightIcon: const Icon(Icons.backspace_outlined),
                        ),
                      ),
                      SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: AppDimens.spacingMd),
                          child: ElevatedButton(
                            onPressed: data.selectedRecipient == null || amountDigits.isEmpty
                                ? null
                                : () => context.read<TransferBloc>().add(PressedContinue()),
                            child: Center(
                              child: Text(
                                'Transfer',
                                style: theme.textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: onPrimary,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
