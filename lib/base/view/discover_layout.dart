import 'package:flutter/material.dart';
import '../../base/app_lib.dart';

class DiscoverLayout extends StatefulWidget {
  final String image;
  final double imageWidth;
  final double imageHeight;
  final Widget items;
  final Color color;
  final double roundCorner;

  DiscoverLayout(
      this.image, this.imageWidth, this.imageHeight, this.items, this.color,
      {this.roundCorner = 0});

  @override
  _DiscoverLayoutState createState() => _DiscoverLayoutState();
}

class _DiscoverLayoutState extends State<DiscoverLayout> with BaseLayout {
  Widget discover() {
    return InkWell(
      onTap: (){
        AlertDialogUtilities.showPressedMessage(context);
      },
      child: Stack(
        children: <Widget>[
          ClipRRect(
              borderRadius: BorderRadius.circular(widget.roundCorner),
              child: Image.asset(
                widget.image,
                fit: BoxFit.fill,
                width: widget.imageWidth,
                height: widget.imageHeight,
              )),
          Container(
            decoration: BoxDecoration(
                color: widget.color,
                borderRadius: BorderRadius.circular(widget.roundCorner)),
            width: widget.imageWidth,
            height: widget.imageHeight,
          ),
          widget.items,
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return discover();
  }
}
