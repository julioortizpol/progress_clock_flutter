import 'package:flutter/material.dart';
import 'dart:math';
import 'constans.dart';

class ProgressPainter extends CustomPainter {
  Color defaultCircleColor;
  Color percentageCompletedColor;
  Color backgroundColor;
  TextStyle textStyle;
  double actualPercentage;
  double circleWidth;
  String progressText;

  ProgressPainter(
      {@required this.defaultCircleColor,
      @required this.percentageCompletedColor,
      @required this.actualPercentage,
      @required this.circleWidth,
      @required this.progressText,
      @required this.backgroundColor,
      @required this.textStyle});

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
        newPaint(backgroundColor, 10, PaintingStyle.fill);
    Paint outerCircleTextContainerPaint =
        newPaint(percentageCompletedColor, 2, PaintingStyle.stroke);
    Paint progressCirclePaint =
        newPaint(percentageCompletedColor, 7, PaintingStyle.stroke);

    Offset center = Offset(size.width / 2, size.height / 2);
    Offset textCenter = Offset((size.width / 2) - 10, (size.height / 2) - 10);
    double radius = min(size.width / 2, size.height / 2);
    double arcAngle = actualPercentage;
    Offset initHandler =
        radiansToCoordinates(center, -((pi / 2) - arcAngle), radius);
    Offset textPosition =
        radiansToCoordinates(textCenter, -((pi / 2) - arcAngle), radius);

    canvas.drawCircle(center, radius, defaultCirclePaint);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi / 2,
        arcAngle, false, progressCirclePaint);
    canvas.drawCircle(initHandler, 18.0, innerCircleTextContainerPaint);
    canvas.drawCircle(initHandler, 18.0, outerCircleTextContainerPaint);
    paintText(size.width, canvas, textPosition);
  }

  @override
  bool shouldRepaint(CustomPainter painter) {
    return true;
  }

  TextPainter createTextPainter() {
    final textSpan = TextSpan(
      text: progressText,
      style: textStyle,
    );

    return TextPainter(
      text: textSpan,
      textDirection: TextDirection.rtl,
    );
  }

  void paintText(maxWidth, canvas, textPosition) {
    final textPainter = createTextPainter();
    textPainter.layout(
      minWidth: 0,
      maxWidth: maxWidth,
    );
    textPainter.paint(canvas, textPosition);
  }
}

Offset radiansToCoordinates(Offset center, double radians, double radius) {
  var dx = center.dx + radius * cos(radians);
  var dy = center.dy + radius * sin(radians);
  return Offset(dx, dy);
}
