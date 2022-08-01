import 'failure.dart';

class UnauthorizedFailure extends Failure {
  @override
  String errorMassage;

  UnauthorizedFailure({required this.errorMassage});
}
