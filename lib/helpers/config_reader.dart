import 'dart:convert';

import 'package:flutter/services.dart';

abstract class ConfigReader {
  static late Map<String, dynamic> _config;

  static Future<void> init() async {
    final configString = await rootBundle.loadString('config/app_config.json');
    _config = json.decode(configString) as Map<String, dynamic>;
  }

  static String get _username => _config['username'] as String;

  static String get _password => _config['password'] as String;

  static String get merchantId => _config['merchantId'] as String;

  static String get redirectUrlAfterSuccessOTP =>
      _config['redirectUrlAfterSuccessOTP'] as String;

  static String get basicAuth =>
      'Basic ' + base64Encode(utf8.encode('$_username:$_password'));
}
