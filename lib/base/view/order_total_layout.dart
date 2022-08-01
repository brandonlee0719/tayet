import '../../base/app_lib.dart';

class OrderTotalLayout extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return OrderTotalLayoutState();
  }
}

class OrderTotalLayoutState extends State<OrderTotalLayout> with BaseLayout {

  Widget getOrderTotal() {
    return Container(
      color: OriginalTotalColor().bgColor,
      child: Padding(
        padding: const EdgeInsets.only(top:8, left:16.0, right: 16),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  getStringValue(LanguageKey.orderTotal, context),
                  style: TextStyle(fontSize: 24,color:OriginalTotalColor().textColor),
                ),
                Text(
                  '\$38.95',
                  style: TextStyle(fontSize: 24,color:OriginalTotalColor().textColor),
                ),
              ],
            ),
            SizedBox(height: 8,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  getStringValue(LanguageKey.deliveryTaxes, context),
                  style: TextStyle(fontSize: 12, color: ColorKey.registerBox),
                ),
                Text(
                  '\$9.90',
                  style: TextStyle(fontSize: 12, color: ColorKey.registerBox),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return getOrderTotal();
  }
}
