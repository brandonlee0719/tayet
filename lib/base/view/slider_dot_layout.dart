import '../../base/app_lib.dart';
class SliderDotLayout extends StatefulWidget {
  final double heightDetail;
  final List<String> imagePath;
  final int current;
  final Color dotColor;
  final Color backgroundColor;
  final Color borderColor;
  final bool needPositionForDotList;

  SliderDotLayout(this.heightDetail, this.imagePath, this.current,
      this.dotColor, this.needPositionForDotList,
      {this.backgroundColor = Colors.white, this.borderColor = Colors.black});

  @override
  _SliderDotLayoutState createState() => _SliderDotLayoutState();
}

class _SliderDotLayoutState extends State<SliderDotLayout> with BaseLayout {
  Widget getDots(int index) {
    return Container(
      width: 8.0,
      height: 8.0,
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
              color:
                  widget.current == index ? Colors.transparent : widget.borderColor),
          color: widget.current == index
              ? widget.dotColor
              : widget.backgroundColor == null
                  ? Colors.white
                  : widget.backgroundColor),
    );
  }

  Widget getDotList() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(),
        ),
        Container(
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(40),
              color: widget.backgroundColor),
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children:
                  CommonUtilities.map<Widget>(widget.imagePath, (index, url) {
                return getDots(index);
              }),
            ),
          ),
        ),
        Expanded(
          child: Container(),
        ),
      ],
    );
  }

  Widget getListOfDotsWithPosition() {
    return !widget.needPositionForDotList
        ? getDotList()
        : Positioned(
            bottom: widget.heightDetail + 16,
            left: 0,
            right: 0,
            child: getDotList());
  }

  Widget getListOfDots() {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(40),
          color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: CommonUtilities.map<Widget>(widget.imagePath, (index, url) {
            return getDots(index);
          }),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return getListOfDotsWithPosition();
  }
}
