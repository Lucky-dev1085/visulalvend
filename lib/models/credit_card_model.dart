
class CCreditCardModel {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;

  CCreditCardModel({this.cardNumber = '', this.expiryDate = '', this.cardHolderName = '', this.cvvCode = '', this.isCvvFocused = false});
}