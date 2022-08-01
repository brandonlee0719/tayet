import 'package:flutter/material.dart';
import '../../base/app_lib.dart';

class CartCheckoutButtonLayout extends StatefulWidget {
  Color? bgColor;
  Color? textColor;
  String? text;
  Color? icon;
  Widget? iconWidget;

  CartCheckoutButtonLayout(
      {Key? key,
      this.bgColor,
      this.textColor,
      this.text,
      this.icon,
      this.iconWidget})
      : super(key: key);

  @override
  _CartCheckoutButtonLayoutState createState() =>
      _CartCheckoutButtonLayoutState(
          bgColor!, textColor!, text!, icon!, iconWidget!);
}

class _CartCheckoutButtonLayoutState extends State<CartCheckoutButtonLayout>
    with BaseLayout {
  Color bgColor;
  Color textColor;
  String text;
  Color icon;
  Widget iconWidget;

  _CartCheckoutButtonLayoutState(
      this.bgColor, this.textColor, this.text, this.icon, this.iconWidget);

  Widget getItem() {
    return TextButton(
      onPressed: () {
        AlertDialogUtilities.showPressedMessage(context);
      },
      // color: bgColor,
      child: Padding(
        padding:
            const EdgeInsets.only(left: 16.0, right: 16, top: 12, bottom: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Container(),
            ),
            Text(
              text,
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.w500, color: textColor),
            ),
            Expanded(
              child: iconWidget,
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    init();
    return getItem();
  }

  void init() {
    bgColor = ColorKey.cartColor;
    textColor = Colors.black;
    if (text == null || text.isEmpty) {
      text = getStringValue(LanguageKey.proceedCheckout, context);
    }
    icon = ColorKey.darkGrey;
  }
}
