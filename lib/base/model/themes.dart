import '../app_lib.dart';

class Themes {
  String s1 = 'Dark Mode';
  List<List<Object>> getThemeItem() {
    List<List<Object>> items = [];
    items.add([
      AssetKey.logo,
      'Flutter App',
    ]);
    items.add([
      'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu.'
    ]);
    items.add(['Website Link']);
    items.add(['Google Store Link']);
    items.add(['Font Selection', 'in the Next Versions']);
    items.add(['Color Selection', 'in the Next Versions']);
    items.add(['Dark Mode', 'in the Next Versions']);
    return items;
  }
}
