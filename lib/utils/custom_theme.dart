import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

// TODO: use Google Fonts - Changa

class CustomTheme extends GoogleFonts {
  final BoxConstraints constraints;

  CustomTheme(this.constraints);

  final double designWidth = 375.0;
  final double designHeight = 812.0;

  double _getProportionateScreenWidth(inputWidth) {
    return (inputWidth / designWidth) * constraints.maxWidth;
  }

  double _getProportionateScreenHeight(inputHeight) {
    return (inputHeight / designHeight) * constraints.maxHeight;
  }

  // FIXME: Unify all fonts to Google Fonts -> Changa
  // nunito() => TextTheme(
  changa() => TextTheme(
        displaySmall: GoogleFonts.changaTextTheme().displaySmall?.copyWith(
            fontSize: _getProportionateScreenHeight(12),
            fontWeight: FontWeight.w400),
        displayMedium: GoogleFonts.changaTextTheme().displayMedium?.copyWith(
            fontSize: _getProportionateScreenHeight(14),
            fontWeight: FontWeight.w400),
      );

  elevatedButtonTheme() => ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(AppColors.primarycolor),
          foregroundColor: MaterialStateProperty.all(Colors.white),
          elevation: MaterialStateProperty.all(0),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                _getProportionateScreenWidth(4),
              ),
            ),
          ),
          textStyle: MaterialStateProperty.all(
            TextStyle(
              fontSize: _getProportionateScreenWidth(16),
            ),
          ),
          minimumSize: MaterialStateProperty.all(
            Size(
              double.infinity,
              _getProportionateScreenHeight(56),
            ),
          ),
        ),
      );

  outlinedButtonTheme() => OutlinedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.white),
          foregroundColor: MaterialStateProperty.all(AppColors.primarycolor),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                _getProportionateScreenWidth(4),
              ),
            ),
          ),
          elevation: MaterialStateProperty.all(0),
          side: MaterialStateProperty.all(
            BorderSide(
                width: _getProportionateScreenWidth(1.5),
                color: AppColors.primarycolor),
          ),
          textStyle: MaterialStateProperty.all(
            TextStyle(
              fontSize: _getProportionateScreenWidth(16),
            ),
          ),
          minimumSize: MaterialStateProperty.all(
            Size(double.infinity, _getProportionateScreenHeight(56)),
          ),
        ),
      );
}
