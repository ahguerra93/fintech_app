class Recipient {
  final String name;
  final String cardNumber;

  const Recipient({required this.name, required this.cardNumber});
}

class TransferModel {
  final Recipient? selectedRecipient;
  final double amount;

  const TransferModel({this.selectedRecipient, this.amount = 0.0});

  String get initials {
    if (selectedRecipient == null || selectedRecipient!.name.isEmpty) return '?';
    return selectedRecipient!.name.trim().split(' ').map((w) => w[0]).take(2).join().toUpperCase();
  }

  TransferModel copyWith({Recipient? selectedRecipient, double? amount}) {
    return TransferModel(selectedRecipient: selectedRecipient ?? this.selectedRecipient, amount: amount ?? this.amount);
  }
}
