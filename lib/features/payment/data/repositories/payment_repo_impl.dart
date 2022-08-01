import 'package:dartz/dartz.dart';
import 'package:smart_auction/core/success/success.dart';

import '../../../../core/error/failure.dart';
import '../data_sources/payment_remote_datasource.dart';
import '../models/card_model.dart';
import '../models/device_config.dart';
import 'payment_repo.dart';

class PaymentRepositoryImpl extends PaymentRepository {
  final PaymentRemoteDataSource remoteDataSource;

  PaymentRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, String>> getSessionId() {
    return remoteDataSource.getSessionId();
  }

  @override
  Future<Either<Failure, String>> authorizeUserInSession({
    required String sessionId,
    required String orderId,
    required String transId,
    required double amount,
    required CardModel userCard,
  }) {
    return remoteDataSource.authorizeUserInSession(
      sessionId: sessionId,
      orderId: orderId,
      transId: transId,
      amount: amount,
      userCard: userCard,
    );
  }

  @override
  Future<Either<Failure, Success>> confirmPayment({
    required String sessionId,
    required String orderId,
    required String transId,
    required String authenticatedTransId,
    required CardModel userCard,
    required double amount,
  }) {
    return remoteDataSource.confirmPayment(
      sessionId: sessionId,
      orderId: orderId,
      transId: transId,
      authenticatedTransId: authenticatedTransId,
      userCard: userCard,
      amount:amount,
    );
  }
}
