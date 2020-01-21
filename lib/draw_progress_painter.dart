import 'progress_painter.dart';
import 'package:flutter/material.dart';

class ProgressTime extends StatelessWidget {
  Color percentageCompletedColor;
  double actualState;
  Widget child;

  ProgressTime(this.child, this.actualState, this.percentageCompletedColor);

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
          defaultCircleColor: Colors.amber,
          percentageCompletedColor: percentageCompletedColor,
          actualPercentage: actualState,
          circleWidth: 5.0,
          progressText: actualState.toString(),
          backgroundColor: Color(0xFF0A0D21),
        ),
      ),
    );
  }
}
