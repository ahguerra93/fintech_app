import 'package:flutter/material.dart';
import 'package:fintech_app/common/widgets/input/numeric_keyboard.dart';
import 'package:fintech_app/common/app_formatters.dart';
import 'package:fintech_app/features/transfers/enum/transfer_stage.dart';

class TransferFormSection extends StatefulWidget {
  const TransferFormSection({super.key, required this.onStageChange});
  final void Function(TransferStage) onStageChange;

  @override
  State<TransferFormSection> createState() => _TransferFormSectionState();
}

class _TransferFormSectionState extends State<TransferFormSection> {
  int _selectedRecipient = 0;
  String _amountDigits = '';

  static final List<_Recipient> recipients = [
    _Recipient('Alice Smith', '**** 1234', 'A'),
    _Recipient('Bob Johnson', '**** 5678', 'B'),
    _Recipient('Charlie Lee', '**** 9012', 'C'),
  ];

  void _onKeyboardTap(String value) {
    setState(() {
      if (value == 'del') {
        if (_amountDigits.isNotEmpty) {
          _amountDigits = _amountDigits.substring(0, _amountDigits.length - 1);
        }
      } else if (RegExp(r'^[0-9]$').hasMatch(value)) {
        if (_amountDigits.length < 9) {
          _amountDigits += value;
        }
      }
    });
  }

  String _formatAmount(String digits) {
    if (digits.isEmpty) return '0.00';
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
        leading: BackButton(color: theme.colorScheme.onPrimary),
        title: Text(
          'Transfer',
          style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: theme.colorScheme.onPrimary),
        ),
        backgroundColor: theme.primaryColor,
      ),
      backgroundColor: theme.primaryColor,
      body: Column(
        children: [
          // Recipient selection section
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Avatar
                  CircleAvatar(
                    radius: 32,
                    backgroundColor: theme.colorScheme.secondary,
                    child: Text(
                      recipients[_selectedRecipient].initials,
                      style: theme.textTheme.headlineSmall?.copyWith(color: onPrimary),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Dropdown
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
                    decoration: BoxDecoration(
                      color: theme.scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: DropdownButton<int>(
                      value: _selectedRecipient,
                      underline: const SizedBox.shrink(),
                      isExpanded: true,
                      icon: Icon(Icons.arrow_drop_down, color: theme.colorScheme.primary),
                      items: List.generate(recipients.length, (i) {
                        final r = recipients[i];
                        return DropdownMenuItem(
                          value: i,
                          child: Row(
                            children: [
                              Text(r.name, style: theme.textTheme.bodyLarge),
                              const SizedBox(width: 8),
                              Text(r.account, style: theme.textTheme.bodyMedium?.copyWith(color: theme.hintColor)),
                            ],
                          ),
                        );
                      }),
                      onChanged: (v) => setState(() => _selectedRecipient = v ?? 0),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Amount and numpad section
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
                  const SizedBox(height: 24),
                  // Amount display
                  Text(
                    _formatAmount(_amountDigits),
                    style: theme.textTheme.displayMedium?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  // Numeric keyboard
                  Expanded(
                    child: NumericKeyboard(
                      onKeyboardTap: _onKeyboardTap,
                      rightButtonFn: () => _onKeyboardTap('del'),
                      rightIcon: const Icon(Icons.backspace_outlined),
                    ),
                  ),
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: ElevatedButton(
                        onPressed: () => widget.onStageChange(TransferStage.confirmation),
                        child: Center(
                          child: Text(
                            'Transfer',
                            style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: onPrimary),
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
      ),
    );
  }
}

class _Recipient {
  final String name;
  final String account;
  final String initials;
  const _Recipient(this.name, this.account, this.initials);
}
