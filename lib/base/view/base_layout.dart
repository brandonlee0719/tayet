import '../app_lib.dart';

class BaseLayout {
  static List<String>? keys;
  static List<Widget>? pages;

  String getStringValue(String key, BuildContext context) {
    if (key.isEmpty) return "";
    return AppLocalization.getStringsValue(context, key);
  }

  Future<bool> requestPop() {
    exit(0);
  }

  void addKeysAndPages(Map<String, Widget> data) {
    data.forEach((key, value) {
      keys?.add(key);
      pages?.add(value);
    });
  }

  Builder createBuilder(Widget body, String page) {
    return Builder(builder: (BuildContext context) {
      return Stack(
        children: [
          body,
          ElevatedButton(
            child: Text(getStringValue(page, context)),
            onPressed: () {
              Navigator.pushNamed(context, page);
            },
          )
          // CustomSwitch(
          //     (int type) {
          //       if (pages == null ||
          //           pages!.isEmpty ||
          //           keys == null ||
          //           keys!.isEmpty) {
          //         return;
          //       } else if (type == CustomSwitch.left) {
          //         Navigator.pop(context);
          //       } else if (type == CustomSwitch.right) {
          //         int position = keys!.indexOf(page) + 1;
          //         if (position > keys!.length - 1) {
          //           return;
          //         }
          //         NavigationSlideTransitionUtilities.pushNavigation(
          //             context, pages![position]);
          //       }
          //     },
          //     () {},
          //     () {
          //       Constants.isDarkTheme = !Constants.isDarkTheme;
          //       themeListener.onThemeChanged!(Constants.isDarkTheme);
          //     })
        ],
      );
    });
  }
}
