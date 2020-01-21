import 'progress_painter.dart';
import 'package:flutter/material.dart';

class ProgressTime extends StatelessWidget {
  final Color percentageCompletedColor;
  final double actualState;
  final Widget child;
  final String actualStateText;
  final TextStyle textStyle;
  final Color desfaultCircleColor;
  final Color backgroundColor;

  ProgressTime(
      {this.child,
      this.actualStateText,
      @required this.actualState,
      @required this.textStyle,
      @required this.desfaultCircleColor,
      @required this.percentageCompletedColor,
      @required this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      padding: EdgeInsets.all(20.0),
      margin: EdgeInsets.all(30.0),
      child: CustomPaint(
        child: child,
        foregroundPainter: ProgressPainter(
          textStyle: textStyle,
          defaultCircleColor: desfaultCircleColor,
          percentageCompletedColor: percentageCompletedColor,
          actualPercentage: actualState,
          circleWidth: 1.0,
          progressText: actualStateText,
          backgroundColor: backgroundColor,
        ),
      ),
    );
  }
}
