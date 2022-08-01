import 'package:flutter/cupertino.dart';
import '../../base/app_lib.dart';
class ProductItemDescriptionLayout extends StatefulWidget {
  final bool showWhiteBg;

  ProductItemDescriptionLayout(this.showWhiteBg);

  @override
  _ProductItemDescriptionLayoutState createState() =>
      _ProductItemDescriptionLayoutState();
}

class _ProductItemDescriptionLayoutState
    extends State<ProductItemDescriptionLayout>
    with BaseLayout, TickerProviderStateMixin {
  String description =
      'The architecture of this material design kit is based on usage nested components in Figma.Thoughtful relationships between the elements allows to perform global changes for components used for both of mobile and desktop layouts within less actions. ';

  Widget getDesc() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(
        description,
        style: TextStyle(
            fontSize: 16, color: ProductItemDescriptionColor().titleColor),
      ),
    );
  }

  Widget itemDescWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            getStringValue(LanguageKey.itemDesc, context),
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: ProductItemDescriptionColor().titleColor),
          ),
        ),
        SizedBox(
          height: 16,
        ),
        widget.showWhiteBg
            ? Container(
                color: ProductItemDescriptionColor().listTileColor,
                padding: EdgeInsets.only(bottom: 16, top: 16),
                child: getDesc(),
              )
            : getDesc(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return itemDescWidget();
  }
}
