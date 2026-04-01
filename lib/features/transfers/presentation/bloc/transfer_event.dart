part of 'transfer_bloc.dart';

@immutable
sealed class TransferEvent {}

final class UpdateRecipient extends TransferEvent {
  final Recipient recipient;

  UpdateRecipient(this.recipient);
}

final class AppendDigit extends TransferEvent {
  final int digit;

  AppendDigit(this.digit);
}

final class DeleteDigit extends TransferEvent {}

final class PressedContinue extends TransferEvent {}

final class PressedBack extends TransferEvent {}

final class PressedConfirm extends TransferEvent {}
