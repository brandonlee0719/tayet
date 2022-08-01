import '../app_lib.dart';
class CommonUtilities {
  static List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  static double getImageWidth(BuildContext context, int crossAxisCount) {
    double width = MediaQuery.of(context).size.width;
    double imageWidth = width / crossAxisCount - 28;
    return imageWidth;
  }

  static Future<String> loadLocalHTML(html) async {
    String url = '';
    url = await rootBundle.loadString(html);
    return Uri.dataFromString(url,
        mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
        .toString();
  }
}
