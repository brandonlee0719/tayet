import '/core/error/failure.dart';

class ServerFailure extends Failure {
  @override
  String errorMassage;

  ServerFailure({required this.errorMassage});
}
