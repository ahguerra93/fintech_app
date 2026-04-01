import 'package:fintech_app/features/transfers/presentation/bloc/transfer_bloc.dart';
import 'package:fintech_app/features/transfers/presentation/sections/transfer_confirmation_section.dart';
import 'package:fintech_app/features/transfers/presentation/sections/transfer_form_section.dart';
import 'package:fintech_app/features/transfers/presentation/sections/transfer_success_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransferPage extends StatelessWidget {
  const TransferPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TransferBloc(),
      child: BlocBuilder<TransferBloc, TransferState>(
        builder: (context, state) {
          return switch (state) {
            TransferDataEntry() => const TransferFormSection(),
            TransferConfirmation() => const TransferConfirmationSection(),
            TransferLoading() => _LoadingSection(),
            TransferSuccess(:final data) => TransferSuccessSection(data: data),
            TransferFailure() => const TransferFormSection(),
          };
        },
      ),
    );
  }
}

class _LoadingSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.primaryColor,
      body: const Center(child: CircularProgressIndicator(color: Colors.white)),
    );
  }
}
