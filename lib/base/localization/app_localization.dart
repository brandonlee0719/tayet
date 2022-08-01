import 'package:flutter/foundation.dart';

import '../app_lib.dart';

class AppLocalization {
  AppLocalization(this.locale);

  final Locale locale;

  static AppLocalization? of(BuildContext context) {
    return Localizations.of<AppLocalization>(context, AppLocalization);
  }

  static final Map<String, Map<String, String>> _localizedValues = {
    'en': Language.mapEn,
  };

  String getStrings(String key) {
    return _localizedValues[locale.languageCode]![key] ?? '$key not found';
  }

  static String getStringsValue(BuildContext context, String key) {
    String value = "";
    if (key.isEmpty) {
      return "";
    }
    if (context == null) {
      return "";
    }
    try {
      value = AppLocalization.of(context)!.getStrings(key);
    } catch (e) {
      if (kDebugMode) {
        print("Error in getStringsValue in AppLocalization: $e");
      }
    }
    return value;
  }
}
