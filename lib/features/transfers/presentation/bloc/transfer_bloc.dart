import 'package:fintech_app/features/transfers/domain/models/transfer_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'transfer_event.dart';
part 'transfer_state.dart';

class TransferBloc extends Bloc<TransferEvent, TransferState> {
  TransferModel _data = const TransferModel();
  String _amountDigits = '';

  TransferBloc() : super(const TransferDataEntry()) {
    on<UpdateRecipient>((event, emit) {
      _data = _data.copyWith(selectedRecipient: event.recipient);
      emit(TransferDataEntry(amountDigits: _amountDigits));
    });

    on<AppendDigit>((event, emit) {
      _amountDigits += event.digit.toString();
      _data = _data.copyWith(amount: double.parse(_amountDigits) / 100.0);
      emit(TransferDataEntry(amountDigits: _amountDigits));
    });

    on<DeleteDigit>((event, emit) {
      if (_amountDigits.isEmpty) return;
      _amountDigits = _amountDigits.substring(0, _amountDigits.length - 1);
      final amount = _amountDigits.isEmpty ? 0.0 : double.parse(_amountDigits) / 100.0;
      _data = _data.copyWith(amount: amount);
      emit(TransferDataEntry(amountDigits: _amountDigits));
    });

    on<PressedContinue>((event, emit) {
      emit(const TransferConfirmation());
    });

    on<PressedBack>((event, emit) {
      emit(TransferDataEntry(amountDigits: _amountDigits));
    });

    on<PressedConfirm>((event, emit) async {
      emit(const TransferLoading());
      await Future.delayed(const Duration(seconds: 2));
      emit(TransferSuccess(_data));
    });
  }

  TransferModel get data => _data;
}
