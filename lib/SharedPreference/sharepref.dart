import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static String firstTimeOpening = "First Time app open";
  static String userAgreementContactAccess =
      "user allow user to read contact";
  SharedPreferences? _sharedPreferences;
  Future init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  void setFirstTimeAppOpen(bool value) {
    _sharedPreferences!.setBool(firstTimeOpening, value);
  }

  bool isFirstTime() {
    var value = _sharedPreferences!.getBool(firstTimeOpening);
    if (kDebugMode) {
      print("sharepref result $value");
    }
    return value ?? true;
  }

  void setReadAgree(bool value) {
    _sharedPreferences!.setBool(userAgreementContactAccess, value);
  }

  bool? isAgree() {
    var value = _sharedPreferences!.getBool(userAgreementContactAccess);
    if (kDebugMode) {
      print("sharepref result $value");
    }
    return value;
  }
}
