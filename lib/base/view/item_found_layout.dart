import '../../base/app_lib.dart';

class ItemFoundLayout extends StatefulWidget {
  @override
  _ItemFoundLayoutState createState() => _ItemFoundLayoutState();
}

class _ItemFoundLayoutState extends State<ItemFoundLayout>
    with BaseLayout, TickerProviderStateMixin {
  Widget getItem(List<List<Object>> items, int index) {
    List<Object> item = items[index];
    double size = 40;
    return Column(
      children: <Widget>[
        Container(
          color: ItemFoundColor().listTileColor,
          padding: EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    item[0].toString() + ' ',
                    style: TextStyle(
                        fontSize: 16, color: ItemFoundColor().titleColor),
                  ),
                  Text(
                    item[1].toString(),
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: ItemFoundColor().titleColor),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  Text(
                    item[2].toString(),
                    style: TextStyle(
                        fontSize: 14, color: ItemFoundColor().titleColor),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Image.asset(
                    AssetKey.arrowSearch,
                    width: size,
                    height: size,
                  )
                ],
              ),
            ],
          ),
        ),
        index == items.length - 1
            ? Container()
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Divider(
                  height: 0.5,
                ),
              )
      ],
    );
  }

  List<Widget> getList() {
    List<List<Object>> items = ItemFound().items;
    List<Widget> widgets = [];
    for (int i = 0; i < items.length; i++) {
      widgets.add(getItem(items, i));
    }
    widgets.insert(
        0,
        Padding(
          padding: EdgeInsets.only(top: 8.0, bottom: 8, left: 16, right: 16),
          child: Text(
            getStringValue(LanguageKey.itemFound, context),
            style: TextStyle(color: ItemFoundColor().titleColor),
          ),
        ));
    return widgets;
  }

  Widget getBuildBody() {
    return ListView(
      children: getList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return getBuildBody();
  }
}
