import 'progress_painter.dart';
import 'package:flutter/material.dart';

class ProgressTime extends StatelessWidget {
  final Color percentageCompletedColor;
  final double actualState;
  final Widget child;
  final String actualStateText;
  final TextStyle textStyle;

  ProgressTime(
      {this.child,
      this.actualStateText,
      @required this.actualState,
      @required this.textStyle,
      @required this.percentageCompletedColor});

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
          defaultCircleColor: Color(0xff4C4F5D),
          percentageCompletedColor: percentageCompletedColor,
          actualPercentage: actualState,
          circleWidth: 1.0,
          progressText: actualStateText,
          backgroundColor: Color(0xFF0A0D21),
        ),
      ),
    );
  }
}
