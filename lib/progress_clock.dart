import 'dart:async';
import 'progress_painter.dart';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_clock_helper/model.dart';
import 'draw_progress_painter.dart';
import 'constans.dart';

import 'package:vector_math/vector_math_64.dart' show radians;

final radiansPerTick = radians(360 / 60);
final radiansPerHour = radians(360 / 24);

class ProgressClock extends StatefulWidget {
  const ProgressClock(this.model);

  final ClockModel model;

  @override
  _ProgressClockState createState() => _ProgressClockState();
}

class _ProgressClockState extends State<ProgressClock>
    with SingleTickerProviderStateMixin {
  var _now = DateTime.now();
  var _temperature = '';
  var _condition = '';
  var _location = '';
  Timer _timer;

  @override
  void initState() {
    super.initState();
    widget.model.addListener(_updateModel);
    // Set the initial values.
    _updateTime();
    _updateModel();
  }

  @override
  void didUpdateWidget(ProgressClock oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.model != oldWidget.model) {
      oldWidget.model.removeListener(_updateModel);
      widget.model.addListener(_updateModel);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    widget.model.removeListener(_updateModel);
    super.dispose();
  }

  void _updateModel() {
    setState(() {
      _temperature = widget.model.temperatureString;
      _condition = widget.model.weatherString;
      _location = widget.model.location;
    });
  }

  void _updateTime() {
    setState(() {
      _now = DateTime.now();
      // Update once per second. Make sure to do it at the beginning of each
      // new second, so that the clock is accurate.
      _timer = Timer(
        Duration(seconds: 1) - Duration(milliseconds: _now.millisecond),
        _updateTime,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final customTheme = Theme.of(context).brightness == Brightness.light
        ? Theme.of(context).copyWith(
            // Hour hand.
            primaryColor: Color(0xFF4285F4),
            // Minute hand.
            highlightColor: Color(0xFF8AB4F8),
            // Second hand.
            accentColor: Color(0xFF669DF6),
            backgroundColor: Color(0xFFD2E3FC),
          )
        : Theme.of(context).copyWith(
            primaryColor: Color(0xFF202335),
            highlightColor: Color(0xFF4285F4),
            accentColor: Color(0xFF8AB4F8),
            backgroundColor: Color(0xFF0A0D21),
          );

    final weatherInfo = DefaultTextStyle(
      style: Theme.of(context).brightness == Brightness.light
          ? kDefaultTextStyleLight
          : kDefaultTextStyleDark,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(_location),
          Text("$_temperature, $_condition"),
        ],
      ),
    );

    final TextStyle textStyle = Theme.of(context).brightness == Brightness.light
        ? kProgressTextStyleLight
        : kProgressTextStyleDark;

    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: customTheme.backgroundColor,
        primaryColor: customTheme.primaryColor,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Progres_Clock"),
        ),
        body: Container(
          alignment: Alignment.center,
          child: Row(
            children: <Widget>[
              Expanded(
                child: ProgressTime(
                  actualState: _now.second * radiansPerTick,
                  percentageCompletedColor: Colors.blue,
                  textStyle: textStyle,
                  actualStateText: _now.second.toString(),
                  child: ProgressTime(
                      textStyle: textStyle,
                      actualState: _now.minute * radiansPerTick,
                      percentageCompletedColor: Colors.green,
                      actualStateText: _now.minute.toString(),
                      child: ProgressTime(
                        textStyle: textStyle,
                        actualState: _now.hour * radiansPerHour,
                        actualStateText: _now.hour.toString(),
                        percentageCompletedColor: Colors.red,
                      )),
                ),
              ),
              Expanded(
                child: Center(
                  child: weatherInfo,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
