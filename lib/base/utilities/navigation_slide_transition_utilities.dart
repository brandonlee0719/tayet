import '../app_lib.dart';

class NavigationSlideTransitionUtilities {
  static Future<dynamic> pushNavigation(BuildContext context, Widget widget) {
    // if (context == null) return null;
    return Navigator.push(
      context,
      MaterialPageRoute(builder: (BuildContext context) {
        return widget;
      }),
    );
  }

  static Future<dynamic> pushAndRemoveUntil(
      BuildContext context, Widget widget) {
    // if (context == null) return null;
    return Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return widget;
    }), (Route<dynamic> route) => false);
  }
}
