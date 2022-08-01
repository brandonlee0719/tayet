import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/success/success.dart';
import '../models/card_model.dart';
import '../models/device_config.dart';

abstract class PaymentRemoteDataSource {
  Future<Either<Failure, String>> getSessionId();

  Future<Either<Failure, String>> authorizeUserInSession({
    required String sessionId,
    required String orderId,
    required String transId,
    required double amount,
    required CardModel userCard,
  });

  Future<Either<Failure, Success>> confirmPayment({
    required String sessionId,
    required String orderId,
    required String transId,
    required String authenticatedTransId,
    required CardModel userCard,
    required double amount,
  });
}
