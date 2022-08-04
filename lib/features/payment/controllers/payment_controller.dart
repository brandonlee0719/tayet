import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../../../core/error/failure.dart';
import '../../../core/widgets/widgets.dart';
import '../data/models/card_model.dart';
import '../data/repositories/payment_repo.dart';
import '../view/pages/credit_card_enter_page.dart';
import '../view/pages/html_web_view_page.dart';
import '../view/pages/payment_confirm_page.dart';

class PaymentController extends GetxController {
  final PaymentRepository repository;

  PaymentController({required this.repository});

  static PaymentController instance = Get.find();

  PayState state = PayState.loading;

  _setLoading() {
    state = PayState.loading;
    update();
  }

  _setError({required Failure failure}) {
    state = PayState.error;
    Get.showSnackbar(
      GetSnackBar(
        messageText: MText(
          failure.errorMassage,
          color: Colors.white,
        ),
        backgroundColor: Colors.red[600]!,
      ),
    );
    update();
  }

  _setPayed() {
    state = PayState.payed;
    //TODO #14 show snack bar or something
    update();
  }

  _setCalm() {
    state = PayState.calm;
    update();
  }

  startPayment({
    required double amount,
    required VoidCallback onSuccess,
  }) {
    _setCalm();
    // FIXME: It's been fixed by removing the return statement
    Get.to(
      () => CreditCardEnterPage(
        amount: amount,
        onCardSubmitted: (CardModel userCard) async {
          _setLoading();
          final sessionIdResult = await repository.getSessionId();

          sessionIdResult.fold(
            (failure) {
              _setError(failure: failure);
            },
            (newSessionId) async {
              final orderId = const Uuid().v1();
              final transId = const Uuid().v1();

              final authenticationResult =
                  await repository.authorizeUserInSession(
                sessionId: newSessionId,
                orderId: orderId,
                transId: transId,
                amount: amount,
                userCard: userCard,
              );

              authenticationResult.fold(
                (failure) {
                  _setError(failure: failure);
                },
                (authenticatedPayerRedirectHTML) {
                  _setCalm();
                  Get.to(() =>
                      HTMLWebViewPage(html: authenticatedPayerRedirectHTML));
                  // return;
                  Get.to(
                    () => PaymentConfirmPage(
                      amount: amount,
                      onPayBottonClicked: () async {
                        _setLoading();

                        final payResult = await repository.confirmPayment(
                          orderId: orderId,
                          userCard: userCard,
                          sessionId: newSessionId,
                          authenticatedTransId: authenticatedPayerRedirectHTML,
                          transId: transId,
                          amount: amount,
                        );

                        payResult.fold(
                          (failure) {
                            _setError(failure: failure);
                          },
                          (success) {
                            _setPayed();
                            onSuccess();
                          },
                        );
                      },
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

enum PayState {
  loading,
  error,
  payed,
  calm,
}
