import 'package:flutter/cupertino.dart';
import '../../base/app_lib.dart';

class ProductBottomAddMinusLayout extends StatefulWidget {
  final Color colorAddCartButton;
  final Color colorTextAddCartButton;

  ProductBottomAddMinusLayout(
      this.colorAddCartButton, this.colorTextAddCartButton);

  @override
  _ProductBottomAddMinusLayoutState createState() =>
      _ProductBottomAddMinusLayoutState();
}

class _ProductBottomAddMinusLayoutState
    extends State<ProductBottomAddMinusLayout>
    with BaseLayout, TickerProviderStateMixin {
  int quantity = 4;

  Widget getBottom() {
    return Container(
      color: Colors.purpleAccent,
      padding: const EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: ColorKey.darkGrey),
                  borderRadius: BorderRadius.circular((5))),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      if (mounted) {
                        setState(() {
                          quantity--;
                          if (quantity < 0) {
                            quantity = 0;
                          }
                        });
                      }
                    },
                    icon: Icon(
                      Icons.remove,
                      color: ColorKey.c35,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: IconTheme.of(context).size! * 2,
                      child: Center(
                        child: Text(
                          quantity.toString(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      if (mounted) {
                        setState(() {
                          quantity++;
                        });
                      }
                    },
                    icon: Icon(
                      Icons.add,
                      color: ColorKey.c35,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          Expanded(
            child: TextButton(
              onPressed: () {
                AlertDialogUtilities.showPressedMessage(context);
              },
              // color: widget.colorAddCartButton,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  getStringValue(LanguageKey.addCart, context).toUpperCase(),
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: widget.colorTextAddCartButton),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return getBottom();
  }
}
