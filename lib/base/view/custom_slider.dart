import '../app_lib.dart';
import 'custom_slider_painter.dart';

class CustomSlider extends StatefulWidget {
  CustomSlider({Key? key, 
    this.sliderHeight = 50.0,
    this.backgroundColor = Colors.black,
    this.progressColor = Colors.black,
    this.padding,
    this.onChangeEnd,
    this.onChangeStart,
    @required this.onChanged,
  }) : assert(sliderHeight >= 50 && sliderHeight <= 600), super(key: key);
  EdgeInsets? padding;
  double sliderHeight;
  ValueChanged<double>? onChanged;
  ValueChanged<double>? onChangeStart;
  ValueChanged<double>? onChangeEnd;
  Color backgroundColor;
  Color progressColor;

  @override
  _CustomSliderState createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider>
    with SingleTickerProviderStateMixin {
  double _dragPosition = 0.0;
  double _dragPercentage = 0.0;
  double _sliderWidth = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _handleChanged(double val) {
    if (widget.onChanged != null) {
      widget.onChanged!(val);
    }
  }

  void _handleChangeStart(double val) {
    if (widget.onChangeStart != null) {
      widget.onChangeStart!(val);
    }
  }

  void _handleChangeEnd(double val) {
    if (widget.onChangeEnd != null) {
      widget.onChangeEnd!(val);
    }
  }

  void _updateDragPosition(Offset val) {
    double newDragPosition = 0.0;
    if (val.dx <= 0.0) {
      newDragPosition = 0.0;
    } else if (val.dx >= _sliderWidth) {
      newDragPosition = _sliderWidth;
    } else {
      newDragPosition = val.dx;
    }

    setState(() {
      _dragPosition = newDragPosition;
      _dragPercentage = _dragPosition / _sliderWidth;
    });
  }

  void _onDragStart(BuildContext context, DragStartDetails start) {
    final RenderBox? box = context.findRenderObject() as RenderBox?;
    final Offset localOffset = box!.globalToLocal(start.globalPosition);
    _updateDragPosition(localOffset);
    _handleChangeStart(_dragPercentage);
  }

  void _onDragUpdate(BuildContext context, DragUpdateDetails update) {
    final RenderBox? box = context.findRenderObject() as RenderBox?;
    final Offset localOffset = box!.globalToLocal(update.globalPosition);
    _updateDragPosition(localOffset);
    _handleChanged(_dragPercentage);
  }

  void _onDragEnd(BuildContext context, DragEndDetails end) {
    setState(() {});
    _handleChangeEnd(_dragPercentage);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        _sliderWidth = constraints.maxWidth;
        return GestureDetector(
          child: Container(
              width: _sliderWidth,
              height: widget.sliderHeight,
              padding: widget.padding,
              child: CustomPaint(
                painter: CustomSliderPainter(
                  dragPercentage: _dragPercentage,
                  backgroundColor: widget.backgroundColor,
                  progressColor: widget.progressColor,
                  lineHeight: widget.sliderHeight,
                ),
              )),
          onTapDown: (TapDownDetails details) {
            DragUpdateDetails update =
                new DragUpdateDetails(globalPosition: details.globalPosition);
            _onDragUpdate(context, update);
          },
          onHorizontalDragStart: (DragStartDetails start) =>
              _onDragStart(context, start),
          onHorizontalDragUpdate: (DragUpdateDetails update) =>
              _onDragUpdate(context, update),
          onHorizontalDragEnd: (DragEndDetails end) => _onDragEnd(context, end),
        );
      },
    );
  }
}
