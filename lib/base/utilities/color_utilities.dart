import 'package:color/color.dart' as co;
import '../app_lib.dart';

class ColorUtilities {
  static Color getColorFromHex(String hex) {
    co.RgbColor rgbColor = co.HexColor(hex).toRgbColor();
    return Color.fromRGBO(rgbColor.r as int, rgbColor.g as int, rgbColor.b as int, 1);
  }
}
