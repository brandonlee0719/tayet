import 'dart:ui';

import 'package:flutter/material.dart';

class CustomSliderPainter extends CustomPainter {
  CustomSliderPainter({
    required this.dragPercentage,
    required this.backgroundColor,
    required this.lineHeight,
    required this.progressColor,
  }) {
    _paintBackground.color = backgroundColor;
    _paintBackground.style = PaintingStyle.stroke;
    _paintBackground.strokeWidth = lineHeight;

    _paintLine.color = dragPercentage.toString() == "0.0"
        ? progressColor.withOpacity(0.0)
        : progressColor;
    _paintLine.style = PaintingStyle.stroke;
    _paintLine.strokeWidth = lineHeight;

    _paintLine.strokeCap = StrokeCap.round;
    _paintBackground.strokeCap = StrokeCap.round;
  }

  final double lineHeight;

  final Color backgroundColor;
  final Paint _paintBackground = new Paint();

  final Color progressColor;
  final Paint _paintLine = new Paint();

  final double dragPercentage;

  @override
  void paint(Canvas canvas, Size size) {
    final start = Offset(0, size.height / 2);
    final end = Offset(size.width, size.height / 2);
    canvas.drawLine(start, end, _paintBackground);
    final xProgress = size.width * dragPercentage;
    canvas.drawLine(start, Offset(xProgress, size.height / 2), _paintLine);
  }

  @override
  bool shouldRepaint(CustomSliderPainter oldDelegate) {
    return true;
  }
}
