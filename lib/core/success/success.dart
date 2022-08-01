abstract class Success {
  abstract String? message;

  bool get hasMessage => message != null;
}
