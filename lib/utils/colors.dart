import 'package:flutter/material.dart';

class AppColors {
  AppColors._(); // this basically makes it so you can instantiate this class

  static const Map<int, Color> orange = <int, Color>{
    50: Color(0xFFFCF2E7),
    100: Color(0xFFF8DEC3),
    200: Color(0xFFF3C89C),
    300: Color(0xFFEEB274),
    400: Color(0xFFEAA256),
    500: Color(0xFFE69138),
    600: Color(0xFFE38932),
    700: Color(0xFFDF7E2B),
    800: Color(0xFFDB7424),
    900: Color(0xFFFF574D)
  };

  static const Color secondary = Color(0xFF14171A);
  static const primarycolor = Color(0xFFf15c24);
  static const Color black = Color(0xFF000000);
  static const accentcolor = Color(0xFF6D6D6D);
  static const whitecolor = Color(0xFFFFFFFF);
  static const orangecolor = Color(0xFFFBC034);

  static const myTextTheme = TextStyle(
    color: Color(0xFF14171A),
    fontFamily: "Tajawal-Medium",
    fontStyle: FontStyle.normal,
    fontSize: 14,
    fontWeight: FontWeight.bold,
  );
}
