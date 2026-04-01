part of 'transfer_bloc.dart';

@immutable
sealed class TransferState {
  const TransferState();
}

final class TransferDataEntry extends TransferState {
  final String amountDigits;
  const TransferDataEntry({this.amountDigits = ''});
}

final class TransferConfirmation extends TransferState {
  const TransferConfirmation();
}

final class TransferLoading extends TransferState {
  const TransferLoading();
}

final class TransferSuccess extends TransferState {
  final TransferModel data;
  const TransferSuccess(this.data);
}

final class TransferFailure extends TransferState {
  final TransferModel data;
  const TransferFailure(this.data);
}
