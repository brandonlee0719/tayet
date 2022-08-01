class CardModel {
  String nameOnCard;
  String cardNumber;
  String expiryMonth;
  String expiryYear;
  String securityCode;

  String get expiryDate => '$expiryMonth/$expiryYear';

  CardModel({
    required this.nameOnCard,
    required this.cardNumber,
    required this.expiryMonth,
    required this.expiryYear,
    required this.securityCode,
  });
}
