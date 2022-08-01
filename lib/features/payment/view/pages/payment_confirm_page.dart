import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../../../core/widgets/widgets.dart';
import '../../controllers/payment_controller.dart';

class PaymentConfirmPage extends StatelessWidget {
  final VoidCallback onPayBottonClicked;
  final double amount;
  const PaymentConfirmPage({
    Key? key,
    required this.amount,
    required this.onPayBottonClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: GetBuilder<PaymentController>(builder: (controller) {
        final state = controller.state;

        if (state == PayState.payed) {
          Future.delayed(
            Duration.zero,
            () => Navigator.popUntil(
              context,
              (route) => route.isFirst,
            ),
          );
        }

        return Stack(
          fit: StackFit.expand,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  const HeightSpace(20),
                  Expanded(
                      child: Center(
                    child: MText('Pay $amount'),
                  )),
                  const HeightSpace(10),
                  ContanierButton(
                      text: 'Pay Now', onTap: () => onPayBottonClicked()),
                  const HeightSpace(10),
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
}
