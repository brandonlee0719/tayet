
typedef ThemeChangeCallback = void Function(bool value);

//singleton class
class ThemeListener {
  static final ThemeListener _singleton = ThemeListener._internal();
  ThemeChangeCallback? onThemeChanged;

  factory ThemeListener() {
    return _singleton;
  }

  ThemeListener._internal();
}

ThemeListener themeListener = ThemeListener();
