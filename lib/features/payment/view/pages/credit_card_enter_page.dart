import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:get/get.dart';

import '../../../../core/widgets/widgets.dart';
import '../../controllers/payment_controller.dart';
import '../../data/models/card_model.dart';

class CreditCardEnterPage extends StatefulWidget {
  final ValueChanged<CardModel> onCardSubmitted;
  final double? amount;
  const CreditCardEnterPage({
    Key? key,
    required this.onCardSubmitted,
    this.amount,
  }) : super(key: key);

  @override
  State<CreditCardEnterPage> createState() => _CreditCardEnterPageState();
}

class _CreditCardEnterPageState extends State<CreditCardEnterPage> {
  late CardModel userCard;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late bool isCvvFocused;

  @override
  void initState() {
    super.initState();
    userCard = CardModel(
      nameOnCard: '',
      cardNumber: '',
      expiryMonth: '',
      expiryYear: '',
      securityCode: '',
    );
    isCvvFocused = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: GetBuilder<PaymentController>(builder: (controller) {
        final state = controller.state;

        if (state == PayState.payed) {
          Future.delayed(Duration.zero, () => Get.back());
        }

        return Stack(
          fit: StackFit.expand,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        const HeightSpace(20),
                        CreditCardWidget(
                          cardNumber: userCard.cardNumber,
                          expiryDate: userCard.expiryDate,
                          cardHolderName: userCard.nameOnCard,
                          cvvCode: userCard.securityCode,
                          showBackView:
                              isCvvFocused, //true when you want to show cvv(back) view
                          onCreditCardWidgetChange: (newCardView) {},
                        ),
                        buildCardEnterForm(),
                        const HeightSpace(20),
                      ],
                    ),
                  ),
                  ContanierButton(
                    text: 'Next',
                    onTap: () {
                      if (formKey.currentState?.validate() ?? false) {
                        widget.onCardSubmitted(userCard);
                      }
                    },
                  ),
                  const HeightSpace(20),
                ],
              ),
            ),
            if (state == PayState.loading)
              GestureDetector(
                child: Container(
                  color: Colors.black12,
                  child: const LoadingWidget(),
                ),
                onTap: () {},
              )
          ],
        );
      }),
    );
  }

  CreditCardForm buildCardEnterForm() {
    return CreditCardForm(
      formKey: formKey,
      obscureCvv: true,
      obscureNumber: true,
      cardNumber: userCard.cardNumber,
      cvvCode: userCard.securityCode,
      isHolderNameVisible: true,
      isCardNumberVisible: true,
      isExpiryDateVisible: true,
      cardHolderName: userCard.nameOnCard,
      expiryDate: userCard.expiryDate,
      themeColor: Theme.of(context).primaryColor,
      textColor: Colors.black,
      cardNumberDecoration: const InputDecoration(
        labelText: 'Number',
        hintText: 'XXXX XXXX XXXX XXXX',
      ),
      expiryDateDecoration: const InputDecoration(
        labelText: 'Expired Date',
        hintText: 'XX/XX',
      ),
      cvvCodeDecoration: const InputDecoration(
        labelText: 'CVV',
        hintText: 'XXX',
      ),
      cardHolderDecoration: const InputDecoration(
        labelText: 'Card Holder',
      ),
      onCreditCardModelChange: onCreditCardModelChange,
    );
  }

  onCreditCardModelChange(CreditCardModel cardModel) {
    setState(() {
      userCard.cardNumber = cardModel.cardNumber.replaceAll(' ', '');
      userCard.nameOnCard = cardModel.cardHolderName;
      userCard.securityCode = cardModel.cvvCode;
      userCard.expiryMonth = cardModel.expiryDate.split('/')[0];
      if (cardModel.expiryDate.split('/').length > 1) {
        userCard.expiryYear = cardModel.expiryDate.split('/')[1];
      }
    });
  }
}
