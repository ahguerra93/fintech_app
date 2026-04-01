enum CardType {
  credit('Credit'),
  debit('Debit');

  final String displayName;
  const CardType(this.displayName);
}

class CardModel {
  final String cardNumber;
  final CardType type;
  final double balance;

  const CardModel({required this.cardNumber, required this.type, required this.balance});

  CardModel copyWith({String? cardNumber, CardType? type, double? balance}) {
    return CardModel(
      cardNumber: cardNumber ?? this.cardNumber,
      type: type ?? this.type,
      balance: balance ?? this.balance,
    );
  }
}
