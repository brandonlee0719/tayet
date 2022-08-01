import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:smart_auction/core/success/success.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/constants.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/error/server_failure.dart';
import '../../../../core/success/payment_success.dart';
import '../../../../helpers/config_reader.dart';
import '../models/card_model.dart';
import 'payment_remote_datasource.dart';

class PaymentCredimaxDataSource extends PaymentRemoteDataSource {
  final String basePaymentUrl =
      'https://credimax.gateway.mastercard.com/api/rest/version/64/merchant/${ConfigReader.merchantId}';

  @override
  Future<Either<Failure, String>> getSessionId() async {
    try {
      final body = jsonEncode(
        {
          "session": {"authenticationLimit": 25}
        },
      );

      final response = await http.post(Uri.parse('$basePaymentUrl/session'),
          headers: {
            "Content-Type": "application/json",
            "Authorization": ConfigReader.basicAuth,
          },
          body: body);
      final Map<String, dynamic> responseBody = jsonDecode(response.body);

      if (response.statusCode != createdStatusCode) {
        return Left(
          ServerFailure(
            errorMassage: responseBody['error']['explanation'] as String,
          ),
        );
      }

      return Right(responseBody['session']['id'] as String);
    } catch (e) {
      return Left(ServerFailure(errorMassage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> authorizeUserInSession({
    required String sessionId,
    required String orderId,
    required String transId,
    required double amount,
    required CardModel userCard,
  }) async {
    try {
      final mainHeader = {
        "Content-Type": "application/json",
        "Authorization": ConfigReader.basicAuth,
      };

      final registerUserRequestBody = jsonEncode(
        {
          "sourceOfFunds": {
            "provided": {
              "card": {
                "nameOnCard": userCard.nameOnCard,
                "number": userCard.cardNumber,
                "expiry": {
                  "month": userCard.expiryMonth,
                  "year": userCard.expiryYear
                },
                "securityCode": userCard.securityCode
              }
            }
          }
        },
      );

      final registerUserCardResponse = await http.put(
        Uri.parse('$basePaymentUrl/session/$sessionId'),
        headers: mainHeader,
        body: registerUserRequestBody,
      );

      if (registerUserCardResponse.statusCode != successStatusCode) {
        final Map<String, dynamic> body =
            jsonDecode(registerUserCardResponse.body);
        return Left(
          ServerFailure(
            errorMassage: body['error']['explanation'] as String,
          ),
        );
      }

      final initAuthRequestBody = jsonEncode(
        {
          "apiOperation": "INITIATE_AUTHENTICATION",
          "authentication": {
            "acceptVersions": "3DS1,3DS2",
            "channel": "PAYER_BROWSER",
            "purpose": "PAYMENT_TRANSACTION"
          },
          "correlationId": const Uuid().v1(),
          // TODO: Trying without this field.
          // "order": {"currency": "USD", "reference": orderId},
          "session": {"id": sessionId},
          "transaction": {"reference": transId}
        },
      );

      final initAuthResponse = await http.put(
        Uri.parse(
          '$basePaymentUrl/order/$orderId/transaction/$transId',
        ),
        headers: mainHeader,
        body: initAuthRequestBody,
      );

      if (initAuthResponse.statusCode != createdStatusCode) {
        final Map<String, dynamic> body = jsonDecode(initAuthResponse.body);
        return Left(
          ServerFailure(
            errorMassage: body['error']['explanation'] as String,
          ),
        );
      }

      final authPayerRequestBody = jsonEncode(
        {
          "apiOperation": "AUTHENTICATE_PAYER",
          // "authentication": {
          //   "redirectResponseUrl": ConfigReader.redirectUrlAfterSuccessOTP
          // },
          // ANCHOR: The actual amount for the trans to be deducted
          "order": {"amount": amount, "currency": "USD"},
          "session": {"id": sessionId},
          "device": {
            "browser": "MOZILLA",
            "browserDetails": {
              "3DSecureChallengeWindowSize": "FULL_SCREEN",
              "acceptHeaders": "application/json",
              "colorDepth": 24,
              "javaEnabled": true,
              "language": "en-US",
              "screenHeight": 640,
              "screenWidth": 480,
              "timeZone": 273
            }
          }
        },
      );

      final authPayerResponse = await http.put(
        Uri.parse(
          '$basePaymentUrl/order/$orderId/transaction/$transId',
        ),
        headers: mainHeader,
        body: authPayerRequestBody,
      );

      final Map<String, dynamic> authPayerResponseBody =
          jsonDecode(authPayerResponse.body);

      if (authPayerResponse.statusCode != createdStatusCode) {
        return Left(
          ServerFailure(
            errorMassage:
                authPayerResponseBody['error']['explanation'] as String,
          ),
        );
      }
      if (kDebugMode) {
        print(authPayerResponseBody);
      }
      if (authPayerResponseBody['response']['gatewayRecommendation'] !=
          'PROCEED') {
        return Left(
          ServerFailure(errorMassage: 'Error: Cloudn`t Auth Payer'),
        );
      }

      if (authPayerResponseBody['result'] == 'FAILURE') {
        return Left(
          ServerFailure(
            errorMassage: 'Error Happend',
          ),
        );
      }

      return Right(
        authPayerResponseBody['authentication']['redirectHTML'] as String,
      );
    } catch (e) {
      return Left(ServerFailure(errorMassage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Success>> confirmPayment({
    required String sessionId,
    required String orderId,
    required String transId,
    required String authenticatedTransId,
    required CardModel userCard,
    required double amount,
  }) async {
    try {
      final requestHeader = {
        "Content-Type": "application/json",
        "Authorization": ConfigReader.basicAuth,
      };

      final payRequestBody = jsonEncode(
        {
          // FIXME: Dear @MohanadDaDev, your attn is required to fix this issue.
          // "apiOperation": "PAY", << changed
          "apiOperation": "AUTHORIZE",
          "authentication": {"transactionId": transId},
          "order": {
            "currency": "USD",
            "amount": amount,
            "reference": orderId,
          },
          "session": {
            "id": sessionId,
          },
          "sourceOfFunds": {
            "provided": {
              "card": {
                "number": userCard.cardNumber,
                "expiry": {
                  "month": userCard.expiryMonth,
                  "year": userCard.expiryYear
                }
              }
            },
            "type": "CARD"
          },
          "transaction": {"reference": orderId}
        },
      );

      final payResponse = await http.put(
        Uri.parse(
          '$basePaymentUrl/order/$orderId/transaction/$authenticatedTransId',
        ),
        headers: requestHeader,
        body: payRequestBody,
      );

      final Map<String, dynamic> payResponseBody = jsonDecode(payResponse.body);

      log(payResponseBody.toString());

      if (payResponseBody['result'] != 'SUCCESS') {
        return Left(
          ServerFailure(errorMassage: payResponseBody['error']['explanation']),
        );
      }

      return Right(PaymentSeccuss());
    } catch (e) {
      return Left(ServerFailure(errorMassage: e.toString()));
    }
  }
}
