import 'package:flutter/material.dart';
import '../../base/app_lib.dart';

class CartAddMinusListLayout extends StatefulWidget {
  final List<Object> item;
  final Widget price;
  final Widget button;
  final double imageWidth;
  final double addMinusSpacing;

  CartAddMinusListLayout(this.item, this.price, this.button,
      {this.imageWidth = 142, this.addMinusSpacing = 26});

  @override
  _CartAddMinusListLayoutState createState() => _CartAddMinusListLayoutState();
}

class _CartAddMinusListLayoutState extends State<CartAddMinusListLayout>
    with BaseLayout {
  int count = 0;

  Widget listTile(List<Object> item) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: <Widget>[
          Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Image.asset(
                  item[2].toString(),
                  fit: BoxFit.fill,
                  width: widget.imageWidth,
                ),
                SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        item[0].toString(),
                        style: TextStyle(
                            fontSize: 12,
                            color: CartAddMinusListColor().titleColor),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        item[1].toString(),
                        style: TextStyle(
                            fontSize: 16,
                            color: CartAddMinusListColor().titleColor),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      widget.price,
                    ],
                  ),
                ),
              ]),
          Row(
            children: <Widget>[
              Container(
                padding:
                EdgeInsets.only(left: 16, right: 16, top: 4, bottom: 4),
                decoration: BoxDecoration(
                    color: CartAddMinusListColor().buttonColor,
                    border: Border.all(color: ColorKey.lightGreyColor)),
                child: Row(
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        if (mounted)
                          setState(() {
                            count--;
                          });
                      },
                      child: Icon(
                        count <= 1 ? Icons.delete : Icons.remove,
                        color: ColorKey.cartColor,
                      ),
                    ),
                    SizedBox(
                      width: widget.addMinusSpacing,
                    ),
                    Text(
                      count.toString(),
                      style: TextStyle(
                          fontSize: 16,
                          color: CartAddMinusListColor().titleColor),
                    ),
                    SizedBox(
                      width: widget.addMinusSpacing,
                    ),
                    InkWell(
                      onTap: () {
                        if (mounted)
                          setState(() {
                            count++;
                          });
                      },
                      child: Icon(
                        Icons.add,
                        color: ColorKey.cartColor,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(),
              ),
              widget.button
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return listTile(widget.item);
  }
}
