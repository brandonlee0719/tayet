import 'package:flutter/material.dart';
import '../../base/app_lib.dart';

class PriceSummaryLayout extends StatefulWidget {
  final Map<String, String> maps;

  PriceSummaryLayout(this.maps);

  @override
  _PriceSummaryLayoutState createState() => _PriceSummaryLayoutState();
}

class _PriceSummaryLayoutState extends State<PriceSummaryLayout>
    with BaseLayout {
  Widget getItem() {
    return Column(
      children: widget.maps.keys.map((String key) {
        return Builder(
          builder: (BuildContext context) {
            return Padding(
              padding: const EdgeInsets.only(
                  top: 8, bottom: 8, left: 16.0, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    getStringValue(key, context),
                    style: TextStyle(
                        fontSize: 16, color: ColorKey.anortherGreyColor),
                  ),
                  new RichText(
                    text: new TextSpan(
                      style: new TextStyle(
                        fontSize: 16,
                      ),
                      children: <TextSpan>[
                        new TextSpan(
                            text: getStringValue(
                                    LanguageKey.usDollarCap, context) +
                                ', ',
                            style: new TextStyle(
                                color: ColorKey.secondAnortherGreyColor,
                                fontWeight: key == LanguageKey.orderTotalCap
                                    ? FontWeight.bold
                                    : FontWeight.normal)),
                        new TextSpan(
                            text: Constants.cartFour[key],
                            style: new TextStyle(
                                color: PriceSummaryColor().textFieldColor,
                                fontWeight: key == LanguageKey.orderTotalCap
                                    ? FontWeight.bold
                                    : FontWeight.normal)),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return getItem();
  }
}
