import 'package:fintech_app/features/transfers/enum/transfer_stage.dart';
import 'package:fintech_app/features/transfers/presentation/sections/transfer_confirmation_section.dart';
import 'package:fintech_app/features/transfers/presentation/sections/transfer_form_section.dart';
import 'package:fintech_app/features/transfers/presentation/sections/transfer_success_section.dart';
import 'package:flutter/material.dart';

class TransferPage extends StatefulWidget {
  const TransferPage({super.key});

  @override
  State<TransferPage> createState() => _TransferPageState();
}

class _TransferPageState extends State<TransferPage> {
  TransferStage _stage = TransferStage.dataEntry;

  @override
  Widget build(BuildContext context) {
    switch (_stage) {
      case TransferStage.dataEntry:
        return TransferFormSection(onStageChange: (stage) => setState(() => _stage = stage));
      case TransferStage.confirmation:
        return TransferConfirmationSection(onStageChange: (stage) => setState(() => _stage = stage));
      case TransferStage.error:
        return const Placeholder();
      case TransferStage.finished:
        return const TransferSuccessSection();
    }
  }
}
