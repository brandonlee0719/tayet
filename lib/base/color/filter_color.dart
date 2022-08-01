import '../../base/app_lib.dart';

class FilterColor {
  Color iconUnselected = Constants.isDarkTheme ? DarkTheme.d1 : LightTheme.l4;
  Color iconSelected = Constants.isDarkTheme ? DarkTheme.d3 : LightTheme.l1;
  Color textColor = Constants.isDarkTheme ? DarkTheme.d1 : LightTheme.l1;
}