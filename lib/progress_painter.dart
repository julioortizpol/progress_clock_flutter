import 'package:flutter/material.dart';
import 'dart:math';

class ProgressPainter extends CustomPainter {
  Color defaultCircleColor;
  Color percentageCompletedColor;
  Color backgroundColor;
  double actualPercentage;
  double circleWidth;
  String progressText;

  ProgressPainter(
      {@required this.defaultCircleColor,
      @required this.percentageCompletedColor,
      @required this.actualPercentage,
      this.circleWidth,
      this.progressText,
      this.backgroundColor});

  newPaint(Color color, double circleWidth, style) {
    return Paint()
      ..color = color
      ..strokeCap = StrokeCap.round
      ..style = style
      ..strokeWidth = circleWidth;
  }

  @override
  void paint(Canvas canvas, Size size) {
    Paint defaultCirclePaint =
        newPaint(defaultCircleColor, circleWidth, PaintingStyle.stroke);

    Paint innerCircleTextContainerPaint =
        newPaint(Color(0xFF0A0D21), 10, PaintingStyle.fill);

    Paint outerCircleTextContainerPaint =
        newPaint(Colors.green, 2, PaintingStyle.stroke);

    Paint progressCirclePaint =
        newPaint(percentageCompletedColor, 7, PaintingStyle.stroke);

    double TIME = (actualPercentage * 60) / 100;
    final textStyle = TextStyle(
        color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold);
    final textSpan = TextSpan(
      text: TIME.toStringAsFixed(0),
      style: textStyle,
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.rtl,
    );
    textPainter.layout(
      minWidth: 0,
      maxWidth: size.width,
    );

    Offset center = Offset(size.width / 2, size.height / 2);
    Offset textCenter = Offset((size.width / 2) - 10, (size.height / 2) - 10);
    double radius = min(size.width / 2, size.height / 2);
    canvas.drawCircle(center, radius, defaultCirclePaint);
    double arcAngle = 2 * pi * (actualPercentage / 100);
    Offset initHandler =
        radiansToCoordinates(center, -((pi / 2) - arcAngle), radius);
    Offset textPosition =
        radiansToCoordinates(textCenter, -((pi / 2) - arcAngle), radius);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi / 2,
        arcAngle, false, progressCirclePaint);
    canvas.drawCircle(initHandler, 18.0, innerCircleTextContainerPaint);
    canvas.drawCircle(initHandler, 18.0, outerCircleTextContainerPaint);
    textPainter.paint(canvas, textPosition);
  }

  @override
  bool shouldRepaint(CustomPainter painter) {
    return true;
  }
}

Offset radiansToCoordinates(Offset center, double radians, double radius) {
  var dx = center.dx + radius * cos(radians);
  var dy = center.dy + radius * sin(radians);
  return Offset(dx, dy);
}
