import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:visualvend/models/credit_card_model.dart';
import 'package:visualvend/utils/themes.dart';
import 'package:visualvend/widgets/appbar.dart';

class CreditCardScreen extends StatefulWidget {
  final String price;
  final Function(bool) onBackCallback;

  const CreditCardScreen({Key key, this.onBackCallback, this.price}) : super(key: key);

  @override
  _CreditCardScreenState createState() => _CreditCardScreenState();
}

class _CreditCardScreenState extends State<CreditCardScreen> {
  final GlobalKey<FormState> _scaffoldKey = GlobalKey<FormState>();
  CCreditCardModel creditCard = new CCreditCardModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: NoTitleAppBar(),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(height: 24, ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(left: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Payment',
                    style: semiBold.copyWith(fontSize: 28, color: Colors.black.withOpacity(0.7)), ),
                  SizedBox(height: 16,),
                  Container(
                    margin: EdgeInsets.only(left: 16),
                    child: Row(
                      children: [
                        Text('You will pay: ',
                          style: semiBold.copyWith(fontSize: 20, color: Colors.black.withOpacity(0.7)), ),
                        Text('\$ ' + widget.price,
                          style: semiBold.copyWith(fontSize: 26, color: Colors.black.withOpacity(0.7)), ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12,)
                ],
              ),
            ),
            CreditCardWidget(
              cardNumber: creditCard.cardNumber,
              expiryDate: creditCard.expiryDate,
              cardHolderName: creditCard.cardHolderName,
              cvvCode: creditCard.cvvCode,
              showBackView: creditCard.isCvvFocused,
              obscureCardNumber: true,
              obscureCardCvv: true,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    CreditCardForm(
                      formKey: _scaffoldKey,
                      obscureCvv: true,
                      obscureNumber: true,
                      cardNumber: creditCard.cardNumber,
                      cvvCode: creditCard.cvvCode,
                      cardHolderName: creditCard.cardHolderName,
                      expiryDate: creditCard.expiryDate,
                      themeColor: Colors.blue,
                      cardNumberDecoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Number',
                        hintText: 'XXXX XXXX XXXX XXXX',
                      ),
                      expiryDateDecoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Expired Date',
                        hintText: 'XX/XX',
                      ),
                      cvvCodeDecoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'CVV',
                        hintText: 'XXX',
                      ),
                      cardHolderDecoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Card Holder',
                      ),
                      onCreditCardModelChange: onCreditCardModelChange,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        primary: const Color(0xff1b447b),
                      ),
                      child: Container(
                        margin: const EdgeInsets.all(8),
                        child: const Text(
                          'Validate',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'halter',
                            fontSize: 14,
                            package: 'flutter_credit_card',
                          ),
                        ),
                      ),
                      onPressed: () {
                        onClickValidate();
                      },
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      creditCard.cardNumber = creditCardModel.cardNumber;
      creditCard.expiryDate = creditCardModel.expiryDate;
      creditCard.cardHolderName = creditCardModel.cardHolderName;
      creditCard.cvvCode = creditCardModel.cvvCode;
      creditCard.isCvvFocused = creditCardModel.isCvvFocused;
    });
  }

  void onClickValidate() {
    // SharedPrefs.saveBool(SharedPrefs.KEY_CREDIT_CARD_ADDED, true);
    // if (_scaffoldKey.currentState.validate()) {
    //   print('valid!');
    // } else {
    //   print('invalid!');
    // }
    Navigator.of(context, rootNavigator: true).pop();
    widget.onBackCallback(true);

    // NavigatorService(context).pushToWidget(screen: CartScreen());
  }
}